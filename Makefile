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

### VARIABLES ###
NAME = Inception
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_DIRS = /home/acosi/data/mysql /home/acosi/data/wordpress
ALREADY_UP := $(shell docker-compose -f $(DOCKER_COMPOSE_FILE) ps -q | wc -l)

### RULES ###

all :
	@if [ "$(ALREADY_UP)" = "3" ]; then \
		docker-compose -f $(DOCKER_COMPOSE_FILE) up -d; \
		echo "$(GREEN)>>> Nothing to be done for $(NAME).$(DEF_COLOR)"; \
	else \
		mkdir -p $(DATA_DIRS); \
		docker-compose -f $(DOCKER_COMPOSE_FILE) up -d; \
		timeout 6 docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f || true; \
		echo "$(GREEN)>>> $(NAME) built successfully!$(DEF_COLOR)"; \
	fi

stop :
	@echo "$(YELLOW)>>> Stopping containers...$(DEF_COLOR)"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) stop
	@echo "$(GREEN)>>> $(NAME) stopped.$(DEF_COLOR)"

start :
	@docker-compose -f $(DOCKER_COMPOSE_FILE) start
	@echo "$(GREEN)>>> $(NAME) started successfully!$(DEF_COLOR)"

# Check status of running containers
status :
	@docker-compose -f $(DOCKER_COMPOSE_FILE) ps

# Stop and remove all containers but keep the images
clean : stop
	@echo "$(YELLOW)>>> Cleaning $(NAME)...$(DEF_COLOR)"
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down --volumes
	@echo "$(GREEN)>>> $(NAME) cleaned!$(DEF_COLOR)"

# Remove all container images
fclean : clean
	@sudo rm -rf /home/acosi/data
	@docker system prune -af

re :
	@echo "$(CYAN)>>> Rebuilding $(NAME) with --build...$(DEF_COLOR)"
	@make fclean
	@mkdir -p $(DATA_DIRS)
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up --build -d
	@timeout 6 docker-compose -f $(DOCKER_COMPOSE_FILE) logs -f || true
	@echo "$(GREEN)>>> $(NAME) rebuilt successfully!$(DEF_COLOR)"

.PHONY: all stop start status clean fclean re