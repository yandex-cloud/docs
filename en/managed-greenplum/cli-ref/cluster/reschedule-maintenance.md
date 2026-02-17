---
editable: false
---

# yc managed-greenplum cluster reschedule-maintenance

Reschedule maintenance for the specified Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum cluster reschedule-maintenance <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Greenplum cluster id. ||
|| `--name` | `string`

Greenplum cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--reschedule-type` | `string`

Type of the reschedule of currently planned maintenance operation. Values: 'immediate', 'next-available-window', 'specific-time' ||
|| `--delayed-until` | `timestamp`

New timestamp of currently maintenance operation when selected SPECIFIC_TIME reschedule type. Format: RFC-3339, HH:MM:SS, or a moment of time relative to the current time.
Examples: '2006-01-02T15:04:05Z', '15:04:05', '2h' or '3h30m ago'. ||
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