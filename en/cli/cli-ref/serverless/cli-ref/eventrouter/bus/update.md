---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/eventrouter/bus/update.md
---

# yc serverless eventrouter bus update

Update the specified bus

#### Command Usage

Syntax:

`yc serverless eventrouter bus update <BUS-NAME>|<BUS-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Bus id. ||
|| `--name` | `string`

Bus name. ||
|| `--new-name` | `string`

New bus name. ||
|| `--description` | `string`

Bus description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--deletion-protection` | Prevents accidental bus removal. ||
|| `--no-deletion-protection` | Remove bus deletion protection. ||
|| `--enable-logging` | Enable logging. ||
|| `--disable-logging` | Disable logging. ||
|| `--log-options` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Logs delivery options

Possible property names:

- `log-group-id`: Write logs to this log group.

- `folder-id`: Write logs to default log group of this folder if log group id is not specified.

- `min-level`: Minimal level of logs to write. Values: 'trace', 'debug', 'info', 'warn', 'error', 'fatal' ||
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