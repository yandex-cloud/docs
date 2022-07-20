# yc container registry

Manage registries.

#### Command Usage

Syntax: 

`yc container registry <command>`

Aliases: 

- `registries`
- `reg`

#### Command Tree

- [yc container registry get](get.md) — Get information about a registry.
- [yc container registry list](list.md) — List registries.
- [yc container registry create](create.md) — Create a registry.
- [yc container registry update](update.md) — Modify configuration or attributes of a registry.
- [yc container registry add-labels](add-labels.md) — Add labels to a registry.
- [yc container registry remove-labels](remove-labels.md) — Remove labels from a registry.
- [yc container registry delete](delete.md) — Delete a registry.
- [yc container registry list-access-bindings](list-access-bindings.md) — List access bindings for the specified registry
- [yc container registry set-access-bindings](set-access-bindings.md) — Set access bindings for the specified registry and delete all existing access bindings if there were any
- [yc container registry add-access-binding](add-access-binding.md) — Add access binding for the specified registry
- [yc container registry remove-access-binding](remove-access-binding.md) — Remove access binding for the specified registry
- [yc container registry list-ip-permissions](list-ip-permissions.md) — List ip permissions for the specified registry
- [yc container registry set-ip-permissions](set-ip-permissions.md) — Set ip permissions for the specified registry and delete all existing ip permission if there were any
- [yc container registry add-ip-permissions](add-ip-permissions.md) — Add ip permissions for the specified registry
- [yc container registry remove-ip-permissions](remove-ip-permissions.md) — Remove ip permissions for the specified registry
- [yc container registry configure-docker](configure-docker.md) — Configure docker to use Yandex Cloud credential helper.

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
