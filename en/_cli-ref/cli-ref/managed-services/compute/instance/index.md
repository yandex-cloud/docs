---
editable: false
---

# yc compute instance

Manage virtual machine instances

#### Command Usage

Syntax: 

`yc compute instance <command>`

Aliases: 

- `instances`

#### Command Tree

- [yc compute instance get](get.md) — Show information about the specified virtual machine instance
- [yc compute instance list](list.md) — List virtual machine instances
- [yc compute instance create](create.md) — Create a virtual machine instance
- [yc compute instance create-with-container](create-with-container.md) — Create a virtual machine instance running Docker container
- [yc compute instance update](update.md) — Update the specified virtual machine instance
- [yc compute instance update-container](update-container.md) — Update the specified virtual machine instance running Docker container
- [yc compute instance add-metadata](add-metadata.md) — Add or update metadata for the specified virtual machine instance
- [yc compute instance remove-metadata](remove-metadata.md) — Remove keys from metadata for the specified virtual machine instance
- [yc compute instance add-labels](add-labels.md) — Add labels to specified virtual machine instance
- [yc compute instance remove-labels](remove-labels.md) — Remove labels from specified virtual machine instance
- [yc compute instance delete](delete.md) — Delete the specified virtual machine instance
- [yc compute instance get-serial-port-output](get-serial-port-output.md) — Return the serial port output of the specified virtual machine instance
- [yc compute instance stop](stop.md) — Stop the specified virtual machine instance
- [yc compute instance start](start.md) — Start the specified virtual machine instance
- [yc compute instance restart](restart.md) — Restart the specified virtual machine instance
- [yc compute instance attach-disk](attach-disk.md) — Attach existing disk to the specified virtual machine instance
- [yc compute instance detach-disk](detach-disk.md) — Detach disk from the specified virtual machine instance
- [yc compute instance attach-filesystem](attach-filesystem.md) — Attach existing filesystem to the specified virtual machine instance
- [yc compute instance detach-filesystem](detach-filesystem.md) — Detach filesystem from the specified virtual machine instance
- [yc compute instance update-network-interface](update-network-interface.md) — Update the specified network interface of virtual machine instance
- [yc compute instance add-one-to-one-nat](add-one-to-one-nat.md) — Add one-to-one NAT to the specified network interface of virtual machine instance
- [yc compute instance remove-one-to-one-nat](remove-one-to-one-nat.md) — Remove one-to-one NAT to the specified network interface of virtual machine instance
- [yc compute instance move](move.md) — Move the specified virtual machine instance into the folder
- [yc compute instance relocate](relocate.md) — Relocate the specified virtual machine instance to the zone
- [yc compute instance list-operations](list-operations.md) — List operations for the specified instance

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
