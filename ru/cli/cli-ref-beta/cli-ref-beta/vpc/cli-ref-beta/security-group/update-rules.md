---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/security-group/update-rules.md
---

# yc beta vpc security-group update-rules

Updates the rules of the specified security group.

#### Command Usage

Syntax: 

`yc beta vpc security-group update-rules <SECURITY-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--addition-rule-specs`|<b>`shorthand/json`</b><br/>Security rules specifications.<br/>Shorthand Syntax:<br/>[<br/>{<br/>description = str,<br/>direction = INGRESS\|EGRESS,<br/>labels = {key=str, key=...},<br/>ports = {<br/>from-port = int,<br/>to-port = int<br/>},<br/>protocol = protocol-name=str \| protocol-number=int,<br/>target = cidr-blocks={<br/>v4-cidr-blocks = str,...,<br/>v6-cidr-blocks = str,...<br/>} \| predefined-target=str \| security-group-id=str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"description": "str",<br/>"direction": "INGRESS\|EGRESS",<br/>"labels": {<br/>"\<key\>": "str", ...<br/>},<br/>"ports": {<br/>"from-port": "int",<br/>"to-port": "int"<br/>},<br/>"protocol": {<br/>"protocol-name": "str",<br/>"protocol-number": "int"<br/>},<br/>"target": {<br/>"cidr-blocks": {<br/>"v4-cidr-blocks": [<br/>"str", ...<br/>],<br/>"v6-cidr-blocks": [<br/>"str", ...<br/>]<br/>},<br/>"predefined-target": "str",<br/>"security-group-id": "str"<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>description -> (string)<br/>Description of the security rule.<br/>direction -> (enum<EGRESS\|INGRESS>)<br/>The direction of network traffic allowed by this rule.<br/>labels -> (map[string,string])<br/>Rule labels as '' key:value '' pairs.<br/>ports -> (struct)<br/>The range of ports that allow traffic to pass through. Null value means any port.<br/>from-port -> (int)<br/>The lowest port in the range.<br/>to-port -> (int)<br/>The highest port in the range.<br/>protocol -> (oneof<protocol-name\|protocol-number>)<br/>Oneof protocol field<br/>protocol-name -> (string)<br/>Protocol name.<br/>protocol-number -> (int)<br/>Protocol number from IANA protocol numbers.<br/>target -> (oneof<cidr-blocks\|predefined-target\|security-group-id>)<br/>Oneof target field<br/>cidr-blocks -> (struct)<br/>CIDR blocks to allow to recieve or send traffic.<br/>v4-cidr-blocks -> ([]string)<br/>IPv4 CIDR blocks to allow traffic to.<br/>v6-cidr-blocks -> ([]string)<br/>IPv6 CIDR blocks to allow traffic to.<br/>security-group-id -> (string)<br/>ID of the security group to add rule to.<br/>predefined-target -> (string)<br/>Predefined target. See documentation for more information.|
|`--deletion-rule-ids`|<b>`strings`</b><br/>List of rules IDs to delete.|
|`--security-group-id`|<b>`string`</b><br/>ID of the SecurityGroup that is being updated with new rules.|
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
