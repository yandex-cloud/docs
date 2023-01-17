---
editable: false
---

# yc compute snapshot-schedule create

Create a snapshot schedule

#### Command Usage

Syntax: 

`yc compute snapshot-schedule create <SNAPSHOT-SCHEDULE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the snapshot schedule.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the snapshot schedule.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--retention-period`|<b>`duration`</b><br/>Retention period.|
|`--snapshot-count`|<b>`uint`</b><br/>Snapshot count.|
|`--expression`|<b>`string`</b><br/>Cron expression for the snapshot schedule.|
|`--start-at`|<b>`timestamp`</b><br/>Start timestamp for the snapshot schedule. Format: RFC-3339, HH:MM:SS, or a moment  of time relative to the current time.<br/>Examples: '2006-01-02T15:04:05Z', '15:04:05', '2h' or '3h30m ago'.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
