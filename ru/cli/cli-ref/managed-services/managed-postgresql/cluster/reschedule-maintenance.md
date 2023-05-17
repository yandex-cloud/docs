---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-postgresql/cluster/reschedule-maintenance.md
---

# yc managed-postgresql cluster reschedule-maintenance

Reschedule currently planned maintenance operation.

#### Command Usage

Syntax: 

`yc managed-postgresql cluster reschedule-maintenance <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>PostgreSQL cluster id.|
|`--name`|<b>`string`</b><br/>PostgreSQL cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--reschedule-type`|<b>`string`</b><br/>Type of the reschedule of currently planned maintenance operation. Values: 'immediate', 'next-available-window', 'specific-time'|
|`--delayed-until`|<b>`timestamp`</b><br/>New timestamp of currently maintenance operation when selected SPECIFIC_TIME reschedule type. Format: RFC-3339, HH:MM:SS, or a moment of time relative to the current time.<br/>Examples: '2006-01-02T15:04:05Z', '15:04:05', '2h' or '3h30m ago'.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
