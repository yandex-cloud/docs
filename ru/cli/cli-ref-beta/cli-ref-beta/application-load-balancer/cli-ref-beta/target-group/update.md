---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/application-load-balancer/cli-ref-beta/target-group/update.md
---

# yc beta application-load-balancer target-group update

Updates the specified target group.

#### Command Usage

Syntax: 

`yc beta application-load-balancer target-group update <TARGET-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New description of the target group.|
|`--labels`|<b>`stringToString`</b><br/>Target group labels as 'key:value' pairs. For details about the concept, see documentation. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [TargetGroupService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the target group. The name must be unique within the folder.|
|`--target-group-id`|<b>`string`</b><br/>ID of the target group to update. To get the target group ID, make a [TargetGroupService.List] request.|
|`--targets`|<b>`shorthand/json`</b><br/>New list of targets in the target group. Existing list of targets is completely replaced by the specified list, so if you just want to add or remove a target, make a [TargetGroupService.AddTargets] request or a [TargetGroupService.RemoveTargets] request.<br/>Shorthand Syntax:<br/>[<br/>{<br/>address-type = ip-address=str,<br/>private-ipv4-address = bool,<br/>subnet-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"address-type": {<br/>"ip-address": "str"<br/>},<br/>"private-ipv4-address": "bool",<br/>"subnet-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>private-ipv4-address -> (bool)<br/>If set, will not require 'subnet_id' to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of 'subnet_id' or 'private_ipv4_address' should be set.<br/>subnet-id -> (string)<br/>ID of the subnet that the target is connected to.<br/>address-type -> (oneof\<ip-address\>)<br/>Oneof address-type field<br/>ip-address -> (string)<br/>IP address of the target.|
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
