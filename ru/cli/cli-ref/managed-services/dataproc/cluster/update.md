---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# yc dataproc cluster update

Modify attributes of a cluster.

#### Command Usage

Syntax: 

`yc dataproc cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> ID of the cluster.|
|`--name`|<b>`string`</b><br/> Name of the cluster.|
|`--new-name`|<b>`string`</b><br/> New name for the cluster.|
|`--description`|<b>`string`</b><br/> New description for the cluster. --labels key=value[,key=value...] A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten.|
|`--bucket`|<b>`string`</b><br/> New Object Storage bucket to be used for Data Proc jobs that are run in the cluster.|
|`--decommission-timeout`|<b>`int`</b><br/> Graceful decommission timeout in seconds.|
|`--ui-proxy`| Whether to enable UI Proxy feature. --security-group-ids value[,value] A list of security groups for the Data Proc cluster.|
|`--service-account-id`|<b>`string`</b><br/> New service account id.|
|`--service-account-name`|<b>`string`</b><br/> New service account name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Flags

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
