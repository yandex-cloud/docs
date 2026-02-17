---
editable: false
---

# yc serverless eventrouter bus

Manage buses

#### Command Usage

Syntax:

`yc serverless eventrouter bus <command>`

#### Command Tree

- [yc serverless eventrouter bus add-access-binding](add-access-binding.md) — Add access binding for the specified bus

- [yc serverless eventrouter bus create](create.md) — Create a bus

- [yc serverless eventrouter bus delete](delete.md) — Delete the specified bus(es)

- [yc serverless eventrouter bus get](get.md) — Show information about the specified bus(es)

- [yc serverless eventrouter bus list](list.md) — List buses

- [yc serverless eventrouter bus list-access-bindings](list-access-bindings.md) — List access bindings for the specified function

- [yc serverless eventrouter bus list-operations](list-operations.md) — Show operations for the specified bus

- [yc serverless eventrouter bus remove-access-binding](remove-access-binding.md) — Remove access binding for the specified bus

- [yc serverless eventrouter bus set-access-bindings](set-access-bindings.md) — Set access bindings for the specified bus and delete all existing access bindings if there were any

- [yc serverless eventrouter bus update](update.md) — Update the specified bus

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