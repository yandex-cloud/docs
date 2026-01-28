---
editable: false
sourcePath: en/_cli-ref/cli-ref/backup/cli-ref/policy/update.md
---

# yc backup policy update

Update the policy

#### Command Usage

Syntax:

`yc backup policy update <POLICY-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Specifies policy id ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--generate-settings-skeleton` |  ||
|| `--settings-from-file` | `string`

Loads settings from file ||
|| `--set-retention-max-count` | `int`

Updates maximum number of backups to store ||
|| `--set-retention-max-hours` | `int`

Updates maximum lifetime of backup in hours ||
|| `--set-retention-max-days` | `int`

Updates maximum lifetime of backup in days ||
|| `--set-period` | `string`

Sets backup period Values: 'hourly', 'daily', 'weekly', 'monthly' ||
|| `--set-backup-type` | `string`

Sets backup type Values: 'simple', 'always-full', 'always-incremental', 'weekly-incremental', 'weekly-full-daily-incremental', 'custom', 'cdp' ||
|| `--set-compression` | `string`

Sets compression rate Values: 'normal', 'high', 'max', 'off' ||
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