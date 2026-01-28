---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/placement-group/get.md
---

# yc compute placement-group get

Show information about the specified placement group

#### Command Usage

Syntax:

`yc compute placement-group get <PLACEMENT-GROUP-NAME>|<PLACEMENT-GROUP-ID> [<PLACEMENT-GROUP-NAME>|<PLACEMENT-GROUP-ID>...] [Global Flags...]`

Aliases:

- `describe`

- `show`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Placement group id. ||
|| `--name` | `string`

Placement group name. ||
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