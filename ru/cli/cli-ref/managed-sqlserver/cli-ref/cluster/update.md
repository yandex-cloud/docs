---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-sqlserver/cli-ref/cluster/update.md
---

# yc managed-sqlserver cluster update

Update the specified SQLServer cluster

#### Command Usage

Syntax:

`yc managed-sqlserver cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

SQLServer cluster id. ||
|| `--name` | `string`

SQLServer cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for the SQLServer cluster ||
|| `--description` | `string`

Cluster description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the SQLServer cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--service-account-id` | `string`

Service account id to assign to cluster hosts. ||
|| `--confirm-payment` | Confirm immediate payment for cluster creation/modification/restoring ||
|| `--resource-preset` | `string`

ID of the preset for computational resources available to a host ||
|| `--disk-size` | `byteSize`

Volume of the storage available to a host in GB ||
|| `--disk-type` | `string`

Type of the storage environment for a host ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--secondary-connections` | `string`

Secondary replicas connection mode Values: 'secondary-connections-off', 'secondary-connections-read-only' ||
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