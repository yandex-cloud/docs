---
editable: false
---

# yc serverless trigger update

Update the specified trigger

#### Command Usage

Syntax:

`yc serverless trigger update <command>`

#### Command Tree

- [yc serverless trigger update billing-budget](billing-budget.md) — Update billing budget trigger

- [yc serverless trigger update container-registry](container-registry.md) — Update container registry trigger

- [yc serverless trigger update internet-of-things](internet-of-things.md) — Update internet of things trigger

- [yc serverless trigger update iot-broker](iot-broker.md) — Update IoT broker trigger

- [yc serverless trigger update logging](logging.md) — Update logging trigger

- [yc serverless trigger update mail](mail.md) — Update Mail trigger

- [yc serverless trigger update message-queue](message-queue.md) — Update message queue trigger

- [yc serverless trigger update object-storage](object-storage.md) — Update object storage trigger

- [yc serverless trigger update timer](timer.md) — Update timer trigger

- [yc serverless trigger update yds](yds.md) — Update YDS trigger

#### Flags

#|
||Flag | Description ||
|| `--new-name` | `string`

New trigger name. ||
|| `--description` | `string`

Trigger description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs. ||
|| `--id` | `string`

Trigger id. ||
|| `--name` | `string`

Trigger name. ||
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