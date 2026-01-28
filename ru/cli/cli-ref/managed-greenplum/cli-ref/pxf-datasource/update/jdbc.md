---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/pxf-datasource/update/jdbc.md
---

# yc managed-greenplum pxf-datasource update jdbc

Get jdbc pxf-datasource for specified Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum pxf-datasource update jdbc <DATASOURCE-NAME> [Flags...]`

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
|| `--xml` | `value[,value]`

Load datasource from xml files ||
|| `--force` | Ignore xml errors ||
|#

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