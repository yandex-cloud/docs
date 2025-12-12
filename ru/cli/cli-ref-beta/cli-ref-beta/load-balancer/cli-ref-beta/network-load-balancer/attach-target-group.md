---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/load-balancer/cli-ref-beta/network-load-balancer/attach-target-group.md
---

# yc beta load-balancer network-load-balancer attach-target-group

Attaches a target group to the specified network load balancer.

#### Command Usage

Syntax: 

`yc beta load-balancer network-load-balancer attach-target-group <NETWORK-LOAD-BALANCER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--attached-target-group`|<b>`shorthand/json`</b><br/>ID of the attached target group to attach to the network load balancer. To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request.<br/>Shorthand Syntax:<br/>{<br/>health-checks = [<br/>{<br/>healthy-threshold = int,<br/>interval = duration,<br/>name = str,<br/>options = http-options={<br/>path = str,<br/>port = int<br/>} \| tcp-options={<br/>port = int<br/>},<br/>timeout = duration,<br/>unhealthy-threshold = int<br/>}, ...<br/>],<br/>target-group-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"health-checks": [<br/>{<br/>"healthy-threshold": "int",<br/>"interval": "duration",<br/>"name": "str",<br/>"options": {<br/>"http-options": {<br/>"path": "str",<br/>"port": "int"<br/>},<br/>"tcp-options": {<br/>"port": "int"<br/>}<br/>},<br/>"timeout": "duration",<br/>"unhealthy-threshold": "int"<br/>}, ...<br/>],<br/>"target-group-id": "str"<br/>}"<br/>Fields:<br/>health-checks -> ([]struct)<br/>A health check to perform on the target group. For now we accept only one health check per AttachedTargetGroup.<br/>healthy-threshold -> (int)<br/>Number of successful health checks required in order to set the '' HEALTHY '' status for the target. The default is 2.<br/>interval -> (duration)<br/>The interval between health checks. The default is 2 seconds.<br/>name -> (string)<br/>Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.<br/>timeout -> (duration)<br/>Timeout for a target to return a response for the health check. The default is 1 second.<br/>unhealthy-threshold -> (int)<br/>Number of failed health checks before changing the status to '' UNHEALTHY ''. The default is 2.<br/>options -> (oneof<http-options\|tcp-options>)<br/>Oneof options field<br/>tcp-options -> (struct)<br/>Options for TCP health check.<br/>port -> (int)<br/>Port to use for TCP health checks.<br/>http-options -> (struct)<br/>Options for HTTP health check.<br/>path -> (string)<br/>URL path to set for health checking requests for every target in the target group. For example '' /ping ''. The default path is '' / ''.<br/>port -> (int)<br/>Port to use for HTTP health checks.<br/>target-group-id -> (string)<br/>ID of the target group.|
|`--network-load-balancer-id`|<b>`string`</b><br/>ID of the network load balancer to attach the target group to. To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request.|
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
