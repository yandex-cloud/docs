# yc lockbox secret

Manage secrets

#### Command Usage

Syntax: 

`yc lockbox secret <command>`

#### Command Tree

- [yc lockbox secret get](get.md) — Show information about the specified secret
- [yc lockbox secret list](list.md) — List secrets for the specified folder
- [yc lockbox secret list-versions](list-versions.md) — List versions for the specified secret
- [yc lockbox secret create](create.md) — Create a secret
- [yc lockbox secret update](update.md) — Update the specified secret
- [yc lockbox secret add-version](add-version.md) — Add new payload version for the specified secret based on an existing one
- [yc lockbox secret delete](delete.md) — Delete the specified secret
- [yc lockbox secret activate](activate.md) — Activate the specified secret
- [yc lockbox secret deactivate](deactivate.md) — Deactivate the specified secret
- [yc lockbox secret schedule-version-destruction](schedule-version-destruction.md) — Schedule destruction of the specified secret version
- [yc lockbox secret cancel-version-destruction](cancel-version-destruction.md) — Cancel destruction of the specified secret version
- [yc lockbox secret list-operations](list-operations.md) — List operations for the specified secret
- [yc lockbox secret list-access-bindings](list-access-bindings.md) — List access bindings for the specified secret
- [yc lockbox secret set-access-bindings](set-access-bindings.md) — Set access bindings for the specified secret and delete all existing access bindings if there were any
- [yc lockbox secret add-access-binding](add-access-binding.md) — Add access binding for the specified secret
- [yc lockbox secret remove-access-binding](remove-access-binding.md) — Remove access binding for the specified secret

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
