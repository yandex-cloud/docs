---
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance-group/index.md
---
# yc compute instance-group

Manage instance groups

#### Command Usage

Syntax: 

`yc compute instance-group <command>`

Aliases: 

- `instance-groups`
- `ig`

#### Command Tree

- [yc compute instance-group get](get.md) — Show information about the specified instance group
- [yc compute instance-group list](list.md) — List instance groups
- [yc compute instance-group create](create.md) — Create an instance group
- [yc compute instance-group update](update.md) — Update the specified instance group
- [yc compute instance-group stop](stop.md) — Stop the specified instance group
- [yc compute instance-group start](start.md) — Start the specified instance group
- [yc compute instance-group add-metadata](add-metadata.md) — Add or update metadata for instance template of the specified instance group
- [yc compute instance-group remove-metadata](remove-metadata.md) — Remove keys from metadata for instance template of the specified instance group
- [yc compute instance-group add-labels](add-labels.md) — Add labels to specified instance group
- [yc compute instance-group remove-labels](remove-labels.md) — Remove labels from specified instance group
- [yc compute instance-group delete](delete.md) — Delete the specified instance group
- [yc compute instance-group list-instances](list-instances.md) — List instances of the specified instance group
- [yc compute instance-group stop-instances](stop-instances.md) — Stop instances of the specified instance group
- [yc compute instance-group delete-instances](delete-instances.md) — Delete instances of the specified instance group
- [yc compute instance-group list-operations](list-operations.md) — List operations for the specified instance group
- [yc compute instance-group list-logs](list-logs.md) — List logs for the specified instance group
- [yc compute instance-group list-access-bindings](list-access-bindings.md) — List access bindings for the specified instance group
- [yc compute instance-group set-access-bindings](set-access-bindings.md) — Set access bindings for the specified instance group and delete all existing access bindings if there were any
- [yc compute instance-group add-access-binding](add-access-binding.md) — Add access binding for the specified instance group
- [yc compute instance-group remove-access-binding](remove-access-binding.md) — Remove access binding for the specified instance group

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
