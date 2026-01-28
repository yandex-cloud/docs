---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-mongodb/cli-ref/user/index.md
---

# yc managed-mongodb user

Manage MongoDB users.

#### Command Usage

Syntax:

`yc managed-mongodb user <command>`

Aliases:

- `users`

#### Command Tree

- [yc managed-mongodb user create](create.md) — Create a MongoDB user.

- [yc managed-mongodb user delete](delete.md) — Delete a MongoDB user.

- [yc managed-mongodb user get](get.md) — Get information about a MongoDB user.

- [yc managed-mongodb user grant-permission](grant-permission.md) — Grant a permission to the specified MongoDB user.

- [yc managed-mongodb user list](list.md) — List users for a MongoDB cluster.

- [yc managed-mongodb user revoke-permission](revoke-permission.md) — Revoke a permission from the specified MongoDB user.

- [yc managed-mongodb user update](update.md) — Modify attributes of a MongoDB user.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#