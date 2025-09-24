all:
	@mkdir -p /Users/amabrouk/Desktop/data/mariadb
	@mkdir -p /Users/amabrouk/Desktop/data/wordpress
	@rm -rf mariadb/* wordpress/*
	@docker compose -f docker-compose.yml up --build

fclean:
	@docker compose -f docker-compose.yml down -v
	@rm -rf mariadb/* wordpress/*
	# @docker system prune -a -f
	# @docker volume prune -f
