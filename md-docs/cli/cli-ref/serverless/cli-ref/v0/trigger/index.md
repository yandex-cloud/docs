[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [serverless](../../index.md) > [v0](../index.md) > trigger > Overview

# yc serverless v0 trigger

Manage triggers

#### Command Usage

Syntax:

`yc serverless trigger <group|command>`

#### Command Tree

- [yc serverless v0 trigger add-labels](add-labels.md) — Add labels to specified trigger

- [yc serverless v0 trigger delete](delete.md) — Delete the specified trigger

- [yc serverless v0 trigger get](get.md) — Show information about the specified trigger

- [yc serverless v0 trigger list](list.md) — List triggers

- [yc serverless v0 trigger list-operations](list-operations.md) — Show history of the tag for the specified trigger

- [yc serverless v0 trigger pause](pause.md) — Pause the specified trigger

- [yc serverless v0 trigger remove-labels](remove-labels.md) — Remove labels from specified trigger

- [yc serverless v0 trigger resume](resume.md) — Resume the specified trigger

- [yc serverless v0 trigger create](create/index.md) — Create triggers

  - [yc serverless v0 trigger create billing-budget](create/billing-budget.md) — Create billing budget trigger

  - [yc serverless v0 trigger create container-registry](create/container-registry.md) — Create container registry trigger

  - [yc serverless v0 trigger create internet-of-things](create/internet-of-things.md) — Create internet of things trigger

  - [yc serverless v0 trigger create iot-broker](create/iot-broker.md) — Create IoT broker trigger

  - [yc serverless v0 trigger create logging](create/logging.md) — Create logging trigger

  - [yc serverless v0 trigger create mail](create/mail.md) — Create Mail trigger

  - [yc serverless v0 trigger create message-queue](create/message-queue.md) — Create message queue trigger

  - [yc serverless v0 trigger create object-storage](create/object-storage.md) — Create object storage trigger

  - [yc serverless v0 trigger create timer](create/timer.md) — Create timer trigger

  - [yc serverless v0 trigger create yds](create/yds.md) — Create YDS trigger

- [yc serverless v0 trigger update](update/index.md) — Update the specified trigger

  - [yc serverless v0 trigger update billing-budget](update/billing-budget.md) — Update billing budget trigger

  - [yc serverless v0 trigger update container-registry](update/container-registry.md) — Update container registry trigger

  - [yc serverless v0 trigger update internet-of-things](update/internet-of-things.md) — Update internet of things trigger

  - [yc serverless v0 trigger update iot-broker](update/iot-broker.md) — Update IoT broker trigger

  - [yc serverless v0 trigger update logging](update/logging.md) — Update logging trigger

  - [yc serverless v0 trigger update mail](update/mail.md) — Update Mail trigger

  - [yc serverless v0 trigger update message-queue](update/message-queue.md) — Update message queue trigger

  - [yc serverless v0 trigger update object-storage](update/object-storage.md) — Update object storage trigger

  - [yc serverless v0 trigger update timer](update/timer.md) — Update timer trigger

  - [yc serverless v0 trigger update yds](update/yds.md) — Update YDS trigger

- [yc serverless v0 trigger v1](v1/index.md) — Manage triggers (v1 API, deprecated)

  - [yc serverless v0 trigger v1 add-labels](v1/add-labels.md) — Add labels to specified trigger

  - [yc serverless v0 trigger v1 delete](v1/delete.md) — Delete the specified trigger

  - [yc serverless v0 trigger v1 get](v1/get.md) — Show information about the specified trigger

  - [yc serverless v0 trigger v1 list](v1/list.md) — List triggers

  - [yc serverless v0 trigger v1 list-operations](v1/list-operations.md) — Show history of the tag for the specified trigger

  - [yc serverless v0 trigger v1 pause](v1/pause.md) — Pause the specified trigger

  - [yc serverless v0 trigger v1 remove-labels](v1/remove-labels.md) — Remove labels from specified trigger

  - [yc serverless v0 trigger v1 resume](v1/resume.md) — Resume the specified trigger

- [yc serverless v0 trigger v2](v2/index.md) — Manage triggers (v2 API)

  - [yc serverless v0 trigger v2 add-labels](v2/add-labels.md) — Add labels to specified trigger

  - [yc serverless v0 trigger v2 delete](v2/delete.md) — Delete the specified trigger

  - [yc serverless v0 trigger v2 get](v2/get.md) — Show information about the specified trigger

  - [yc serverless v0 trigger v2 help-action](v2/help-action.md) — Describe action json format

  - [yc serverless v0 trigger v2 list](v2/list.md) — List triggers

  - [yc serverless v0 trigger v2 list-operations](v2/list-operations.md) — Show history of operations for the specified trigger

  - [yc serverless v0 trigger v2 pause](v2/pause.md) — Pause the specified trigger

  - [yc serverless v0 trigger v2 remove-labels](v2/remove-labels.md) — Remove labels from specified trigger

  - [yc serverless v0 trigger v2 resume](v2/resume.md) — Resume the specified trigger

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