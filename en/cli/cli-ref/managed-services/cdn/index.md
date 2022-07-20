---
sourcePath: en/_cli-ref/cli-ref/managed-services/cdn/index.md
---
# yc cdn

Manage CDN resources

#### Command Usage

Syntax: 

`yc cdn <group>`

#### Command Tree

- [yc cdn resource](resource/index.md) — Manage CDN resources
	- [yc cdn resource get](resource/get.md) — Show information about resource
	- [yc cdn resource list](resource/list.md) — List resources in the specified folder
	- [yc cdn resource create](resource/create.md) — Create resource
	- [yc cdn resource update](resource/update.md) — Update resource
	- [yc cdn resource get-provider-cname](resource/get-provider-cname.md) — Get provider CNAME
	- [yc cdn resource delete](resource/delete.md) — Delete resource.
- [yc cdn origin](origin/index.md) — Manage origins inside origin group
	- [yc cdn origin get](origin/get.md) — Show information about the specified origin
	- [yc cdn origin list](origin/list.md) — List origins in the specified origin group
	- [yc cdn origin create](origin/create.md) — Create origin
	- [yc cdn origin update](origin/update.md) — Update origin. PUT behaviour - specify all parameters
	- [yc cdn origin delete](origin/delete.md) — Delete the specified origin.
- [yc cdn origin-group](origin-group/index.md) — Manage origin groups
	- [yc cdn origin-group get](origin-group/get.md) — Show information about the specified origin group
	- [yc cdn origin-group list](origin-group/list.md) — List origin groups in the specified folder
	- [yc cdn origin-group create](origin-group/create.md) — Create origin group
	- [yc cdn origin-group update](origin-group/update.md) — Update origin group
	- [yc cdn origin-group delete](origin-group/delete.md) — Delete the specified origin group.
- [yc cdn provider](provider/index.md) — Manage CDN providers
	- [yc cdn provider list-activated](provider/list-activated.md) — List activated CDN providers
	- [yc cdn provider activate](provider/activate.md) — Activate CDN provider
- [yc cdn cache](cache/index.md) — Manage CDN resources cache
	- [yc cdn cache purge](cache/purge.md) — Purge CDN resource paths
	- [yc cdn cache prefetch](cache/prefetch.md) — Prefetch CDN resource paths

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
