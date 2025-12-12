---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/ydb/cli-ref-beta/database/backup.md
---

# yc beta ydb database backup



#### Command Usage

Syntax: 

`yc beta ydb database backup <DATABASE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--backup-settings`|<b>`shorthand/json`</b><br/>custom backup options, if required.<br/>Shorthand Syntax:<br/>{<br/>backup-schedule = {<br/>next-execute-time = timestamp,<br/>policy = daily-backup-schedule={<br/>execute-time = timeofday<br/>} \| recurring-backup-schedule={<br/>recurrence = str,<br/>start-time = timestamp<br/>} \| weekly-backup-schedule={<br/>days-of-week = [<br/>{<br/>days = MONDAY\|TUESDAY\|WEDNESDAY\|THURSDAY\|FRIDAY\|SATURDAY\|SUNDAY,...,<br/>execute-time = timeofday<br/>}, ...<br/>]<br/>}<br/>},<br/>backup-time-to-live = duration,<br/>description = str,<br/>name = str,<br/>source-paths = str,...,<br/>source-paths-to-exclude = str,...,<br/>storage-class = STANDARD\|REDUCED_REDUNDANCY\|STANDARD_IA\|ONEZONE_IA\|INTELLIGENT_TIERING\|GLACIER\|DEEP_ARCHIVE\|OUTPOSTS,<br/>type = SYSTEM\|USER<br/>}<br/>JSON Syntax:<br/>"{<br/>"backup-schedule": {<br/>"next-execute-time": "timestamp",<br/>"policy": {<br/>"daily-backup-schedule": {<br/>"execute-time": "timeofday"<br/>},<br/>"recurring-backup-schedule": {<br/>"recurrence": "str",<br/>"start-time": "timestamp"<br/>},<br/>"weekly-backup-schedule": {<br/>"days-of-week": [<br/>{<br/>"days": [<br/>"MONDAY\|TUESDAY\|WEDNESDAY\|THURSDAY\|FRIDAY\|SATURDAY\|SUNDAY", ...<br/>],<br/>"execute-time": "timeofday"<br/>}, ...<br/>]<br/>}<br/>}<br/>},<br/>"backup-time-to-live": "duration",<br/>"description": "str",<br/>"name": "str",<br/>"source-paths": [<br/>"str", ...<br/>],<br/>"source-paths-to-exclude": [<br/>"str", ...<br/>],<br/>"storage-class": "STANDARD\|REDUCED_REDUNDANCY\|STANDARD_IA\|ONEZONE_IA\|INTELLIGENT_TIERING\|GLACIER\|DEEP_ARCHIVE\|OUTPOSTS",<br/>"type": "SYSTEM\|USER"<br/>}"<br/>Fields:<br/>backup-schedule -> (struct)<br/>provide schedule. if empty, backup will be disabled.<br/>next-execute-time -> (timestamp)<br/>output only field: when next backup will be executed using provided schedule.<br/>policy -> (oneof<daily-backup-schedule\|recurring-backup-schedule\|weekly-backup-schedule>)<br/>Oneof policy field<br/>daily-backup-schedule -> (struct)<br/>execute-time -> (timeofday)<br/>weekly-backup-schedule -> (struct)<br/>days-of-week -> ([]struct)<br/>days -> ([]int)<br/>execute-time -> (timeofday)<br/>recurring-backup-schedule -> (struct)<br/>recurrence -> (string)<br/>An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported.<br/>start-time -> (timestamp)<br/>Timestamp of the first recurrence.<br/>backup-time-to-live -> (duration)<br/>provide time to live of backup.<br/>description -> (string)<br/>human readable description.<br/>name -> (string)<br/>name of backup settings<br/>source-paths -> ([]string)<br/>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.<br/>source-paths-to-exclude -> ([]string)<br/>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.<br/>storage-class -> (enum<DEEP_ARCHIVE\|GLACIER\|INTELLIGENT_TIERING\|ONEZONE_IA\|OUTPOSTS\|REDUCED_REDUNDANCY\|STANDARD\|STANDARD_IA>)<br/>type -> (enum<SYSTEM\|USER>)|
|`--database-id`|<b>`string`</b><br/>|
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
