---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/backend-group/update-http-backend.md
---

# yc application-load-balancer backend-group update-http-backend

Update HTTP backend to the backend group

#### Command Usage

Syntax: 

`yc application-load-balancer backend-group update-http-backend <BACKEND_GROUP-NAME>|<BACKEND_GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--backend-group-id`|<b>`string`</b><br/>Backend group id.|
|`--backend-group-name`|<b>`string`</b><br/>Backend group name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--name`|<b>`string`</b><br/>A name of the gRPC backend to update.|
|`--weight`|<b>`int`</b><br/>Weight of the gRPC backend.|
|`--port`|<b>`int`</b><br/>Port of the gRPC backend.|
|`--target-group-id`|<b>`value[,value]`</b><br/>Target groups for the backend, --target-group-id id1 --target-group-id=id2|
|`--target-group-name`|<b>`value[,value]`</b><br/>Target groups for the backend, --target-group-name name1 --target-group-name=name2|
|`--panic-threshold`|<b>`int`</b><br/>Panic threshold of the gRPC backend.|
|`--locality-aware-routing-percent`|<b>`int`</b><br/>Percent of requests to route to the same location for the gRPC backend.|
|`--strict-locality`|Enables strict locality routing for the gRPC backend.|
|`--enable-tls`|Enables TLS for the gRPC backend.|
|`--tls-sni`|<b>`string`</b><br/>SNI for the backend, --tls-sni=backend.local|
|`--tls-trusted-ca-from-file`|<b>`string`</b><br/>Path to file with trusted CA for the backend|
|`--http-healthcheck`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of HTTP health checks for backend.<br/><br/>Possible property names:<br/><ul> <li><code>port</code>:     Port of the health check.</li> <li><code>healthy-threshold</code>:     Healthy threshold of the health check.</li> <li><code>unhealthy-threshold</code>:     Unhealthy threshold of the health check.</li> <li><code>timeout</code>:     Timeout of the health check.</li> <li><code>interval</code>:     Interval of the health check.</li> <li><code>host</code>:     Host header to use for HTTP health check.</li> <li><code>path</code>:     Request path to use for HTTP health check.</li> <li><code>use-http2</code>:     Enables HTTP2 protocol for HTTP health check.</li> </ul>|
|`--grpc-healthcheck`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of gRPC health checks for backend.<br/><br/>Possible property names:<br/><ul> <li><code>port</code>:     Port of the health check.</li> <li><code>healthy-threshold</code>:     Healthy threshold of the health check.</li> <li><code>unhealthy-threshold</code>:     Unhealthy threshold of the health check.</li> <li><code>timeout</code>:     Timeout of the health check.</li> <li><code>interval</code>:     Interval of the health check.</li> <li><code>service-name</code>:     Service name of the gRPC health check.</li> </ul>|
|`--stream-healthcheck`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of stream (TCP) health checks for backend.<br/><br/>Possible property names:<br/><ul> <li><code>port</code>:     Port of the health check.</li> <li><code>healthy-threshold</code>:     Healthy threshold of the health check.</li> <li><code>unhealthy-threshold</code>:     Unhealthy threshold of the health check.</li> <li><code>timeout</code>:     Timeout of the health check.</li> <li><code>interval</code>:     Interval of the health check.</li> <li><code>send-text</code>:     Text to send for stream (TCP) health check.</li> <li><code>receive-text</code>:     Text to receive for stream (TCP) health check.</li> </ul>|
|`--use-http2`|Enables HTTP2 for the HTTP backend.|

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
