---
editable: false
noIndex: true
---

# yc beta lockbox

Manage Lockbox resources

#### Command Usage

Syntax:

`yc beta lockbox <group>`

#### Command Tree

- [yc beta lockbox payload](payload/index.md) — Set of methods to access payload of secrets.

  - [yc beta lockbox payload get](payload/get.md) — Returns the payload of the specified secret.

  - [yc beta lockbox payload get-ex](payload/get-ex.md) — 

- [yc beta lockbox secret](secret/index.md) — A set of methods for managing secrets.

  - [yc beta lockbox secret activate](secret/activate.md) — Activates the specified secret.

  - [yc beta lockbox secret add-version](secret/add-version.md) — Adds new version based on a previous one.

  - [yc beta lockbox secret cancel-version-destruction](secret/cancel-version-destruction.md) — Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.

  - [yc beta lockbox secret create](secret/create.md) — Creates a secret in the specified folder.

  - [yc beta lockbox secret deactivate](secret/deactivate.md) — Deactivates the specified secret.

  - [yc beta lockbox secret delete](secret/delete.md) — Deletes the specified secret.

  - [yc beta lockbox secret get](secret/get.md) — Returns the specified secret.

  - [yc beta lockbox secret list](secret/list.md) — Retrieves the list of secrets in the specified folder.

  - [yc beta lockbox secret list-access-bindings](secret/list-access-bindings.md) — Lists existing access bindings for the specified secret.

  - [yc beta lockbox secret list-operations](secret/list-operations.md) — Lists operations for the specified secret.

  - [yc beta lockbox secret list-versions](secret/list-versions.md) — Retrieves the list of versions of the specified secret.

  - [yc beta lockbox secret schedule-version-destruction](secret/schedule-version-destruction.md) — Schedules the specified version for destruction.

  - [yc beta lockbox secret set-access-bindings](secret/set-access-bindings.md) — Sets access bindings for the secret.

  - [yc beta lockbox secret update](secret/update.md) — Updates the specified secret.

  - [yc beta lockbox secret update-access-bindings](secret/update-access-bindings.md) — Updates access bindings for the secret.

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