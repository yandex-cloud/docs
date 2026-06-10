---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cic/cli-ref/v0/
---

# yc cic v0

[PREVIEW] Manage Yandex Cloud Interconnect resources

#### Command Usage

Syntax:

`yc cic v0 <group>`

#### Command Tree

- [yc cic v0 partner](partner/index.md) — [PREVIEW] Manage partners.

  - [yc cic v0 partner get](partner/get.md) — Get information about a partner.

  - [yc cic v0 partner list](partner/list.md) — List partners in a folder.

- [yc cic v0 point-of-presence](point-of-presence/index.md) — [PREVIEW] Manage point of presences.

  - [yc cic v0 point-of-presence get](point-of-presence/get.md) — Get information about a point of presence.

  - [yc cic v0 point-of-presence list](point-of-presence/list.md) — List point of presences in a folder.

- [yc cic v0 private-connection](private-connection/index.md) — [PREVIEW] Manage privateConnections.

  - [yc cic v0 private-connection add-labels](private-connection/add-labels.md) — Assign labels to a privateConnection.

  - [yc cic v0 private-connection batch-get](private-connection/batch-get.md) — Get information about several privateConnections in one request.

  - [yc cic v0 private-connection create](private-connection/create.md) — Create a privateConnection.

  - [yc cic v0 private-connection delete](private-connection/delete.md) — Delete a privateConnection.

  - [yc cic v0 private-connection get](private-connection/get.md) — Get information about a privateConnection.

  - [yc cic v0 private-connection list](private-connection/list.md) — List privateConnections in a folder.

  - [yc cic v0 private-connection list-operations](private-connection/list-operations.md) — List operations for a privateConnection.

  - [yc cic v0 private-connection move](private-connection/move.md) — Move the specified private connection into the folder

  - [yc cic v0 private-connection remove-labels](private-connection/remove-labels.md) — Remove labels from a privateConnection.

  - [yc cic v0 private-connection remove-static-routes](private-connection/remove-static-routes.md) — Remove static routes from a privateConnection.

  - [yc cic v0 private-connection update](private-connection/update.md) — Modify configuration or attributes of a privateConnection.

  - [yc cic v0 private-connection upsert-static-routes](private-connection/upsert-static-routes.md) — Upsert static routes to a privateConnection.

- [yc cic v0 public-connection](public-connection/index.md) — [PREVIEW] Manage publicConnections.

  - [yc cic v0 public-connection get](public-connection/get.md) — Get information about an publicConnection.

  - [yc cic v0 public-connection list](public-connection/list.md) — List publicConnections in a folder.

  - [yc cic v0 public-connection list-operations](public-connection/list-operations.md) — List operations for a publicConnection.

  - [yc cic v0 public-connection move](public-connection/move.md) — Move the specified public connection into the folder

- [yc cic v0 trunk-connection](trunk-connection/index.md) — [PREVIEW] Manage trunk connections.

  - [yc cic v0 trunk-connection add-labels](trunk-connection/add-labels.md) — Add labels to a trunk connection.

  - [yc cic v0 trunk-connection batch-get](trunk-connection/batch-get.md) — Get information about several trunk connections in one request.

  - [yc cic v0 trunk-connection delete](trunk-connection/delete.md) — Delete a trunk connection.

  - [yc cic v0 trunk-connection get](trunk-connection/get.md) — Get information about a trunk connection.

  - [yc cic v0 trunk-connection list](trunk-connection/list.md) — List trunk connections in a folder.

  - [yc cic v0 trunk-connection list-operations](trunk-connection/list-operations.md) — List operations for a trunk connection.

  - [yc cic v0 trunk-connection list-private-connections](trunk-connection/list-private-connections.md) — List private connections for a trunk connection.

  - [yc cic v0 trunk-connection list-public-connections](trunk-connection/list-public-connections.md) — List public connections for a trunk connection.

  - [yc cic v0 trunk-connection move](trunk-connection/move.md) — Move the specified trunk connection into the folder

  - [yc cic v0 trunk-connection remove-labels](trunk-connection/remove-labels.md) — Remove labels from a trunk connection.

  - [yc cic v0 trunk-connection update](trunk-connection/update.md) — Modify configuration or attributes of a trunk connection.

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