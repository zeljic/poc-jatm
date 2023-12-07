# Proof of Concept (YATM - Yet Another Task Manager)
- [ ] Quarkus
- [ ] Vue
- [ ] Docker
- [ ] Postgres
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
pg_dump -U poc-user -W -d poc-db --no-owner --no-privileges --schema-only --quote-all-identifiers
```