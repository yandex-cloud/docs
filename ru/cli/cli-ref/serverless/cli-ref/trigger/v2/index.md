---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/trigger/v2/
---

# yc serverless trigger v2

Manage triggers (v2 API)

#### Command Usage

Syntax:

`yc serverless trigger v2 <group|command>`

#### Command Tree

- [yc serverless trigger v2 add-labels](add-labels.md) — Add labels to specified trigger

- [yc serverless trigger v2 delete](delete.md) — Delete the specified trigger

- [yc serverless trigger v2 get](get.md) — Show information about the specified trigger

- [yc serverless trigger v2 help-action](help-action.md) — Describe action json format

- [yc serverless trigger v2 list](list.md) — List triggers

- [yc serverless trigger v2 list-operations](list-operations.md) — Show history of operations for the specified trigger

- [yc serverless trigger v2 pause](pause.md) — Pause the specified trigger

- [yc serverless trigger v2 remove-labels](remove-labels.md) — Remove labels from specified trigger

- [yc serverless trigger v2 resume](resume.md) — Resume the specified trigger

- [yc serverless trigger v2 create](create/index.md) — Create triggers

  - [yc serverless trigger v2 create billing-budget](create/billing-budget.md) — Create billing budget trigger

  - [yc serverless trigger v2 create container-registry](create/container-registry.md) — Create container registry trigger

  - [yc serverless trigger v2 create internet-of-things](create/internet-of-things.md) — Create internet of things trigger

  - [yc serverless trigger v2 create iot-broker](create/iot-broker.md) — Create IoT broker trigger

  - [yc serverless trigger v2 create logging](create/logging.md) — Create logging trigger

  - [yc serverless trigger v2 create mail](create/mail.md) — Create Mail trigger

  - [yc serverless trigger v2 create message-queue](create/message-queue.md) — Create message queue trigger

  - [yc serverless trigger v2 create object-storage](create/object-storage.md) — Create object storage trigger

  - [yc serverless trigger v2 create telegram](create/telegram.md) — Create Telegram trigger

  - [yc serverless trigger v2 create timer](create/timer.md) — Create timer trigger

  - [yc serverless trigger v2 create yandex-messenger](create/yandex-messenger.md) — Create Yandex Messenger trigger

  - [yc serverless trigger v2 create yds](create/yds.md) — Create YDS trigger

- [yc serverless trigger v2 update](update/index.md) — Update the specified trigger. Only basic attributes are updated. Use subcommands to update source and actions.

  - [yc serverless trigger v2 update add-actions](update/add-actions.md) — Add actions to the trigger

  - [yc serverless trigger v2 update billing-budget](update/billing-budget.md) — Update billing budget trigger

  - [yc serverless trigger v2 update container-registry](update/container-registry.md) — Update container registry trigger

  - [yc serverless trigger v2 update internet-of-things](update/internet-of-things.md) — Update internet of things trigger

  - [yc serverless trigger v2 update iot-broker](update/iot-broker.md) — Update IoT broker trigger

  - [yc serverless trigger v2 update logging](update/logging.md) — Update logging trigger

  - [yc serverless trigger v2 update mail](update/mail.md) — Update Mail trigger

  - [yc serverless trigger v2 update message-queue](update/message-queue.md) — Update message queue trigger

  - [yc serverless trigger v2 update object-storage](update/object-storage.md) — Update object storage trigger

  - [yc serverless trigger v2 update replace-actions](update/replace-actions.md) — Replace all actions

  - [yc serverless trigger v2 update telegram](update/telegram.md) — Update Telegram trigger

  - [yc serverless trigger v2 update timer](update/timer.md) — Update timer trigger

  - [yc serverless trigger v2 update yandex-messenger](update/yandex-messenger.md) — Update Yandex Messenger trigger

  - [yc serverless trigger v2 update yds](update/yds.md) — Update YDS trigger

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