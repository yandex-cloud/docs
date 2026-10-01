---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/trigger/v2/create/
---

# yc serverless trigger v2 create

Create triggers

#### Command Usage

Syntax:

`yc serverless trigger v2 create <command>`

#### Command Tree

- [yc serverless trigger v2 create billing-budget](billing-budget.md) — Create billing budget trigger

- [yc serverless trigger v2 create container-registry](container-registry.md) — Create container registry trigger

- [yc serverless trigger v2 create internet-of-things](internet-of-things.md) — Create internet of things trigger

- [yc serverless trigger v2 create iot-broker](iot-broker.md) — Create IoT broker trigger

- [yc serverless trigger v2 create logging](logging.md) — Create logging trigger

- [yc serverless trigger v2 create mail](mail.md) — Create Mail trigger

- [yc serverless trigger v2 create max](max.md) — Create MAX trigger

- [yc serverless trigger v2 create message-queue](message-queue.md) — Create message queue trigger

- [yc serverless trigger v2 create object-storage](object-storage.md) — Create object storage trigger

- [yc serverless trigger v2 create telegram](telegram.md) — Create Telegram trigger

- [yc serverless trigger v2 create timer](timer.md) — Create timer trigger

- [yc serverless trigger v2 create yandex-forms](yandex-forms.md) — Create Yandex Forms trigger

- [yc serverless trigger v2 create yandex-messenger](yandex-messenger.md) — Create Yandex Messenger trigger

- [yc serverless trigger v2 create yds](yds.md) — Create YDS trigger

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#