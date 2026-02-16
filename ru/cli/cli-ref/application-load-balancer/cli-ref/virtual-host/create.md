---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md
---

# yc application-load-balancer virtual-host create

Create an virtual host for the http router

#### Command Usage

Syntax:

`yc application-load-balancer virtual-host create <VIRTUAL-HOST-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--http-router-id` | `string`

ID of the Http router. ||
|| `--http-router-name` | `string`

Name of the Http router. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--authority` | `value[,value]`

Specifies domains (:authority/Host header values) that will be matched to this virtual host. Wildcard hosts are supported in the form of '*.foo.com' or '*-bar.foo.com' ||
|| `--modify-request-header` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies modifications to be applied to the request headers.

Possible property names:

- `name`: Specifies the name of the header to modify.

- `append`: Specifies the value to be appended to the header.

- `replace`: Specifies the new value for the header.

- `rename`: Specifies the new name fot the header.

- `remove`: Remove the specified header ||
|| `--modify-response-header` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies modifications to be applied to the response headers.

Possible property names:

- `name`: Specifies the name of the header to modify.

- `append`: Specifies the value to be appended to the header.

- `replace`: Specifies the new value for the header.

- `rename`: Specifies the new name fot the header.

- `remove`: Remove the specified header ||
|| `--rate-limit` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies rate limit configuration to be applied to virtual host.

Possible property names:

- `rps`: Rate per second value.

- `rpm`: Rate per minute value.

- `all-requests`: Use rate limit for all incoming requests.

- `requests-per-ip`: Use rate limit for requests groupped by client ip address. ||
|| `--security-profile-id` | `string`

Specifies security profile ID for the virtual host. ||
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