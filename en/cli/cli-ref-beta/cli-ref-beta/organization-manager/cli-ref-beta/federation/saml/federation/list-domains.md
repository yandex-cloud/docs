---
editable: false
noIndex: true
---

# yc beta organization-manager federation saml federation list-domains

Retrieves the list of domains in the specified federation.

#### Command Usage

Syntax:

`yc beta organization-manager federation saml federation list-domains <FEDERATION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--federation-id` | `string`

ID of the federation to list domains for. To get the federation ID, make a [FederationService.List] request. ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression supports the following operations: - '=' for exact match: 'domain = 'domain-1.com'' - 'IN' for multiple values: 'status IN ('NEED_TO_VALIDATE', 'VALID')' - 'contains' for domain substring search: 'domain contains '3'' - 'AND' for combining conditions: 'status = 'INVALID' AND domain contains '3'' Available fields for filtering: - 'domain' - domain name - 'status' - domain validation status Must be 1-1000 characters long. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListFederationDomainsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListFederationDomainsResponse.next_page_token] returned by a previous list request. ||
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