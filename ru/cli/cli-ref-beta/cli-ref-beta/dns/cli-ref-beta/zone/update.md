---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dns/cli-ref-beta/zone/update.md
---

# yc beta dns zone update

Updates the specified DNS zone.

#### Command Usage

Syntax: 

`yc beta dns zone update <DNS-ZONE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--deletion-protection`|Prevents accidental zone removal.|
|`--description`|<b>`string`</b><br/>New description of the DNS zone.|
|`--dns-zone-id`|<b>`string`</b><br/>ID of the DNS zone to update. To get the DNS zone ID, make a [DnsZoneService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>DNS zone labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [DnsZoneService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the DNS zone. The name must be unique within the folder.|
|`--private-visibility`|<b>`shorthand/json`</b><br/>Change network IDs for private visibility.<br/>Shorthand Syntax:<br/>{<br/>network-ids = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"network-ids": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>network-ids -> ([]string)<br/>Network IDs.|
|`--public-visibility`|<b>`shorthand/json`</b><br/>Public visibility configuration.<br/>Shorthand Syntax:<br/>{}<br/>JSON Syntax:<br/>"{}"|
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
