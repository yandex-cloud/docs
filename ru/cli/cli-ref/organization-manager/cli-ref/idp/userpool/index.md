---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/userpool/index.md
---

# yc organization-manager idp userpool

Manage user pools

#### Command Usage

Syntax: 

`yc organization-manager idp userpool <group|command>`

Aliases: 

- `userpools`

#### Command Tree

- [yc organization-manager idp userpool create](create.md) — Create a user pool
- [yc organization-manager idp userpool delete](delete.md) — Delete the specified user pool
- [yc organization-manager idp userpool get](get.md) — Show information about the specified user pool
- [yc organization-manager idp userpool list](list.md) — List user pools
- [yc organization-manager idp userpool list-access-bindings](list-access-bindings.md) — List access bindings for the specified user pool
- [yc organization-manager idp userpool list-operations](list-operations.md) — List operations for the specified user pool
- [yc organization-manager idp userpool set-access-bindings](set-access-bindings.md) — Set access bindings for the specified user pool
- [yc organization-manager idp userpool update](update.md) — Update the specified user pool
- [yc organization-manager idp userpool update-access-bindings](update-access-bindings.md) — Update access bindings for the specified user pool
- [yc organization-manager idp userpool domain](domain/index.md) — Manage domains for user pools
	- [yc organization-manager idp userpool domain add](domain/add.md) — Add a domain to the specified user pool
	- [yc organization-manager idp userpool domain delete](domain/delete.md) — Delete the specified domain from a user pool
	- [yc organization-manager idp userpool domain get](domain/get.md) — Show information about the specified domain
	- [yc organization-manager idp userpool domain list](domain/list.md) — List domains for the specified user pool
	- [yc organization-manager idp userpool domain validate](domain/validate.md) — Validate the specified domain for a user pool

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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
