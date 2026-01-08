# Local Dev Infrastructure: Services for a Fresh Start

This repo spins up a set of common infrastructure services for local development using Docker Compose.
Passwords are intentionally weak or empty because this stack is **dev-only** and meant to run on your
local machine.

## Services

- MongoDB (port 27017) – image `mongo:8.2.3`
- PostgreSQL (port 5432) – image `postgres:16.3`
- RabbitMQ + management UI (ports 5672, 15672) – image `rabbitmq:4.2.2-management`
- Redis (port 6379) – image `bitnami/redis:latest` with empty password
- RedisInsight (port 8001) – image `redis/redisinsight:latest`
- Valkey (port 6380) – image `valkey/valkey:latest`
- Redis Cluster (ports 7000–7005) – image `grokzen/redis-cluster:7.2.5`
- Elasticsearch (port 9200) – image `docker.elastic.co/elasticsearch/elasticsearch:7.17.9`
- Kibana (port 5601) – image `docker.elastic.co/kibana/kibana:7.17.9`
- etcd (ports 2379, 2380) – image `bitnami/etcd:latest`

All services are attached to the `backend` Docker network and have their ports exposed to your host.

## Usage

### 1. Prepare data directories

Run the helper script once to create the local data directories:

```bash
./start.sh
```

This will create the `etcd`, `mongodb`, `postgres`, `elasticsearch`, `kibana`, and `redis` folders
in this directory (idempotently).

### 2. Start the stack

Bring everything up in the background:

```bash
docker-compose up -d
```

Or start only the services you need, for example just Redis, MongoDB, and PostgreSQL:

```bash
docker-compose up -d redis mongo postgres
```

You can list the service names from this file with:

```bash
docker-compose config --services
```

Alternatively, you can use the provided `Makefile`:

- Start everything (creates dirs if needed): `make up`
- Stop containers but keep data: `make down`
- Stop containers and delete all data dirs: `make reset`
- Show container status: `make ps`
- Tail logs: `make logs`

To stop the stack but keep data:

```bash
docker-compose down
```

To stop the stack and delete all data volumes:

```bash
docker-compose down -v
rm -rf etcd mongodb postgres elasticsearch kibana redis
```

## Credentials & Security

- **MongoDB**: username `root`, password `example`
- **PostgreSQL**: password `example` for the default `postgres` user
- **Redis**: empty password (no auth)
- **etcd**: no authentication

These settings are **only** appropriate for local development. Do **not** expose this stack to the
internet or use it as-is in staging/production.
