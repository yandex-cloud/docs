---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-greenplum/cli-ref/v0/pxf-datasource/create/jdbc/
---

# yc managed-greenplum v0 pxf-datasource create jdbc

Create jdbc pxf-datasource for specified Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum v0 pxf-datasource create jdbc <DATASOURCE-NAME> [Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Greenplum cluster id. ||
|| `--cluster-name` | `string`

Greenplum cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--driver` | `string`

JDBC driver ||
|| `--url` | `string`

JDBC URL ||
|| `--user` | `string`

JDBC user ||
|| `--password` | `string`

JDBC password ||
|| `--statement-batch-size` | `int`

JDBC statement batch size ||
|| `--statement-fetch-size` | `int`

JDBC statement fetch size ||
|| `--statement-query-timeout` | `int`

JDBC statement query timeout ||
|| `--pool-enabled` | JDBC statement query timeout ||
|| `--pool-maximum-size` | `int`

JDBC maximum pool size ||
|| `--pool-connection-timeout` | `int`

JDBC connection timeout in milliseconds ||
|| `--pool-idle-timeout` | `int`

JDBC idle timeout in milliseconds ||
|| `--pool-minimum-idle` | `int`

JDBC maximum idle ||
|| `--xml` | `[]string`

Load datasource from xml files ||
|| `--force` | Ignore xml errors ||
|#

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