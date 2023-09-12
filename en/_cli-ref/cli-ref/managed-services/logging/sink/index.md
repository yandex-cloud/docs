---
editable: false
---

# yc logging sink

Manage log groups

#### Command Usage

Syntax: 

`yc logging sink <command>`

#### Command Tree

- [yc logging sink get](get.md) — Show information about the specified logging sink
- [yc logging sink list](list.md) — List log sinks
- [yc logging sink create](create.md) — Create log sink
- [yc logging sink update](update.md) — Update log sink
- [yc logging sink delete](delete.md) — Delete log sink
- [yc logging sink list-operations](list-operations.md) — List sink operations
- [yc logging sink list-access-bindings](list-access-bindings.md) — List log group access bindings
- [yc logging sink set-access-bindings](set-access-bindings.md) — Set access bindings for the specified log group and delete all existing access bindings if there were any
- [yc logging sink add-access-binding](add-access-binding.md) — Add access binding for the specified sink
- [yc logging sink remove-access-binding](remove-access-binding.md) — Rempve access binding from the specified sink

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
