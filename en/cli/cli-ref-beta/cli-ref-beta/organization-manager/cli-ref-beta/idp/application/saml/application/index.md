---
editable: false
noIndex: true
---

# yc beta organization-manager idp application saml application

A set of methods for managing SAML applications in the Identity Provider system.

#### Command Usage

Syntax:

`yc beta organization-manager idp application saml application <command>`

#### Command Tree

- [yc beta organization-manager idp application saml application create](create.md) — Creates a SAML application in the specified organization.

- [yc beta organization-manager idp application saml application delete](delete.md) — Deletes the specified SAML application.

- [yc beta organization-manager idp application saml application get](get.md) — Returns the specified SAML application.

- [yc beta organization-manager idp application saml application list](list.md) — Retrieves the list of SAML applications in the specified organization.

- [yc beta organization-manager idp application saml application list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified SAML application.

- [yc beta organization-manager idp application saml application list-assignments](list-assignments.md) — Lists assignments for the specified SAML application.

- [yc beta organization-manager idp application saml application list-operations](list-operations.md) — Lists operations for the specified SAML application.

- [yc beta organization-manager idp application saml application list-supported-attribute-values](list-supported-attribute-values.md) — Returns the list of supported attribute values for SAML applications.

- [yc beta organization-manager idp application saml application reactivate](reactivate.md) — Reactivates a previously suspended SAML application.

- [yc beta organization-manager idp application saml application set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified SAML application.

- [yc beta organization-manager idp application saml application suspend](suspend.md) — Suspends the specified SAML application.

- [yc beta organization-manager idp application saml application update](update.md) — Updates the specified SAML application.

- [yc beta organization-manager idp application saml application update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified SAML application.

- [yc beta organization-manager idp application saml application update-assignments](update-assignments.md) — Updates assignments for the specified SAML application.

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