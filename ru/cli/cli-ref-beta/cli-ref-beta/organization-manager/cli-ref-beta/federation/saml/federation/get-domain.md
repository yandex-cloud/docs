---
editable: false
noIndex: true
---

# yc beta organization-manager federation saml federation get-domain

Returns the specified domain in the federation.
To get the list of available domains, make a [ListDomains] request.

#### Command Usage

Syntax:

`yc beta organization-manager federation saml federation get-domain <FEDERATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--domain` | `string`

Domain name to get information for. Must be a valid domain name (1-253 characters). ||
|| `--federation-id` | `string`

ID of the federation to get domain information for. To get the federation ID, make a [FederationService.List] request. ||
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