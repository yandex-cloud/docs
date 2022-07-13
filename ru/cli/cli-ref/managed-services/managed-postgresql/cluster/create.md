---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-postgresql/cluster/create.md
---
# yc managed-postgresql cluster create

Create PostgreSQL cluster

#### Command Usage

Syntax: 

`yc managed-postgresql cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Cluster name.|
|`--description`|<b>`string`</b><br/> Cluster description.|
|`--environment`|<b>`string`</b><br/> Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Individual configurations for hosts that should be created for the PostgresSQL cluster.  Possible property names:  zone-id ID of the availability zone where the host resides.  subnet-id ID of the subnet that the host should be created in.  subnet-name Name of the subnet that the host should be created in.  assign-public-ip Whether the host should get a public IP address on creation.  replication-source Host name of the host to be used as the replication source (for cascading replication).  priority Priority of the host as a replica.  |
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of database users to be created in the PostgresSQL cluster.  Possible property names:  name Name of the PostgresSQL user.  password Password of the PostgresSQL user.  permission Permission for PostgresSQL user.  conn-limit Number of connections available to the user.  lock-timeout Lock timeout in milliseconds.  log-min-duration-statement Log minimal duration statement in milliseconds.  temp-file-limit Temporary file limit in bytes.  default-transaction-isolation Default transaction isolation. Values: 'transaction-isolation-read-uncommitted', 'transaction-isolation-read-committed', 'transaction-isolation-repeatable-read', 'transaction-isolation-serializable'  synchronous-commit Synchronous commit. Values: 'synchronous-commit-on', 'synchronous-commit-off', 'synchronous-commit-local', 'synchronous-commit-remote-write', 'synchronous-commit-remote-apply'  log-statement Log statement. Values: 'log-statement-none', 'log-statement-ddl', 'log-statement-mod', 'log-statement-all'  |
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Descriptions of databases to be created in the PostgresSQL cluster.  Possible property names:  name Name of the PostgresSQL database.  owner Name of the user to be assigned as the owner of the database.  lc-collate POSIX locale for string sorting order.  lc-ctype POSIX locale for character classification.  |
|`--datalens-access`| Allow access for DataLens|
|`--websql-access`| Allow access for Web SQL|
|`--serverless-access`| Allow access for Serverless|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--postgresql-version`|<b>`string`</b><br/> Version of PostgreSQL used in the cluster. Values: 14, 13, 12, 11, 10, 10_1c|
|`--resource-preset`|<b>`string`</b><br/> ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to a host.|
|`--disk-type`|<b>`string`</b><br/> Type of the storage environment for the host.|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/> Retention policy of automated backups.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the PostgreSQL cluster.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/> A list of host groups to place VMs of cluster on.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
