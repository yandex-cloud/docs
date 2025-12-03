---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dns/cli-ref-beta/zone/update-record-sets.md
---

# yc beta dns zone update-record-sets

Method with strict control for changing zone state. Returns error when:  1. Deleted record is not found.  2. Found record with matched type and name but different TTL or value.  3. Attempted to add record with existing name and type.  Deletions happen first. If a record with the same name and type exists in both lists,  then the existing record will be deleted, and a new one added.

#### Command Usage

Syntax: 

`yc beta dns zone update-record-sets <DNS-ZONE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--additions`|<b>`shorthand/json`</b><br/>List of record sets to add.<br/><br/>Example:|
|`--additions`|<b>`[{data=value,`</b><br/>name=value, ttl=1, type=value}]<br/><br/>Shorthand Syntax:<br/>[{data=str,..., name=str, ttl=int, type=str},...]<br/>Fields:<br/>data  []string  — Data of the record set.<br/>name  string    — Domain name.<br/>ttl   int       — Time to live in seconds.<br/>type  string    — Record type.<br/>|
|`--deletions`|<b>`shorthand/json`</b><br/>List of record sets to delete.<br/><br/>Example:|
|`--deletions`|<b>`[{data=value,`</b><br/>name=value, ttl=1, type=value}]<br/><br/>Shorthand Syntax:<br/>[{data=str,..., name=str, ttl=int, type=str},...]<br/>Fields:<br/>data  []string  — Data of the record set.<br/>name  string    — Domain name.<br/>ttl   int       — Time to live in seconds.<br/>type  string    — Record type.<br/>|
|`--dns-zone-id`|<b>`string`</b><br/>ID of the DNS zone to update record sets in.<br/><br/>To get a DNS zone ID, make a [DnsZoneService.List] request.|
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
