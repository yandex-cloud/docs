---
editable: false
---

# yc resource-manager

Manage Yandex Resource Manager resources

#### Command Usage

Syntax:

`yc resource-manager <group>`

Aliases:

- `resource`

#### Command Tree

- [yc resource-manager cloud](cloud/index.md) — Manage clouds

  - [yc resource-manager cloud add-access-binding](cloud/add-access-binding.md) — Add access binding for the specified cloud

  - [yc resource-manager cloud add-labels](cloud/add-labels.md) — Add labels to specified cloud

  - [yc resource-manager cloud bind-access-policy](cloud/bind-access-policy.md) — Bind access policy to the specified cloud

  - [yc resource-manager cloud create](cloud/create.md) — Create a cloud

  - [yc resource-manager cloud delete](cloud/delete.md) — Delete the specified cloud

  - [yc resource-manager cloud get](cloud/get.md) — Show information about the specified cloud

  - [yc resource-manager cloud list](cloud/list.md) — List clouds

  - [yc resource-manager cloud list-access-bindings](cloud/list-access-bindings.md) — List access bindings for the specified cloud

  - [yc resource-manager cloud list-access-policy-bindings](cloud/list-access-policy-bindings.md) — List access policy bindings for the specified cloud

  - [yc resource-manager cloud list-operations](cloud/list-operations.md) — List operations for the specified cloud

  - [yc resource-manager cloud remove-access-binding](cloud/remove-access-binding.md) — Remove access binding for the specified cloud

  - [yc resource-manager cloud remove-labels](cloud/remove-labels.md) — Remove labels from specified cloud

  - [yc resource-manager cloud set-access-bindings](cloud/set-access-bindings.md) — Set access bindings for the specified cloud and delete all existing access bindings if there were any

  - [yc resource-manager cloud unbind-access-policy](cloud/unbind-access-policy.md) — Unbind access policy from the specified cloud

  - [yc resource-manager cloud update](cloud/update.md) — Update the specified cloud

- [yc resource-manager folder](folder/index.md) — Manage folders

  - [yc resource-manager folder add-access-binding](folder/add-access-binding.md) — Add access binding for the specified folder

  - [yc resource-manager folder add-labels](folder/add-labels.md) — Add labels to specified folder

  - [yc resource-manager folder bind-access-policy](folder/bind-access-policy.md) — Bind access policy to the specified folder

  - [yc resource-manager folder create](folder/create.md) — Create a folder

  - [yc resource-manager folder delete](folder/delete.md) — Delete the specified folder

  - [yc resource-manager folder get](folder/get.md) — Show information about the specified folder

  - [yc resource-manager folder list](folder/list.md) — List folders

  - [yc resource-manager folder list-access-bindings](folder/list-access-bindings.md) — List access bindings for the specified folder

  - [yc resource-manager folder list-access-policy-bindings](folder/list-access-policy-bindings.md) — List access policy bindings for the specified folder

  - [yc resource-manager folder list-operations](folder/list-operations.md) — List operations for the specified folder

  - [yc resource-manager folder remove-access-binding](folder/remove-access-binding.md) — Remove access binding for the specified folder

  - [yc resource-manager folder remove-labels](folder/remove-labels.md) — Remove labels from specified folder

  - [yc resource-manager folder set-access-bindings](folder/set-access-bindings.md) — Set access bindings for the specified folder and delete all existing access bindings if there were any

  - [yc resource-manager folder unbind-access-policy](folder/unbind-access-policy.md) — Unbind access policy from the specified folder

  - [yc resource-manager folder update](folder/update.md) — Update the specified folder

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#