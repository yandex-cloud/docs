---
editable: false
---

# yc iam oauth-client

Manage oauth-clients.
OAuth clients are used in OAuth and OIDC flows.

#### Command Usage

Syntax:

`yc iam oauth-client <command>`

#### Command Tree

- [yc iam oauth-client create](create.md) — Create an oauth-client in the specified folder

- [yc iam oauth-client delete](delete.md) — Delete the specified oauth-client

- [yc iam oauth-client get](get.md) — Show information about state of a specified oauth-client

- [yc iam oauth-client list](list.md) — List oauth-clients in the specified folder

- [yc iam oauth-client update](update.md) — Update the specified oauth-client

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