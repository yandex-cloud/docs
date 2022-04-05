---
sourcePath: ru/_cli-ref/cli-ref/managed-services/compute/image/index.md
---
# yc compute image

Manage images

#### Command Usage

Syntax: 

`yc compute image <command>`

Aliases: 

- `images`

#### Command Tree

- [yc compute image get](get.md) — Show information about the specified image
- [yc compute image list](list.md) — List images
- [yc compute image get-latest-from-family](get-latest-from-family.md) — Show information about the latest image that is part of an image family
- [yc compute image create](create.md) — Create an image
- [yc compute image update](update.md) — Update the specified image
- [yc compute image add-labels](add-labels.md) — Add labels to specified image
- [yc compute image remove-labels](remove-labels.md) — Remove labels from specified image
- [yc compute image delete](delete.md) — Delete the specified image
- [yc compute image list-operations](list-operations.md) — List operations for the specified image

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
