---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/virtual-host/update-grpc-route.md
---

# yc application-load-balancer virtual-host update-grpc-route

Updates grpc route in the specified virtual host of the http router

#### Command Usage

Syntax:

`yc application-load-balancer virtual-host update-grpc-route <ROUTE-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--http-router-id` | `string`

ID of the Http router. ||
|| `--http-router-name` | `string`

Name of the Http router. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--virtual-host-name` | `string`

Specifies the name of the virtual host for the route. ||
|| `--exact-fqmn-match` | `string`

Specifies exact FQMN matcher for the route. ||
|| `--prefix-fqmn-match` | `string`

Specifies prefix FQMN matcher for the route. ||
|| `--regex-fqmn-match` | `string`

Specifies regex FQMN matcher for the route. ||
|| `--backend-group-id` | `string`

Specifies target backend group id for the route. ||
|| `--backend-group-name` | `string`

Specifies target backend group name for the route. ||
|| `--request-max-timeout` | `duration`

Specifies maximun request timeout for the route. The client may set lower timeout via grpc-timeout header. ||
|| `--request-idle-timeout` | `duration`

Specifies request idle timeout for the route. ||
|| `--host-rewrite` | `string`

Specifies host rewrite for the route. Authority/host header sent to the backend will be replace with this value ||
|| `--grpc-status-response-code` | `string`

Specifies direct response with configured gRPC status code for the route. ||
|| `--rate-limit` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies rate limit configuration to be applied to grpc route.

Possible property names:

- `rps`: Rate per second value.

- `rpm`: Rate per minute value.

- `all-requests`: Use rate limit for all incoming requests.

- `requests-per-ip`: Use rate limit for requests groupped by client ip address. ||
|| `--disable-security-profile` | Disables security profile for the route. ||
|| `--clear-fqmn-match` | Clears route FQMN match. ||
|| `--clear-max-timeout` | Clears route request max timeout. ||
|| `--clear-idle-timeout` | Clears route request idle timeout. ||
|| `--clear-host-rewrite` | Clears route host rewrite. ||
|| `--clear-rate-limit` | Clears rate limiter configuration. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#