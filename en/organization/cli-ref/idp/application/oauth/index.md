---
editable: false
---

# yc organization-manager idp application oauth

Manage oauth applications and related resources

#### Command Usage

Syntax:

`yc organization-manager idp application oauth <group>`

Aliases:

- `application-oauth`

#### Command Tree

- [yc organization-manager idp application oauth application](application/index.md) — Manage OAuth applications

  - [yc organization-manager idp application oauth application add-access-bindings](application/add-access-bindings.md) — Add access bindings for the specified OAuth application

  - [yc organization-manager idp application oauth application add-assignments](application/add-assignments.md) — Add user assignments for the specified OAuth application

  - [yc organization-manager idp application oauth application create](application/create.md) — Create an OAuth application

  - [yc organization-manager idp application oauth application delete](application/delete.md) — Delete the specified OAuth application

  - [yc organization-manager idp application oauth application get](application/get.md) — Show information about the specified OAuth application

  - [yc organization-manager idp application oauth application list](application/list.md) — List OAuth applications

  - [yc organization-manager idp application oauth application list-access-bindings](application/list-access-bindings.md) — List access bindings for the specified OAuth application

  - [yc organization-manager idp application oauth application list-assignments](application/list-assignments.md) — List user assignments for the specified OAuth application

  - [yc organization-manager idp application oauth application list-operations](application/list-operations.md) — List operations for the specified OAuth application

  - [yc organization-manager idp application oauth application reactivate](application/reactivate.md) — Reactivate a previously suspended OAuth application

  - [yc organization-manager idp application oauth application remove-access-bindings](application/remove-access-bindings.md) — Remove access bindings from the specified OAuth application

  - [yc organization-manager idp application oauth application remove-assignments](application/remove-assignments.md) — Remove user assignments from the specified OAuth application

  - [yc organization-manager idp application oauth application set-access-bindings](application/set-access-bindings.md) — Set access bindings for the specified OAuth application

  - [yc organization-manager idp application oauth application suspend](application/suspend.md) — Suspend the specified OAuth application

  - [yc organization-manager idp application oauth application update](application/update.md) — Update the specified OAuth application

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