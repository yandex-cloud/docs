[Документация Yandex Cloud](../../../../index.md) > [Интерфейс командной строки](../../../index.md) > [Справочник (англ.)](../../index.md) > managed-zonalshift > Overview

# yc managed-zonalshift

Manage zonal shift configurations and tasks for Managed Databases.

#### Command Usage

Syntax:

`yc managed-zonalshift <group>`

#### Command Tree

- [yc managed-zonalshift config](config/index.md) — Manage zonal shift configurations.

  - [yc managed-zonalshift config create](config/create.md) — Create a zonal shift configuration.

  - [yc managed-zonalshift config delete](config/delete.md) — Delete a zonal shift configuration.

  - [yc managed-zonalshift config get](config/get.md) — Show the specified zonal shift configuration.

  - [yc managed-zonalshift config list](config/list.md) — List zonal shift configurations.

  - [yc managed-zonalshift config update](config/update.md) — Update a zonal shift configuration.

- [yc managed-zonalshift drill-type](drill-type/index.md) — Show supported zonal shift drill types.

  - [yc managed-zonalshift drill-type list](drill-type/list.md) — List supported zonal shift drill types.

- [yc managed-zonalshift task](task/index.md) — Manage zonal shift tasks.

  - [yc managed-zonalshift task cancel](task/cancel.md) — Cancel an active zonal shift task.

  - [yc managed-zonalshift task list](task/list.md) — List tasks of a zonal shift configuration.

- [yc managed-zonalshift v0](v0/index.md) — Manage zonal shift configurations and tasks for Managed Databases.



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