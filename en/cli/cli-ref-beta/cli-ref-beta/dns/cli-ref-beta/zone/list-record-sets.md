---
editable: false
noIndex: true
---

# yc beta dns zone list-record-sets

Retrieves the list of record sets in the specified folder.

#### Command Usage

Syntax:

`yc beta dns zone list-record-sets <DNS-ZONE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--dns-zone-id` | `string`

ID of the DNS zone to list record sets in. To get a DNS zone ID, make a [DnsZoneService.List] request. ||
|| `--filter` | `string`

A filter expression that filters record sets listed in the response. The expression consists of one or more conditions united by 'AND' operator: '&lt;condition1&gt; [AND &lt;condition2&gt; [&lt;...&gt; AND &lt;conditionN&gt;]]'. Each condition has the form '&lt;field&gt; &lt;operator&gt; &lt;value&gt;', where: 1. '&lt;field&gt;' is the field name. Currently you can use filtering only on the [RecordSet.name] and [RecordSet.type] fields. 2. '&lt;operator&gt;' is a logical operator, one of '=', '!=', 'IN', 'NOT IN'. 3. '&lt;value&gt;' represents a value. 3.1. In case of single value condition ('=' or '!='), the value is a string in double ('"') or single (''') quotes. C-style escape sequences are supported ('\"' turns to '"', '\'' to ''', '\\' to backslash). 3.2. In case of a list of values condition ('IN' or 'NOT IN'), the value is '(&lt;string1&gt;, &lt;string2&gt;, .., &lt;stringN&gt;)', where '&lt;string&gt;' is a string in double ('"') or single (''') quotes. Examples of a filter: 'name="my-record-set"', 'type IN ("MX","A") AND name="works.on.my.machine."'. ||
|| `--page-size` | `int`

The maximum number of results per page to return. If the number of available results is larger than 'page_size', the service returns a [ListDnsZoneRecordSetsResponse.next_page_token] that can be used to get the next page of results in subsequent list requests. ||
|| `--page-token` | `string`

Page token. To get the next page of results, set 'page_token' to the [ListDnsZoneRecordSetsResponse.next_page_token] returned by a previous list request. ||
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