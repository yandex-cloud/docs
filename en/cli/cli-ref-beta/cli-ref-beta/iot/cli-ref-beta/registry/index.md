---
editable: false
noIndex: true
---

# yc beta iot registry

A set of methods for managing registry.

#### Command Usage

Syntax:

`yc beta iot registry <command>`

#### Command Tree

- [yc beta iot registry add-certificate](add-certificate.md) — Adds a certificate.

- [yc beta iot registry add-data-stream-export](add-data-stream-export.md) — Adds YDS export for the specified registry.

- [yc beta iot registry add-password](add-password.md) — Adds password for the specified registry.

- [yc beta iot registry create](create.md) — Creates a registry in the specified folder.

- [yc beta iot registry delete](delete.md) — Deletes the specified registry.

- [yc beta iot registry delete-certificate](delete-certificate.md) — Deletes the specified registry certificate.

- [yc beta iot registry delete-data-stream-export](delete-data-stream-export.md) — Deletes the specified YDS export.

- [yc beta iot registry delete-password](delete-password.md) — Deletes the specified password.

- [yc beta iot registry disable](disable.md) — Disables the specified registry.

- [yc beta iot registry enable](enable.md) — Enables the specified registry.

- [yc beta iot registry get](get.md) — Returns the specified registry.

- [yc beta iot registry get-by-name](get-by-name.md) — 

- [yc beta iot registry list](list.md) — Retrieves the list of registries in the specified folder.

- [yc beta iot registry list-certificates](list-certificates.md) — Retrieves the list of registry certificates for the specified registry.

- [yc beta iot registry list-data-stream-exports](list-data-stream-exports.md) — Retrieves the list of YDS exports for the specified registry.

- [yc beta iot registry list-device-topic-aliases](list-device-topic-aliases.md) — Retrieves the list of device topic aliases for the specified registry.

- [yc beta iot registry list-operations](list-operations.md) — Lists operations for the specified registry.

- [yc beta iot registry list-passwords](list-passwords.md) — Retrieves the list of passwords for the specified registry.

- [yc beta iot registry update](update.md) — Updates the specified registry.

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