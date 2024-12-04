include ./docker/.env
export

##################
# Variables
##################

DOCKER_COMPOSE = docker-compose -f ./docker/docker-compose.yaml

DOCKER_COMPOSE_PHP_FPM_EXEC = ${DOCKER_COMPOSE} exec -u www-data ${CONTEINER_NAME_PHP}

##################
# Docker compose
##################

build:
	${DOCKER_COMPOSE} build

start:
	${DOCKER_COMPOSE} start

stop:
	${DOCKER_COMPOSE} stop

up:
	${DOCKER_COMPOSE} up -d --remove-orphans

ps:
	${DOCKER_COMPOSE} ps

logs:
	${DOCKER_COMPOSE} logs -f

down:
	${DOCKER_COMPOSE} down -v --rmi=all --remove-orphans



##################
# App
##################

app_bash:
	${DOCKER_COMPOSE} exec -u www-data ${CONTEINER_NAME_PHP} bash