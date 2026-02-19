---
editable: false
noIndex: true
---

# yc beta certificate-manager certificate

A set of methods for managing certificates.

#### Command Usage

Syntax:

`yc beta certificate-manager certificate <command>`

#### Command Tree

- [yc beta certificate-manager certificate create](create.md) — Creates a certificate in the specified folder.

- [yc beta certificate-manager certificate delete](delete.md) — Deletes the specified certificate.

- [yc beta certificate-manager certificate get](get.md) — Returns the specified certificate.

- [yc beta certificate-manager certificate list](list.md) — Returns the list of certificates in the specified folder.

- [yc beta certificate-manager certificate list-access-bindings](list-access-bindings.md) — Lists existing access bindings for the specified certificate.

- [yc beta certificate-manager certificate list-operations](list-operations.md) — Lists operations for the specified certificate.

- [yc beta certificate-manager certificate list-versions](list-versions.md) — 

- [yc beta certificate-manager certificate request-new](request-new.md) — Request a certificate in the specified folder.

- [yc beta certificate-manager certificate set-access-bindings](set-access-bindings.md) — Sets access bindings for the certificate.

- [yc beta certificate-manager certificate update](update.md) — Updates the specified certificate.

- [yc beta certificate-manager certificate update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified certificate.

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