# yc cdn resource

Manage CDN resources

#### Command Usage

Syntax: 

`yc cdn resource <command>`

#### Command Tree

- [yc cdn resource get](get.md) — Show information about resource
- [yc cdn resource list](list.md) — List resources in the specified folder
- [yc cdn resource create](create.md) — Create resource
- [yc cdn resource update](update.md) — Update resource
- [yc cdn resource get-provider-cname](get-provider-cname.md) — Get provider CNAME
- [yc cdn resource delete](delete.md) — Delete resource.

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
