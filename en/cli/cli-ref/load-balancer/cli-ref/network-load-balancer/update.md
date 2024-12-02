---
editable: false
sourcePath: en/_cli-ref/cli-ref/load-balancer/cli-ref/network-load-balancer/update.md
---

# yc load-balancer network-load-balancer update

Update the specified load balancer

#### Command Usage

Syntax: 

`yc load-balancer network-load-balancer update <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Network load balancer id.|
|`--name`|<b>`string`</b><br/>Network load balancer name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--target-group`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Target group specification.<br/><br/>Possible property names:<br/><ul> <li><code>target-group-id</code>:     Specifies the target group id.</li> <li><code>healthcheck-name</code>:     Specifies the name of the health check to perform on the target group</li> <li><code>healthcheck-interval</code>:     Specifies the interval between health checks. The default is 2 seconds.</li> <li><code>healthcheck-timeout</code>:     Specifies timeout for a target to return a response for the health check. The default is 1 second.</li> <li><code>healthcheck-unhealthythreshold</code>:     Specifies the number of failed health checks before changing the status to 'UNHEALTHY'. The default is 2.</li> <li><code>healthcheck-healthythreshold</code>:     Specifies the number of successful health checks required in order to set the 'HEALTHY' status for the target. The default is 2.</li> <li><code>healthcheck-tcp-port</code>:     Specifies the port to use for TCP health checks.</li> <li><code>healthcheck-http-port</code>:     Specifies the port to use for HTTP health checks.</li> <li><code>healthcheck-http-path</code>:     Specifies URL path to set for health checking requests for every target in the target group.</li> </ul>|
|`--listener`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Listener specification.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name for listener.</li> <li><code>port</code>:     Specifies the port for incoming traffic.</li> <li><code>target-port</code>:     Specifies the port on which the targets receive traffic.</li> <li><code>protocol</code>:     Specifies the protocol for incoming traffic. Supported option is 'tcp' or 'udp'. If omitted, 'tcp' is used as a default.</li> <li><code>external-address</code>:     Specifies the External IP address for incoming traffic. Must be empty when creating a new network load balancer. Must be provided when updating an existing load balancer.</li> <li><code>external-ip-version</code>:     Specifies the IP version for external address for incoming traffic. Supported option is 'ipv4' and 'ipv6'. If omitted, 'ipv4' is used as a default.</li> <li><code>internal-address</code>:     Specifies the Internal IP address for incoming traffic. Must be empty when creating a new network load balancer. Must be provided when updating an existing load balancer.</li> <li><code>internal-subnet-id</code>:     Specifies the Subnet ID of internal IP address for incoming traffic.</li> <li><code>internal-ip-version</code>:     Specifies the IP version for internal address for incoming traffic. Supported option is 'ipv4' and 'ipv6'. If omitted, 'ipv4' is used as a default.</li> </ul>|
|`--new-name`|<b>`string`</b><br/>A new name of the network load balancer.|
|`--description`|<b>`string`</b><br/>A description of the network load balancer.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--deletion-protection`|Specifies if network load balancer protected from deletion.|

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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
