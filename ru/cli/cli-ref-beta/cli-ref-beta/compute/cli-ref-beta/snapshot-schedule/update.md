---
editable: false
noIndex: true
---

# yc beta compute snapshot-schedule update

Updates the specified snapshot schedule.
The schedule is updated only after all snapshot creations and deletions triggered by the schedule are completed.

#### Command Usage

Syntax:

`yc beta compute snapshot-schedule update <SNAPSHOT-SCHEDULE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New description of the snapshot schedule. ||
|| `--labels` | `map<string><string>`

Snapshot schedule labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [SnapshotScheduleService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--name` | `string`

New name for the snapshot schedule. The name must be unique within the folder. ||
|| `--schedule-policy` | `shorthand/json`

New frequency settings of the snapshot schedule.

Shorthand Syntax:

```hcl
{
  expression = string,
  start-at = timestamp
}
```

JSON Syntax:

```json
{
  "expression": "string",
  "start-at": "timestamp"
}
```

Fields:

```
expression -> (string)
  Cron expression for the snapshot schedule (UTC+0). The expression must consist of five fields ('Minutes Hours Day-of-month Month Day-of-week') or be one of nonstandard predefined expressions (e.g. '@hourly'). For details about the format, see documentation
start-at -> (timestamp)
  Timestamp for creating the first snapshot.
``` ||
|| `--snapshot-schedule-id` | `string`

ID of the snapshot schedule to update. To get the snapshot schedule ID, make a [SnapshotScheduleService.List] request. ||
|| `--snapshot-spec` | `shorthand/json`

New attributes of snapshots created by the snapshot schedule.

Shorthand Syntax:

```hcl
{
  description = string,
  labels = {key=string, key=...}
}
```

JSON Syntax:

```json
{
  "description": "string",
  "labels": {
    "<key>": "string", ...
  }
}
```

Fields:

```
description -> (string)
  Description of the created snapshot.
labels -> (map[string,string])
  Snapshot labels as 'key:value' pairs.
``` ||
|| `--retention-period` | `duration`

Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is automatically deleted. (duration, e.g. 30s, 5m10s) ||
|| `--snapshot-count` | `int`

Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted after the sixth one is created, the second is deleted after the seventh one is created, and so on. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#