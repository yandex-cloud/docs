---
editable: false
noIndex: true
---

# yc beta organization-manager idp user update

Updates the specified user.

#### Command Usage

Syntax:

`yc beta organization-manager idp user update <USER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--email` | `string`

New email address for the user. ||
|| `--family-name` | `string`

New last name for the user. ||
|| `--full-name` | `string`

New full name for the user. ||
|| `--given-name` | `string`

New first name for the user. ||
|| `--phone-number` | `string`

New phone number for the user. ||
|| `--user-id` | `string`

ID of the user to update. ||
|| `--username` | `string`

New username for the user. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

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