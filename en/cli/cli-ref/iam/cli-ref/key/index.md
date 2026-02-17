---
editable: false
---

# yc iam key

Manage IAM keys.
IAM keys can be issued for authenticated user account or a service account.
IAM key may be used to authorize service account in CLI and API.

#### Command Usage

Syntax:

`yc iam key <command>`

Aliases:

- `keys`

#### Command Tree

- [yc iam key create](create.md) — Create an IAM key for for authenticated account or the specified service account

- [yc iam key delete](delete.md) — Delete the specified IAM key

- [yc iam key get](get.md) — Show information about the specified IAM key

- [yc iam key list](list.md) — List IAM keys for authenticated account or the specified service account

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