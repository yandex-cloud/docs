---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/organization-manager/cli-ref-beta/federation/saml/federation/list-domains.md
---

# yc beta organization-manager federation saml federation list-domains

Retrieves the list of domains in the specified federation.

#### Command Usage

Syntax: 

`yc beta organization-manager federation saml federation list-domains <FEDERATION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--federation-id`|<b>`string`</b><br/>ID of the federation to list domains for.<br/>To get the federation ID, make a [FederationService.List] request.|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response.<br/>The expression supports the following operations:<br/>- '=' for exact match: 'domain = 'domain-1.com''<br/>- 'IN' for multiple values: 'status IN ('NEED_TO_VALIDATE', 'VALID')'<br/>- 'contains' for domain substring search: 'domain contains '3''<br/>- 'AND' for combining conditions: 'status = 'INVALID' AND domain contains '3''<br/><br/>Available fields for filtering:<br/>- 'domain' - domain name<br/>- 'status' - domain validation status<br/><br/>Must be 1-1000 characters long.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than [page_size], the service returns a [ListFederationDomainsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token]<br/>to the [ListFederationDomainsResponse.next_page_token]<br/>returned by a previous list request.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
