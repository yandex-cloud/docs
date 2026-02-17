---
editable: false
---

# yc kms asymmetric-encryption-key

Manage asymmetric encryption keys

#### Command Usage

Syntax:

`yc kms asymmetric-encryption-key <command>`

Aliases:

- `asymmetric-encryption-keys`

#### Command Tree

- [yc kms asymmetric-encryption-key add-access-binding](add-access-binding.md) — Add access binding for the specified asymmetric encryption key

- [yc kms asymmetric-encryption-key create](create.md) — Create asymmetric encryption key

- [yc kms asymmetric-encryption-key delete](delete.md) — Delete the specified asymmetric encryption key

- [yc kms asymmetric-encryption-key get](get.md) — Show information about the specified asymmetric encryption key

- [yc kms asymmetric-encryption-key list](list.md) — List asymmetric encryption keys of the specified folder

- [yc kms asymmetric-encryption-key list-access-bindings](list-access-bindings.md) — List access bindings for the specified asymmetric encryption key

- [yc kms asymmetric-encryption-key list-operations](list-operations.md) — List operations for the specified asymmetric encryption key

- [yc kms asymmetric-encryption-key remove-access-binding](remove-access-binding.md) — Remove access binding for the specified asymmetric encryption key

- [yc kms asymmetric-encryption-key set-access-bindings](set-access-bindings.md) — Set access bindings for the specified asymmetric encryption key and delete all existing access bindings if there were any

- [yc kms asymmetric-encryption-key update](update.md) — Update the specified asymmetric encryption key

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