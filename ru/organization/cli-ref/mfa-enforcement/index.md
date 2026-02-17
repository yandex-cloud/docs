---
editable: false
---

# yc organization-manager mfa-enforcement

Manage MFA enforcements in organizations

#### Command Usage

Syntax:

`yc organization-manager mfa-enforcement <command>`

Aliases:

- `mfa-enforcements`

#### Command Tree

- [yc organization-manager mfa-enforcement activate](activate.md) — Activate the specified mfa enforcement

- [yc organization-manager mfa-enforcement create](create.md) — Create mfa enforcement

- [yc organization-manager mfa-enforcement deactivate](deactivate.md) — Deactivate the specified mfa enforcement

- [yc organization-manager mfa-enforcement delete](delete.md) — Delete the specified mfa enforcement

- [yc organization-manager mfa-enforcement get](get.md) — Show information about the specified mfa enforcement

- [yc organization-manager mfa-enforcement list](list.md) — List mfa enforcements

- [yc organization-manager mfa-enforcement list-audience](list-audience.md) — List audience for the specified mfa enforcement

- [yc organization-manager mfa-enforcement update](update.md) — Update the specified mfa enforcement

- [yc organization-manager mfa-enforcement update-audience](update-audience.md) — Update audience for the specified mfa enforcement

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