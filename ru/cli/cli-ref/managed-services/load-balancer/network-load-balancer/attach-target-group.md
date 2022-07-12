---
sourcePath: en/_cli-ref/cli-ref/managed-services/load-balancer/network-load-balancer/attach-target-group.md
---
# yc load-balancer network-load-balancer attach-target-group

Attaches a target group to the specified network load balancer.

#### Command Usage

Syntax: 

`yc load-balancer network-load-balancer attach-target-group <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

Aliases: 

- `attach`

#### Flags

| Flag | Description |
|----|----|
|`--target-group`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Target group specification.  Possible property names:  target-group-id Specifies the target group id.  healthcheck-name Specifies the name of the health check to perform on the target group  healthcheck-interval Specifies the interval between health checks. The default is 2 seconds.  healthcheck-timeout Specifies timeout for a target to return a response for the health check. The default is 1 second.  healthcheck-unhealthythreshold Specifies the number of failed health checks before changing the status to 'UNHEALTHY'. The default is 2.  healthcheck-healthythreshold Specifies the number of successful health checks required in order to set the 'HEALTHY' status for the target. The default is 2.  healthcheck-tcp-port Specifies the port to use for TCP health checks.  healthcheck-http-port Specifies the port to use for HTTP health checks.  healthcheck-http-path Specifies URL path to set for health checking requests for every target in the target group.  |
|`--id`|<b>`string`</b><br/> Network load balancer id.|
|`--name`|<b>`string`</b><br/> Network load balancer name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
