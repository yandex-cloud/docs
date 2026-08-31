---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/serverless/cli-ref/trigger/v2/create/yandex-messenger/
---

# yc serverless trigger v2 create yandex-messenger

Create Yandex Messenger trigger

#### Command Usage

Syntax:

`yc serverless trigger v2 create yandex-messenger <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

Trigger name. ||
|| `--description` | `string`

Trigger description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--action` | `value[,value]`

Action as JSON or '@path/to/file.json'. To set multiple actions, use multiple --action flags. ||
|| `--oauth-token` | `string`

Bot oauth token. Required ||
|| `--force` | Overwrite a webhook the bot already has set to a different URL, instead of failing with "webhook already in use".
If the webhook already points to this trigger, force does nothing - the existing webhook is kept. ||
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