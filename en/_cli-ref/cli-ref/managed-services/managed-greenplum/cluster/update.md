# yc managed-greenplum cluster update

Update the specified Greenplum cluster

#### Command Usage

Syntax: 

`yc managed-greenplum cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Greenplum cluster id.|
|`--name`|<b>`string`</b><br/>Greenplum cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add.|
|`--new-name`|<b>`string`</b><br/>New name for the Greenplum cluster|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--user-password`|<b>`string`</b><br/>Owner user password. Must be 8-128 characters long.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Greenplum cluster.|
|`--master-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of master config resources for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>resource-id</code>:     ID of the preset for computational resources available on the host.</li> <li><code>disk-size</code>:     Volume of the storage available on the host.</li> </ul>|
|`--segment-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of segment config resources for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>resource-id</code>:     ID of the preset for computational resources available on the host.</li> <li><code>disk-size</code>:     Volume of the storage available on the host.</li> </ul>|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>update<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|
|`--datalens-access`|Allow access for DataLens.|
|`--websql-access`|Allow access for Web SQL.|
|`--datatransfer-access`|Allow access for DataTransfer.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--connection-pooling-mode`|<b>`string`</b><br/>Connection pooler pooling mode Values: 'session', 'transaction'|
|`--connection-pooling-size`|<b>`int`</b><br/>Connection pooler size|
|`--connection-pooling-client-idle-timeout`|<b>`int`</b><br/>Connection pooler client idle timeout|

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
