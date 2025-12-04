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
|`--address-spec`|<b>`shorthand/json`</b><br/>Private endpoint address specification.<br/><br/>Example:<br/>--address-spec address={address-id=value}<br/><br/>Shorthand Syntax:<br/>{address={address-id=str \| internal-ipv4-address-spec={address=str, subnet-id=str}}}<br/>Fields:<br/>address  oneof<address-id\|internal-ipv4-address-spec>  — Oneof address field<br/>address-id                  string  — ID of IP address to associate with private endpoint.<br/>internal-ipv4-address-spec  struct  — Internal ipv4 address specification.<br/>address    string            — Value of address.<br/>subnet-id  string  required  — ID of the subnet that address belongs to.<br/>|
|`--description`|<b>`string`</b><br/>New description of the private endpoint.|
|`--dns-options`|<b>`shorthand/json`</b><br/>Private endpoint dns options.<br/><br/>Example:<br/>--dns-options private-dns-records-enabled=true<br/><br/>Shorthand Syntax:<br/>{private-dns-records-enabled=bool}<br/>Fields:<br/>private-dns-records-enabled  bool  — If enabled - vpc will create private dns records for specified service.<br/>|
|`--labels`|<b>`stringToString`</b><br/>Private endpoint labels as 'key:value' pairs.<br/><br/>Existing set of labels is completely replaced by the provided set, so if<br/>you just want to add or remove a label:<br/>1. Get the current set of labels with a [PrivateEndpointService.Get]<br/>request.<br/>2. Add or remove a label in this set.<br/>3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the private endpoint.<br/>The name must be unique within the folder.|
|`--private-endpoint-id`|<b>`string`</b><br/>ID of the private endpoint to update.<br/><br/>To get the private endpoint ID make a [PrivateEndpointService.List]<br/>request.|
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
