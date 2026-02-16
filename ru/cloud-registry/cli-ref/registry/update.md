---
editable: false
sourcePath: en/_cli-ref/cli-ref/cloud-registry/cli-ref/registry/update.md
---

# yc cloud-registry registry update

Updates the specified registry

#### Command Usage

Syntax:

`yc cloud-registry registry update <REGISTRY-NAME>|<REGISTRY-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Registry id. ||
|| `--name` | `string`

Registry name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name of the registry. ||
|| `--new-description` | `string`

New description of the registry. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the registry as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--properties` | `key=value[,key=value...]`

New set of properties for the registry as key-value pairs. Existing set of labels will be completely overwritten. ||
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