---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/vpc/address/index.md
---

# yc vpc address

Manage addresses.

#### Command Usage

Syntax: 

`yc vpc address <command>`

Aliases: 

- `addresses`
- `addr`

#### Command Tree

- [yc vpc address get](get.md) — Get information about an address.
- [yc vpc address list](list.md) — List addresses in a folder.
- [yc vpc address create](create.md) — Create an address.
- [yc vpc address update](update.md) — Modify configuration or attributes of the address.
- [yc vpc address delete](delete.md) — Delete an address.
- [yc vpc address list-operations](list-operations.md) — List operations for an address.
- [yc vpc address move](move.md) — Move an address to another folder.

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
