---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-gitlab/cli-ref/instance/update.md
---

# yc managed-gitlab instance update

Update the specified Gitlab instance

#### Command Usage

Syntax:

`yc managed-gitlab instance update <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Gitlab instance id. ||
|| `--name` | `string`

Gitlab instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the Gitlab instance. ||
|| `--description` | `string`

Description of the instance. ||
|| `--labels` | `key=value[,key=value...]`

A list of Gitlab instance labels as key-value pairs. ||
|| `--resource-preset-id` | `string`

ID of the preset for computational resources available to the instance (CPU, memory etc.). One of: s2.micro, s2.small, s2.medium, s2.large. ||
|| `--disk-size` | `byteSize`

Amount of disk storage available to a instance in GB. ||
|| `--backup-retain-period-days` | `int`

Auto backups retain period in days. ||
|| `--maintenance-delete-untagged` | Delete untagged images during maintenance. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the instance. ||
|| `--approval-rules` | `string`

Approval rules configuration. One of: BASIC, STANDARD, ADVANCED. ||
|| `--approval-rules-token` | `string`

Approval rules token. ||
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