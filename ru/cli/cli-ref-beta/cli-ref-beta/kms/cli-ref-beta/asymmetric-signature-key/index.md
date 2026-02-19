---
editable: false
noIndex: true
---

# yc beta kms asymmetric-signature-key

Set of methods for managing asymmetric signature keys.

#### Command Usage

Syntax:

`yc beta kms asymmetric-signature-key <command>`

#### Command Tree

- [yc beta kms asymmetric-signature-key create](create.md) — control plane

- [yc beta kms asymmetric-signature-key delete](delete.md) — Deletes the specified asymmetric KMS key. This action also automatically schedules

- [yc beta kms asymmetric-signature-key get](get.md) — Returns the specified asymmetric KMS key.

- [yc beta kms asymmetric-signature-key list](list.md) — Returns the list of asymmetric KMS keys in the specified folder.

- [yc beta kms asymmetric-signature-key list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified key.

- [yc beta kms asymmetric-signature-key list-operations](list-operations.md) — Lists operations for the specified asymmetric KMS key.

- [yc beta kms asymmetric-signature-key set-access-bindings](set-access-bindings.md) — Sets access bindings for the key.

- [yc beta kms asymmetric-signature-key update](update.md) — Updates the specified asymmetric KMS key.

- [yc beta kms asymmetric-signature-key update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified key.

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