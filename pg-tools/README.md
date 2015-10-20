# texastribune/pg-tools

A dockerized toolset for importing and exporting data from a postgreSQL database.

## Example usage

#### Importing from S3

```
docker run -it --rm \
  --link=db:db \
  --env=<aws_access_key_id> \
  --env=<aws_secret_access_key> \
  --env=DATABASE_URL=<database-url> \
  --env=S3_SOURCE=<s3-source> \
  texastribune/pg-tools /app/import-from-s3.sh
```

#### Importing from a URL

```
docker run -it --rm \
  --link=db:db \
  --env=DATABASE_URL=<database-url> \
  --env=DATABASE_BACKUP_URL=<url-to-postgres-dump> \
  texastribune/pg-tools /app/import-from-url.sh
```
