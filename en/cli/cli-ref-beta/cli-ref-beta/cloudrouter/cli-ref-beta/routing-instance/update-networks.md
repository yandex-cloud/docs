---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cloudrouter/cli-ref-beta/routing-instance/update-networks.md
---

# yc beta cloudrouter routing-instance update-networks

Updates multiple vpc using the data specified in the request.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cloudrouter routing-instance update-networks <ROUTING-INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--added-vpc-networks`|<b>`shorthand/json`</b><br/>Lists information about the VPC networks that are added to the routing instance.<br/>Shorthand Syntax:<br/>[<br/>{<br/>vpc-az-info-prefixes = [<br/>{<br/>az-id = str,<br/>prefixes = str,...<br/>}, ...<br/>],<br/>vpc-network-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"vpc-az-info-prefixes": [<br/>{<br/>"az-id": "str",<br/>"prefixes": [<br/>"str", ...<br/>]<br/>}, ...<br/>],<br/>"vpc-network-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>vpc-az-info-prefixes -> ([]struct)<br/>List of the az-related info about vpcNetworks which are attached to routingInstance<br/>az-id -> (string)<br/>ID of the AZ.<br/>prefixes -> ([]string)<br/>List of prefixes.<br/>vpc-network-id -> (string)<br/>ID of the vpcNetwork that is attached to the routingInstance.|
|`--deleted-vpc-network-ids`|<b>`strings`</b><br/>List of VPC ids to remove from the routing instance.|
|`--routing-instance-id`|<b>`string`</b><br/>ID of the RoutingInstance resource.|
|`--strict-remove`|Specifies whether to check for vpc in routing instance.|
|`--updated-vpc-networks`|<b>`shorthand/json`</b><br/>List of VPC network information that is updated in the routing instance.<br/>Shorthand Syntax:<br/>[<br/>{<br/>vpc-az-info-prefixes = [<br/>{<br/>az-id = str,<br/>prefixes = str,...<br/>}, ...<br/>],<br/>vpc-network-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"vpc-az-info-prefixes": [<br/>{<br/>"az-id": "str",<br/>"prefixes": [<br/>"str", ...<br/>]<br/>}, ...<br/>],<br/>"vpc-network-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>vpc-az-info-prefixes -> ([]struct)<br/>List of the az-related info about vpcNetworks which are attached to routingInstance<br/>az-id -> (string)<br/>ID of the AZ.<br/>prefixes -> ([]string)<br/>List of prefixes.<br/>vpc-network-id -> (string)<br/>ID of the vpcNetwork that is attached to the routingInstance.|
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
