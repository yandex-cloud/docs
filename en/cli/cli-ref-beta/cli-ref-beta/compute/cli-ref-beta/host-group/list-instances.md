---
editable: false
noIndex: true
---

# yc beta compute host-group list-instances

Lists instances that belongs to the specified host group.

#### Command Usage

Syntax:

`yc beta compute host-group list-instances <HOST-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

A filter expression that filters resources listed in the response. The expression consists of one or more conditions united by 'AND' operator: '&lt;condition1&gt; [AND &lt;condition2&gt; [&lt;...&gt; AND &lt;conditionN&gt;]]'. Each condition has the form '&lt;field&gt; &lt;operator&gt; &lt;value&gt;', where: 1. '&lt;field&gt;' is the field name. Currently you can use filtering only on the limited number of fields. 2. '&lt;operator&gt;' is a logical operator, one of '=', '!=', 'IN', 'NOT IN'. 3. '&lt;value&gt;' represents a value. String values should be written in double ('"') or single (''') quotes. C-style escape sequences are supported ('\"' turns to '"', '\'' to ''', '\\' to backslash). Currently you can use filtering only on the [Host.id] field. To get the host ID, use [HostGroupService.ListHosts] request. ||
|| `--host-group-id` | `string`

ID of the host group to list instances for. To get the host group ID, use [HostGroupService.List] request. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than [page_size], the service returns a [ListHostGroupInstancesResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set [page_token] to the [ListHostGroupInstancesResponse.next_page_token] returned by a previous list request. ||
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