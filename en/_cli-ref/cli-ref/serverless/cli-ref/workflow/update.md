---
editable: false
---

# yc serverless workflow update

Update Workflow

#### Command Usage

Syntax:

`yc serverless workflow update <WORKFLOW-NAME>|<WORKFLOW-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Workflow id. ||
|| `--name` | `string`

Workflow name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New workflow name. ||
|| `--description` | `string`

New workflow description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--yaml-spec` | `string`

New workflow specification file name. ||
|| `--network-id` | `string`

New workflow network id. ||
|| `--service-account-id` | `string`

New workflow service account id. ||
|| `--schedule-cron-expression` | `string`

Cron expression for workflow schedule. Example: '0 * * * * *'. ||
|| `--schedule-timezone` | `string`

Timezone for workflow schedule, e.g. Europe/Moscow. Defaults to your local timezone. ||
|| `--remove-schedule` | Remove schedule for the workflow. ||
|| `--set-is-public` | Make workflow public for execution. ||
|| `--remove-is-public` | Make workflow private for execution. ||
|| `--no-logging` | Disable logging from workflow. ||
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