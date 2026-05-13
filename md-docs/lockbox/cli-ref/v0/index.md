# yc lockbox v0

Manage Yandex Lockbox resources

#### Command Usage

Syntax:

`yc lockbox v0 <group>`

#### Command Tree

- [yc lockbox v0 payload](payload/index.md) — Access secret payload

  - [yc lockbox v0 payload get](payload/get.md) — Get payload of the specified secret

- [yc lockbox v0 secret](secret/index.md) — Manage secrets

  - [yc lockbox v0 secret activate](secret/activate.md) — Activate the specified secret

  - [yc lockbox v0 secret add-access-binding](secret/add-access-binding.md) — Add access binding for the specified secret

  - [yc lockbox v0 secret add-version](secret/add-version.md) — Add new payload version for the specified secret based on an existing one

  - [yc lockbox v0 secret cancel-version-destruction](secret/cancel-version-destruction.md) — Cancel destruction of the specified secret version

  - [yc lockbox v0 secret create](secret/create.md) — Create a secret

  - [yc lockbox v0 secret deactivate](secret/deactivate.md) — Deactivate the specified secret

  - [yc lockbox v0 secret delete](secret/delete.md) — Delete the specified secret

  - [yc lockbox v0 secret get](secret/get.md) — Show information about the specified secret

  - [yc lockbox v0 secret list](secret/list.md) — List secrets for the specified folder

  - [yc lockbox v0 secret list-access-bindings](secret/list-access-bindings.md) — List access bindings for the specified secret

  - [yc lockbox v0 secret list-operations](secret/list-operations.md) — List operations for the specified secret

  - [yc lockbox v0 secret list-versions](secret/list-versions.md) — List versions for the specified secret

  - [yc lockbox v0 secret remove-access-binding](secret/remove-access-binding.md) — Remove access binding for the specified secret

  - [yc lockbox v0 secret schedule-version-destruction](secret/schedule-version-destruction.md) — Schedule destruction of the specified secret version

  - [yc lockbox v0 secret set-access-bindings](secret/set-access-bindings.md) — Set access bindings for the specified secret and delete all existing access bindings if there were any

  - [yc lockbox v0 secret update](secret/update.md) — Update the specified secret

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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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