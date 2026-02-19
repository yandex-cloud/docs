---
editable: false
noIndex: true
---

# yc beta organization-manager idp application saml



#### Command Usage

Syntax:

`yc beta organization-manager idp application saml <group>`

#### Command Tree

- [yc beta organization-manager idp application saml application](application/index.md) — A set of methods for managing SAML applications in the Identity Provider system.

  - [yc beta organization-manager idp application saml application create](application/create.md) — Creates a SAML application in the specified organization.

  - [yc beta organization-manager idp application saml application delete](application/delete.md) — Deletes the specified SAML application.

  - [yc beta organization-manager idp application saml application get](application/get.md) — Returns the specified SAML application.

  - [yc beta organization-manager idp application saml application list](application/list.md) — Retrieves the list of SAML applications in the specified organization.

  - [yc beta organization-manager idp application saml application list-access-bindings](application/list-access-bindings.md) — Lists access bindings for the specified SAML application.

  - [yc beta organization-manager idp application saml application list-assignments](application/list-assignments.md) — Lists assignments for the specified SAML application.

  - [yc beta organization-manager idp application saml application list-operations](application/list-operations.md) — Lists operations for the specified SAML application.

  - [yc beta organization-manager idp application saml application list-supported-attribute-values](application/list-supported-attribute-values.md) — Returns the list of supported attribute values for SAML applications.

  - [yc beta organization-manager idp application saml application reactivate](application/reactivate.md) — Reactivates a previously suspended SAML application.

  - [yc beta organization-manager idp application saml application set-access-bindings](application/set-access-bindings.md) — Sets access bindings for the specified SAML application.

  - [yc beta organization-manager idp application saml application suspend](application/suspend.md) — Suspends the specified SAML application.

  - [yc beta organization-manager idp application saml application update](application/update.md) — Updates the specified SAML application.

  - [yc beta organization-manager idp application saml application update-access-bindings](application/update-access-bindings.md) — Updates access bindings for the specified SAML application.

  - [yc beta organization-manager idp application saml application update-assignments](application/update-assignments.md) — Updates assignments for the specified SAML application.

- [yc beta organization-manager idp application saml signature-certificate](signature-certificate/index.md) — A set of methods for managing signature certificates for SAML applications.

  - [yc beta organization-manager idp application saml signature-certificate create](signature-certificate/create.md) — Creates a new signature certificate for the specified SAML application.

  - [yc beta organization-manager idp application saml signature-certificate delete](signature-certificate/delete.md) — Deletes the specified signature certificate.

  - [yc beta organization-manager idp application saml signature-certificate get](signature-certificate/get.md) — Returns the specified signature certificate.

  - [yc beta organization-manager idp application saml signature-certificate list](signature-certificate/list.md) — Retrieves the list of signature certificates for the specified SAML application.

  - [yc beta organization-manager idp application saml signature-certificate update](signature-certificate/update.md) — Updates the specified signature certificate.

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