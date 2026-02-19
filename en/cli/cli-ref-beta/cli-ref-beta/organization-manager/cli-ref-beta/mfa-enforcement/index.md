---
editable: false
noIndex: true
---

# yc beta organization-manager mfa-enforcement

a set of methods for managing MFA enforcements

#### Command Usage

Syntax:

`yc beta organization-manager mfa-enforcement <command>`

#### Command Tree

- [yc beta organization-manager mfa-enforcement activate](activate.md) — activates the specified MFA enforcement

- [yc beta organization-manager mfa-enforcement create](create.md) — creates an MFA enforcement in the specified organization

- [yc beta organization-manager mfa-enforcement deactivate](deactivate.md) — deactivates the specified MFA enforcement

- [yc beta organization-manager mfa-enforcement delete](delete.md) — deletes the specified MFA enforcement

- [yc beta organization-manager mfa-enforcement get](get.md) — returns the specified MFA enforcement

- [yc beta organization-manager mfa-enforcement list](list.md) — returns MFA enforcements for the specified organization

- [yc beta organization-manager mfa-enforcement list-audience](list-audience.md) — returns specified MFA enforcement's audience

- [yc beta organization-manager mfa-enforcement update](update.md) — updates the specified MFA enforcement

- [yc beta organization-manager mfa-enforcement update-audience](update-audience.md) — updates specified MFA enforcement's audience

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