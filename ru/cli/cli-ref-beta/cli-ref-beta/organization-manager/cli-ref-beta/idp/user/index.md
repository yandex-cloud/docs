---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/idp/user/index.md
---

# yc beta organization-manager idp user

A set of methods for managing users in the Identity Provider system.

#### Command Usage

Syntax: 

`yc beta organization-manager idp user <command>`

#### Command Tree

- [yc beta organization-manager idp user convert-to-external](convert-to-external.md) — Converts a user to use external authentication.
- [yc beta organization-manager idp user create](create.md) — Creates a user in the specified userpool.
- [yc beta organization-manager idp user delete](delete.md) — Deletes the specified user.
- [yc beta organization-manager idp user generate-password](generate-password.md) — Generates a new password.
- [yc beta organization-manager idp user get](get.md) — Returns the specified user.
- [yc beta organization-manager idp user get-self-password-metadata](get-self-password-metadata.md) — Returns metadata about the authenticated user's password.
- [yc beta organization-manager idp user list](list.md) — Retrieves the list of users in the specified userpool.
- [yc beta organization-manager idp user reactivate](reactivate.md) — Reactivates a previously suspended user.
- [yc beta organization-manager idp user resolve-external-ids](resolve-external-ids.md) — Resolves external IDs to internal user IDs.
- [yc beta organization-manager idp user set-others-password](set-others-password.md) — Sets the password for another user.
- [yc beta organization-manager idp user set-own-password](set-own-password.md) — Sets the password for the authenticated user.
- [yc beta organization-manager idp user set-password-hash](set-password-hash.md) — Sets a password hash for the specified user.
- [yc beta organization-manager idp user suspend](suspend.md) — Suspends the specified user.
- [yc beta organization-manager idp user update](update.md) — Updates the specified user.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
