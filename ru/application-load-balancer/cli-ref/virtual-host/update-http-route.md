---
editable: false
---

# yc application-load-balancer virtual-host update-http-route

Updates http route in the specified virtual host of the http router

#### Command Usage

Syntax:

`yc application-load-balancer virtual-host update-http-route <ROUTE-NAME> [Flags...] [Global Flags...]`

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
|| `--match-http-method` | `value[,value]`

Specifies HTTP method matcher for the route. ||
|| `--exact-path-match` | `string`

Specifies exact path matcher for the route. ||
|| `--prefix-path-match` | `string`

Specifies prefix path matcher for the route. ||
|| `--regex-path-match` | `string`

Specifies regex path matcher for the route. ||
|| `--backend-group-id` | `string`

Specifies target backend group id for the route. ||
|| `--backend-group-name` | `string`

Specifies target backend group name for the route. ||
|| `--request-timeout` | `duration`

Specifies request timeout for the route. ||
|| `--request-idle-timeout` | `duration`

Specifies request idle timeout for the route. ||
|| `--upgrade-types` | `value[,value]`

Specifies allowed HTTP upgrade types for the route (e.g. websocket). ||
|| `--host-rewrite` | `string`

Specifies host rewrite for the route. Authority/host header sent to the backend will be replace with this value ||
|| `--path-prefix-rewrite` | `string`

Specifies path prefix rewrite for the route. Its value will be prepended to the request path. ||
|| `--direct-response-code` | `int`

Specifies direct response http status code for the route. ||
|| `--direct-response-body` | `string`

Specifies direct response body for the route. ||
|| `--direct-response-body-file` | `string`

Specifies path to a file containing direct response body. ||
|| `--redirect-code` | `string`

Specifies redirect response http status code for the route, either http code (302, 303) or textual representation (FOUND, SEE_OTHER). Default: 301 (MOVED_PERMANENTLY) ||
|| `--redirect-scheme` | `string`

Specifies redirect scheme rewrite for the route. If not specified, http scheme remains unchanged ||
|| `--redirect-host` | `string`

Specifies redirect authority/host rewrite for the route. If not specified, header remains unchanged ||
|| `--redirect-port` | `int`

Specifies redirect port rewrite for the route. If not specified, port either is rewritten according to well-known rules (80 -> 443 for http -> https redirect) or remains unchanged. ||
|| `--redirect-path` | `string`

Specifies redirect path rewrite for the route. ||
|| `--redirect-prefix` | `string`

Specifies path prefix to be appended to the request uri for the redirect. ||
|| `--redirect-strip-query` | If specified, original request query will be stripped from redirect location for the route. ||
|| `--rate-limit` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies rate limit configuration to be applied to http route.

Possible property names:

- `rps`: Rate per second value.

- `rpm`: Rate per minute value.

- `all-requests`: Use rate limit for all incoming requests.

- `requests-per-ip`: Use rate limit for requests groupped by client ip address. ||
|| `--path-regex-rewrite` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies regex rewrite configuration to be applied to http route.

Possible property names:

- `regex`: Regular expression string used to find substrings that should be replaced.

- `substitute`: String that should be substituted into matching substrings. ||
|| `--disable-security-profile` | Disables security profile for the route. ||
|| `--clear-method-match` | Clears route method match. ||
|| `--clear-path-match` | Clears route path match. ||
|| `--clear-request-timeout` | Clears route request timeout. ||
|| `--clear-idle-timeout` | Clears route request idle timeout. ||
|| `--clear-host-rewrite` | Clears route host rewrite. ||
|| `--clear-upgrade-types` | Clears route allowed upgrade types. ||
|| `--clear-path-rewrite` | Clears route path rewrite. ||
|| `--clear-redirect-scheme` | Clears route redirect scheme rewrite. ||
|| `--clear-redirect-host` | Clears route redirect host rewrite. ||
|| `--clear-redirect-port` | Clears route redirect port rewrite. ||
|| `--clear-redirect-path` | Clears route redirect path rewrite. ||
|| `--clear-rate-limit` | Clears rate limiter configuration. ||
|| `--clear-path-regex-rewrite` | Clears regex rewrite configuration. ||
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