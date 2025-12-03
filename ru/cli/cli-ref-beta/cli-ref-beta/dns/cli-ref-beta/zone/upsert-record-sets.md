---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dns/cli-ref-beta/zone/upsert-record-sets.md
---

# yc beta dns zone upsert-record-sets

Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist.  Deletes records that match all specified fields which allows to delete only specified records from a record set.

#### Command Usage

Syntax: 

`yc beta dns zone upsert-record-sets <DNS-ZONE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--deletions`|<b>`shorthand/json`</b><br/>Delete only specified records from corresponding record sets.<br/><br/>Example:|
|`--deletions`|<b>`[{data=value,`</b><br/>name=value, ttl=1, type=value}]<br/><br/>Shorthand Syntax:<br/>[{data=str,..., name=str, ttl=int, type=str},...]<br/>Fields:<br/>data  []string  — Data of the record set.<br/>name  string    — Domain name.<br/>ttl   int       — Time to live in seconds.<br/>type  string    — Record type.<br/>|
|`--dns-zone-id`|<b>`string`</b><br/>ID of the DNS zone to upsert record sets to.<br/><br/>To get a DNS zone ID, make a [DnsZoneService.List] request.|
|`--merges`|<b>`shorthand/json`</b><br/>Replace specified records or add new ones if no such record sets exists.<br/><br/>Example:|
|`--merges`|<b>`[{data=value,`</b><br/>name=value, ttl=1, type=value}]<br/><br/>Shorthand Syntax:<br/>[{data=str,..., name=str, ttl=int, type=str},...]<br/>Fields:<br/>data  []string  — Data of the record set.<br/>name  string    — Domain name.<br/>ttl   int       — Time to live in seconds.<br/>type  string    — Record type.<br/>|
|`--replacements`|<b>`shorthand/json`</b><br/>Entirely replace specified record sets.<br/><br/>Example:|
|`--replacements`|<b>`[{data=value,`</b><br/>name=value, ttl=1, type=value}]<br/><br/>Shorthand Syntax:<br/>[{data=str,..., name=str, ttl=int, type=str},...]<br/>Fields:<br/>data  []string  — Data of the record set.<br/>name  string    — Domain name.<br/>ttl   int       — Time to live in seconds.<br/>type  string    — Record type.<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
