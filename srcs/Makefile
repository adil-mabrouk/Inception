all:
	@mkdir -p /home/adil_unix/Inception/data/mariadb
	@mkdir -p /home/adil_unix/Inception/data/wordpress
	@rm -rf mariadb/* wordpress/*
	@docker-compose -f docker-compose.yml up --build

fclean:
	@docker-compose -f docker-compose.yml down -v
	@sudo rm -rf /home/adil_unix/Inception/data/mariadb
	@sudo rm -rf /home/adil_unix/Inception/data/wordpress
	@docker system prune -a -f
	@docker volume prune -f
