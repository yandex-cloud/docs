---
editable: false
---

# yc load-balancer network-load-balancer add-listener

Adds a listener to the specified network load balancer.

#### Command Usage

Syntax: 

`yc load-balancer network-load-balancer add-listener <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--listener`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Listener specification.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the name for listener.</li> <li><code>port</code>:     Specifies the port for incoming traffic.</li> <li><code>target-port</code>:     Specifies the port on which the targets receive traffic.</li> <li><code>protocol</code>:     Specifies the protocol for incoming traffic. Supported option is 'tcp' or 'udp'. If omitted, 'tcp' is used as a default.</li> <li><code>external-address</code>:     Specifies the External IP address for incoming traffic. Must be empty when creating a new network load balancer. Must be provided when updating an existing load balancer.</li> <li><code>external-ip-version</code>:     Specifies the IP version for external address for incoming traffic. Supported option is 'ipv4' and 'ipv6'. If omitted, 'ipv4' is used as a default.</li> <li><code>internal-address</code>:     Specifies the Internal IP address for incoming traffic. Must be empty when creating a new network load balancer. Must be provided when updating an existing load balancer.</li> <li><code>internal-subnet-id</code>:     Specifies the Subnet ID of internal IP address for incoming traffic.</li> <li><code>internal-ip-version</code>:     Specifies the IP version for internal address for incoming traffic. Supported option is 'ipv4' and 'ipv6'. If omitted, 'ipv4' is used as a default.</li> </ul>|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
