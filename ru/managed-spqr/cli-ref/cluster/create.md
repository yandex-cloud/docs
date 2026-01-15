---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-sharded-postgresql/cli-ref/cluster/create.md
---

# yc managed-sharded-postgresql cluster create

Create Sharded PostgreSQL cluster

#### Command Usage

Syntax: 

`yc managed-sharded-postgresql cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Cluster name.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--environment`|<b>`string`</b><br/>Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for hosts that should be created for the Sharded PostgreSQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the host resides.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Whether the host should get a public IP address on creation.</li> <li><code>type</code>:     Type of the host Values: 'router', 'coordinator', 'infra', 'postgresql', 'external-postgresql', 'mdb-postgresql'</li> </ul>|
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of database users to be created in the Sharded PostgreSQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the Sharded PostgreSQL user.</li> <li><code>password</code>:     Password of the Sharded PostgreSQL user.</li> <li><code>permission</code>:     Permission for Sharded PostgreSQL user.</li> <li><code>connection-limit</code>:     TODO</li> <li><code>connection-retries</code>:     TODO</li> </ul>|
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of databases to be created in the Sharded PostgreSQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the Sharded PostgreSQL database.</li> </ul>|
|`--router-resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--router-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host in GB.|
|`--router-disk-type`|<b>`string`</b><br/>Type of the storage environment for the host.|
|`--coordinator-resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--coordinator-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host in GB.|
|`--coordinator-disk-type`|<b>`string`</b><br/>Type of the storage environment for the host.|
|`--infra-resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--infra-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host in GB.|
|`--infra-disk-type`|<b>`string`</b><br/>Type of the storage environment for the host.|
|`--postgresql-resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--postgresql-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host in GB.|
|`--postgresql-disk-type`|<b>`string`</b><br/>Type of the storage environment for the host.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retention policy of automated backups.|
|`--datalens-access`|Allow access for DataLens|
|`--websql-access`|Allow access for Web SQL|
|`--serverless-access`|Allow access for Serverless|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Sharded PostgreSQL cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
