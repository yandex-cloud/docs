---
title: DatabaseQuery integration step
description: This article describes the fields for the DatabaseQuery integration step.
---

# DatabaseQuery

SQL queries against {{ MY }}, {{ PG }}, {{ CH }}, and {{ ydb-short-name }} databases.

The `connection` and `dsn` fields are mutually exclusive: you can use only one of them.

#|
|| Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description ||
|| `connection` | [DatabaseConnection](#DatabaseonnecCtion) | No | No | No | Database connection parameters ||
|| `dsn` | `string` | No | No | No | Database connection string (DNS). The supported schemas are: `postgres://`, `postgresql://`, `clickhouse://`, `grpc://`, `grpcs://`, `ydb://`, and the {{ MY }} DSN (`user:pass@tcp(host:port)/db?...`) format. ||
|| `query` | `string` | Yes | No | Yes | SQL query text ||
|| `mode` | `string` | No | `EXEC` | No | SQL query execution method. Values to choose from:
* `EXEC`: Execute the SQL query and return the service fields only, e.g., `RowsAffected` and `LastInsertId`.
* `QUERY`: Execute the SQL query and return the result. ||
|#

## DatabaseConnection {#DatabaseConnection}

The `simple` and `iam` fields are mutually exclusive: you can use only one of them. The `iam` field is only supported for {{ ydb-short-name }} databases.

For a {{ MY }} database, `parseTime=true` and `charset=utf8mb4` are set automatically.

#|
|| Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description ||
|| `type` | `string` | Yes | No | No | Database type. Values to choose from: `MYSQL`, `POSTGRES`, `YDB`, `CLICKHOUSE`. ||
|| `host` | `string` | Yes | No | No | Database host. ||
|| `port` | `number` | Yes | No | No | Database port. ||
|| `database` | `string` | Yes | No | No | Database name. ||
|| `ssl` | `bool` | No | `false` | No | If `true`, the database connection is over SSL. 

Additionally,
* For a {{ PG }} database, set `sslmode=require` if `ssl=true`. Otherwise, `sslmode=disable`.
* For a {{ CH }} database, set `secure=true` if `ssl=true`. ||
|| `simple` | [DatabaseConnectionSimpleAuth](#DatabaseConnectionSimpleAuth) | No | No | Yes | Authentication by username and password. ||
|| `iam` | `bool` | No | No | No | Authentication by IAM token of the service account specified in the workflow settings. ||
|#

## DatabaseConnectionSimpleAuth {#DatabaseConnectionSimpleAuth}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`username` | `string` | Yes | No | Yes | Username.
`password` | `string` | Yes | No | Yes | User password.
