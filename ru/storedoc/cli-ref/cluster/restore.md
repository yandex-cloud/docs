---
editable: false
---

# yc managed-mongodb cluster restore

Restore a MongoDB cluster from a backup.

#### Command Usage

Syntax:

`yc managed-mongodb cluster restore [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backup-id` | `string`

ID of the backup to use for restoring a cluster. ||
|| `--name` | `string`

Name for the restored cluster. ||
|| `--description` | `string`

Description for the restored cluster. ||
|| `--environment` | `string`

Environment for the restored cluster. Supported values: 'production', 'prestable'. ||
|| `--recovery-target-timestamp` | `int`

Timestamp of the moment to which the MongoDB cluster should be restored. Format: UNIX Epoch time (POSIX time).
Example: '1600884000' is UNIX Epoch time for '2020-09-23T18:00:00+00:00'. ||
|| `--whitelist` | `value[,value]`

A comma separated list of MongoDB namespaces restore to. Format: 'db_name.coll_name'.
Example: 'foo,bar.baz' will restore foo database and bar.baz namespace ||
|| `--blacklist` | `value[,value]`

A comma separated list of MongoDB namespaces NOT restore to. Format: 'db_name.coll_name'.
Example: 'foo,bar.baz' will NOT restore foo database and bar.baz namespace ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for hosts that should be created for the MongoDB cluster being restored.

Possible property names:

- `shard-name`: Host shard name.

- `type`: Type of the host to be created. Supported values: 'mongod', 'mongos', 'mongocfg', 'mongoinfra'.

- `zone-id`: ID of the availability zone where the new host should reside.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Assign a public IP address to the host being added.

- `hidden`: Set hidden parameter to the host being added

- `secondary-delay-secs`: Set secondaryDelaySecs parameter to the host being added

- `priority`: Set priority parameter to the host being added

- `tags`: Set tags parameter to the host being added ||
|| `--labels` | `key=value[,key=value...]`

A list of labels as key-value pairs to add for the cluster being restored. ||
|| `--folder-id` | `string`

ID of folder where restored cluster will be created. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the MongoDB cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. Empty input will remove the use of encryption. ||
|| `--mongodb-version` | `string`

Version of MongoDB used by the cluster. Supported value: 5.0, 6.0, 7.0 ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--backup-retain-period-days` | `int`

Retain period of automatically created backup in days. ||
|| `--performance-diagnostics` | Enable or disable performance diagnostics ||
|| `--datalens-access` | Allow access for DataLens ||
|| `--websql-access` | Allow access for Web SQL ||
|| `--datatransfer-access` | Allow access for DataTransfer ||
|| `--mongod-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongod-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongod-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--mongocfg-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongocfg-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongocfg-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--mongos-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongos-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongos-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--mongoinfra-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongoinfra-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongoinfra-disk-type` | `string`

Storage type for mongodb host with corresponding role. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
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