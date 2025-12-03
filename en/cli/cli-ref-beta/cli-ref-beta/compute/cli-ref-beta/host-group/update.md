---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/host-group/update.md
---

# yc beta compute host-group update

Updates the specified host group.

#### Command Usage

Syntax: 

`yc beta compute host-group update <HOST-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>Description of the group.|
|`--host-group-id`|<b>`string`</b><br/>ID of the host group to update.<br/>To get the host group ID, use an [HostGroupService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.<br/><br/>The existing set of 'labels' is completely replaced by the provided set.|
|`--maintenance-policy`|<b>`enum`</b><br/>Behaviour on maintenance events Possible Values: 'restart', 'migrate'|
|`--name`|<b>`string`</b><br/>Name of the group.|
|`--scale-policy`|<b>`shorthand/json`</b><br/>Scale policy. Only fixed number of hosts are supported at this moment.<br/><br/>Example:<br/>--scale-policy scale-type={fixed-scale={size=1}}<br/><br/>Shorthand Syntax:<br/>{scale-type={fixed-scale={size=int}}}<br/>Fields:<br/>scale-type  oneof\<fixed-scale\>  — Oneof scale-type field<br/>fixed-scale  struct  —<br/>size  int  —<br/>|
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
