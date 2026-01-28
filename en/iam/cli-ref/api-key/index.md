---
editable: false
sourcePath: en/_cli-ref/cli-ref/iam/cli-ref/api-key/index.md
---

# yc iam api-key

Manage service account API keys.
API keys are used for authentication with Yandex Cloud services.

#### Command Usage

Syntax:

`yc iam api-key <command>`

Aliases:

- `api-keys`

#### Command Tree

- [yc iam api-key create](create.md) — Create an API key for the specified service account

- [yc iam api-key delete](delete.md) — Delete the specified API key

- [yc iam api-key get](get.md) — Show information about the specified API key

- [yc iam api-key list](list.md) — List API keys for the specified service account

- [yc iam api-key list-scopes](list-scopes.md) — List of scopes

- [yc iam api-key update](update.md) — Update an API key for the specified service account

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