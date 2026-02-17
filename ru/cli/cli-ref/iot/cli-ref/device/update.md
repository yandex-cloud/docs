---
editable: false
---

# yc iot device update

Update specified device

#### Command Usage

Syntax:

`yc iot device update <DEVICE-NAME>|<DEVICE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--new-name` | `string`

A new name of device. ||
|| `--description` | `string`

Description of device. ||
|| `--labels` | `key=value[,key=value...]`

List of KEY=VALUE pairs to replace existing. ||
|| `--topic-aliases` | `key=value[,key=value...]`

A list of ALIAS=TOPIC_PREFIX pairs to add. ||
|| `--id` | `string`

Device id. ||
|| `--name` | `string`

Device name. ||
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