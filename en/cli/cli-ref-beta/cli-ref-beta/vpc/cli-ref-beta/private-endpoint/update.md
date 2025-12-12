---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/private-endpoint/update.md
---

# yc beta vpc private-endpoint update

Updates the specified private endpoint.

#### Command Usage

Syntax: 

`yc beta vpc private-endpoint update <PRIVATE-ENDPOINT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--address-spec`|<b>`shorthand/json`</b><br/>Private endpoint address specification.<br/>Shorthand Syntax:<br/>{<br/>address = address-id=str \| internal-ipv4-address-spec={<br/>address = str,<br/>subnet-id = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"address": {<br/>"address-id": "str",<br/>"internal-ipv4-address-spec": {<br/>"address": "str",<br/>"subnet-id": "str"<br/>}<br/>}<br/>}"<br/>Fields:<br/>address -> (oneof<address-id\|internal-ipv4-address-spec>)<br/>Oneof address field<br/>address-id -> (string)<br/>ID of IP address to associate with private endpoint.<br/>internal-ipv4-address-spec -> (struct)<br/>Internal ipv4 address specification.<br/>address -> (string)<br/>Value of address.<br/>subnet-id -> (string)<br/>ID of the subnet that address belongs to.|
|`--description`|<b>`string`</b><br/>New description of the private endpoint.|
|`--dns-options`|<b>`shorthand/json`</b><br/>Private endpoint dns options.<br/>Shorthand Syntax:<br/>{<br/>private-dns-records-enabled = bool<br/>}<br/>JSON Syntax:<br/>"{<br/>"private-dns-records-enabled": "bool"<br/>}"<br/>Fields:<br/>private-dns-records-enabled -> (bool)<br/>If enabled - vpc will create private dns records for specified service.|
|`--labels`|<b>`stringToString`</b><br/>Private endpoint labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [PrivateEndpointService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the private endpoint. The name must be unique within the folder.|
|`--private-endpoint-id`|<b>`string`</b><br/>ID of the private endpoint to update. To get the private endpoint ID make a [PrivateEndpointService.List] request.|
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
