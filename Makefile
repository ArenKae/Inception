### RULES ###

all :
	mkdir -p /home/acosi/data/mysql && mkdir -p /home/acosi/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up --build

stop :
	docker-compose -f ./srcs/docker-compose.yml stop

start :
	docker-compose -f ./srcs/docker-compose.yml start

status :
	docker ps

clean :
	docker-compose -f ./srcs/docker-compose.yml down --volumes

fclean : clean
	sudo rm -rf /home/acosi/data
	docker system prune -af

re : fclean all

.PHONY: all stop start status clean fclean re