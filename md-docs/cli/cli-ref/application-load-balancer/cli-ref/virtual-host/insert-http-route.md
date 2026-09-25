[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [application-load-balancer](../index.md) > [virtual-host](index.md) > insert-http-route

# yc application-load-balancer virtual-host insert-http-route

Inserts HTTP route into the specified virtual host of the HTTP router

#### Command Usage

Syntax:

`yc application-load-balancer virtual-host insert-http-route <ROUTE-NAME> [Flags...] [Global Flags...]`

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
|| `--match-http-method` | `[]string`

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
|| `--upgrade-types` | `[]string`

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
|| `--ccf-header` | `string`

Specifies header with the provided client certificate's (if it is validated by the configured trusted CA). ||
|| `--ccf-issuer` | `string`

Specifies header with the provided client certificate's issuer (if it is validated by the configured trusted CA). ||
|| `--ccf-subject` | `string`

Specifies header with the provided client certificate's subject (if it is validated by the configured trusted CA). ||
|| `--before` | `string`

Specifies the name of the route to append the new route before. ||
|| `--after` | `string`

Specifies the name of the route to append the new route after. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#