---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/backend-group/update.md
---

# yc application-load-balancer backend-group update

Update the specified backend group

#### Command Usage

Syntax:

`yc application-load-balancer backend-group update <BACKEND_GROUP-NAME>|<BACKEND_GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Backend group id. ||
|| `--name` | `string`

Backend group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the backend group. ||
|| `--description` | `string`

A description of the backend group. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--connection-affinity` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Connection affinity type for backend-group.

Possible property names:

- `source-ip`: Use IP address to define a connection for session affinity. ||
|| `--cookie-affinity` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Cookie affinity type for backend-group.

Possible property names:

- `name`: Name of the cookie.

- `ttl`: TTL of the cookie.

- `path`: Path of cookie. ||
|| `--header-affinity` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Header affinity type for backend-group.

Possible property names:

- `name`: Name of the header. ||
|| `--clean-session-affinity` | Clean session affinity value ||
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