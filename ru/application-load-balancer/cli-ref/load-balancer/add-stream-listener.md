---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/load-balancer/add-stream-listener.md
---

# yc application-load-balancer load-balancer add-stream-listener

Adds a Stream listener to the specified application load balancer.

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer add-stream-listener <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the Application load balancer.|
|`--name`|<b>`string`</b><br/>Name of the Application load balancer.|
|`--listener-name`|<b>`string`</b><br/>Name of listener to add/update in application load balancer.|
|`--enable-tls`|Enable TLS for specified listener.|
|`--certificate-id`|<b>`value[,value]`</b><br/>Certificate ID for specified listener.|
|`--external-ipv4-endpoint`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>External IPv4 endpoint settings for specified listener.<br/><br/>Possible property names:<br/><ul> <li><code>port</code>:     Port for the listener.</li> <li><code>address</code>:     Use allocated address for the listener.</li> </ul>|
|`--internal-ipv4-endpoint`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Internal IPv4 endpoint settings for specified listener.<br/><br/>Possible property names:<br/><ul> <li><code>port</code>:     Port for the new listener.</li> <li><code>subnet-id</code>:     Subnet for internal endpoint.</li> </ul>|
|`--external-ipv6-endpoint`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>External IPv6 endpoint settings for specified listener.<br/><br/>Possible property names:<br/><ul> <li><code>port</code>:     Port for the listener.</li> <li><code>address</code>:     Use allocated address for the listener.</li> </ul>|
|`--backend-group-id`|<b>`string`</b><br/>Backend group id for new listener.|
|`--backend-group-name`|<b>`string`</b><br/>Backend group name for new listener.|
|`--idle-timeout`|<b>`duration`</b><br/>Idle timeout for the stream.|
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
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
