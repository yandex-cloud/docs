---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/index.md
---

# yc vpc

Manage Yandex Virtual Private Cloud resources

#### Command Usage

Syntax: 

`yc vpc <group>`

#### Command Tree

- [yc vpc network](network/index.md) — Manage networks.
	- [yc vpc network get](network/get.md) — Get information about a network.
	- [yc vpc network list](network/list.md) — List networks in a folder.
	- [yc vpc network create](network/create.md) — Create a network.
	- [yc vpc network update](network/update.md) — Modify configuration or attributes of a network.
	- [yc vpc network add-labels](network/add-labels.md) — Assign labels to a network.
	- [yc vpc network remove-labels](network/remove-labels.md) — Remove labels from a network.
	- [yc vpc network delete](network/delete.md) — Delete a network.
	- [yc vpc network list-subnets](network/list-subnets.md) — List subnets in a network.
	- [yc vpc network list-security-groups](network/list-security-groups.md) — List security groups in a network.
	- [yc vpc network list-route-tables](network/list-route-tables.md) — List route tables in a network.
	- [yc vpc network list-operations](network/list-operations.md) — List operations for a network.
	- [yc vpc network move](network/move.md) — Move a network to another folder.
- [yc vpc route-table](route-table/index.md) — Manage route tables.
	- [yc vpc route-table get](route-table/get.md) — Get information about a route table.
	- [yc vpc route-table list](route-table/list.md) — List route tables in a folder.
	- [yc vpc route-table create](route-table/create.md) — Create a route table.
	- [yc vpc route-table update](route-table/update.md) — Modify configuration or attributes of a route table.
	- [yc vpc route-table add-labels](route-table/add-labels.md) — Add labels to a route table.
	- [yc vpc route-table remove-labels](route-table/remove-labels.md) — Remove labels from a route table.
	- [yc vpc route-table delete](route-table/delete.md) — Delete a route table.
	- [yc vpc route-table list-operations](route-table/list-operations.md) — List operations for a route table.
	- [yc vpc route-table move](route-table/move.md) — Move a route table to another folder.
- [yc vpc security-group](security-group/index.md) — Manage security groups.
	- [yc vpc security-group get](security-group/get.md) — Get information about a security group.
	- [yc vpc security-group list](security-group/list.md) — List security groups in a folder.
	- [yc vpc security-group create](security-group/create.md) — Create a security group.
	- [yc vpc security-group update](security-group/update.md) — Modify configuration or attributes of a security group.
	- [yc vpc security-group add-labels](security-group/add-labels.md) — Add labels to a security group.
	- [yc vpc security-group remove-labels](security-group/remove-labels.md) — Remove labels from a security group.
	- [yc vpc security-group delete](security-group/delete.md) — Delete a security group.
	- [yc vpc security-group list-operations](security-group/list-operations.md) — List operations for a security group.
	- [yc vpc security-group move](security-group/move.md) — Move a security group to another folder.
	- [yc vpc security-group update-rules](security-group/update-rules.md) — Update rules of a security group.
	- [yc vpc security-group update-rule-meta](security-group/update-rule-meta.md) — Update rule of a security group.
- [yc vpc subnet](subnet/index.md) — Manage subnets.
	- [yc vpc subnet get](subnet/get.md) — Get information about a subnet.
	- [yc vpc subnet list](subnet/list.md) — List subnets in a folder.
	- [yc vpc subnet create](subnet/create.md) — Create a subnet in the specified network.
	- [yc vpc subnet update](subnet/update.md) — Modify configuration or attributes of a subnet.
	- [yc vpc subnet add-range](subnet/add-range.md) — Add CIDR range to a subnet.
	- [yc vpc subnet remove-range](subnet/remove-range.md) — Remove CIDR range from a subnet.
	- [yc vpc subnet add-labels](subnet/add-labels.md) — Assign labels to a subnet.
	- [yc vpc subnet remove-labels](subnet/remove-labels.md) — Remove labels from a subnet.
	- [yc vpc subnet delete](subnet/delete.md) — Delete a subnet.
	- [yc vpc subnet list-operations](subnet/list-operations.md) — List operations for a subnet.
	- [yc vpc subnet list-used-addresses](subnet/list-used-addresses.md) — List used addresses in subnet.
	- [yc vpc subnet move](subnet/move.md) — Move a subnet to another folder.
	- [yc vpc subnet relocate](subnet/relocate.md) — Relocate a subnet to another zone.
- [yc vpc address](address/index.md) — Manage addresses.
	- [yc vpc address get](address/get.md) — Get information about an address.
	- [yc vpc address list](address/list.md) — List addresses in a folder.
	- [yc vpc address create](address/create.md) — Create an address.
	- [yc vpc address update](address/update.md) — Modify configuration or attributes of the address.
	- [yc vpc address delete](address/delete.md) — Delete an address.
	- [yc vpc address list-operations](address/list-operations.md) — List operations for an address.
	- [yc vpc address move](address/move.md) — Move an address to another folder.
- [yc vpc gateway](gateway/index.md) — Manage gateways.
	- [yc vpc gateway get](gateway/get.md) — Get information about a gateway.
	- [yc vpc gateway list](gateway/list.md) — List gateways in a folder.
	- [yc vpc gateway create](gateway/create.md) — Create a gateway.
	- [yc vpc gateway update](gateway/update.md) — Modify configuration or attributes of a gateway.
	- [yc vpc gateway add-labels](gateway/add-labels.md) — Assign labels to a gateway.
	- [yc vpc gateway remove-labels](gateway/remove-labels.md) — Remove labels from a gateway.
	- [yc vpc gateway delete](gateway/delete.md) — Delete a gateway.
	- [yc vpc gateway list-operations](gateway/list-operations.md) — List operations for a gateway.
	- [yc vpc gateway move](gateway/move.md) — Move a gateway to another folder.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
