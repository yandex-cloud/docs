---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/load-balancer/cli-ref-beta/network-load-balancer/create.md
---

# yc beta load-balancer network-load-balancer create

Creates a network load balancer in the specified folder using the data specified in the request.

#### Command Usage

Syntax: 

`yc beta load-balancer network-load-balancer create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--allow-zonal-shift`|Specifies if network load balancer available to zonal shift.|
|`--attached-target-groups`|<b>`shorthand/json`</b><br/>List of attached target groups for the network load balancer.<br/>Shorthand Syntax:<br/>[<br/>{<br/>health-checks = [<br/>{<br/>healthy-threshold = int,<br/>interval = duration,<br/>name = str,<br/>options = http-options={<br/>path = str,<br/>port = int<br/>} \| tcp-options={<br/>port = int<br/>},<br/>timeout = duration,<br/>unhealthy-threshold = int<br/>}, ...<br/>],<br/>target-group-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"health-checks": [<br/>{<br/>"healthy-threshold": "int",<br/>"interval": "duration",<br/>"name": "str",<br/>"options": {<br/>"http-options": {<br/>"path": "str",<br/>"port": "int"<br/>},<br/>"tcp-options": {<br/>"port": "int"<br/>}<br/>},<br/>"timeout": "duration",<br/>"unhealthy-threshold": "int"<br/>}, ...<br/>],<br/>"target-group-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>health-checks -> ([]struct)<br/>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.<br/>healthy-threshold -> (int)<br/>Number of successful health checks required in order to set the '' HEALTHY '' status for the target. The default is 2.<br/>interval -> (duration)<br/>The interval between health checks. The default is 2 seconds.<br/>name -> (string)<br/>Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.<br/>timeout -> (duration)<br/>Timeout for a target to return a response for the health check. The default is 1 second.<br/>unhealthy-threshold -> (int)<br/>Number of failed health checks before changing the status to '' UNHEALTHY ''. The default is 2.<br/>options -> (oneof<http-options\|tcp-options>)<br/>Oneof options field<br/>tcp-options -> (struct)<br/>Options for TCP health check.<br/>port -> (int)<br/>Port to use for TCP health checks.<br/>http-options -> (struct)<br/>Options for HTTP health check.<br/>path -> (string)<br/>URL path to set for health checking requests for every target in the target group. For example '' /ping ''. The default path is '' / ''.<br/>port -> (int)<br/>Port to use for HTTP health checks.<br/>target-group-id -> (string)<br/>ID of the target group.|
|`--deletion-protection`|Specifies if network load balancer protected from deletion.|
|`--description`|<b>`string`</b><br/>Description of the network load balancer.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a network load balancer in. To get the folder ID, use a [NetworkLoadBalancerService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as '' key:value '' pairs.|
|`--listener-specs`|<b>`shorthand/json`</b><br/>List of listeners and their specs for the network load balancer.<br/>Shorthand Syntax:<br/>[<br/>{<br/>address = external-address-spec={<br/>address = str,<br/>ip-version = IPV4\|IPV6<br/>} \| internal-address-spec={<br/>address = str,<br/>ip-version = IPV4\|IPV6,<br/>subnet-id = str<br/>},<br/>name = str,<br/>port = int,<br/>protocol = TCP\|UDP,<br/>target-port = int<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"address": {<br/>"external-address-spec": {<br/>"address": "str",<br/>"ip-version": "IPV4\|IPV6"<br/>},<br/>"internal-address-spec": {<br/>"address": "str",<br/>"ip-version": "IPV4\|IPV6",<br/>"subnet-id": "str"<br/>}<br/>},<br/>"name": "str",<br/>"port": "int",<br/>"protocol": "TCP\|UDP",<br/>"target-port": "int"<br/>}, ...<br/>]"<br/>Fields:<br/>name -> (string)<br/>Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.<br/>port -> (int)<br/>Port for incoming traffic.<br/>protocol -> (enum<TCP\|UDP>)<br/>Protocol for incoming traffic.<br/>target-port -> (int)<br/>Port of a target. Acceptable values are 1 to 65535, inclusive.<br/>address -> (oneof<external-address-spec\|internal-address-spec>)<br/>Oneof address field<br/>external-address-spec -> (struct)<br/>External IP address specification.<br/>address -> (string)<br/>Public IP address for a listener. If you provide a static public IP address for the [NetworkLoadBalancerService.Update] method, it will replace the existing listener address.<br/>ip-version -> (enum<IPV4\|IPV6>)<br/>IP version.<br/>internal-address-spec -> (struct)<br/>Internal IP address specification.<br/>address -> (string)<br/>Internal IP address for a listener.<br/>ip-version -> (enum<IPV4\|IPV6>)<br/>IP version.<br/>subnet-id -> (string)<br/>ID of the subnet.|
|`--name`|<b>`string`</b><br/>Name of the network load balancer. The name must be unique within the folder.|
|`--region-id`|<b>`string`</b><br/>ID of the region where the network load balancer resides.|
|`--type`|<b>`enum`</b><br/>Type of the network load balancer. Possible Values: 'external', 'internal'|
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
