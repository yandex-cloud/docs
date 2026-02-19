---
editable: false
noIndex: true
---

# yc beta organization-manager idp application saml signature-certificate

A set of methods for managing signature certificates for SAML applications.

#### Command Usage

Syntax:

`yc beta organization-manager idp application saml signature-certificate <command>`

#### Command Tree

- [yc beta organization-manager idp application saml signature-certificate create](create.md) — Creates a new signature certificate for the specified SAML application.

- [yc beta organization-manager idp application saml signature-certificate delete](delete.md) — Deletes the specified signature certificate.

- [yc beta organization-manager idp application saml signature-certificate get](get.md) — Returns the specified signature certificate.

- [yc beta organization-manager idp application saml signature-certificate list](list.md) — Retrieves the list of signature certificates for the specified SAML application.

- [yc beta organization-manager idp application saml signature-certificate update](update.md) — Updates the specified signature certificate.

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