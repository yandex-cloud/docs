---
editable: false
---

# yc compute snapshot-schedule update

Update the specified snapshot schedule

#### Command Usage

Syntax:

`yc compute snapshot-schedule update <SNAPSHOT-SCHEDULE-NAME>|<SNAPSHOT-SCHEDULE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Snapshot schedule id. ||
|| `--name` | `string`

Snapshot schedule name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the snapshot schedule. ||
|| `--description` | `string`

Specifies a textual description of the snapshot schedule. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--snapshot-description` | `string`

Specifies a textual description of the created snapshot. ||
|| `--snapshot-labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--snapshot-labels foo=baz,bar=baz'. ||
|| `--retention-period` | `duration`

Retention period. ||
|| `--snapshot-count` | `uint`

Snapshot count. ||
|| `--expression` | `string`

Cron expression for the snapshot schedule. ||
|| `--start-at` | `timestamp`

Start timestamp for the snapshot schedule. Format: RFC-3339, HH:MM:SS, or a moment  of time relative to the current time.
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