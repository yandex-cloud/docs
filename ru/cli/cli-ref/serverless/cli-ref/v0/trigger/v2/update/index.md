---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/v0/trigger/v2/update/
---

# yc serverless v0 trigger v2 update

Update the specified trigger. Only basic attributes are updated. Use subcommands to update source and actions.

#### Command Usage

Syntax:

`yc serverless v0 trigger v2 update <command>`

#### Command Tree

- [yc serverless v0 trigger v2 update add-actions](add-actions.md) — Add actions to the trigger

- [yc serverless v0 trigger v2 update billing-budget](billing-budget.md) — Update billing budget trigger

- [yc serverless v0 trigger v2 update container-registry](container-registry.md) — Update container registry trigger

- [yc serverless v0 trigger v2 update internet-of-things](internet-of-things.md) — Update internet of things trigger

- [yc serverless v0 trigger v2 update iot-broker](iot-broker.md) — Update IoT broker trigger

- [yc serverless v0 trigger v2 update logging](logging.md) — Update logging trigger

- [yc serverless v0 trigger v2 update mail](mail.md) — Update Mail trigger

- [yc serverless v0 trigger v2 update max](max.md) — Update MAX trigger

- [yc serverless v0 trigger v2 update message-queue](message-queue.md) — Update message queue trigger

- [yc serverless v0 trigger v2 update object-storage](object-storage.md) — Update object storage trigger

- [yc serverless v0 trigger v2 update replace-actions](replace-actions.md) — Replace all actions

- [yc serverless v0 trigger v2 update telegram](telegram.md) — Update Telegram trigger

- [yc serverless v0 trigger v2 update timer](timer.md) — Update timer trigger

- [yc serverless v0 trigger v2 update yandex-forms](yandex-forms.md) — Update Yandex Forms trigger

- [yc serverless v0 trigger v2 update yandex-messenger](yandex-messenger.md) — Update Yandex Messenger trigger

- [yc serverless v0 trigger v2 update yds](yds.md) — Update YDS trigger

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

Trigger new name. ||
|| `--description` | `string`

Trigger description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. All existing labels are replaced ||
|| `--id` | `string`

Trigger id. ||
|| `--name` | `string`

Trigger name. ||
|#

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