

help () {
	echo "
CLI to deploy/test wikijs application
Commands:
	build
	run
	stop
	update_host (not yet implemented)
"
}


run_docker_containers () {

	sudo docker run \
		--name some-postgres \
		--rm \
		--env POSTGRES_PASSWORD=mysecretpassword \
		--detach \
		--volume ./data/db-data:/var/lib/postgresql/data \
		--publish 5432:5432 \
		postgres

	sudo docker run \
		--name=wikijs \
		--rm \
		--volume ./data/config:/config \
		--volume ./data/wiki_data:/data \
		--detach \
		--network=host \
		--env PUID=1000 \
		--env PGID=1000 \
		--env TZ=Etc/UTC \
		--env DB_TYPE=postgres \
		--env DB_HOST=localhost \
		--env DB_PORT=5432 \
		--env DB_NAME=postgres \
		--env DB_USER=postgres \
		--env DB_PASS=mysecretpassword \
		lscr.io/linuxserver/wikijs:latest			    
}


main_commands () {
	case $1 in 

		"--help")
			help
			;;

		"build")
			sudo docker build \
				--tag andrew_wikijs \
				.
			;;

		"stop")
			sudo docker kill some-postgres
			sudo docker kill wikijs
			;;

		"update_host")
			echo "not yet implemented"
			;;

		"run")
			run_docker_containers 
			;;

		*)
			echo "Command '$1' not found"
			help
			;;
	esac
}


main_commands "$@"
