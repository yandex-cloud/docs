---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/application-load-balancer/cli-ref-beta/load-balancer/add-sni-match.md
---

# yc beta application-load-balancer load-balancer add-sni-match

Adds a SNI handler to the specified listener.

#### Command Usage

Syntax: 

`yc beta application-load-balancer load-balancer add-sni-match <LOAD-BALANCER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--handler`|<b>`shorthand/json`</b><br/>Settings for handling requests with Server Name Indication (SNI) matching one of [server_names] values.<br/>Shorthand Syntax:<br/>{<br/>certificate-ids = str,...,<br/>handler = http-handler={<br/>http-router-id = str,<br/>protocol-settings = allow-http10=bool \| http2-options={<br/>max-concurrent-streams = int<br/>},<br/>rewrite-request-id = bool<br/>} \| stream-handler={<br/>backend-group-id = str,<br/>idle-timeout = duration<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"certificate-ids": [<br/>"str", ...<br/>],<br/>"handler": {<br/>"http-handler": {<br/>"http-router-id": "str",<br/>"protocol-settings": {<br/>"allow-http10": "bool",<br/>"http2-options": {<br/>"max-concurrent-streams": "int"<br/>}<br/>},<br/>"rewrite-request-id": "bool"<br/>},<br/>"stream-handler": {<br/>"backend-group-id": "str",<br/>"idle-timeout": "duration"<br/>}<br/>}<br/>}"<br/>Fields:<br/>certificate-ids -> ([]string)<br/>ID's of the TLS server certificates from documentation. RSA and ECDSA certificates are supported, and only the first certificate of each type is used.<br/>handler -> (oneof<http-handler\|stream-handler>)<br/>Oneof handler field<br/>http-handler -> (struct)<br/>HTTP handler.<br/>http-router-id -> (string)<br/>ID of the HTTP router processing requests. For details about the concept, see documentation. To get the list of all available HTTP routers, make a [HttpRouterService.List] request.<br/>rewrite-request-id -> (bool)<br/>When unset, will preserve the incoming x-request-id header, otherwise would rewrite it with a new value.<br/>protocol-settings -> (oneof<allow-http10\|http2-options>)<br/>Oneof protocol-settings field<br/>http2-options -> (struct)<br/>HTTP/2 settings. If specified, incoming HTTP/2 requests are supported by the listener.<br/>max-concurrent-streams -> (int)<br/>Maximum number of concurrent HTTP/2 streams in a connection.<br/>allow-http10 -> (bool)<br/>Enables support for incoming HTTP/1.0 and HTTP/1.1 requests and disables it for HTTP/2 requests.<br/>stream-handler -> (struct)<br/>Stream (TCP) handler.<br/>backend-group-id -> (string)<br/>ID of the backend group processing requests. For details about the concept, see documentation. The backend group type, specified via [BackendGroup.backend], must be 'stream'. To get the list of all available backend groups, make a [BackendGroupService.List] request.<br/>idle-timeout -> (duration)<br/>The idle timeout is duration during which no data is transmitted or received on either the upstream or downstream connection. If not configured, the default idle timeout is 1 hour. Setting it to 0 disables the timeout.|
|`--listener-name`|<b>`string`</b><br/>Name of the listener to add a SNI handler to.|
|`--load-balancer-id`|<b>`string`</b><br/>ID of the application load balancer to add a SNI handler to.|
|`--name`|<b>`string`</b><br/>Name of the SNI handler to add.|
|`--server-names`|<b>`strings`</b><br/>Server names that are matched by the SNI handler.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
