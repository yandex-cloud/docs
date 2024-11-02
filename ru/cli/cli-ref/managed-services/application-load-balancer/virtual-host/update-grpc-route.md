---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/virtual-host/update-grpc-route.md
---

# yc application-load-balancer virtual-host update-grpc-route

Updates grpc route in the specified virtual host of the http router

#### Command Usage

Syntax: 

`yc application-load-balancer virtual-host update-grpc-route <ROUTE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--http-router-id`|<b>`string`</b><br/>ID of the Http router.|
|`--http-router-name`|<b>`string`</b><br/>Name of the Http router.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--virtual-host-name`|<b>`string`</b><br/>Specifies the name of the virtual host for the route.|
|`--exact-fqmn-match`|<b>`string`</b><br/>Specifies exact FQMN matcher for the route.|
|`--prefix-fqmn-match`|<b>`string`</b><br/>Specifies prefix FQMN matcher for the route.|
|`--regex-fqmn-match`|<b>`string`</b><br/>Specifies regex FQMN matcher for the route.|
|`--backend-group-id`|<b>`string`</b><br/>Specifies target backend group id for the route.|
|`--backend-group-name`|<b>`string`</b><br/>Specifies target backend group name for the route.|
|`--request-max-timeout`|<b>`duration`</b><br/>Specifies maximun request timeout for the route. The client may set lower timeout via grpc-timeout header.|
|`--request-idle-timeout`|<b>`duration`</b><br/>Specifies request idle timeout for the route.|
|`--host-rewrite`|<b>`string`</b><br/>Specifies host rewrite for the route. Authority/host header sent to the backend will be replace with this value|
|`--grpc-status-response-code`|<b>`string`</b><br/>Specifies direct response with configured gRPC status code for the route.|
|`--rate-limit`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies rate limit configuration to be applied to grpc route.<br/><br/>Possible property names:<br/><ul> <li><code>rps</code>:     Rate per second value.</li> <li><code>rpm</code>:     Rate per minute value.</li> <li><code>all-requests</code>:     Use rate limit for all incoming requests.</li> <li><code>requests-per-ip</code>:     Use rate limit for requests groupped by client ip address.</li> </ul>|
|`--clear-fqmn-match`|Clears route FQMN match.|
|`--clear-max-timeout`|Clears route request max timeout.|
|`--clear-idle-timeout`|Clears route request idle timeout.|
|`--clear-host-rewrite`|Clears route host rewrite.|
|`--clear-rate-limit`|Clears rate limiter configuration.|

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
