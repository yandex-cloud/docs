---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/load-balancer/logging.md
---

# yc application-load-balancer load-balancer logging

Manage cloud logging settings of the load balancer.

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer logging <LOAD-BALANCER-NAME>|<LOAD-BALANCER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the Application load balancer.|
|`--name`|<b>`string`</b><br/>Name of the Application load balancer.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--log-group-id`|<b>`string`</b><br/>ID of the log group to which the loadbalancer send logs.|
|`--log-group-name`|<b>`string`</b><br/>Name of the log group to which the loadbalancer send logs.|
|`--log-group-use-default`|Use default log group in the folder where load balancer resides.|
|`--disable`|Do not send access logs to Cloud Logging log group.|
|`--enable`|Send access logs to specified Cloud Logging log group.|
|`--discard`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Discard a percentage of logs for given codes. Multiple discard rules can be provided, order is preserved and the first matching rule is applied.<br/><br/>Provided set of rules replaces any previously defined rules.<br/><br/>Example (discard 90% of codes 200, 3XX, GRPC_OK and 15% of any other codes):<br/>|
|`--discard`|<b>`codes=[200,3XX,GRPC_OK],percent=90`</b><br/>--discard codes=ALL,percent=15<br/><br/>Possible property names:<br/><ul> <li><code>codes</code>:     codes to be discarded. value can be an http code (100..599), an interval (1XX..5XX or ALL) or a grpc-code marked by prefix (GRPC_OK..GRPC_UNAUTHENTICATED) (required)</li> <li><code>percent</code>:     percent of logs to be discarded if matched by codes (required)</li> </ul>|

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
