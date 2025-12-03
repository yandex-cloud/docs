---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/vpc/cli-ref-beta/security-group/create.md
---

# yc beta vpc security-group create

Creates a security group in the specified folder and network.

#### Command Usage

Syntax: 

`yc beta vpc security-group create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the security group.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder for this request to create a security group in.<br/>To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.|
|`--name`|<b>`string`</b><br/>Name of the security group.<br/>The name must be unique within the folder.|
|`--network-id`|<b>`string`</b><br/>ID of the Network to create security group for.|
|`--rule-specs`|<b>`shorthand/json`</b><br/>Security rules specifications.<br/><br/>Example:|
|`--rule-specs`|<b>`[{description=value,`</b><br/>direction=INGRESS, labels={key=value}, ports={from-port=1, to-port=1}, protocol={protocol-name=value}, target={cidr-blocks={v4-cidr-blocks=value, v6-cidr-blocks=value}}}]<br/><br/>Shorthand Syntax:<br/>[{description=str, direction=INGRESS\|EGRESS, labels={key=str, key=...}, ports={from-port=int, to-port=int}, protocol={protocol-name=str \| protocol-number=int}, target={cidr-blocks={v4-cidr-blocks=str,..., v6-cidr-blocks=str,...} \| predefined-target=str \| security-group-id=str}},...]<br/>Fields:<br/>description  string                                                            — Description of the security rule.<br/>direction    enum<EGRESS\|INGRESS>                                    required  — The direction of network traffic allowed by this rule.<br/>labels       map[string,string]                                                — Rule labels as '' key:value '' pairs.<br/>ports        struct                                                            — The range of ports that allow traffic to pass through. Null value means any port.<br/>from-port  int  — The lowest port in the range.<br/>to-port    int  — The highest port in the range.<br/>protocol     oneof<protocol-name\|protocol-number>                              — Oneof protocol field<br/>protocol-name    string  — Protocol name.<br/>protocol-number  int     — Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).<br/>target       oneof<cidr-blocks\|predefined-target\|security-group-id>            — Oneof target field<br/>cidr-blocks        struct  — CIDR blocks to allow to recieve or send traffic.<br/>v4-cidr-blocks  []string  — IPv4 CIDR blocks to allow traffic to.<br/>v6-cidr-blocks  []string  — IPv6 CIDR blocks to allow traffic to.<br/>security-group-id  string  — ID of the security group to add rule to.<br/>predefined-target  string  — Predefined target. See [security groups rules](https://yandex.cloud/ru/docs/vpc/concepts/security-groups#security-groups-rules) for more information.<br/>|
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
