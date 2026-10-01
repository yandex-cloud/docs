---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/application-load-balancer/cli-ref/virtual-host/update/
---

# yc application-load-balancer virtual-host update

Update the specified virtual host

#### Command Usage

Syntax:

`yc application-load-balancer virtual-host update <VIRTUAL-HOST-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--http-router-id` | `string`

ID of the Http router. ||
|| `--http-router-name` | `string`

Name of the Http router. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--authority` | `[]string`

Specifies domains (:authority/Host header values) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com' ||
|| `--clear-authorities` | Clears authority match specifications for the virtual host. Virtual host with no authority specified, matches all :authority/Host headers ||
|| `--modify-request-header` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies modifications to be applied to the request headers.

Possible property names:

- `name`: Specifies the name of the header to modify.

- `append`: Specifies the value to be appended to the header.

- `replace`: Specifies the new value for the header.

- `rename`: Specifies the new name fot the header.

- `remove`: Remove the specified header ||
|| `--clear-request-header-modifications` | Clears all request header modifications for the virtual host. ||
|| `--modify-response-header` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies modifications to be applied to the response headers.

Possible property names:

- `name`: Specifies the name of the header to modify.

- `append`: Specifies the value to be appended to the header.

- `replace`: Specifies the new value for the header.

- `rename`: Specifies the new name fot the header.

- `remove`: Remove the specified header ||
|| `--clear-response-header-modifications` | Clears all response header modifications for the virtual host. ||
|| `--rate-limit` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies rate limit configuration to be applied to virtual host.

Possible property names:

- `rps`: Rate per second value.

- `rpm`: Rate per minute value.

- `all-requests`: Use rate limit for all incoming requests.

- `requests-per-ip`: Use rate limit for requests groupped by client ip address. ||
|| `--clear-rate-limit` | Clears rate limiter configuration. ||
|| `--clear-routes` | Clears all routes for the virtual host. ||
|| `--security-profile-id` | `string`

Specifies security profile ID for the virtual host. ||
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