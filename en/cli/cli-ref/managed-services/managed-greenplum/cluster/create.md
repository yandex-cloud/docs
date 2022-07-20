---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-greenplum/cluster/create.md
---
# yc managed-greenplum cluster create

Create Greenplum cluster

#### Command Usage

Syntax: 

`yc managed-greenplum cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Cluster name.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--environment`|<b>`string`</b><br/>Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--master-host-count`|<b>`int`</b><br/>Master host count. Values: 1, 2. Default is 2.|
|`--segment-host-count`|<b>`int`</b><br/>Segment host count. Default is 2.|
|`--segment-in-host`|<b>`int`</b><br/>Numbers of segments in host.|
|`--user-name`|<b>`string`</b><br/>Cluster owner user name.|
|`--user-password`|<b>`string`</b><br/>Owner user password. Must be 8-128 characters long.|
|`--master-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of master config for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>resource-id</code>:     ID of the preset for computational resources available on the host.</li> <li><code>disk-size</code>:     Volume of the storage available on the host.</li> <li><code>disk-type</code>:     Type of the storage environment for the host.</li> </ul>|
|`--segment-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Descriptions of segment config for Greenplum cluster.<br/><br/>Possible property names:<br/><ul> <li><code>resource-id</code>:     ID of the preset for computational resources available on the host.</li> <li><code>disk-size</code>:     Volume of the storage available on the host.</li> <li><code>disk-type</code>:     Type of the storage environment for the host.</li> </ul>|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add.|
|`--host-group-ids`|<b>`value[,value]`</b><br/>A list of host groups for Greenplum cluster.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Greenplum cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--datalens-access`|Allow access for DataLens.|
|`--websql-access`|Allow access for Web SQL.|
|`--greenplum-version`|<b>`string`</b><br/>Version of Greenplum used in the cluster. Values: 6.19|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the host resides.|
|`--subnet-id`|<b>`string`</b><br/>ID of the subnet that the host should be created in.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--assign-public-ip`|Whether the host should get a public IP address on creation.|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|
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
