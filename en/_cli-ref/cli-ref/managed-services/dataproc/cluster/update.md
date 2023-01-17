---
editable: false
---

# yc dataproc cluster update

Modify attributes of a cluster.

#### Command Usage

Syntax: 

`yc dataproc cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the cluster.|
|`--name`|<b>`string`</b><br/>Name of the cluster.|
|`--new-name`|<b>`string`</b><br/>New name for the cluster.|
|`--description`|<b>`string`</b><br/>New description for the cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten.|
|`--bucket`|<b>`string`</b><br/>New Object Storage bucket to be used for Data Proc jobs that are run in the cluster.|
|`--decommission-timeout`|<b>`int`</b><br/>Graceful decommission timeout in seconds.|
|`--ui-proxy`|Whether to enable UI Proxy feature.|
|`--property`|<b>`value[,value]`</b><br/>Properties passed to all hosts *-site.xml configurations in \<service\>:\<property\>=\<value\> format.<br/>For example setting property 'dfs.replication' to 3 in /etc/hadoop/conf/hdfs-site.xml requires specifying --property "hdfs:dfs.replication=3"<br/>This flag can be passed multiple times.<br/>If you previously specified properties when creating a cluster and now want to add new ones, then you need to list the full set of properties, not just the ones that are being added.<br/>|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Data Proc cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--service-account-id`|<b>`string`</b><br/>New service account id.|
|`--service-account-name`|<b>`string`</b><br/>New service account name.|
|`--log-group-id`|<b>`string`</b><br/>Id of a log group to write cluster logs to.|
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
