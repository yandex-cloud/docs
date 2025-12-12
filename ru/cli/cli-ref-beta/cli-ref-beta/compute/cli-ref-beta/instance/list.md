---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/list.md
---

# yc beta compute instance list

Retrieves the list of Instance resources in the specified folder.

#### Command Usage

Syntax: 

`yc beta compute instance list <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--filter`|<b>`string`</b><br/>A filter expression that filters resources listed in the response. The expression consists of one or more conditions united by 'AND' operator: '\<condition1\> [AND \<condition2\> [<...> AND \<conditionN\>]]'. Each condition has the form '\<field\> \<operator\> \<value\>', where: 1. '\<field\>' is the field name. Currently you can use filtering on these fields only: - 'id': ID of the instance. - 'name': name of the instance. - 'created_at': timestamp representing the moment in time the instance was created at. - 'status': documentation of the instance. - 'zone_id': ID of the documentation where the instance resides. - 'platform_id': ID of the hardware documentation the instance is created on. - 'host_id': ID of the documentation that the instance belongs to. 2. '\<operator\>' is a logical operator, one of '=', '!=', 'IN', 'NOT IN'. 3. '\<value\>' represents a value. String values should be written in double ('"') or single (''') quotes. C-style escape sequences are supported ('\"' turns to '"', '\'' to ''', '\\' to backslash).|
|`--folder-id`|<b>`string`</b><br/>ID of the Folder to list instances in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--order-by`|<b>`string`</b><br/>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. The default sorting order is ascending|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListInstancesResponse.next_page_token] that can be used to get the next page of results in subsequent list requests.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set [page_token] to the [ListInstancesResponse.next_page_token] returned by a previous list request.|

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
