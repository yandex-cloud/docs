# yc managed-sqlserver cluster update

Update the specified SQLServer cluster

#### Command Usage

Syntax: 

`yc managed-sqlserver cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>SQLServer cluster id.|
|`--name`|<b>`string`</b><br/>SQLServer cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the SQLServer cluster|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the SQLServer cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--service-account-id`|<b>`string`</b><br/>Service account id to assign to cluster hosts.|
|`--confirm-payment`|Confirm immediate payment for cluster creation/modification/restoring|
|`--resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available to a host|
|`--disk-size`|<b>`byteSize`</b><br/>Volume of the storage available to a host|
|`--disk-type`|<b>`string`</b><br/>Type of the storage environment for a host|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--secondary-connections`|<b>`string`</b><br/>Secondary replicas connection mode Values: 'secondary-connections-off', 'secondary-connections-read-only'|

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
