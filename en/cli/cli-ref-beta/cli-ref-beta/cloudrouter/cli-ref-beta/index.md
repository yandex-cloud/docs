---
editable: false
noIndex: true
---

# yc beta cloudrouter

[PREVIEW] Manage Cloud Router resources

#### Command Usage

Syntax:

`yc beta cloudrouter <group>`

#### Command Tree

- [yc beta cloudrouter routing-instance](routing-instance/index.md) — A set of methods for managing RoutingInstance resources.

  - [yc beta cloudrouter routing-instance add-private-connection](routing-instance/add-private-connection.md) — Adds specified PrivateConnection to a RoutingInstance resource.

  - [yc beta cloudrouter routing-instance create](routing-instance/create.md) — Creates a RoutingInstance resource in the specified folder using the data specified in the request.

  - [yc beta cloudrouter routing-instance delete](routing-instance/delete.md) — Deletes a RoutingInstance resource.

  - [yc beta cloudrouter routing-instance get](routing-instance/get.md) — Returns the specified RoutingInstance resource.

  - [yc beta cloudrouter routing-instance get-by-cic-private-connection-id](routing-instance/get-by-cic-private-connection-id.md) — Returns the RoutingInstance resource by cicPrivateConnectionId

  - [yc beta cloudrouter routing-instance get-by-vpc-network-id](routing-instance/get-by-vpc-network-id.md) — Returns the RoutingInstance resource by vpcNetworkId

  - [yc beta cloudrouter routing-instance list](routing-instance/list.md) — Retrieves the list of RoutingInstance resources in the specified folder.

  - [yc beta cloudrouter routing-instance list-operations](routing-instance/list-operations.md) — Lists operations for the specified RoutingInstance.

  - [yc beta cloudrouter routing-instance move](routing-instance/move.md) — Moves the specified RoutingInstance to another folder.

  - [yc beta cloudrouter routing-instance move-prefix](routing-instance/move-prefix.md) — Moves the specified prefix between availability zones of the RoutingInstance.

  - [yc beta cloudrouter routing-instance remove-prefixes](routing-instance/remove-prefixes.md) — Removes specified prefixes from a RoutingInstance resource.

  - [yc beta cloudrouter routing-instance remove-private-connection](routing-instance/remove-private-connection.md) — Removes specified PrivateConnection from a RoutingInstance resource.

  - [yc beta cloudrouter routing-instance update](routing-instance/update.md) — Updates a RoutingInstance resource using the data specified in the request.

  - [yc beta cloudrouter routing-instance update-networks](routing-instance/update-networks.md) — Updates multiple vpc using the data specified in the request.

  - [yc beta cloudrouter routing-instance update-prefix-mask](routing-instance/update-prefix-mask.md) — Removes specified PrivateConnection from a RoutingInstance resource.

  - [yc beta cloudrouter routing-instance upsert-prefixes](routing-instance/upsert-prefixes.md) — Upserts specified prefixes to a RoutingInstance resource.

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