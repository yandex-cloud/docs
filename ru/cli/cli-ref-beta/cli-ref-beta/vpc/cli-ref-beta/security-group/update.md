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
|`--labels`|<b>`stringToString`</b><br/>Security group labels as 'key:value' pairs.<br/><br/>Existing set of labels is completely replaced by the provided set, so if you just want<br/>to add or remove a label:<br/>1. Get the current set of labels with a [SecurityGroupService.Get] request.<br/>2. Add or remove a label in this set.<br/>3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the security group.<br/>The name must be unique within the folder.|
|`--rule-specs`|<b>`shorthand/json`</b><br/>Updated rule list. All existing rules will be replaced with given list.<br/><br/>Example:|
|`--rule-specs`|<b>`[{description=value,`</b><br/>direction=INGRESS, labels={key=value}, ports={from-port=1, to-port=1}, protocol={protocol-name=value}, target={cidr-blocks={v4-cidr-blocks=value, v6-cidr-blocks=value}}}]<br/><br/>Shorthand Syntax:<br/>[{description=str, direction=INGRESS\|EGRESS, labels={key=str, key=...}, ports={from-port=int, to-port=int}, protocol={protocol-name=str \| protocol-number=int}, target={cidr-blocks={v4-cidr-blocks=str,..., v6-cidr-blocks=str,...} \| predefined-target=str \| security-group-id=str}},...]<br/>Fields:<br/>description  string                                                            — Description of the security rule.<br/>direction    enum<EGRESS\|INGRESS>                                    required  — The direction of network traffic allowed by this rule.<br/>labels       map[string,string]                                                — Rule labels as '' key:value '' pairs.<br/>ports        struct                                                            — The range of ports that allow traffic to pass through. Null value means any port.<br/>from-port  int  — The lowest port in the range.<br/>to-port    int  — The highest port in the range.<br/>protocol     oneof<protocol-name\|protocol-number>                              — Oneof protocol field<br/>protocol-name    string  — Protocol name.<br/>protocol-number  int     — Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).<br/>target       oneof<cidr-blocks\|predefined-target\|security-group-id>            — Oneof target field<br/>cidr-blocks        struct  — CIDR blocks to allow to recieve or send traffic.<br/>v4-cidr-blocks  []string  — IPv4 CIDR blocks to allow traffic to.<br/>v6-cidr-blocks  []string  — IPv6 CIDR blocks to allow traffic to.<br/>security-group-id  string  — ID of the security group to add rule to.<br/>predefined-target  string  — Predefined target. See [security groups rules](https://yandex.cloud/ru/docs/vpc/concepts/security-groups#security-groups-rules) for more information.<br/>|
|`--security-group-id`|<b>`string`</b><br/>ID of the security group to update.<br/><br/>To get the security group ID make a [SecurityGroupService.List] request.|
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
