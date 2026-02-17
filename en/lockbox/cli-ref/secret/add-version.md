---
editable: false
---

# yc lockbox secret add-version

Add new payload version for the specified secret based on an existing one

#### Command Usage

Syntax:

`yc lockbox secret add-version <SECRET-NAME>|<SECRET-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Secret id. ||
|| `--name` | `string`

Secret name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--description` | `string`

Version description. ||
|| `--payload` | `string`

YAML or JSON array defining how to change payload from the base version.
Each item of the array must match the format: https://yandex.cloud/ru/docs/lockbox/api-ref/grpc/Secret/create#yandex.cloud.lockbox.v1.PayloadEntryChange
For instance, to modify the value of "password" entry from the base version payload:
        [{"key": "username", "text_value": "alice"}, {"key": "password", "text_value": "p@$$w0rd"}]
the following JSON can be passed:
        [{"key": "password", "text_value": "another-p@$$w0rd"}]
so the resulting payload of the newly added version will be:
        [{"key": "username", "text_value": "alice"}, {"key": "password", "text_value": "another-p@$$w0rd"}]
To remove the entry pass an item containing only the "key" field, e.g.:
        [..., {"key": "the-key-of-the-entry-to-remove"}, ...]
Use - value to pass payload string via stdin. ||
|| `--base-version-id` | `string`

Base version id. By default, the current one is used. ||
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