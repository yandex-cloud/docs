---
editable: false
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
|`--target-group`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Target group specification.<br/><br/>Possible property names:<br/><ul> <li><code>target-group-id</code>:     Specifies the target group id.</li> <li><code>healthcheck-name</code>:     Specifies the name of the health check to perform on the target group</li> <li><code>healthcheck-interval</code>:     Specifies the interval between health checks. The default is 2 seconds.</li> <li><code>healthcheck-timeout</code>:     Specifies timeout for a target to return a response for the health check. The default is 1 second.</li> <li><code>healthcheck-unhealthythreshold</code>:     Specifies the number of failed health checks before changing the status to 'UNHEALTHY'. The default is 2.</li> <li><code>healthcheck-healthythreshold</code>:     Specifies the number of successful health checks required in order to set the 'HEALTHY' status for the target. The default is 2.</li> <li><code>healthcheck-tcp-port</code>:     Specifies the port to use for TCP health checks.</li> <li><code>healthcheck-http-port</code>:     Specifies the port to use for HTTP health checks.</li> <li><code>healthcheck-http-path</code>:     Specifies URL path to set for health checking requests for every target in the target group.</li> </ul>|
|`--id`|<b>`string`</b><br/>Network load balancer id.|
|`--name`|<b>`string`</b><br/>Network load balancer name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
