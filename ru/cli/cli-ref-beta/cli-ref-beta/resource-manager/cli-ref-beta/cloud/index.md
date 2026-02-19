---
editable: false
noIndex: true
---

# yc beta resource-manager cloud

A set of methods for managing Cloud resources.

#### Command Usage

Syntax:

`yc beta resource-manager cloud <command>`

#### Command Tree

- [yc beta resource-manager cloud bind-access-policy](bind-access-policy.md) — Binds the access policy template to the cloud.

- [yc beta resource-manager cloud create](create.md) — Creates a cloud in the specified organization.

- [yc beta resource-manager cloud delete](delete.md) — Deletes the specified cloud.

- [yc beta resource-manager cloud get](get.md) — Returns the specified Cloud resource.

- [yc beta resource-manager cloud list](list.md) — Retrieves the list of Cloud resources.

- [yc beta resource-manager cloud list-access-bindings](list-access-bindings.md) — Lists access bindings for the specified cloud.

- [yc beta resource-manager cloud list-access-policy-bindings](list-access-policy-bindings.md) — Returns list of access policy bindings for the cloud.

- [yc beta resource-manager cloud list-operations](list-operations.md) — Lists operations for the specified cloud.

- [yc beta resource-manager cloud set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified cloud.

- [yc beta resource-manager cloud unbind-access-policy](unbind-access-policy.md) — Unbinds the access policy template from the cloud.

- [yc beta resource-manager cloud update](update.md) — Updates the specified cloud.

- [yc beta resource-manager cloud update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified cloud.

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