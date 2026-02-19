---
editable: false
noIndex: true
---

# yc beta resource-manager

Manage Yandex Resource Manager resources

#### Command Usage

Syntax:

`yc beta resource-manager <group>`

#### Command Tree

- [yc beta resource-manager cloud](cloud/index.md) — A set of methods for managing Cloud resources.

  - [yc beta resource-manager cloud bind-access-policy](cloud/bind-access-policy.md) — Binds the access policy template to the cloud.

  - [yc beta resource-manager cloud create](cloud/create.md) — Creates a cloud in the specified organization.

  - [yc beta resource-manager cloud delete](cloud/delete.md) — Deletes the specified cloud.

  - [yc beta resource-manager cloud get](cloud/get.md) — Returns the specified Cloud resource.

  - [yc beta resource-manager cloud list](cloud/list.md) — Retrieves the list of Cloud resources.

  - [yc beta resource-manager cloud list-access-bindings](cloud/list-access-bindings.md) — Lists access bindings for the specified cloud.

  - [yc beta resource-manager cloud list-access-policy-bindings](cloud/list-access-policy-bindings.md) — Returns list of access policy bindings for the cloud.

  - [yc beta resource-manager cloud list-operations](cloud/list-operations.md) — Lists operations for the specified cloud.

  - [yc beta resource-manager cloud set-access-bindings](cloud/set-access-bindings.md) — Sets access bindings for the specified cloud.

  - [yc beta resource-manager cloud unbind-access-policy](cloud/unbind-access-policy.md) — Unbinds the access policy template from the cloud.

  - [yc beta resource-manager cloud update](cloud/update.md) — Updates the specified cloud.

  - [yc beta resource-manager cloud update-access-bindings](cloud/update-access-bindings.md) — Updates access bindings for the specified cloud.

- [yc beta resource-manager folder](folder/index.md) — A set of methods for managing Folder resources.

  - [yc beta resource-manager folder bind-access-policy](folder/bind-access-policy.md) — Binds the access policy template to the folder.

  - [yc beta resource-manager folder create](folder/create.md) — Creates a folder in the specified cloud.

  - [yc beta resource-manager folder delete](folder/delete.md) — Deletes the specified folder.

  - [yc beta resource-manager folder get](folder/get.md) — Returns the specified Folder resource.

  - [yc beta resource-manager folder list](folder/list.md) — Retrieves the list of Folder resources in the specified cloud.

  - [yc beta resource-manager folder list-access-bindings](folder/list-access-bindings.md) — Lists access bindings for the specified folder.

  - [yc beta resource-manager folder list-access-policy-bindings](folder/list-access-policy-bindings.md) — Returns list of access policy bindings for the folder.

  - [yc beta resource-manager folder list-operations](folder/list-operations.md) — Lists operations for the specified folder.

  - [yc beta resource-manager folder set-access-bindings](folder/set-access-bindings.md) — Sets access bindings for the specified folder.

  - [yc beta resource-manager folder unbind-access-policy](folder/unbind-access-policy.md) — Unbinds the access policy template from the folder.

  - [yc beta resource-manager folder update](folder/update.md) — Updates the specified folder.

  - [yc beta resource-manager folder update-access-bindings](folder/update-access-bindings.md) — Updates access bindings for the specified folder.

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