---
editable: false
sourcePath: en/_cli-ref/cli-ref/organization-manager/cli-ref/federation/group-mapping/remove-mapping-items.md
---

# yc organization-manager federation group-mapping remove-mapping-items

Remove group mapping items from the specified federation

#### Command Usage

Syntax:

`yc organization-manager federation group-mapping remove-mapping-items <FEDERATION-NAME>|<FEDERATION-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

federation id. ||
|| `--name` | `string`

federation name. ||
|| `--organization-id` | `string`

Set the ID of the organization to use. ||
|| `--external-group-id` | `string`

ID of the external group id that is being added or removed from mapping items. ||
|| `--internal-group-id` | `string`

ID of the internal group id that is being added or removed from mapping items. ||
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