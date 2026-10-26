[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [managed-greenplum](../../index.md) > [v0](../index.md) > pxf-datasource > Overview

# yc managed-greenplum v0 pxf-datasource

Manage Greenplum pxf datasources

#### Command Usage

Syntax:

`yc managed-greenplum v0 pxf-datasource <group|command>`

Aliases:

- `pxf`

#### Command Tree

- [yc managed-greenplum v0 pxf-datasource delete](delete.md) — Delete pxf-datasource for specified Greenplum cluster

- [yc managed-greenplum v0 pxf-datasource get](get.md) — Get pxf-datasource for specified Greenplum cluster

- [yc managed-greenplum v0 pxf-datasource list](list.md) — List pxf-datasources for specified Greenplum cluster

- [yc managed-greenplum v0 pxf-datasource create](create/index.md) — Create pxf-datasource for specified Greenplum cluster

  - [yc managed-greenplum v0 pxf-datasource create jdbc](create/jdbc.md) — Create jdbc pxf-datasource for specified Greenplum cluster

  - [yc managed-greenplum v0 pxf-datasource create s3](create/s3.md) — Create s3 pxf-datasource for specified Greenplum cluster

- [yc managed-greenplum v0 pxf-datasource update](update/index.md) — Update pxf-datasource for specified Greenplum cluster

  - [yc managed-greenplum v0 pxf-datasource update jdbc](update/jdbc.md) — Update jdbc pxf-datasource for specified Greenplum cluster

  - [yc managed-greenplum v0 pxf-datasource update s3](update/s3.md) — Update s3 pxf-datasource for specified Greenplum cluster

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