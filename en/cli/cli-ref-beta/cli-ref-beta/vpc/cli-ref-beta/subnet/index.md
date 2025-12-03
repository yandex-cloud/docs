---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/subnet/index.md
---

# yc beta vpc subnet

A set of methods for managing Subnet resources.

#### Command Usage

Syntax: 

`yc beta vpc subnet <command>`

#### Command Tree

- [yc beta vpc subnet add-cidr-blocks](add-cidr-blocks.md) — Adds CIDR blocks to the specified subnet.
- [yc beta vpc subnet create](create.md) — Creates a subnet in the specified folder and network.
- [yc beta vpc subnet delete](delete.md) — Deletes the specified subnet.
- [yc beta vpc subnet get](get.md) — Returns the specified Subnet resource.
- [yc beta vpc subnet list](list.md) — Retrieves the list of Subnet resources in the specified folder.
- [yc beta vpc subnet list-operations](list-operations.md) — List operations for the specified subnet.
- [yc beta vpc subnet list-used-addresses](list-used-addresses.md) — List used addresses in specified subnet.
- [yc beta vpc subnet move](move.md) — Move subnet to another folder.
- [yc beta vpc subnet relocate](relocate.md) — 
- [yc beta vpc subnet remove-cidr-blocks](remove-cidr-blocks.md) — Removes CIDR blocks from the specified subnet.
- [yc beta vpc subnet update](update.md) — Updates the specified subnet.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
