---
editable: false
---

# yc serverless eventrouter rule

Manage rules

#### Command Usage

Syntax:

`yc serverless eventrouter rule <command>`

#### Command Tree

- [yc serverless eventrouter rule add-access-binding](add-access-binding.md) — Add access binding for the specified rule

- [yc serverless eventrouter rule create](create.md) — Create a rule

- [yc serverless eventrouter rule delete](delete.md) — Delete the specified rule(es)

- [yc serverless eventrouter rule disable](disable.md) — Enable the specified rule

- [yc serverless eventrouter rule enable](enable.md) — Enable the specified rule

- [yc serverless eventrouter rule get](get.md) — Show information about the specified rule(es)

- [yc serverless eventrouter rule list](list.md) — List rulees

- [yc serverless eventrouter rule list-access-bindings](list-access-bindings.md) — List access bindings for the specified function

- [yc serverless eventrouter rule list-operations](list-operations.md) — Show operations for the specified rule

- [yc serverless eventrouter rule remove-access-binding](remove-access-binding.md) — Remove access binding for the specified rule

- [yc serverless eventrouter rule set-access-bindings](set-access-bindings.md) — Set access bindings for the specified rule and delete all existing access bindings if there were any

- [yc serverless eventrouter rule update](update.md) — Update the specified rule

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