.PHONY: dirs up down reset ps logs

dirs:
	./start.sh

up: dirs
	docker-compose up -d

down:
	docker-compose down

reset: down
	rm -rf etcd mongodb postgres elasticsearch kibana redis

ps:
	docker-compose ps

logs:
	docker-compose logs -f
