---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloudrouter/cli-ref/v1/routing-instance/
editable: false
---

# yc cloudrouter v1 routing-instance

A set of methods for managing RoutingInstance resources.

#### Command Usage

Syntax:

`yc cloudrouter v1 routing-instance <command>`

#### Command Tree

- [yc cloudrouter v1 routing-instance add-private-connection](add-private-connection.md) — Adds specified PrivateConnection to a RoutingInstance resource.

- [yc cloudrouter v1 routing-instance create](create.md) — Creates a RoutingInstance resource in the specified folder using the data specified in the request.

- [yc cloudrouter v1 routing-instance delete](delete.md) — Deletes a RoutingInstance resource.

- [yc cloudrouter v1 routing-instance get](get.md) — Returns the specified RoutingInstance resource.

- [yc cloudrouter v1 routing-instance get-by-cic-private-connection-id](get-by-cic-private-connection-id.md) — Returns the RoutingInstance resource by cicPrivateConnectionId

- [yc cloudrouter v1 routing-instance get-by-vpc-network-id](get-by-vpc-network-id.md) — Returns the RoutingInstance resource by vpcNetworkId

- [yc cloudrouter v1 routing-instance list](list.md) — Retrieves the list of RoutingInstance resources in the specified folder.

- [yc cloudrouter v1 routing-instance list-operations](list-operations.md) — Lists operations for the specified RoutingInstance.

- [yc cloudrouter v1 routing-instance move](move.md) — Moves the specified RoutingInstance to another folder.

- [yc cloudrouter v1 routing-instance move-prefix](move-prefix.md) — Moves the specified prefix between availability zones of the RoutingInstance.

- [yc cloudrouter v1 routing-instance remove-prefixes](remove-prefixes.md) — Removes specified prefixes from a RoutingInstance resource.

- [yc cloudrouter v1 routing-instance remove-private-connection](remove-private-connection.md) — Removes specified PrivateConnection from a RoutingInstance resource.

- [yc cloudrouter v1 routing-instance update](update.md) — Updates a RoutingInstance resource using the data specified in the request.

- [yc cloudrouter v1 routing-instance update-networks](update-networks.md) — Updates multiple vpc using the data specified in the request.

- [yc cloudrouter v1 routing-instance update-prefix-mask](update-prefix-mask.md) — Removes specified PrivateConnection from a RoutingInstance resource.

- [yc cloudrouter v1 routing-instance upsert-prefixes](upsert-prefixes.md) — Upserts specified prefixes to a RoutingInstance resource.

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
|| `--syntax` | `string`

CLI syntax: this standalone binary only supports 2 (current). Use main yc for syntax 1. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
