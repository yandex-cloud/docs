---
editable: false
---

# yc managed-mongodb cluster create

Create a MongoDB cluster.

#### Command Usage

Syntax:

`yc managed-mongodb cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the cluster. ||
|| `--description` | `string`

Description of the cluster. ||
|| `--environment` | `string`

Environment to deploy the cluster in. Supported values: 'production', 'prestable'. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for hosts that should be created with the MongoDB cluster.

Possible property names:

- `type`: Type of the host to be created. Supported values: 'mongod', 'mongos', 'mongocfg', 'mongoinfra'.

- `zone-id`: ID of the availability zone where the new host should reside.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Assign a public IP address to the host being added.

- `hidden`: Set hidden parameter to the host being added

- `secondary-delay-secs`: Set secondaryDelaySecs parameter to the host being added

- `priority`: Set priority parameter to the host being added

- `tags`: Set tags parameter to the host being added ||
|| `--user` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of database users to be created with the MongoDB cluster.

Possible property names:

- `name`: Name of the MongoDB user.

- `password`: Password of the MongoDB user. ||
|| `--database` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Descriptions of databases to be created with the MongoDB cluster.

Possible property names:

- `name`: Name of the MongoDB database. ||
|| `--disk-size-autoscaling` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Disk size autoscaling settings

Possible property names:

- `mongod-disk-size-limit`: Set disk size limit for mongod in GB

- `mongod-planned-usage-threshold`: Planned usage threshold mongod

- `mongod-emergency-usage-threshold`: Emergency usage threshold mongod

- `mongocfg-disk-size-limit`: Set disk size limit for mongocfg in GB

- `mongocfg-planned-usage-threshold`: Planned usage threshold mongocfg

- `mongocfg-emergency-usage-threshold`: Emergency usage threshold mongocfg

- `mongoinfra-disk-size-limit`: Set disk size limit for mongoinfra in GB

- `mongoinfra-planned-usage-threshold`: Planned usage threshold mongoinfra

- `mongoinfra-emergency-usage-threshold`: Emergency usage threshold mongoinfra

- `mongos-disk-size-limit`: Set disk size limit for mongos in GB

- `mongos-planned-usage-threshold`: Planned usage threshold mongos

- `mongos-emergency-usage-threshold`: Emergency usage threshold mongos ||
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
|| `--mongoinfra-resource-preset` | `string`

Resource preset for computational resources available to mongodb host with corresponding role (CPU, RAM etc.). ||
|| `--mongoinfra-disk-size` | `byteSize`

Volume of the storage available to mongodb host with corresponding role in GB. ||
|| `--mongoinfra-disk-type` | `string`

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
|| `--labels` | `key=value[,key=value...]`

A list of cluster labels as key-value pairs. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the MongoDB cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. ||
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