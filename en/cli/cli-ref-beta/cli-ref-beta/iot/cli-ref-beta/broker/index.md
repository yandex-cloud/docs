---
editable: false
noIndex: true
---

# yc beta iot broker

A set of methods for managing broker.

#### Command Usage

Syntax:

`yc beta iot broker <command>`

#### Command Tree

- [yc beta iot broker add-certificate](add-certificate.md) — Adds a certificate.

- [yc beta iot broker add-password](add-password.md) — Adds password for the specified broker.

- [yc beta iot broker create](create.md) — Creates a broker in the specified folder.

- [yc beta iot broker delete](delete.md) — Deletes the specified broker.

- [yc beta iot broker delete-certificate](delete-certificate.md) — Deletes the specified broker certificate.

- [yc beta iot broker delete-password](delete-password.md) — Deletes the specified password.

- [yc beta iot broker get](get.md) — Returns the specified broker.

- [yc beta iot broker list](list.md) — Retrieves the list of brokers in the specified folder.

- [yc beta iot broker list-certificates](list-certificates.md) — Retrieves the list of broker certificates for the specified broker.

- [yc beta iot broker list-operations](list-operations.md) — Lists operations for the specified broker.

- [yc beta iot broker list-passwords](list-passwords.md) — Retrieves the list of passwords for the specified broker.

- [yc beta iot broker update](update.md) — Updates the specified broker.

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