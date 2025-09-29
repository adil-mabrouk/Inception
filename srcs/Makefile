all:
	@mkdir -p /Users/amabrouk/Desktop/Inception/data/mariadb
	@mkdir -p /Users/amabrouk/Desktop/Inception/data/wordpress
	@rm -rf mariadb/* wordpress/*
	@docker-compose -f docker-compose.yml up --build

fclean:
	@docker-compose -f docker-compose.yml down -v
	@rm -rf /Users/amabrouk/Desktop/Inception/data/mariadb
	@rm -rf /Users/amabrouk/Desktop/Inception/data/wordpress
	@docker system prune -a -f
	@docker volume prune -f
