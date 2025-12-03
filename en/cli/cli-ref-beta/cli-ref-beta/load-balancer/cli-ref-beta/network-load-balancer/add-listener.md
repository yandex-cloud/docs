---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/load-balancer/cli-ref-beta/network-load-balancer/add-listener.md
---

# yc beta load-balancer network-load-balancer add-listener

Adds a listener to the specified network load balancer.

#### Command Usage

Syntax: 

`yc beta load-balancer network-load-balancer add-listener <NETWORK-LOAD-BALANCER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--listener-spec`|<b>`shorthand/json`</b><br/>Listener spec.<br/><br/>Example:|
|`--listener-spec`|<b>`address={external-address-spec={address=value,`</b><br/>ip-version=IPV4}}, name=value, port=1, protocol=TCP, target-port=1<br/><br/>Shorthand Syntax:<br/>{address={external-address-spec={address=str, ip-version=IPV4\|IPV6} \| internal-address-spec={address=str, ip-version=IPV4\|IPV6, subnet-id=str}}, name=str, port=int, protocol=TCP\|UDP, target-port=int}<br/>Fields:<br/>name         string                                              required  — Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.<br/>port         int                                                           — Port for incoming traffic.<br/>protocol     enum<TCP\|UDP>                                       required  — Protocol for incoming traffic.<br/>target-port  int                                                           — Port of a target.<br/>Acceptable values are 1 to 65535, inclusive.<br/>address      oneof<external-address-spec\|internal-address-spec>            — Oneof address field<br/>external-address-spec  struct  — External IP address specification.<br/>address     string           — Public IP address for a listener.<br/>If you provide a static public IP address for the [NetworkLoadBalancerService.Update]<br/>method, it will replace the existing listener address.<br/>ip-version  enum<IPV4\|IPV6>  — IP version.<br/>internal-address-spec  struct  — Internal IP address specification.<br/>address     string           — Internal IP address for a listener.<br/>ip-version  enum<IPV4\|IPV6>  — IP version.<br/>subnet-id   string           — ID of the subnet.<br/>|
|`--network-load-balancer-id`|<b>`string`</b><br/>ID of the network load balancer to add a listener to.<br/>To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request.|
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
