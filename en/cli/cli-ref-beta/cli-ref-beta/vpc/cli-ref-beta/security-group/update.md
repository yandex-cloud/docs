---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/security-group/update.md
---

# yc beta vpc security-group update

Updates the specified security group.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta vpc security-group update <SECURITY-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New description of the security group.|
|`--labels`|<b>`stringToString`</b><br/>Security group labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [SecurityGroupService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the security group. The name must be unique within the folder.|
|`--rule-specs`|<b>`shorthand/json`</b><br/>Updated rule list. All existing rules will be replaced with given list.<br/>Shorthand Syntax:<br/>[<br/>{<br/>description = str,<br/>direction = INGRESS\|EGRESS,<br/>labels = {key=str, key=...},<br/>ports = {<br/>from-port = int,<br/>to-port = int<br/>},<br/>protocol = protocol-name=str \| protocol-number=int,<br/>target = cidr-blocks={<br/>v4-cidr-blocks = str,...,<br/>v6-cidr-blocks = str,...<br/>} \| predefined-target=str \| security-group-id=str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"description": "str",<br/>"direction": "INGRESS\|EGRESS",<br/>"labels": {<br/>"\<key\>": "str", ...<br/>},<br/>"ports": {<br/>"from-port": "int",<br/>"to-port": "int"<br/>},<br/>"protocol": {<br/>"protocol-name": "str",<br/>"protocol-number": "int"<br/>},<br/>"target": {<br/>"cidr-blocks": {<br/>"v4-cidr-blocks": [<br/>"str", ...<br/>],<br/>"v6-cidr-blocks": [<br/>"str", ...<br/>]<br/>},<br/>"predefined-target": "str",<br/>"security-group-id": "str"<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>description -> (string)<br/>Description of the security rule.<br/>direction -> (enum<EGRESS\|INGRESS>)<br/>The direction of network traffic allowed by this rule.<br/>labels -> (map[string,string])<br/>Rule labels as '' key:value '' pairs.<br/>ports -> (struct)<br/>The range of ports that allow traffic to pass through. Null value means any port.<br/>from-port -> (int)<br/>The lowest port in the range.<br/>to-port -> (int)<br/>The highest port in the range.<br/>protocol -> (oneof<protocol-name\|protocol-number>)<br/>Oneof protocol field<br/>protocol-name -> (string)<br/>Protocol name.<br/>protocol-number -> (int)<br/>Protocol number from IANA protocol numbers.<br/>target -> (oneof<cidr-blocks\|predefined-target\|security-group-id>)<br/>Oneof target field<br/>cidr-blocks -> (struct)<br/>CIDR blocks to allow to recieve or send traffic.<br/>v4-cidr-blocks -> ([]string)<br/>IPv4 CIDR blocks to allow traffic to.<br/>v6-cidr-blocks -> ([]string)<br/>IPv6 CIDR blocks to allow traffic to.<br/>security-group-id -> (string)<br/>ID of the security group to add rule to.<br/>predefined-target -> (string)<br/>Predefined target. See documentation for more information.|
|`--security-group-id`|<b>`string`</b><br/>ID of the security group to update. To get the security group ID make a [SecurityGroupService.List] request.|
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
