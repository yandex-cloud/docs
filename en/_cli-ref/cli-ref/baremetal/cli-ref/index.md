---
editable: false
---

# yc baremetal

Manage  Baremetal resources

#### Command Usage

Syntax: 

`yc baremetal <group>`

#### Command Tree

- [yc baremetal boot-image](boot-image/index.md) — Manage images
	- [yc baremetal boot-image add-labels](boot-image/add-labels.md) — Add labels to specified boot-image
	- [yc baremetal boot-image create](boot-image/create.md) — Create an boot-image
	- [yc baremetal boot-image delete](boot-image/delete.md) — Delete the specified boot-image
	- [yc baremetal boot-image get](boot-image/get.md) — Show information about the specified boot-image
	- [yc baremetal boot-image list](boot-image/list.md) — List images
	- [yc baremetal boot-image list-operations](boot-image/list-operations.md) — List operations for the specified boot-image
	- [yc baremetal boot-image remove-labels](boot-image/remove-labels.md) — Remove labels from specified boot-image
	- [yc baremetal boot-image update](boot-image/update.md) — Update the specified boot-image
- [yc baremetal configuration](configuration/index.md) — Manage configurations
	- [yc baremetal configuration get](configuration/get.md) — Show information about the specified configuration
	- [yc baremetal configuration list](configuration/list.md) — List configurations
- [yc baremetal hardware-pool](hardware-pool/index.md) — Manage hardware pools
	- [yc baremetal hardware-pool get](hardware-pool/get.md) — Show information about the specified hardware pool
	- [yc baremetal hardware-pool list](hardware-pool/list.md) — List hardware pools
- [yc baremetal private-subnet](private-subnet/index.md) — Manage private subnet
	- [yc baremetal private-subnet add-labels](private-subnet/add-labels.md) — Add labels to specified private subnet
	- [yc baremetal private-subnet create](private-subnet/create.md) — Create a private subnet
	- [yc baremetal private-subnet delete](private-subnet/delete.md) — Delete the specified private subnet
	- [yc baremetal private-subnet get](private-subnet/get.md) — Show information about the specified private subnet
	- [yc baremetal private-subnet list](private-subnet/list.md) — List private subnets
	- [yc baremetal private-subnet list-operations](private-subnet/list-operations.md) — List operations for the specified private subnet
	- [yc baremetal private-subnet remove-labels](private-subnet/remove-labels.md) — Remove labels from specified private subnet
	- [yc baremetal private-subnet update](private-subnet/update.md) — Update the specified private subnet
- [yc baremetal public-subnet](public-subnet/index.md) — Manage public subnet
	- [yc baremetal public-subnet add-labels](public-subnet/add-labels.md) — Add labels to specified public subnet
	- [yc baremetal public-subnet create](public-subnet/create.md) — Create a public subnet
	- [yc baremetal public-subnet delete](public-subnet/delete.md) — Delete the specified public subnet
	- [yc baremetal public-subnet get](public-subnet/get.md) — Show information about the specified public subnet
	- [yc baremetal public-subnet list](public-subnet/list.md) — List public subnets
	- [yc baremetal public-subnet list-operations](public-subnet/list-operations.md) — List operations for the specified public subnet
	- [yc baremetal public-subnet remove-labels](public-subnet/remove-labels.md) — Remove labels from specified public subnet
	- [yc baremetal public-subnet update](public-subnet/update.md) — Update the specified public subnet
- [yc baremetal server](server/index.md) — Manage servers
	- [yc baremetal server add-labels](server/add-labels.md) — Add labels to specified server
	- [yc baremetal server create](server/create.md) — Create an server
	- [yc baremetal server get](server/get.md) — Show information about the specified server
	- [yc baremetal server list](server/list.md) — List servers
	- [yc baremetal server list-operations](server/list-operations.md) — List operations for the specified server
	- [yc baremetal server power-off](server/power-off.md) — Power Off the specified server
	- [yc baremetal server power-on](server/power-on.md) — Power On the specified server
	- [yc baremetal server reboot](server/reboot.md) — Power Off the specified server
	- [yc baremetal server reinstall](server/reinstall.md) — Reinstall the specified server
	- [yc baremetal server remove-labels](server/remove-labels.md) — Remove labels from specified server
	- [yc baremetal server update](server/update.md) — Update the specified server
- [yc baremetal vrf](vrf/index.md) — Manage vrf
	- [yc baremetal vrf add-labels](vrf/add-labels.md) — Add labels to specified vrf
	- [yc baremetal vrf create](vrf/create.md) — Create a vrf
	- [yc baremetal vrf delete](vrf/delete.md) — Delete the specified vrf
	- [yc baremetal vrf get](vrf/get.md) — Show information about the specified vrf
	- [yc baremetal vrf list](vrf/list.md) — List vrfs
	- [yc baremetal vrf list-operations](vrf/list-operations.md) — List operations for the specified vrf
	- [yc baremetal vrf remove-labels](vrf/remove-labels.md) — Remove labels from specified vrf
	- [yc baremetal vrf update](vrf/update.md) — Update the specified vrf
- [yc baremetal zone](zone/index.md) — Manage zones
	- [yc baremetal zone get](zone/get.md) — Show information about the specified zone
	- [yc baremetal zone list](zone/list.md) — List zones

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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
