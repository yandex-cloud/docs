# yc certificate-manager certificate

Manage certificates

#### Command Usage

Syntax: 

`yc certificate-manager certificate <command>`

Aliases: 

- `certificates`

#### Command Tree

- [yc certificate-manager certificate get](get.md) — Show information about the specified certificate
- [yc certificate-manager certificate content](content.md) — Download content of the specified certificate: chain and private key
- [yc certificate-manager certificate list](list.md) — List certificates in the specified folder
- [yc certificate-manager certificate create](create.md) — Create an imported certificate
- [yc certificate-manager certificate request](request.md) — Request a managed certificate
- [yc certificate-manager certificate update](update.md) — Update the specified certificate
- [yc certificate-manager certificate delete](delete.md) — Delete the specified certificate
- [yc certificate-manager certificate list-operations](list-operations.md) — List operations for the specified certificate
- [yc certificate-manager certificate list-access-bindings](list-access-bindings.md) — List access bindings for the specified certificate
- [yc certificate-manager certificate set-access-bindings](set-access-bindings.md) — Set access bindings for the specified certificate and delete all existing access bindings if there were any
- [yc certificate-manager certificate add-access-binding](add-access-binding.md) — Add access binding for the specified certificate
- [yc certificate-manager certificate remove-access-binding](remove-access-binding.md) — Remove access binding for the specified certificate

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
