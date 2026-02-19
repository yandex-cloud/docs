---
editable: false
noIndex: true
---

# yc beta cic

[PREVIEW] Manage Interconnect resources

#### Command Usage

Syntax:

`yc beta cic <group>`

#### Command Tree

- [yc beta cic partner](partner/index.md) — A set of methods for managing Partner resources.

  - [yc beta cic partner get](partner/get.md) — Returns the specified Partner resource.

  - [yc beta cic partner list](partner/list.md) — Retrieves the list of Partner resources in the specified folder.

- [yc beta cic point-of-presence](point-of-presence/index.md) — A set of methods for managing PointOfPresence resources.

  - [yc beta cic point-of-presence get](point-of-presence/get.md) — Returns the specified PointOfPresence resource.

  - [yc beta cic point-of-presence list](point-of-presence/list.md) — Retrieves the list of PointOfPresence resources in the specified folder.

- [yc beta cic private-connection](private-connection/index.md) — A set of methods for managing PrivateConnection resources.

  - [yc beta cic private-connection create](private-connection/create.md) — Creates a PrivateConnection resource in the specified folder using the data specified in the request.

  - [yc beta cic private-connection delete](private-connection/delete.md) — Deletes a PrivateConnection resource.

  - [yc beta cic private-connection get](private-connection/get.md) — Returns the specified PrivateConnection resource.

  - [yc beta cic private-connection list](private-connection/list.md) — Retrieves the list of PrivateConnection resources in the specified folder.

  - [yc beta cic private-connection list-operations](private-connection/list-operations.md) — Lists operations for the specified PrivateConnection.

  - [yc beta cic private-connection move](private-connection/move.md) — Moves the specified PrivateConnection to another folder.

  - [yc beta cic private-connection remove-static-route](private-connection/remove-static-route.md) — Removes specified static routes to a PrivateConnection resource.

  - [yc beta cic private-connection update](private-connection/update.md) — Updates a PrivateConnection resource using the data specified in the request.

  - [yc beta cic private-connection upsert-static-route](private-connection/upsert-static-route.md) — Upserts specified static routes to a PrivateConnection resource.

- [yc beta cic public-connection](public-connection/index.md) — A set of methods for managing PublicConnection resources.

  - [yc beta cic public-connection get](public-connection/get.md) — Returns the specified PublicConnection resource.

  - [yc beta cic public-connection list](public-connection/list.md) — Retrieves the list of PublicConnection resources in the specified folder.

  - [yc beta cic public-connection move](public-connection/move.md) — Moves the specified PublicConnection to another folder.

- [yc beta cic trunk-connection](trunk-connection/index.md) — A set of methods for managing TrunkConnection resources.

  - [yc beta cic trunk-connection create](trunk-connection/create.md) — Creates a TrunkConnection resource in the specified folder using the data specified in the request.

  - [yc beta cic trunk-connection delete](trunk-connection/delete.md) — Deletes a TrunkConnection resource.

  - [yc beta cic trunk-connection get](trunk-connection/get.md) — Returns the specified TrunkConnection resource.

  - [yc beta cic trunk-connection list](trunk-connection/list.md) — Retrieves the list of TrunkConnection resources in the specified folder.

  - [yc beta cic trunk-connection list-operations](trunk-connection/list-operations.md) — Lists operations for the specified TrunkConnection.

  - [yc beta cic trunk-connection move](trunk-connection/move.md) — Moves the specified TrunkConnection to another folder.

  - [yc beta cic trunk-connection update](trunk-connection/update.md) — Updates a TrunkConnection resource using the data specified in the request.

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