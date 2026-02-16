---
editable: false
sourcePath: en/_cli-ref/cli-ref/datatransfer/cli-ref/endpoint/create/index.md
---

# yc datatransfer endpoint create

Create endpoint

#### Command Usage

Syntax:

`yc datatransfer endpoint create <command>`

#### Command Tree

- [yc datatransfer endpoint create clickhouse-source](clickhouse-source.md) — Create Clickhouse source

- [yc datatransfer endpoint create clickhouse-target](clickhouse-target.md) — Create Clickhouse target

- [yc datatransfer endpoint create mongo-source](mongo-source.md) — Create MongoDB source

- [yc datatransfer endpoint create mongo-target](mongo-target.md) — Create MongoDB target

- [yc datatransfer endpoint create mysql-source](mysql-source.md) — Create MySQL source

- [yc datatransfer endpoint create mysql-target](mysql-target.md) — Create MySQL target

- [yc datatransfer endpoint create postgres-source](postgres-source.md) — Create PostgreSQL source

- [yc datatransfer endpoint create postgres-target](postgres-target.md) — Create PostgreSQL target

- [yc datatransfer endpoint create yds-source](yds-source.md) — Create YDS source

- [yc datatransfer endpoint create yds-target](yds-target.md) — Create YDS target

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#