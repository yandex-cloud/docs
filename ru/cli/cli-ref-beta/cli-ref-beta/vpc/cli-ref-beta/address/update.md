---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/address/update.md
---

# yc beta vpc address update

Updates the specified address.

#### Command Usage

Syntax: 

`yc beta vpc address update <ADDRESS-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--address-id`|<b>`string`</b><br/>ID of the address to update. To get the address ID make a [AddressService.List] request.|
|`--deletion-protection`|Specifies if address protected from deletion.|
|`--description`|<b>`string`</b><br/>New description of the address.|
|`--dns-record-specs`|<b>`shorthand/json`</b><br/>Optional DNS record specifications<br/>Shorthand Syntax:<br/>[<br/>{<br/>dns-zone-id = str,<br/>fqdn = str,<br/>ptr = bool,<br/>ttl = int<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"dns-zone-id": "str",<br/>"fqdn": "str",<br/>"ptr": "bool",<br/>"ttl": "int"<br/>}, ...<br/>]"<br/>Fields:<br/>dns-zone-id -> (string)<br/>Required. ID of the public DNS zone. The maximum string length in characters is 20.<br/>fqdn -> (string)<br/>Required. DNS record name (absolute or relative to the DNS zone in use).<br/>ptr -> (bool)<br/>Optional. If the PTR record is required, this parameter must be set to "true".<br/>ttl -> (int)<br/>TTL of record. Acceptable values are 0 to 86400, inclusive.|
|`--labels`|<b>`stringToString`</b><br/>Address labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [AddressService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the address. The name must be unique within the folder.|
|`--reserved`|Specifies if address is reserved or not.|
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
