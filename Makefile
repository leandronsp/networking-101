run.bash:
	@docker-compose run \
		--rm \
		--service-ports \
		--name ubuntu \
		ubuntu \
		bash

exec.bash:
	@docker-compose exec ubuntu bash
