NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

LOGIN = emunoz
DOMAIN = $(LOGIN).42.fr
HOSTS_FILE = /etc/hosts
LOCAL_IP = 127.0.0.1

DATA_DIR = /home/$(LOGIN)/data
MARIADB_DIR = $(DATA_DIR)/mariadb
WORDPRESS_DIR = $(DATA_DIR)/wordpress

all: hosts build up

hosts:
	@echo "Configuring /etc/hosts..."
	@if grep -q "$(DOMAIN)" $(HOSTS_FILE); then \
		echo "$(DOMAIN) already present"; \
	else \
		echo "$(LOCAL_IP) $(DOMAIN)" | sudo tee -a $(HOSTS_FILE) > /dev/null; \
		echo "$(DOMAIN) added"; \
	fi

build:
	mkdir -p $(MARIADB_DIR) $(WORDPRESS_DIR)
	sudo chown -R $(USER):$(USER) $(DATA_DIR)
	sudo chmod -R 755 $(DATA_DIR)
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down --volumes
	docker system prune -af

fclean: clean
	sudo rm -rf $(DATA_DIR)

re: fclean all

.PHONY: all hosts build up down clean fclean re logs ps
