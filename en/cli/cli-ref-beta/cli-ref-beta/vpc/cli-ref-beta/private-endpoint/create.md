---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/private-endpoint/create.md
---

# yc beta vpc private-endpoint create

Creates an private endpoint in the specified folder and network.

#### Command Usage

Syntax: 

`yc beta vpc private-endpoint create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--address-spec`|<b>`shorthand/json`</b><br/>Private endpoint address specification.<br/><br/>Example:<br/>--address-spec address={address-id=value}<br/><br/>Shorthand Syntax:<br/>{address={address-id=str \| internal-ipv4-address-spec={address=str, subnet-id=str}}}<br/>Fields:<br/>address  oneof<address-id\|internal-ipv4-address-spec>  — Oneof address field<br/>address-id                  string  — ID of IP address to associate with private endpoint.<br/>internal-ipv4-address-spec  struct  — Internal ipv4 address specification.<br/>address    string            — Value of address.<br/>subnet-id  string  required  — ID of the subnet that address belongs to.<br/>|
|`--description`|<b>`string`</b><br/>Description of the private endpoint.|
|`--dns-options`|<b>`shorthand/json`</b><br/>Private endpoint dns options.<br/><br/>Example:<br/>--dns-options private-dns-records-enabled=true<br/><br/>Shorthand Syntax:<br/>{private-dns-records-enabled=bool}<br/>Fields:<br/>private-dns-records-enabled  bool  — If enabled - vpc will create private dns records for specified service.<br/>|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a private endpoint in.<br/><br/>To get a folder ID make a<br/>[yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Private endpoint labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the private endpoint.<br/>The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the network to create a private endpoint in.|
|`--object-storage`|<b>`shorthand/json`</b><br/>Yandex Cloud Object Storage.<br/><br/>Example:<br/>--object-storage<br/><br/>Shorthand Syntax:<br/>{}|
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
