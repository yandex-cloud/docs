---
title: DatabaseQuery integration step
description: This article describes the fields for the DatabaseQuery integration step.
---

# DatabaseQuery

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

SQL queries against {{ MY }}, {{ PG }}, {{ CH }}, and {{ ydb-short-name }} databases.

The `connection` and `dsn` fields are mutually exclusive: you can use only one of them.

#|
|| Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description ||
|| `connection` | [DatabaseConnection](#DatabaseonnecCtion) | None | None | None | Database connection parameters ||
|| `dsn` | `string` | None | None | None | Database connection string (DNS). Supported schemas: `postgres://`, `postgresql://`, `clickhouse://`, `grpc://`, `grpcs://`, `ydb://`, and the {{ MY }} DSN format (`user:pass@tcp(host:port)/db?...`). ||
|| `query` | `string` | Yes | None | Yes | SQL query text ||
|| `mode` | `string` | None | `EXEC` | None | SQL query execution method. The possible values are:
* `EXEC`: Execute the SQL query and return the service fields only, e.g., `RowsAffected` and `LastInsertId`.
* `QUERY`: Execute the SQL query and return the result. ||
|#

## DatabaseConnection {#DatabaseConnection}

The `simple` and `iam` fields are mutually exclusive: you can use only one of them. The `iam` field is only supported for {{ ydb-short-name }} databases.

For a {{ MY }} database, `parseTime=true` and `charset=utf8mb4` are set automatically.

#|
|| Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description ||
|| `type` | `string` | Yes | None | None | Database type. The possible values are `MYSQL`, `POSTGRES`, `YDB`, and `CLICKHOUSE`. ||
|| `host` | `string` | Yes | None | None | Database host. ||
|| `port` | `number` | Yes | None | None | Database port. ||
|| `database` | `string` | Yes | None | None | Database name. ||
|| `ssl` | `bool` |  | `false` | None | If `true`, the database connection is over SSL. 

Additionally, consider the following:
* For a {{ PG }} database, set `sslmode=require` if `ssl=true`. Otherwise, `sslmode=disable`.
* For a {{ CH }} database, set `secure=true` if `ssl=true`. ||
|| `simple` | [DatabaseConnectionSimpleAuth](#DatabaseConnectionSimpleAuth) | None | None | Yes | Authentication by username and password. ||
|| `iam` | `bool` | None | None | None | Authentication by IAM token of the service account specified in the workflow settings. ||
|#

## DatabaseConnectionSimpleAuth {#DatabaseConnectionSimpleAuth}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`username` | `string` | Yes | None | Yes | Username.
`password` | `string` | Yes | None | Yes | Password.
