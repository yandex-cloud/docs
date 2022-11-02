---
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/snapshot-schedule/index.md
---
# yc compute snapshot-schedule

Manage snapshot schedules

#### Command Usage

Syntax: 

`yc compute snapshot-schedule <command>`

Aliases: 

- `snapshot-schedules`

#### Command Tree

- [yc compute snapshot-schedule get](get.md) — Show information about the specified snapshot schedule
- [yc compute snapshot-schedule list](list.md) — List snapshot schedules
- [yc compute snapshot-schedule create](create.md) — Create a snapshot schedule
- [yc compute snapshot-schedule disable](disable.md) — Disable the specified snapshot schedule
- [yc compute snapshot-schedule enable](enable.md) — Enable the specified snapshot schedule
- [yc compute snapshot-schedule update](update.md) — Update the specified snapshot schedule
- [yc compute snapshot-schedule add-disks](add-disks.md) — Add disks to the specified snapshot schedule
- [yc compute snapshot-schedule remove-disks](remove-disks.md) — Remove disks from the specified snapshot schedule
- [yc compute snapshot-schedule add-labels](add-labels.md) — Add labels to specified snapshot schedule
- [yc compute snapshot-schedule remove-labels](remove-labels.md) — Remove labels from specified snapshot schedule
- [yc compute snapshot-schedule delete](delete.md) — Delete the specified snapshot schedule
- [yc compute snapshot-schedule list-operations](list-operations.md) — List operations for the specified snapshot schedule
- [yc compute snapshot-schedule list-disks](list-disks.md) — List disks attached to the specified snapshot schedule
- [yc compute snapshot-schedule list-snapshots](list-snapshots.md) — List snapshots created by specified snapshot schedule

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
