---
sourcePath: en/ydb/overlay/getting_started/_includes/create_db.md
---
# Creating a database - Getting started

{% include [create_db_overlay.md](create_db_overlay.md) %}

## Self-deployment {#self-hosted}

There are two methods you can use to deploy YDB:

- [Using Docker](../self_hosted/ydb_docker.md)
- [In Kubernetes](../../deploy/orchestrated/concepts.md)

By default, each of these scenarios will produce a database with the following connection parameters:

- Endpoint: `grpc://localhost:2136`
- Database name: `/local`
- Authentication: not required

Detailed information about databases can be found in the article [Terms and definitions - Database](../../concepts/databases.md#database) in the "Concepts" section.