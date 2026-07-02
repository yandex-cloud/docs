[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Interconnect](../../index.md) > [Справочник CLI (англ.)](../index.md) > v1 > Overview

# yc cic v1

Manage Interconnect resources

#### Command Usage

Syntax:

`yc cic v1 <group>`

#### Command Tree

- [yc cic v1 partner](partner/index.md) — A set of methods for managing Partner resources.

  - [yc cic v1 partner get](partner/get.md) — Returns the specified Partner resource.

  - [yc cic v1 partner list](partner/list.md) — Retrieves the list of Partner resources in the specified folder.

- [yc cic v1 point-of-presence](point-of-presence/index.md) — A set of methods for managing PointOfPresence resources.

  - [yc cic v1 point-of-presence get](point-of-presence/get.md) — Returns the specified PointOfPresence resource.

  - [yc cic v1 point-of-presence list](point-of-presence/list.md) — Retrieves the list of PointOfPresence resources in the specified folder.

- [yc cic v1 private-connection](private-connection/index.md) — A set of methods for managing PrivateConnection resources.

  - [yc cic v1 private-connection add-labels](private-connection/add-labels.md) — Assign labels to a privateConnection.

  - [yc cic v1 private-connection batch-get](private-connection/batch-get.md) — Get list of PrivateConnections by their IDs

  - [yc cic v1 private-connection create](private-connection/create.md) — Create a privateConnection.

  - [yc cic v1 private-connection delete](private-connection/delete.md) — Deletes a PrivateConnection resource.

  - [yc cic v1 private-connection get](private-connection/get.md) — Returns the specified PrivateConnection resource.

  - [yc cic v1 private-connection list](private-connection/list.md) — Retrieves the list of PrivateConnection resources in the specified folder.

  - [yc cic v1 private-connection list-operations](private-connection/list-operations.md) — Lists operations for the specified PrivateConnection.

  - [yc cic v1 private-connection move](private-connection/move.md) — Moves the specified PrivateConnection to another folder.

  - [yc cic v1 private-connection remove-labels](private-connection/remove-labels.md) — Remove labels from a privateConnection.

  - [yc cic v1 private-connection remove-static-routes](private-connection/remove-static-routes.md) — Remove static routes from a privateConnection.

  - [yc cic v1 private-connection update](private-connection/update.md) — Modify configuration or attributes of a privateConnection.

  - [yc cic v1 private-connection upsert-static-routes](private-connection/upsert-static-routes.md) — Upsert static routes to a privateConnection.

- [yc cic v1 public-connection](public-connection/index.md) — A set of methods for managing PublicConnection resources.

  - [yc cic v1 public-connection get](public-connection/get.md) — Returns the specified PublicConnection resource.

  - [yc cic v1 public-connection list](public-connection/list.md) — Retrieves the list of PublicConnection resources in the specified folder.

  - [yc cic v1 public-connection list-operations](public-connection/list-operations.md) — 

  - [yc cic v1 public-connection move](public-connection/move.md) — Moves the specified PublicConnection to another folder.

- [yc cic v1 trunk-connection](trunk-connection/index.md) — A set of methods for managing TrunkConnection resources.

  - [yc cic v1 trunk-connection add-labels](trunk-connection/add-labels.md) — Add labels to a trunk connection.

  - [yc cic v1 trunk-connection batch-get](trunk-connection/batch-get.md) — 

  - [yc cic v1 trunk-connection delete](trunk-connection/delete.md) — Deletes a TrunkConnection resource.

  - [yc cic v1 trunk-connection get](trunk-connection/get.md) — Returns the specified TrunkConnection resource.

  - [yc cic v1 trunk-connection list](trunk-connection/list.md) — Retrieves the list of TrunkConnection resources in the specified folder.

  - [yc cic v1 trunk-connection list-operations](trunk-connection/list-operations.md) — Lists operations for the specified TrunkConnection.

  - [yc cic v1 trunk-connection list-private-connections](trunk-connection/list-private-connections.md) — Retrieves the list of PrivateConnection resources associated with the specified TrunkConnection.

  - [yc cic v1 trunk-connection list-public-connections](trunk-connection/list-public-connections.md) — Retrieves the list of PublicConnection resources associated with the specified TrunkConnection.

  - [yc cic v1 trunk-connection move](trunk-connection/move.md) — Moves the specified TrunkConnection to another folder.

  - [yc cic v1 trunk-connection remove-labels](trunk-connection/remove-labels.md) — Remove labels from a trunk connection.

  - [yc cic v1 trunk-connection update](trunk-connection/update.md) — Modify configuration or attributes of a trunk connection.

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
|| `--no-pager` | Do not pipe help output through a pager. ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#