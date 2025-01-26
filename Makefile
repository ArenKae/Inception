### COLORS ###
DEF_COLOR = \033[0;39m
GRAY = \033[0;90m
RED = \033[0;91m
GREEN = \033[0;92m
YELLOW = \033[0;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m

### RULES ###

all :
	@mkdir -p /home/acosi/data/mysql && mkdir -p /home/acosi/data/wordpress
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