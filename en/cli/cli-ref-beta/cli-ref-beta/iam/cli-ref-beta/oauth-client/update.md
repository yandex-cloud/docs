---
editable: false
noIndex: true
---

# yc beta iam oauth-client update

Updates the specified oauth client.

#### Command Usage

Syntax:

`yc beta iam oauth-client update <OAUTH-CLIENT-ID>`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the oauth client. The name must be unique within folder. ||
|| `--oauth-client-id` | `string`

ID of the OAuthClient resource to update. To get the oauth client ID, use a [OAuthClientService.List] request. ||
|| `--redirect-uris` | `[]string`

List of redirect uries allowed for the oauth client. ||
|| `--scopes` | `[]string`

List of oauth scopes requested by the oauth client. ||
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