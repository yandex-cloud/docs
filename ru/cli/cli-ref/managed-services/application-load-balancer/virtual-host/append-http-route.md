---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md
---

# yc application-load-balancer virtual-host append-http-route

Appends http route to the specified virtual host of the http router

#### Command Usage

Syntax: 

`yc application-load-balancer virtual-host append-http-route <ROUTE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--http-router-id`|<b>`string`</b><br/>ID of the Http router.|
|`--http-router-name`|<b>`string`</b><br/>Name of the Http router.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--virtual-host-name`|<b>`string`</b><br/>Specifies the name of the virtual host for the route.|
|`--match-http-method`|<b>`value[,value]`</b><br/>Specifies HTTP method matcher for the route.|
|`--exact-path-match`|<b>`string`</b><br/>Specifies exact path matcher for the route.|
|`--prefix-path-match`|<b>`string`</b><br/>Specifies prefix path matcher for the route.|
|`--regex-path-match`|<b>`string`</b><br/>Specifies regex path matcher for the route.|
|`--backend-group-id`|<b>`string`</b><br/>Specifies target backend group id for the route.|
|`--backend-group-name`|<b>`string`</b><br/>Specifies target backend group name for the route.|
|`--request-timeout`|<b>`duration`</b><br/>Specifies request timeout for the route.|
|`--request-idle-timeout`|<b>`duration`</b><br/>Specifies request idle timeout for the route.|
|`--upgrade-types`|<b>`value[,value]`</b><br/>Specifies allowed HTTP upgrade types for the route (e.g. websocket).|
|`--host-rewrite`|<b>`string`</b><br/>Specifies host rewrite for the route. Authority/host header sent to the backend will be replace with this value|
|`--path-prefix-rewrite`|<b>`string`</b><br/>Specifies path prefix rewrite for the route. Its value will be prepended to the request path.|
|`--direct-response-code`|<b>`int`</b><br/>Specifies direct response http status code for the route.|
|`--direct-response-body`|<b>`string`</b><br/>Specifies direct response body for the route.|
|`--direct-response-body-file`|<b>`string`</b><br/>Specifies path to a file containing direct response body.|
|`--redirect-code`|<b>`string`</b><br/>Specifies redirect response http status code for the route, either http code (302, 303) or textual representation (FOUND, SEE_OTHER). Default: 301 (MOVED_PERMANENTLY)|
|`--redirect-scheme`|<b>`string`</b><br/>Specifies redirect scheme rewrite for the route. If not specified, http scheme remains unchanged|
|`--redirect-host`|<b>`string`</b><br/>Specifies redirect authority/host rewrite for the route. If not specified, header remains unchanged|
|`--redirect-port`|<b>`int`</b><br/>Specifies redirect port rewrite for the route. If not specified, port either is rewritten according to well-known rules (80 -> 443 for http -> https redirect) or remains unchanged.|
|`--redirect-path`|<b>`string`</b><br/>Specifies redirect path rewrite for the route.|
|`--redirect-prefix`|<b>`string`</b><br/>Specifies path prefix to be appended to the request uri for the redirect.|
|`--redirect-strip-query`|If specified, original request query will be stripped from redirect location for the route.|
|`--rate-limit`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies rate limit configuration to be applied to http route.<br/><br/>Possible property names:<br/><ul> <li><code>rps</code>:     Rate per second value.</li> <li><code>rpm</code>:     Rate per minute value.</li> <li><code>all-requests</code>:     Use rate limit for all incoming requests.</li> <li><code>requests-per-ip</code>:     Use rate limit for requests groupped by client ip address.</li> </ul>|

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
