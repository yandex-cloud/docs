---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/snapshot-schedule/update.md
---

# yc beta compute snapshot-schedule update

Updates the specified snapshot schedule.

#### Command Usage

Syntax: 

`yc beta compute snapshot-schedule update <SNAPSHOT-SCHEDULE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New description of the snapshot schedule.|
|`--labels`|<b>`stringToString`</b><br/>Snapshot schedule labels as 'key:value' pairs.<br/><br/>Existing set of labels is completely replaced by the provided set, so if you just want<br/>to add or remove a label:<br/>1. Get the current set of labels with a [SnapshotScheduleService.Get] request.<br/>2. Add or remove a label in this set.<br/>3. Send the new set in this field.|
|`--name`|<b>`string`</b><br/>New name for the snapshot schedule.<br/><br/>The name must be unique within the folder.|
|`--schedule-policy`|<b>`shorthand/json`</b><br/>New frequency settings of the snapshot schedule.<br/><br/>Example:|
|`--schedule-policy`|<b>`expression=value,`</b><br/>start-at=1996-10-16T00:30:00Z<br/><br/>Shorthand Syntax:<br/>{expression=str, start-at=timestamp}<br/>Fields:<br/>expression  string     — Cron expression for the snapshot schedule (UTC+0).<br/><br/>The expression must consist of five fields ('Minutes Hours Day-of-month Month Day-of-week') or be one of<br/>nonstandard predefined expressions (e.g. '@hourly'). For details about the format,<br/>see [documentation](https://yandex.cloud/ru/docs/compute/concepts/snapshot-schedule#cron)<br/>start-at    timestamp  — Timestamp for creating the first snapshot.<br/>|
|`--snapshot-schedule-id`|<b>`string`</b><br/>ID of the snapshot schedule to update.<br/><br/>To get the snapshot schedule ID, make a [SnapshotScheduleService.List] request.|
|`--snapshot-spec`|<b>`shorthand/json`</b><br/>New attributes of snapshots created by the snapshot schedule.<br/><br/>Example:|
|`--snapshot-spec`|<b>`description=value,`</b><br/>labels={key=value}<br/><br/>Shorthand Syntax:<br/>{description=str, labels={key=str, key=...}}<br/>Fields:<br/>description  string              — Description of the created snapshot.<br/>labels       map[string,string]  — Snapshot labels as 'key:value' pairs.<br/>|
|`--retention-period`|<b>`duration`</b><br/>Retention period of the snapshot schedule. Once a snapshot created by the schedule reaches this age, it is<br/>automatically deleted. (duration, e.g. 30s, 5m10s)|
|`--snapshot-count`|<b>`int`</b><br/>Retention count of the snapshot schedule. Once the number of snapshots created by the schedule exceeds this<br/>number, the oldest ones are automatically deleted. E.g. if the number is 5, the first snapshot is deleted<br/>after the sixth one is created, the second is deleted after the seventh one is created, and so on.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
