---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# yc application-load-balancer load-balancer update-listener

Updates listener in the specified application load balancer.

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer update-listener <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the Application load balancer.|
|`--name`|<b>`string`</b><br/> Name of the Application load balancer.|
|`--listener-name`|<b>`string`</b><br/> Name of listener to update in application load balancer.|
|`--enable-tls`| Enable TLS for specified listener.|
|`--disable-tls`| Disable TLS for specified listener.|
|`--redirect-to-https`| Redirect HTTP requests to HTTPS for specified listener. --certificate-id value[,value] Certificate ID for specified listener.|
|`--allow-http10`| Allow HTTP1.0 for specified listener. --http2-options PROPERTY=VALUE[,PROPERTY=VALUE...] HTTP2 options for specified listener.  Possible property names:  max-concurrent-streams Max concurrent streams for HTTP2 listener.   --external-ipv4-endpoint PROPERTY=VALUE[,PROPERTY=VALUE...] External IPv4 endpoint settings for specified listener.  Possible property names:  port Port for the new listener.  address Use allocated address for the new listener.  |
|`--disable-external-ipv4-endpoint`| Disable external ipv4 endpoint for specified listener. --internal-ipv4-endpoint PROPERTY=VALUE[,PROPERTY=VALUE...] Internal IPv4 endpoint settings for specified listener.  Possible property names:  port Port for the new listener.  subnet-id Subnet for internal endpoint.  |
|`--disable-internal-ipv4-endpoint`| Disable internal ipv4 endpoint for specified listener. --external-ipv6-endpoint PROPERTY=VALUE[,PROPERTY=VALUE...] External IPv6 endpoint settings for specified listener.  Possible property names:  port Port for the new listener.  address Use allocated address for the new listener.  |
|`--disable-external-ipv6-endpoint`| Disable external ipv6 endpoint for specified listener.|
|`--clear-sni-matches`| Disable TLS for specified listener.|
|`--http-router-id`|<b>`string`</b><br/> HTTP router id for specified listener.|
|`--http-router-name`|<b>`string`</b><br/> HTTP router name for specified listener.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Flags

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
