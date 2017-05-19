# sets GOPATH to the current work directory
alias gohere="export GOPATH=\`pwd\`; echo \"GOPATH := '\$GOPATH'\"; PATH=\"$PATH:\$GOPATH/bin\"; echo \"PATH = \$PATH\""

# runs go test and shows code coverage when complete
alias gocover="go test -coverprofile=coverage.out && go tool cover -html=coverage.out"

# build and run docker-compose
alias figit="docker-compose build && docker-compose up"

# prints out the greatest port number exposed in a docker-compose.yml across all services.
alias last_port="find $SENSEYE_BACKEND -name 'fig.yml' -o -name 'docker-compose.yml' -exec cat {} \; | grep -E '\b5[0-9]+:[0-9]+' | sed -E 's/[^0-9]*([0-9]+):([0-9]+)[^0-9]*/\1/g' | sort -n | tail -1"

# kills all running containers
alias dka='docker kill $(docker ps -q)'

# Generates a mock of an interface in package defined in the current working directory
# Usage: makemock <interfaceToMock>
alias makemock='mockgen $(pwd | sed "s:$GOPATH/src/::")'
# finds the IP address of a container.  A bit fragile, but it works for me so far...
function ipof {
	if [[ $# < 1 ]]
	then
		echo "Usage: ipof <container>"
		return
	fi

	docker inspect "$1" | grep -m 1 \"IPAddress\" | cut -d":" -sf 2 | sed 's/[^0-9.]//g'
}
# Attempts to connect to a mongo database within the specified container using the specified client
function xmgo {
	if [[ $# < 2 ]]
	then
		echo "Usage: xmgo client <container>[/database] [mongo arguments]"
		return
	fi
	client=$1
	shift
	hostanddb=$1
	shift
	host=${hostanddb%/*}
	db=${hostanddb##*/}

	if [[ "$host" == "$db" ]]
	then
		db=""
	else
		db="/$db"
	fi

	$client "`ipof $host`$db" $@
}


# Attempts to connect to the mongo database on the specified container using the mongo cli.
# Usage is cmgo <containerName>[/databaseName]
function cmgo {
	xmgo "mongo" $@
}


# Opens an interactive bash shell in the specified container
function dbash {
	if [[ $# < 1 ]]
	then
		echo "Usage: dbash <container> [bash arguments]"
		return
	fi

	container=$1
	shift

	docker exec -it "$container" bash $@
}




# Finds a README.md file for one of our top-level services.
# Note that this will not work for test-tools or data-ingestion/* services.
# Usage: readme <service_name>
# service-name may be the beginning of the service name (e.g. event, for the event-storage service)
function readme {
	if [[ $# < 1 ]]
	then
		echo "Usage: readme <servicename>"
		return
	fi

	if [ -z ${MD_VIEWER+1} ];
	then
		echo 'MD_VIEWER environment variable must be set to your preferred markdown viewer.'
		return
	fi

	if [ -z ${SENSEYE_BACKEND+1} ];
	then
		echo "SENSEYE_BACKEND environment variable must be set.  It should not contain a trailing /.";
		return
	fi

	if [ -z ${SENSEYE_ANALYTICS+1} ];
	then
		echo "SENSEYE_ANALYTICS environment variable must be set.  It should not contain a trailing /.";
		return
	fi


	if [ -z ${SENSEYE_EXTERNAL+1} ];
	then
		echo "SENSEYE_EXTERNAL environment variable must be set.  It should not contain a trailing /.";
		return
	fi

	matches=`find  $SENSEYE_BACKEND $SENSEYE_ANALYTICS $SENSEYE_EXTERNAL -maxdepth 2 \( -path "$SENSEYE_BACKEND/$1*" -or -path "$SENSEYE_ANALYTICS/$1*" -or -path "$SENSEYE_EXTERNAL/$1*" \) -not -path '*/src/*' -name README.md`
	#bit sad about this duplication. couldnt get it to work in a neater way.
	noMatches=`find  $SENSEYE_BACKEND $SENSEYE_ANALYTICS $SENSEYE_EXTERNAL -maxdepth 2 \( -path "$SENSEYE_BACKEND/$1*" -or -path "$SENSEYE_ANALYTICS/$1*" -or -path "$SENSEYE_EXTERNAL/$1*" \) -not -path '*/src/*' -name README.md | wc -l`

	if [[ $noMatches -eq 0 ]]
	then
		echo "No candidates found."
		return
	fi

	if [[ $noMatches -gt 1 ]]
	then
		echo "$noMatches candidates found.  Please be more specific"
		echo "$matches" | sed -r 's:.*/([^/]+)/README.md:\t\1:'
		return
	fi

	$MD_VIEWER "$matches"
}




# Changes directory to a service given by the specified acronym.  Provides a select list if the acronym is ambiguous.
# Usage cda <acronym>
# Example: cda ads
#   The example will CD into the anomaly detection service.
# Requires $SENSEYE_GIT to be set, and for all SENSEYE repos to be one level inside this folder.
# E.g.
#   $SENSEYE_GIT/external
#   $SENSEYE_GIT/backend
#   $SENSEYE_GIT/analytics


function cda {
	search=".*/"
	for char in $(echo $1 | grep -o .);
	do
		search="$search$char[^-/]*-"
	done
	search="${search::-1}$"

	results=($(find "$SENSEYE_GIT" -maxdepth 2 -type d -regextype posix-extended -regex $search))
	if [ ${#results[@]} -eq 0 ];
	then
		echo "No results found"
		return
	fi

	if [ ${#results[@]} -gt 1 ];
	then
		echo "Multiple results found:"
		PS3="Choose a service: "
		select f in $(basename -a ${results[@]})
		do
			if [ "$f" != "" ];
			then
				cd "${results[$REPLY-1]}"
				break
			fi
		done
	else
		cd $results
	fi
}
