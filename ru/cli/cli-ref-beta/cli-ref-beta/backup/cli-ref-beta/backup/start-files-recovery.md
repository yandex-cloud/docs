---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/backup/cli-ref-beta/backup/start-files-recovery.md
---

# yc beta backup backup start-files-recovery

StartFilesRecovery runs recovery process of selected files to specific Compute Cloud instance.

#### Command Usage

Syntax: 

`yc beta backup backup start-files-recovery <BACKUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--backup-id`|<b>`string`</b><br/>Backup ID.|
|`--compute-instance-id`|<b>`string`</b><br/>Destination instance ID.|
|`--opts`|<b>`shorthand/json`</b><br/><br/>Example:|
|`--opts`|<b>`overwrite=OVERWRITE_ALL,`</b><br/>reboot-if-needed=true, type={custom={path=value}}<br/><br/>Shorthand Syntax:<br/>{overwrite=OVERWRITE_ALL\|OVERWRITE_OLDER\|OVERWRITE_NONE, reboot-if-needed=bool, type={custom={path=str} \| original={}}}<br/>Fields:<br/>overwrite         enum<OVERWRITE_ALL\|OVERWRITE_NONE\|OVERWRITE_OLDER>  — Overwrite options declares the behavior for files that already exists on the file system.<br/>reboot-if-needed  bool                                                — specifies whether the recovery plan is able to reboot host if needed.<br/>type              oneof<custom\|original>                              — Oneof type field<br/>original  struct  — Keep original paths of files.<br/>custom    struct  — Set custom folder for file recovery.<br/>path  string  — Custom folder for file recovery.<br/>|
|`--source-ids`|<b>`strings`</b><br/>|
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
