---
editable: false
noIndex: true
---

# yc beta organization-manager idp



#### Command Usage

Syntax:

`yc beta organization-manager idp <group>`

#### Command Tree

- [yc beta organization-manager idp application](application/index.md) — 



- [yc beta organization-manager idp user](user/index.md) — A set of methods for managing users in the Identity Provider system.

  - [yc beta organization-manager idp user convert-to-external](user/convert-to-external.md) — Converts a user to use external authentication.

  - [yc beta organization-manager idp user create](user/create.md) — Creates a user in the specified userpool.

  - [yc beta organization-manager idp user delete](user/delete.md) — Deletes the specified user.

  - [yc beta organization-manager idp user generate-password](user/generate-password.md) — Generates a new password.

  - [yc beta organization-manager idp user get](user/get.md) — Returns the specified user.

  - [yc beta organization-manager idp user get-self-password-metadata](user/get-self-password-metadata.md) — Returns metadata about the authenticated user's password.

  - [yc beta organization-manager idp user list](user/list.md) — Retrieves the list of users in the specified userpool.

  - [yc beta organization-manager idp user reactivate](user/reactivate.md) — Reactivates a previously suspended user.

  - [yc beta organization-manager idp user resolve-external-ids](user/resolve-external-ids.md) — Resolves external IDs to internal user IDs.

  - [yc beta organization-manager idp user set-others-password](user/set-others-password.md) — Sets the password for another user.

  - [yc beta organization-manager idp user set-own-password](user/set-own-password.md) — Sets the password for the authenticated user.

  - [yc beta organization-manager idp user set-password-hash](user/set-password-hash.md) — Sets a password hash for the specified user.

  - [yc beta organization-manager idp user suspend](user/suspend.md) — Suspends the specified user.

  - [yc beta organization-manager idp user update](user/update.md) — Updates the specified user.

- [yc beta organization-manager idp userpool](userpool/index.md) — A set of methods for managing userpools.

  - [yc beta organization-manager idp userpool add-domain](userpool/add-domain.md) — Adds a domain to the specified userpool.

  - [yc beta organization-manager idp userpool create](userpool/create.md) — Creates a userpool in the specified organization.

  - [yc beta organization-manager idp userpool delete](userpool/delete.md) — Deletes the specified userpool.

  - [yc beta organization-manager idp userpool delete-domain](userpool/delete-domain.md) — Deletes the specified domain from a userpool.

  - [yc beta organization-manager idp userpool get](userpool/get.md) — Returns the specified userpool.

  - [yc beta organization-manager idp userpool get-domain](userpool/get-domain.md) — Returns the specified domain for a userpool.

  - [yc beta organization-manager idp userpool list](userpool/list.md) — Retrieves the list of userpools in the specified organization.

  - [yc beta organization-manager idp userpool list-access-bindings](userpool/list-access-bindings.md) — Lists access bindings for the specified userpool.

  - [yc beta organization-manager idp userpool list-domains](userpool/list-domains.md) — Lists domains for the specified userpool.

  - [yc beta organization-manager idp userpool list-operations](userpool/list-operations.md) — Lists operations for the specified userpool.

  - [yc beta organization-manager idp userpool set-access-bindings](userpool/set-access-bindings.md) — Sets access bindings for the specified userpool.

  - [yc beta organization-manager idp userpool update](userpool/update.md) — Updates the specified userpool.

  - [yc beta organization-manager idp userpool update-access-bindings](userpool/update-access-bindings.md) — Updates access bindings for the specified userpool.

  - [yc beta organization-manager idp userpool validate-domain](userpool/validate-domain.md) — Validates the specified domain for a userpool.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#