---
editable: false
noIndex: true
---

# yc beta lockbox secret

A set of methods for managing secrets.

#### Command Usage

Syntax:

`yc beta lockbox secret <command>`

#### Command Tree

- [yc beta lockbox secret activate](activate.md) — Activates the specified secret.

- [yc beta lockbox secret add-version](add-version.md) — Adds new version based on a previous one.

- [yc beta lockbox secret cancel-version-destruction](cancel-version-destruction.md) — Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.

- [yc beta lockbox secret create](create.md) — Creates a secret in the specified folder.

- [yc beta lockbox secret deactivate](deactivate.md) — Deactivates the specified secret.

- [yc beta lockbox secret delete](delete.md) — Deletes the specified secret.

- [yc beta lockbox secret get](get.md) — Returns the specified secret.

- [yc beta lockbox secret list](list.md) — Retrieves the list of secrets in the specified folder.

- [yc beta lockbox secret list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified secret.

- [yc beta lockbox secret list-operations](list-operations.md) — Lists operations for the specified secret.

- [yc beta lockbox secret list-versions](list-versions.md) — Retrieves the list of versions of the specified secret.

- [yc beta lockbox secret schedule-version-destruction](schedule-version-destruction.md) — Schedules the specified version for destruction.

- [yc beta lockbox secret set-access-bindings](set-access-bindings.md) — Sets access bindings for the secret.

- [yc beta lockbox secret update](update.md) — Updates the specified secret.

- [yc beta lockbox secret update-access-bindings](update-access-bindings.md) — Updates access bindings for the secret.

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