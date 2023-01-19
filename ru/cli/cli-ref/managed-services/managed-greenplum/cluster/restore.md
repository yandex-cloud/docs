---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-greenplum/cluster/restore.md
---

# yc managed-greenplum cluster restore

Restore Greenplum cluster

#### Command Usage

Syntax: 

`yc managed-greenplum cluster restore [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--backup-id`|<b>`string`</b><br/>ID of the backup to create a cluster from.|
|`--name`|<b>`string`</b><br/>Cluster name.|
|`--description`|<b>`string`</b><br/>Cluster description.|
|`--environment`|<b>`string`</b><br/>Cluster environment. Values: production, prestable.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--master-resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available on the master host.|
|`--master-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available on the master host.|
|`--master-disk-type`|<b>`string`</b><br/>Type of the storage environment for the master host.|
|`--segment-resource-preset`|<b>`string`</b><br/>ID of the preset for computational resources available on the segment host.|
|`--segment-disk-size`|<b>`byteSize`</b><br/>Volume of the storage available on the segment host.|
|`--segment-disk-type`|<b>`string`</b><br/>Type of the storage environment for the segment host.|
|`--datalens-access`|Allow access for DataLens.|
|`--websql-access`|Allow access for Web SQL.|
|`--datatransfer-access`|Allow access for DataTransfer.|
|`--backup-window-start`|<b>`timeofday`</b><br/>Start time for the daily backup in UTC timezone. Format: HH:MM:SS|
|`--zone-id`|<b>`string`</b><br/>Network name.|
|`--subnet-id`|<b>`string`</b><br/>Name of the subnet. It must be specified if the selected availability zone includes two or more subnets.|
|`--assign-public-ip`|Flag to specify if a host requires a public IP address.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Greenplum cluster.|
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
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
