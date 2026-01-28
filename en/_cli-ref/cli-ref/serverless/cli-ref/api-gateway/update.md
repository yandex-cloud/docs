---
editable: false
---

# yc serverless api-gateway update

Update API Gateway

#### Command Usage

Syntax:

`yc serverless api-gateway update <API-GATEWAY-NAME>|<API-GATEWAY-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Api-gateway id. ||
|| `--name` | `string`

Api-gateway name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New api-gateway name. ||
|| `--description` | `string`

New api-gateway description. ||
|| `--labels` | `key=value[,key=value...]`

New list of label KEY=VALUE pairs to replace existing list. ||
|| `--spec` | `string`

New api-gateway specification file name. ||
|| `--network-name` | `string`

New api-gateway network name. ||
|| `--network-id` | `string`

New api-gateway network id. ||
|| `--subnet-name` | `value[,value]`

New api-gateway subnet names. ||
|| `--subnet-id` | `value[,value]`

New api-gateway subnet ids. ||
|| `--no-logging` | Disable logging from api-gateway. ||
|| `--log-group-id` | `string`

Send logs to custom log group by id. ||
|| `--log-group-name` | `string`

Send logs to custom log group by name. ||
|| `--log-folder-id` | `string`

Send logs to default log group of custom folder by id. ||
|| `--log-folder-name` | `string`

Send logs to default log group of custom folder by name. ||
|| `--min-log-level` | `string`

Min log level. Values: 'trace', 'debug', 'info', 'warn', 'error', 'fatal' ||
|| `--variables` | `key=value[,key=value...]`

A list of values for variables in gateway specification. ||
|| `--canary-weight` | `int`

Percentage of requests, which will be processed by canary release. ||
|| `--canary-variables` | `key=value[,key=value...]`

A list of values for variables in gateway specification of canary release. ||
|| `--execution-timeout` | `duration`

Execution timeout. ||
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