---
editable: false
noIndex: true
---

# yc beta vpc

Manage Virtual Private Cloud resources

#### Command Usage

Syntax:

`yc beta vpc <group>`

#### Command Tree

- [yc beta vpc address](address/index.md) — A set of methods for managing Address resources.

  - [yc beta vpc address create](address/create.md) — Creates an address in the specified folder and network.

  - [yc beta vpc address delete](address/delete.md) — Deletes the specified address.

  - [yc beta vpc address get](address/get.md) — Returns the specified Address resource.

  - [yc beta vpc address get-by-value](address/get-by-value.md) — Returns the specified Address resource by a given value.

  - [yc beta vpc address list](address/list.md) — Retrieves the list of Address resources in the specified folder.

  - [yc beta vpc address list-operations](address/list-operations.md) — List operations for the specified address.

  - [yc beta vpc address move](address/move.md) — Move an address to another folder

  - [yc beta vpc address update](address/update.md) — Updates the specified address.

- [yc beta vpc gateway](gateway/index.md) — 

  - [yc beta vpc gateway create](gateway/create.md) — Creates a gateway in the specified folder.

  - [yc beta vpc gateway delete](gateway/delete.md) — Deletes the specified gateway.

  - [yc beta vpc gateway get](gateway/get.md) — Returns the specified Gateway resource.

  - [yc beta vpc gateway list](gateway/list.md) — Retrieves the list of Gateway resources in the specified folder.

  - [yc beta vpc gateway list-operations](gateway/list-operations.md) — List operations for the specified gateway.

  - [yc beta vpc gateway move](gateway/move.md) — Move a gateway to another folder

  - [yc beta vpc gateway update](gateway/update.md) — Updates the specified gateway.

- [yc beta vpc network](network/index.md) — A set of methods for managing Network resources.

  - [yc beta vpc network create](network/create.md) — Creates a network in the specified folder using the data specified in the request.

  - [yc beta vpc network delete](network/delete.md) — Deletes the specified network.

  - [yc beta vpc network get](network/get.md) — Returns the specified Network resource.

  - [yc beta vpc network list](network/list.md) — Retrieves the list of Network resources in the specified folder.

  - [yc beta vpc network list-operations](network/list-operations.md) — Lists operations for the specified network.

  - [yc beta vpc network list-route-tables](network/list-route-tables.md) — Lists route tables from the specified network.

  - [yc beta vpc network list-security-groups](network/list-security-groups.md) — Lists security groups from the specified network.

  - [yc beta vpc network list-subnets](network/list-subnets.md) — Lists subnets from the specified network.

  - [yc beta vpc network move](network/move.md) — Move network to another folder.

  - [yc beta vpc network update](network/update.md) — Updates the specified network.

- [yc beta vpc private-endpoint](private-endpoint/index.md) — A set of methods for managing PrivateEndpoint resources.

  - [yc beta vpc private-endpoint create](private-endpoint/create.md) — Creates an private endpoint in the specified folder and network.

  - [yc beta vpc private-endpoint delete](private-endpoint/delete.md) — Deletes the specified private endpoint.

  - [yc beta vpc private-endpoint get](private-endpoint/get.md) — Returns the specified Private Endpoint resource.

  - [yc beta vpc private-endpoint list](private-endpoint/list.md) — Retrieves the list of PrivateEndpoint resources in the specified folder.

  - [yc beta vpc private-endpoint list-operations](private-endpoint/list-operations.md) — List operations for the specified private endpoint.

  - [yc beta vpc private-endpoint update](private-endpoint/update.md) — Updates the specified private endpoint.

- [yc beta vpc route-table](route-table/index.md) — A set of methods for managing RouteTable resources.

  - [yc beta vpc route-table create](route-table/create.md) — Creates a route table in the specified folder and network.

  - [yc beta vpc route-table delete](route-table/delete.md) — Deletes the specified route table.

  - [yc beta vpc route-table get](route-table/get.md) — Returns the specified RouteTable resource.

  - [yc beta vpc route-table list](route-table/list.md) — Retrieves the list of RouteTable resources in the specified folder.

  - [yc beta vpc route-table list-operations](route-table/list-operations.md) — List operations for the specified route table.

  - [yc beta vpc route-table move](route-table/move.md) — Move route table to another folder.

  - [yc beta vpc route-table update](route-table/update.md) — Updates the specified route table.

- [yc beta vpc security-group](security-group/index.md) — A set of methods for managing SecurityGroup resources.

  - [yc beta vpc security-group create](security-group/create.md) — Creates a security group in the specified folder and network.

  - [yc beta vpc security-group delete](security-group/delete.md) — Deletes the specified security group.

  - [yc beta vpc security-group get](security-group/get.md) — Returns the specified SecurityGroup resource.

  - [yc beta vpc security-group list](security-group/list.md) — Retrieves the list of SecurityGroup resources in the specified folder.

  - [yc beta vpc security-group list-operations](security-group/list-operations.md) — Lists operations for the specified security groups.

  - [yc beta vpc security-group move](security-group/move.md) — Moves security groups to another folder.

  - [yc beta vpc security-group update](security-group/update.md) — Updates the specified security group.

  - [yc beta vpc security-group update-rule](security-group/update-rule.md) — Updates the specified rule.

  - [yc beta vpc security-group update-rules](security-group/update-rules.md) — Updates the rules of the specified security group.

- [yc beta vpc subnet](subnet/index.md) — A set of methods for managing Subnet resources.

  - [yc beta vpc subnet add-cidr-blocks](subnet/add-cidr-blocks.md) — Adds CIDR blocks to the specified subnet.

  - [yc beta vpc subnet create](subnet/create.md) — Creates a subnet in the specified folder and network.

  - [yc beta vpc subnet delete](subnet/delete.md) — Deletes the specified subnet.

  - [yc beta vpc subnet get](subnet/get.md) — Returns the specified Subnet resource.

  - [yc beta vpc subnet list](subnet/list.md) — Retrieves the list of Subnet resources in the specified folder.

  - [yc beta vpc subnet list-operations](subnet/list-operations.md) — List operations for the specified subnet.

  - [yc beta vpc subnet list-used-addresses](subnet/list-used-addresses.md) — List used addresses in specified subnet.

  - [yc beta vpc subnet move](subnet/move.md) — Move subnet to another folder.

  - [yc beta vpc subnet relocate](subnet/relocate.md) — 

  - [yc beta vpc subnet remove-cidr-blocks](subnet/remove-cidr-blocks.md) — Removes CIDR blocks from the specified subnet.

  - [yc beta vpc subnet update](subnet/update.md) — Updates the specified subnet.

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