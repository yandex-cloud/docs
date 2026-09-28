---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/organization-manager/cli-ref/mfa-enforcement/
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

- [yc organization-manager mfa-enforcement list-excluded-audience](list-excluded-audience.md) — List excluded audience for the specified mfa enforcement

- [yc organization-manager mfa-enforcement update](update.md) — Update the specified mfa enforcement

- [yc organization-manager mfa-enforcement update-audience](update-audience.md) — Update audience for the specified mfa enforcement

- [yc organization-manager mfa-enforcement update-excluded-audience](update-excluded-audience.md) — Update excluded audience for the specified mfa enforcement

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