---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/trigger/create/index.md
---

# yc serverless trigger create

Create triggers

#### Command Usage

Syntax:

`yc serverless trigger create <command>`

#### Command Tree

- [yc serverless trigger create billing-budget](billing-budget.md) — Create billing budget trigger

- [yc serverless trigger create container-registry](container-registry.md) — Create container registry trigger

- [yc serverless trigger create internet-of-things](internet-of-things.md) — Create internet of things trigger

- [yc serverless trigger create iot-broker](iot-broker.md) — Create IoT broker trigger

- [yc serverless trigger create logging](logging.md) — Create logging trigger

- [yc serverless trigger create mail](mail.md) — Create Mail trigger

- [yc serverless trigger create message-queue](message-queue.md) — Create message queue trigger

- [yc serverless trigger create object-storage](object-storage.md) — Create object storage trigger

- [yc serverless trigger create timer](timer.md) — Create timer trigger

- [yc serverless trigger create yds](yds.md) — Create YDS trigger

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