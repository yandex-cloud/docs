# yc managed-postgresql cluster update

Update the specified PostgreSQL cluster

#### Command Usage

Syntax: 

`yc managed-postgresql cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>PostgreSQL cluster id.|
|`--name`|<b>`string`</b><br/>PostgreSQL cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the cluster|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the PostgreSQL cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--connection-pooling-mode`|<b>`string`</b><br/>Connection pooler pooling mode|
|`--connection-pool-discard`|Indicates whether client parameters should be discarded before using a server from the pool|
|`--postgresql-version`|<b>`string`</b><br/>Version of PostgreSQL used in the cluster|
|`--resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host|
|`--disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host|
|`--disk-type`|<b>`string`</b><br/>Type of the storage environment for a host|
|`--autofailover`|Enables/disables autofailover in cluster|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--backup-retain-period-days`|<b>`int`</b><br/>Retention policy of automated backups.|
|`--datalens-access`|Allow access for DataLens|
|`--websql-access`|Allow access for Web SQL|
|`--serverless-access`|Allow access for Serverless|
|`--datatransfer-access`|Allow access for DataTransfer|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|
|`--performance-diagnostics`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Performance diagnostics settings<br/><br/>Possible property names:<br/><ul> <li><code>enabled</code>:     Enable or disable performance diagnostics</li> <li><code>sessions-sampling-interval</code>:     pg_stat_activity sampling interval</li> <li><code>statements-sampling-interval</code>:     pg_stat_statements sampling interval</li> </ul>|

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
