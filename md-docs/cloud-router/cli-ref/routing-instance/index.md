# yc cloudrouter routing-instance

A set of methods for managing RoutingInstance resources.

#### Command Usage

Syntax:

`yc cloudrouter routing-instance <command>`

#### Command Tree

- [yc cloudrouter routing-instance add-labels](add-labels.md) — Assign labels to a routingInstance.

- [yc cloudrouter routing-instance add-private-connection](add-private-connection.md) — Adds specified PrivateConnection to a RoutingInstance resource.

- [yc cloudrouter routing-instance create](create.md) — Create a routingInstance.

- [yc cloudrouter routing-instance delete](delete.md) — Deletes a RoutingInstance resource.

- [yc cloudrouter routing-instance get](get.md) — Returns the specified RoutingInstance resource.

- [yc cloudrouter routing-instance get-by-cic-private-connection-id](get-by-cic-private-connection-id.md) — Returns the RoutingInstance resource by cicPrivateConnectionId

- [yc cloudrouter routing-instance get-by-vpc-network-id](get-by-vpc-network-id.md) — Returns the RoutingInstance resource by vpcNetworkId

- [yc cloudrouter routing-instance list](list.md) — Retrieves the list of RoutingInstance resources in the specified folder.

- [yc cloudrouter routing-instance list-operations](list-operations.md) — Lists operations for the specified RoutingInstance.

- [yc cloudrouter routing-instance move](move.md) — Moves the specified RoutingInstance to another folder.

- [yc cloudrouter routing-instance move-prefix](move-prefix.md) — Moves the specified prefix between availability zones of the RoutingInstance.

- [yc cloudrouter routing-instance remove-labels](remove-labels.md) — Remove labels from a routingInstance.

- [yc cloudrouter routing-instance remove-prefixes](remove-prefixes.md) — Remove announced VPC network prefixes from the routingInstance.

- [yc cloudrouter routing-instance remove-private-connection](remove-private-connection.md) — Removes specified PrivateConnection from a RoutingInstance resource.

- [yc cloudrouter routing-instance update](update.md) — Modify configuration or attributes of a routingInstance.

- [yc cloudrouter routing-instance update-networks](update-networks.md) — Update announced VPC network prefixes in the routingInstance.

- [yc cloudrouter routing-instance update-prefix-mask](update-prefix-mask.md) — Removes specified PrivateConnection from a RoutingInstance resource.

- [yc cloudrouter routing-instance upsert-prefixes](upsert-prefixes.md) — Upsert announced VPC network prefixes to the routingInstance.

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