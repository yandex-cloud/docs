---
editable: false
---

# yc load-balancer target-group update

Update the specified target group

#### Command Usage

Syntax:

`yc load-balancer target-group update <TARGET-GROUP-NAME>|<TARGET-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Target group id. ||
|| `--name` | `string`

Target group name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--target` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Adds a target to the target group.

Possible property names:

- `subnet-name`: Specifies the subnet that the target will connect to.

- `subnet-id`: Specifies the ID of the subnet that the target will connect to.

- `address`: Specifies the IP address that the target will connect to ||
|| `--new-name` | `string`

A new name of the target group. ||
|| `--description` | `string`

Specifies a textual description of the target group. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
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