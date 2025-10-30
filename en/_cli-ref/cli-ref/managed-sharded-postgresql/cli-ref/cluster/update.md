---
editable: false
---

# yc managed-sharded-postgresql cluster update

Update the specified Sharded PostgreSQL cluster

#### Command Usage

Syntax: 

`yc managed-sharded-postgresql cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Sharded PostgreSQL cluster id.|
|`--name`|<b>`string`</b><br/>Sharded PostgreSQL cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the cluster|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Sharded PostgreSQL cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
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
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Type of maintenance window, it can be anytime or weekly. A day and hour of window need to be specified with weekly window.</li> <li><code>hour</code>:     Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly.</li> <li><code>day</code>:     Day of week for maintenance window if window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|

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
