---
editable: false
noIndex: true
---

# yc beta iam workload-identity oidc federation update

Updates the specified OIDC workload identity federation.

#### Command Usage

Syntax:

`yc beta iam workload-identity oidc federation update <FEDERATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--audiences` | `[]string`

List of trusted values for aud claim. ||
|| `--description` | `string`

Description of the OIDC workload identity federation. ||
|| `--disabled` | True - the OIDC workload identity federation is disabled and cannot be used for authentication. False - the OIDC workload identity federation is enabled and can be used for authentication. ||
|| `--federation-id` | `string`

ID of the OIDC workload identity federation to update. To get the OIDC workload identity federation ID, make a [FederationService.List] request. ||
|| `--jwks-url` | `string`

URL reference to trusted keys in format of JSON Web Key Set. ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs ||
|| `--name` | `string`

Name of the OIDC workload identity federation. The name must be unique within the folder. ||
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