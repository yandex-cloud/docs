---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/application-load-balancer/cli-ref-beta/target-group/create.md
---

# yc beta application-load-balancer target-group create

Creates a target group in the specified folder.

#### Command Usage

Syntax: 

`yc beta application-load-balancer target-group create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the target group.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a target group in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Target group labels as 'key:value' pairs. For details about the concept, see documentation.|
|`--name`|<b>`string`</b><br/>Name of the target group. The name must be unique within the folder.|
|`--targets`|<b>`shorthand/json`</b><br/>List of targets in the target group.<br/>Shorthand Syntax:<br/>[<br/>{<br/>address-type = ip-address=str,<br/>private-ipv4-address = bool,<br/>subnet-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"address-type": {<br/>"ip-address": "str"<br/>},<br/>"private-ipv4-address": "bool",<br/>"subnet-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>private-ipv4-address -> (bool)<br/>If set, will not require 'subnet_id' to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of 'subnet_id' or 'private_ipv4_address' should be set.<br/>subnet-id -> (string)<br/>ID of the subnet that the target is connected to.<br/>address-type -> (oneof\<ip-address\>)<br/>Oneof address-type field<br/>ip-address -> (string)<br/>IP address of the target.|
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
