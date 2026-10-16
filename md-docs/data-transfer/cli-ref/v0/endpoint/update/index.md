[Документация Yandex Cloud](../../../../../index.md) > [Yandex Data Transfer](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [v0](../../index.md) > [endpoint](../index.md) > update > Overview

# yc datatransfer v0 endpoint update

Update endpoint

#### Command Usage

Syntax:

`yc datatransfer v0 endpoint update <command>`

#### Command Tree

- [yc datatransfer v0 endpoint update clickhouse-source](clickhouse-source.md) — Update Clickhouse source

- [yc datatransfer v0 endpoint update clickhouse-target](clickhouse-target.md) — Update Clickhouse target

- [yc datatransfer v0 endpoint update mongo-source](mongo-source.md) — Update MongoDB source

- [yc datatransfer v0 endpoint update mongo-target](mongo-target.md) — Update MongoDB target

- [yc datatransfer v0 endpoint update mysql-source](mysql-source.md) — Update MySQL source

- [yc datatransfer v0 endpoint update mysql-target](mysql-target.md) — Update MySQL target

- [yc datatransfer v0 endpoint update postgres-source](postgres-source.md) — Update PostgreSQL source

- [yc datatransfer v0 endpoint update postgres-target](postgres-target.md) — Update PostgreSQL target

- [yc datatransfer v0 endpoint update yds-source](yds-source.md) — Update YDS source

- [yc datatransfer v0 endpoint update yds-target](yds-target.md) — Update YDS target

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#