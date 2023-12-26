# Proof of Concept (YATM - Yet Another Task Manager)
- [ ] Quarkus
- [ ] Vue or React
- [ ] Docker (_Docker Compose_)
- [ ] Postgres
- [ ] Redis
- [ ] OAuth2
- [ ] Traefik or Nginx Proxy Manager
- [ ] RabbitMQ
- [ ] GraphQL

### How to run in dev mode
```bash
# Go to docker directory and run docker-compose command
cd docker
docker-compose -p poc up -d

# Go to service directory and run quarkus in dev mode
cd service
./mvnw compile quarkus:dev
```

### How to dump the database
```bash
docker exec -it poc-yatm-db /bin/bash -c "pg_dump -U poc-user -d poc-db --no-owner --no-privileges --schema-only --quote-all-identifiers"
```

### How to drop the database
```bash
docker exec -it poc-yatm-db /bin/bash -c "psql -U poc-user -c 'drop schema if exists public cascade;' -d poc-db"
```

### Initialize the database
```bash
docker exec -it poc-yatm-db /bin/bash -c "psql -U poc-user -d poc-db < /docker-entrypoint-initdb.d/init.sql"
```