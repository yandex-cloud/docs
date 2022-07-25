# yc managed-mysql cluster update

Update the specified MySQL cluster

#### Command Usage

Syntax: 

`yc managed-mysql cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> MySQL cluster id.|
|`--name`|<b>`string`</b><br/> MySQL cluster name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> New name for the MySQL cluster|
|`--description`|<b>`string`</b><br/> Cluster description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the MySQL cluster.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--mysql-version`|<b>`string`</b><br/> Version of MYSQL used in the cluster|
|`--resource-preset`|<b>`string`</b><br/> ID of the preset for computational resources available to a host|
|`--disk-size`|<b>`byteSize`</b><br/> Volume of the storage available to a host|
|`--disk-type`|<b>`string`</b><br/> Type of the storage environment for a host|
|`--backup-window-start`|<b>`timeofday`</b><br/> Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--datalens-access`| Allow access for DataLens|
|`--websql-access`| Allow access for Web SQL|
|`--datatransfer-access`| Allow access for DataTransfer|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Maintenance window settings  Possible property names:  type Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.  hour Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.  day Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'  |
|`--performance-diagnostics`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Performance diagnostics settings  Possible property names:  enabled Enable or disable performance diagnostics  sessions-sampling-interval my_stat_activity sampling interval  statements-sampling-interval my_stat_statements sampling interval|

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
