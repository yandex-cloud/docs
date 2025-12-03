---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/application-load-balancer/cli-ref-beta/target-group/add-targets.md
---

# yc beta application-load-balancer target-group add-targets

Adds targets to the specified target group.

#### Command Usage

Syntax: 

`yc beta application-load-balancer target-group add-targets <TARGET-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--target-group-id`|<b>`string`</b><br/>ID of the target group to add targets to.<br/><br/>To get the target group ID, make a [TargetGroupService.List] request.|
|`--targets`|<b>`shorthand/json`</b><br/>List of targets to add to the target group.<br/><br/>Example:|
|`--targets`|<b>`[{address-type={ip-address=value},`</b><br/>private-ipv4-address=true, subnet-id=value}]<br/><br/>Shorthand Syntax:<br/>[{address-type={ip-address=str}, private-ipv4-address=bool, subnet-id=str},...]<br/>Fields:<br/>private-ipv4-address  bool               — If set, will not require 'subnet_id' to validate the target.<br/>Instead, the address should belong to one of the following ranges:<br/>10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16<br/>Only one of 'subnet_id' or 'private_ipv4_address' should be set.<br/>subnet-id             string             — ID of the subnet that the target is connected to.<br/>address-type          oneof\<ip-address\>  — Oneof address-type field<br/>ip-address  string  — IP address of the target.<br/>|
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
