---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dns/cli-ref-beta/zone/list-record-sets.md
---

# yc beta dns zone list-record-sets

Retrieves the list of record sets in the specified folder.

#### Command Usage

Syntax: 

`yc beta dns zone list-record-sets <DNS-ZONE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--dns-zone-id`|<b>`string`</b><br/>ID of the DNS zone to list record sets in.<br/><br/>To get a DNS zone ID, make a [DnsZoneService.List] request.|
|`--filter`|<b>`string`</b><br/>A filter expression that filters record sets listed in the response. The expression consists of one or more conditions united by 'AND' operator: '\<condition1\> [AND \<condition2\> [<...> AND \<conditionN\>]]'.<br/><br/>Each condition has the form '\<field\> \<operator\> \<value\>', where:<br/>1. '\<field\>' is the field name. Currently you can use filtering only on the [RecordSet.name] and [RecordSet.type] fields.<br/>2. '\<operator\>' is a logical operator, one of '=', '!=', 'IN', 'NOT IN'.<br/>3. '\<value\>' represents a value.<br/>3.1. In case of single value condition ('=' or '!='), the value is a string in double ('"') or single (''') quotes. C-style escape sequences are supported ('\"' turns to '"', '\'' to ''', '\\' to backslash).<br/>3.2. In case of a list of values condition ('IN' or 'NOT IN'), the value is '(\<string1\>, \<string2\>, .., \<stringN\>)', where '\<string\>' is a string in double ('"') or single (''') quotes.<br/><br/>Examples of a filter: 'name="my-record-set"', 'type IN ("MX","A") AND name="works.on.my.machine."'.|
|`--page-size`|<b>`int`</b><br/>The maximum number of results per page to return. If the number of available<br/>results is larger than 'page_size', the service returns a [ListDnsZoneRecordSetsResponse.next_page_token]<br/>that can be used to get the next page of results in subsequent list requests.|
|`--page-token`|<b>`string`</b><br/>Page token. To get the next page of results, set 'page_token' to the<br/>[ListDnsZoneRecordSetsResponse.next_page_token] returned by a previous list request.|

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
