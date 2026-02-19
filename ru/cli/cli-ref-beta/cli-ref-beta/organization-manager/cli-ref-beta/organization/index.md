---
editable: false
noIndex: true
---

# yc beta organization-manager organization

A set of methods for managing Organization resources.

#### Command Usage

Syntax:

`yc beta organization-manager organization <command>`

#### Command Tree

- [yc beta organization-manager organization bind-access-policy](bind-access-policy.md) — Binds the access policy template to the organization.

- [yc beta organization-manager organization get](get.md) — Returns the specified Organization resource.

- [yc beta organization-manager organization list](list.md) — Retrieves the list of Organization resources.

- [yc beta organization-manager organization list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified organization.

- [yc beta organization-manager organization list-access-policy-bindings](list-access-policy-bindings.md) — Returns list of access policy bindings for the organization.

- [yc beta organization-manager organization list-operations](list-operations.md) — Lists operations for the specified organization.

- [yc beta organization-manager organization set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified organization.

- [yc beta organization-manager organization unbind-access-policy](unbind-access-policy.md) — Unbinds the access policy template from the organization.

- [yc beta organization-manager organization update](update.md) — Updates the specified organization.

- [yc beta organization-manager organization update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified organization.

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