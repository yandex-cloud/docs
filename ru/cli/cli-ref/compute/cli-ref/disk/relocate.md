---
editable: false
---

# yc compute disk relocate

Relocate the specified disk to the zone

#### Command Usage

Syntax:

`yc compute disk relocate <DISK-NAME>|<DISK-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Disk id. ||
|| `--name` | `string`

Disk name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--destination-zone-id` | `string`

The zone to relocate to. ||
|| `--disk-placement-group-id` | `string`

Placement group to move the disk to. ||
|| `--disk-placement-group-name` | `string`

Placement group to move the disk to. ||
|| `--disk-placement-group-partition` | `int`

Placement group partition. Used when a placement group is created with the partition strategy. ||
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