---
editable: false
---

# yc backup policy update

Update the policy

#### Command Usage

Syntax: 

`yc backup policy update <POLICY-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Specifies policy id|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--generate-settings-skeleton`||
|`--settings-from-file`|<b>`string`</b><br/>Loads settings from file|
|`--set-retention-max-count`|<b>`int`</b><br/>Updates maximum number of backups to store|
|`--set-retention-max-hours`|<b>`int`</b><br/>Updates maximum lifetime of backup in hours|
|`--set-retention-max-days`|<b>`int`</b><br/>Updates maximum lifetime of backup in days|
|`--set-period`|<b>`string`</b><br/>Sets backup period Values: 'hourly', 'daily', 'weekly', 'monthly'|
|`--set-backup-type`|<b>`string`</b><br/>Sets backup type Values: 'simple', 'always-full', 'always-incremental', 'weekly-incremental', 'weekly-full-daily-incremental', 'custom', 'cdp'|
|`--set-compression`|<b>`string`</b><br/>Sets compression rate Values: 'normal', 'high', 'max', 'off'|

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
