---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/public-subnet/list.md
---

# yc beta baremetal public-subnet list

Retrieves the list of PublicSubnet resources in the specified folder.

#### Command Usage

Syntax: 

`yc beta baremetal public-subnet list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. The expression consists of one or more conditions united by 'AND' operator: '\<condition1\> [AND \<condition2\> [<...> AND \<conditionN\>]]'. Each condition has the form '\<field\> \<operator\> \<value\>', where: 1. '\<field\>' is the field name. Currently you can use filtering only on the limited number of fields. 2. '\<operator\>' is a logical operator, one of '=' (equal), ':' (substring), '@>' (contains). 3. '\<value\>' represents a value. String values should be written in double ('"') or single (''') quotes. C-style escape sequences are supported ('\"' turns to '"', '\'' to ''', '\\' to backslash). Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["id", "name", "zoneId", "hardwarePoolIds"]. Deprecated fields: ["hardwarePoolId"]. Both snake_case and camelCase are supported for fields.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to list public subnets in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--order-by`|<b>`string`</b><br/>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Supported fields: ["id", "name", "createdAt"]. Both snake_case and camelCase are supported for fields.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is greater than 'page_size', the service returns a [ListPublicSubnetResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value is 20.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the [ListPublicSubnetResponse.next_page_token] returned by a previous list request.|

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
