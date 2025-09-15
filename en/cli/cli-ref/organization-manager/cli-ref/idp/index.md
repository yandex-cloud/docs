---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/index.md
---

# yc organization-manager idp

Manage Identity Provider

#### Command Usage

Syntax: 

`yc organization-manager idp <group>`

Aliases: 

- `identity-provider`

#### Command Tree

- [yc organization-manager idp user](user/index.md) — Manage users
	- [yc organization-manager idp user convert-to-external](user/convert-to-external.md) — Convert a user to use external authentication
	- [yc organization-manager idp user create](user/create.md) — Create a user in the specified user pool
	- [yc organization-manager idp user delete](user/delete.md) — Delete the specified user
	- [yc organization-manager idp user generate-password](user/generate-password.md) — Generate a new password
	- [yc organization-manager idp user get](user/get.md) — Show information about the specified user
	- [yc organization-manager idp user get-password-metadata](user/get-password-metadata.md) — Get metadata about the authenticated user's password
	- [yc organization-manager idp user list](user/list.md) — List users in the specified user pool
	- [yc organization-manager idp user reactivate](user/reactivate.md) — Reactivate a previously suspended user
	- [yc organization-manager idp user resolve-external-ids](user/resolve-external-ids.md) — Resolve external IDs to internal user IDs
	- [yc organization-manager idp user set-own-password](user/set-own-password.md) — Set the password for the authenticated user
	- [yc organization-manager idp user set-password](user/set-password.md) — Set the password for the specified user
	- [yc organization-manager idp user set-password-hash](user/set-password-hash.md) — Set a password hash for the specified user
	- [yc organization-manager idp user suspend](user/suspend.md) — Suspend the specified user
	- [yc organization-manager idp user update](user/update.md) — Update the specified user
- [yc organization-manager idp userpool](userpool/index.md) — Manage user pools
	- [yc organization-manager idp userpool create](userpool/create.md) — Create a user pool
	- [yc organization-manager idp userpool delete](userpool/delete.md) — Delete the specified user pool
	- [yc organization-manager idp userpool get](userpool/get.md) — Show information about the specified user pool
	- [yc organization-manager idp userpool list](userpool/list.md) — List user pools
	- [yc organization-manager idp userpool list-access-bindings](userpool/list-access-bindings.md) — List access bindings for the specified user pool
	- [yc organization-manager idp userpool list-operations](userpool/list-operations.md) — List operations for the specified user pool
	- [yc organization-manager idp userpool set-access-bindings](userpool/set-access-bindings.md) — Set access bindings for the specified user pool
	- [yc organization-manager idp userpool update](userpool/update.md) — Update the specified user pool
	- [yc organization-manager idp userpool update-access-bindings](userpool/update-access-bindings.md) — Update access bindings for the specified user pool

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
