---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/scanner/list-vulnerabilities.md
---

# yc beta container scanner list-vulnerabilities

Retrieves the list of vulnerabilities found in particular scan.

#### Command Usage

Syntax: 

`yc beta container scanner list-vulnerabilities <SCAN-RESULT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response.<br/>The expression must specify:<br/>1. The field name. Currently you can use filtering only on [Vulnerability.severity] and [PackageVulnerability.name] fields.<br/>2. An '=' operator.<br/>3. The value in double quotes ('"').|
|`--order-by`|<b>`string`</b><br/>An order expression that orders resources listed in the response.<br/>The expression must specify:<br/>1. The field name. Currently you can use filtering only on [Vulnerability.severity] and [PackageVulnerability.name] fields.<br/>2. Order selector. Currently you can use ordering only on 'Vulnerability.severity' field (recent first).|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than [page_size],<br/>the service returns a [ListRegistriesResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.<br/>Default value: 100.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the<br/>[ListRegistriesResponse.next_page_token] returned by a previous list request.|
|`--scan-result-id`|<b>`string`</b><br/>ID of the ScanResult to get list of vulnerabilities for.|

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
