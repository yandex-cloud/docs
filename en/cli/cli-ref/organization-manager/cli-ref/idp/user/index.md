---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/idp/user/index.md
---

# yc organization-manager idp user

Manage users

#### Command Usage

Syntax: 

`yc organization-manager idp user <command>`

Aliases: 

- `users`

#### Command Tree

- [yc organization-manager idp user convert-to-external](convert-to-external.md) — Convert a user to use external authentication
- [yc organization-manager idp user create](create.md) — Create a user in the specified user pool
- [yc organization-manager idp user delete](delete.md) — Delete the specified user
- [yc organization-manager idp user generate-password](generate-password.md) — Generate a new password
- [yc organization-manager idp user get](get.md) — Show information about the specified user
- [yc organization-manager idp user get-password-metadata](get-password-metadata.md) — Get metadata about the authenticated user's password
- [yc organization-manager idp user list](list.md) — List users in the specified user pool
- [yc organization-manager idp user reactivate](reactivate.md) — Reactivate a previously suspended user
- [yc organization-manager idp user resolve-external-ids](resolve-external-ids.md) — Resolve external IDs to internal user IDs
- [yc organization-manager idp user set-own-password](set-own-password.md) — Set the password for the authenticated user
- [yc organization-manager idp user set-password](set-password.md) — Set the password for the specified user
- [yc organization-manager idp user set-password-hash](set-password-hash.md) — Set a password hash for the specified user
- [yc organization-manager idp user suspend](suspend.md) — Suspend the specified user
- [yc organization-manager idp user update](update.md) — Update the specified user

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
