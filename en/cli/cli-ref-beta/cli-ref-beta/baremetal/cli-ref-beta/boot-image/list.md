---
editable: false
noIndex: true
---

# yc beta baremetal boot-image list

Retrieves the list of Image resources in the specified folder.

#### Command Usage

Syntax:

`yc beta baremetal boot-image list <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression consists of one or more conditions united by 'AND' operator: '&lt;condition1&gt; [AND &lt;condition2&gt; [&lt;...&gt; AND &lt;conditionN&gt;]]'. Each condition has the form '&lt;field&gt; &lt;operator&gt; &lt;value&gt;', where: 1. '&lt;field&gt;' is the field name. Currently you can use filtering only on the limited number of fields. 2. '&lt;operator&gt;' is a logical operator, one of '=' (equal), ':' (substring). 3. '&lt;value&gt;' represents a value. String values should be written in double ('"') or single (''') quotes. C-style escape sequences are supported ('\"' turns to '"', '\'' to ''', '\\' to backslash). Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["id", "name"]. Both snake_case and camelCase are supported for fields. ||
|| `--folder-id` | `string`

ID of the folder to list images in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--order-by` | `string`

By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Supported fields: ["id", "name", "createdAt"]. Both snake_case and camelCase are supported for fields. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is greater than 'page_size', the service returns a [ListConfigurationsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value is 20. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the [ListConfigurationsResponse.next_page_token] returned by a previous list request. ||
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