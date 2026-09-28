---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/organization-manager/cli-ref/idp/user/
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

- [yc organization-manager idp user reset-password](reset-password.md) — Reset the password for the specified user

- [yc organization-manager idp user resolve-external-ids](resolve-external-ids.md) — Resolve external IDs to internal user IDs

- [yc organization-manager idp user set-own-password](set-own-password.md) — Set the password for the authenticated user

- [yc organization-manager idp user set-password](set-password.md) — Set the password for the specified user

- [yc organization-manager idp user set-password-hash](set-password-hash.md) — Set a password hash for the specified user

- [yc organization-manager idp user suspend](suspend.md) — Suspend the specified user

- [yc organization-manager idp user update](update.md) — Update the specified user

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#