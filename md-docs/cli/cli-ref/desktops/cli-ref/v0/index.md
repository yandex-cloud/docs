# yc desktops v0

[PREVIEW] Manage Desktop resources

#### Command Usage

Syntax:

`yc desktops v0 <group>`

#### Command Tree

- [yc desktops v0 desktop](desktop/index.md) — [PREVIEW] Manage desktop instances

  - [yc desktops v0 desktop create](desktop/create.md) — Create a desktop

  - [yc desktops v0 desktop delete](desktop/delete.md) — Delete the specified desktop

  - [yc desktops v0 desktop get](desktop/get.md) — Get information about a desktop

  - [yc desktops v0 desktop get-rdp-file](desktop/get-rdp-file.md) — Download desktop RDP file

  - [yc desktops v0 desktop list](desktop/list.md) — List desktops

  - [yc desktops v0 desktop list-operations](desktop/list-operations.md) — List operations for the specified desktop

  - [yc desktops v0 desktop reset-password](desktop/reset-password.md) — Reset desktop Password

  - [yc desktops v0 desktop restart](desktop/restart.md) — Restart the specified desktop

  - [yc desktops v0 desktop start](desktop/start.md) — Start the specified desktop

  - [yc desktops v0 desktop stop](desktop/stop.md) — Stop the specified desktop

  - [yc desktops v0 desktop update](desktop/update.md) — Update the specified desktop

  - [yc desktops v0 desktop update-properties](desktop/update-properties.md) — Update a desktop

- [yc desktops v0 group](group/index.md) — [PREVIEW] Manage desktop groups

  - [yc desktops v0 group add-access-bindings](group/add-access-bindings.md) — Add access binding for the specified desktop group

  - [yc desktops v0 group create](group/create.md) — Create a desktop group

  - [yc desktops v0 group delete](group/delete.md) — Delete the specified desktop group

  - [yc desktops v0 group get](group/get.md) — Get information about a desktop group

  - [yc desktops v0 group list](group/list.md) — List desktops

  - [yc desktops v0 group list-access-bindings](group/list-access-bindings.md) — List access bindings for the specified desktop group

  - [yc desktops v0 group list-desktops](group/list-desktops.md) — List desktops of the specified desktop group

  - [yc desktops v0 group list-operations](group/list-operations.md) — List operations for the specified desktop group

  - [yc desktops v0 group remove-access-bindings](group/remove-access-bindings.md) — Remove access binding for the specified desktop group

  - [yc desktops v0 group set-access-bindings](group/set-access-bindings.md) — Set access bindings for the specified desktop group and delete all existing access bindings if there were any

  - [yc desktops v0 group update](group/update.md) — Update desktop group

- [yc desktops v0 image](image/index.md) — [PREVIEW] Manage desktop images

  - [yc desktops v0 image copy](image/copy.md) — Create desktop image as copy of the specified desktop or compute image

  - [yc desktops v0 image delete](image/delete.md) — Delete the specified desktop image

  - [yc desktops v0 image get](image/get.md) — Get information about a desktop image

  - [yc desktops v0 image list](image/list.md) — List desktop images

  - [yc desktops v0 image update](image/update.md) — Update the specified desktop image

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
|| `--syntax` | `string`

CLI syntax: 1 (legacy) or 2 (current). Omit to use default-syntax in the profile or the product default. ||
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