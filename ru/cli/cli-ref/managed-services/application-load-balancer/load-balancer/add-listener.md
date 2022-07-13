---
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md
---
# yc application-load-balancer load-balancer add-listener

Adds a listener to the specified application load balancer.

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer add-listener <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

Aliases: 

- `add-http-listener`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the Application load balancer.|
|`--name`|<b>`string`</b><br/> Name of the Application load balancer.|
|`--listener-name`|<b>`string`</b><br/> Name of listener to add/update in application load balancer.|
|`--enable-tls`| Enable TLS for specified listener.|
|`--certificate-id`|<b>`value[,value]`</b><br/> Certificate ID for specified listener.|
|`--external-ipv4-endpoint`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> External IPv4 endpoint settings for specified listener.  Possible property names:  port Port for the listener.  address Use allocated address for the listener.  |
|`--internal-ipv4-endpoint`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Internal IPv4 endpoint settings for specified listener.  Possible property names:  port Port for the new listener.  subnet-id Subnet for internal endpoint.  |
|`--external-ipv6-endpoint`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> External IPv6 endpoint settings for specified listener.  Possible property names:  port Port for the listener.  address Use allocated address for the listener.  |
|`--redirect-to-https`| Redirect HTTP requests to HTTPS for new listener.|
|`--allow-http10`| Allow HTTP1.0 for new listener.|
|`--http2-options`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> HTTP2 options for new listener.  Possible property names:  max-concurrent-streams Max concurrent streams for HTTP2 listener.  |
|`--http-router-id`|<b>`string`</b><br/> HTTP router id for new listener.|
|`--http-router-name`|<b>`string`</b><br/> HTTP router name for new listener.|
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
