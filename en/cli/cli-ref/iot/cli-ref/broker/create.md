---
editable: false
---

# yc iot broker create

Create new broker

#### Command Usage

Syntax:

`yc iot broker create <BROKER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of broker. ||
|| `--description` | `string`

Description of broker/ ||
|| `--labels` | `key=value[,key=value...]`

List of KEY=VALUES pairs to add. ||
|| `--certificate-file` | `string`

Path to X.509 certificate file to associate with selected broker. ||
|| `--password` | `string`

Password for entity. Usage of --read-password is more secure ||
|| `--read-password` | Read password for entity from input ||
|| `--generate-password` | Generate random password ||
|| `--no-logging` | Disable logging for broker. ||
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
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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