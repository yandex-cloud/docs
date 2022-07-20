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
|`--name`|<b>`string`</b><br/>Cluster name.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--environment`|<b>`string`</b><br/>Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for hosts that should be created for the PostgresSQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the host resides.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Whether the host should get a public IP address on creation.</li> <li><code>replication-source</code>:     Host name of the host to be used as the replication source (for cascading replication).</li> <li><code>priority</code>:     Priority of the host as a replica.</li> </ul>|
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of database users to be created in the PostgresSQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the PostgresSQL user.</li> <li><code>password</code>:     Password of the PostgresSQL user.</li> <li><code>permission</code>:     Permission for PostgresSQL user.</li> <li><code>conn-limit</code>:     Number of connections available to the user.</li> <li><code>lock-timeout</code>:     Lock timeout in milliseconds.</li> <li><code>log-min-duration-statement</code>:     Log minimal duration statement in milliseconds.</li> <li><code>temp-file-limit</code>:     Temporary file limit in bytes.</li> <li><code>default-transaction-isolation</code>:     Default transaction isolation. Values: 'transaction-isolation-read-uncommitted', 'transaction-isolation-read-committed', 'transaction-isolation-repeatable-read', 'transaction-isolation-serializable'</li> <li><code>synchronous-commit</code>:     Synchronous commit. Values: 'synchronous-commit-on', 'synchronous-commit-off', 'synchronous-commit-local', 'synchronous-commit-remote-write', 'synchronous-commit-remote-apply'</li> <li><code>log-statement</code>:     Log statement. Values: 'log-statement-none', 'log-statement-ddl', 'log-statement-mod', 'log-statement-all'</li> </ul>|
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of databases to be created in the PostgresSQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the PostgresSQL database.</li> <li><code>owner</code>:     Name of the user to be assigned as the owner of the database.</li> <li><code>lc-collate</code>:     POSIX locale for string sorting order.</li> <li><code>lc-ctype</code>:     POSIX locale for character classification.</li> </ul>|
|`--datalens-access`|Allow access for DataLens|
|`--websql-access`|Allow access for Web SQL|
|`--serverless-access`|Allow access for Serverless|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--postgresql-version`|<b>`string`</b><br/>Version of PostgreSQL used in the cluster. Values: 14, 13, 12, 11, 10, 10_1c|
|`--resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host.|
|`--disk-type`|<b>`string`</b><br/>Type of the storage environment for the host.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retention policy of automated backups.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the PostgreSQL cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/>A list of host groups to place VMs of cluster on.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
