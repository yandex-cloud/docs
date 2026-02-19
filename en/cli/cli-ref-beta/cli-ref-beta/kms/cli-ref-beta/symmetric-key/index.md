---
editable: false
noIndex: true
---

# yc beta kms symmetric-key

Set of methods for managing symmetric KMS keys.

#### Command Usage

Syntax:

`yc beta kms symmetric-key <command>`

#### Command Tree

- [yc beta kms symmetric-key cancel-version-destruction](cancel-version-destruction.md) — Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.

- [yc beta kms symmetric-key create](create.md) — Creates a symmetric KMS key in the specified folder.

- [yc beta kms symmetric-key delete](delete.md) — Deletes the specified symmetric KMS key. This action also automatically schedules

- [yc beta kms symmetric-key get](get.md) — Returns the specified symmetric KMS key.

- [yc beta kms symmetric-key list](list.md) — Returns the list of symmetric KMS keys in the specified folder.

- [yc beta kms symmetric-key list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified key.

- [yc beta kms symmetric-key list-operations](list-operations.md) — Lists operations for the specified symmetric KMS key.

- [yc beta kms symmetric-key list-versions](list-versions.md) — Returns the list of versions of the specified symmetric KMS key.

- [yc beta kms symmetric-key rotate](rotate.md) — Rotates the specified key: creates a new key version and makes it the primary version.

- [yc beta kms symmetric-key schedule-version-destruction](schedule-version-destruction.md) — Schedules the specified key version for destruction.

- [yc beta kms symmetric-key set-access-bindings](set-access-bindings.md) — Sets access bindings for the key.

- [yc beta kms symmetric-key set-primary-version](set-primary-version.md) — Sets the primary version for the specified key. The primary version is used

- [yc beta kms symmetric-key update](update.md) — Updates the specified symmetric KMS key.

- [yc beta kms symmetric-key update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified key.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#