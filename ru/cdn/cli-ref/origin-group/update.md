---
editable: false
---

# yc cdn origin-group update

Update origin group

#### Command Usage

Syntax:

`yc cdn origin-group update [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `int`

Origin group id. ||
|| `--name` | `string`

New group name. ||
|| `--use-next` | Specifies if use the next origin from the list. ||
|| `--origin` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Origin specification.

Possible property names:

- `source`: Specifies the source of the origin.

- `enabled`: Specifies if origin is enabled.

- `backup`: Specifies if origin is backup one.

- `meta-bucket-name`: Specifies meta bucket name.

- `meta-website-name`: Specifies meta website name.

- `meta-balancer-id`: Specifies meta balancer id. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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