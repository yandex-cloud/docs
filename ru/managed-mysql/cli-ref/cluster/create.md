---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-mysql/cli-ref/cluster/create.md
---

# yc managed-mysql cluster create

Create MySQL cluster

#### Command Usage

Syntax: 

`yc managed-mysql cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Cluster name.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--environment`|<b>`string`</b><br/>Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--host`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Individual configurations for hosts that should be created for the MySQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>zone-id</code>:     ID of the availability zone where the host resides.</li> <li><code>subnet-id</code>:     ID of the subnet that the host should be created in.</li> <li><code>subnet-name</code>:     Name of the subnet that the host should be created in.</li> <li><code>assign-public-ip</code>:     Whether the host should get a public IP address on creation.</li> <li><code>replication-source</code>:     Name of the host to be used as the replication source for cascaded replication.</li> <li><code>backup-priority</code>:     Priority of the host as a backup source.</li> <li><code>priority</code>:     Host master promotion priority.</li> </ul>|
|`--user`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of database users to be created in the MySQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the MySQL user.</li> <li><code>password</code>:     Password of the MySQL user.</li> <li><code>generate-password</code>:     Generate password using Connection Manager.</li> </ul>|
|`--database`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of databases to be created in the MySQL cluster.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the MySQL database.</li> </ul>|
|`--datalens-access`|Allow access for DataLens|
|`--websql-access`|Allow access for Web SQL|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--yandexquery-access`|Allow access for YandexQuery|
|`--mysql-version`|<b>`string`</b><br/>Version of MYSQL used in the cluster. Values: 8.0, 5.7|
|`--resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host (CPU, memory etc.).|
|`--disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host in GB.|
|`--disk-type`|<b>`string`</b><br/>Type of the storage environment for the host.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retention policy of automated backups.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the MySQL cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/>A list of host groups to place VMs of cluster on.|
|`--disk-encryption-key-id`|<b>`string`</b><br/>ID of the KMS key for cluster disk encryption.|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|
|`--performance-diagnostics`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Performance diagnostics settings<br/><br/>Possible property names:<br/><ul> <li><code>enabled</code>:     Enable or disable performance diagnostics</li> <li><code>sessions-sampling-interval</code>:     my_stat_activity sampling interval</li> <li><code>statements-sampling-interval</code>:     my_stat_statements sampling interval</li> </ul>|
|`--disk-size-autoscaling`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Disk size autoscaling settings<br/><br/>Possible property names:<br/><ul> <li><code>disk-size-limit</code>:     Set disk size limit</li> <li><code>planned-usage-threshold</code>:     Planned usage threshold</li> <li><code>emergency-usage-threshold</code>:     Emergency usage threshold</li> </ul>|
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
