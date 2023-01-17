---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/resource-manager/cloud/index.md
---

# yc resource-manager cloud

Manage clouds

#### Command Usage

Syntax: 

`yc resource-manager cloud <command>`

Aliases: 

- `clouds`

#### Command Tree

- [yc resource-manager cloud get](get.md) — Show information about the specified cloud
- [yc resource-manager cloud list](list.md) — List clouds
- [yc resource-manager cloud update](update.md) — Update the specified cloud
- [yc resource-manager cloud list-access-bindings](list-access-bindings.md) — List access bindings for the specified cloud
- [yc resource-manager cloud set-access-bindings](set-access-bindings.md) — Set access bindings for the specified cloud and delete all existing access bindings if there were any
- [yc resource-manager cloud add-access-binding](add-access-binding.md) — Add access binding for the specified cloud
- [yc resource-manager cloud remove-access-binding](remove-access-binding.md) — Remove access binding for the specified cloud
- [yc resource-manager cloud list-operations](list-operations.md) — List operations for the specified cloud

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
