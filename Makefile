LOGIN = cfrancie

all: setup build up

setup:
	sudo mkdir -p /home/${LOGIN}/data/wordpress /home/${LOGIN}/data/mariadb

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down
	sudo rm -rf /home/${LOGIN}/data/

fclean: down
	@CONTAINERS=$$(docker ps -qa); if [ -n "$$CONTAINERS" ]; then docker stop $$CONTAINERS; docker rm $$CONTAINERS; fi
	@IMAGES=$$(docker images -qa); if [ -n "$$IMAGES" ]; then docker rmi -f $$IMAGES; fi
	@VOLUMES=$$(docker volume ls -q); if [ -n "$$VOLUMES" ]; then docker volume rm $$VOLUMES; fi
	@sudo docker system prune -a -f
	@sudo rm -rf /home/${LOGIN}/data

re: clean all

fre: fclean all

logs:
	docker-compose -f srcs/docker-compose.yml logs -f

.PHONY: all setup build up down clean fclean re fre logs
