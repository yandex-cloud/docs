---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/v0/trigger/v1/
---

# yc serverless v0 trigger v1

Manage triggers (v1 API, deprecated)

#### Command Usage

Syntax:

`yc serverless trigger v1 <group|command>`

#### Command Tree

- [yc serverless v0 trigger v1 add-labels](add-labels.md) — Add labels to specified trigger

- [yc serverless v0 trigger v1 delete](delete.md) — Delete the specified trigger

- [yc serverless v0 trigger v1 get](get.md) — Show information about the specified trigger

- [yc serverless v0 trigger v1 list](list.md) — List triggers

- [yc serverless v0 trigger v1 list-operations](list-operations.md) — Show history of the tag for the specified trigger

- [yc serverless v0 trigger v1 pause](pause.md) — Pause the specified trigger

- [yc serverless v0 trigger v1 remove-labels](remove-labels.md) — Remove labels from specified trigger

- [yc serverless v0 trigger v1 resume](resume.md) — Resume the specified trigger

- [yc serverless v0 trigger v1 create](create/index.md) — Create triggers

  - [yc serverless v0 trigger v1 create billing-budget](create/billing-budget.md) — Create billing budget trigger

  - [yc serverless v0 trigger v1 create container-registry](create/container-registry.md) — Create container registry trigger

  - [yc serverless v0 trigger v1 create internet-of-things](create/internet-of-things.md) — Create internet of things trigger

  - [yc serverless v0 trigger v1 create iot-broker](create/iot-broker.md) — Create IoT broker trigger

  - [yc serverless v0 trigger v1 create logging](create/logging.md) — Create logging trigger

  - [yc serverless v0 trigger v1 create mail](create/mail.md) — Create Mail trigger

  - [yc serverless v0 trigger v1 create message-queue](create/message-queue.md) — Create message queue trigger

  - [yc serverless v0 trigger v1 create object-storage](create/object-storage.md) — Create object storage trigger

  - [yc serverless v0 trigger v1 create timer](create/timer.md) — Create timer trigger

  - [yc serverless v0 trigger v1 create yds](create/yds.md) — Create YDS trigger

- [yc serverless v0 trigger v1 update](update/index.md) — Update the specified trigger

  - [yc serverless v0 trigger v1 update billing-budget](update/billing-budget.md) — Update billing budget trigger

  - [yc serverless v0 trigger v1 update container-registry](update/container-registry.md) — Update container registry trigger

  - [yc serverless v0 trigger v1 update internet-of-things](update/internet-of-things.md) — Update internet of things trigger

  - [yc serverless v0 trigger v1 update iot-broker](update/iot-broker.md) — Update IoT broker trigger

  - [yc serverless v0 trigger v1 update logging](update/logging.md) — Update logging trigger

  - [yc serverless v0 trigger v1 update mail](update/mail.md) — Update Mail trigger

  - [yc serverless v0 trigger v1 update message-queue](update/message-queue.md) — Update message queue trigger

  - [yc serverless v0 trigger v1 update object-storage](update/object-storage.md) — Update object storage trigger

  - [yc serverless v0 trigger v1 update timer](update/timer.md) — Update timer trigger

  - [yc serverless v0 trigger v1 update yds](update/yds.md) — Update YDS trigger

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