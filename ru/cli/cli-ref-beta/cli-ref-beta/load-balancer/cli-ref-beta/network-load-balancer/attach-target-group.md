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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--attached-target-group`|<b>`shorthand/json`</b><br/>ID of the attached target group to attach to the network load balancer.<br/>To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request.<br/><br/>Example:|
|`--attached-target-group`|<b>`health-checks=[{healthy-threshold=1,`</b><br/>interval=1h30m, name=value, options={http-options={path=value, port=1}}, timeout=1h30m, unhealthy-threshold=1}], target-group-id=value<br/><br/>Shorthand Syntax:<br/>{health-checks=[{healthy-threshold=int, interval=duration, name=str, options={http-options={path=str, port=int} \| tcp-options={port=int}}, timeout=duration, unhealthy-threshold=int},...], target-group-id=str}<br/>Fields:<br/>health-checks    []struct            — A health check to perform on the target group.<br/>For now we accept only one health check per AttachedTargetGroup.<br/>healthy-threshold    int                                        — Number of successful health checks required in order to set the '' HEALTHY '' status for the target. The default is 2.<br/>interval             duration                                   — The interval between health checks. The default is 2 seconds.<br/>name                 string                           required  — Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.<br/>timeout              duration                                   — Timeout for a target to return a response for the health check. The default is 1 second.<br/>unhealthy-threshold  int                                        — Number of failed health checks before changing the status to '' UNHEALTHY ''. The default is 2.<br/>options              oneof<http-options\|tcp-options>            — Oneof options field<br/>tcp-options   struct  — Options for TCP health check.<br/>port  int  — Port to use for TCP health checks.<br/>http-options  struct  — Options for HTTP health check.<br/>path  string  — URL path to set for health checking requests for every target in the target group.<br/>For example '' /ping ''. The default path is '' / ''.<br/>port  int     — Port to use for HTTP health checks.<br/>target-group-id  string    required  — ID of the target group.<br/>|
|`--network-load-balancer-id`|<b>`string`</b><br/>ID of the network load balancer to attach the target group to.<br/>To get the network load balancer ID, use a [NetworkLoadBalancerService.List] request.|
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
