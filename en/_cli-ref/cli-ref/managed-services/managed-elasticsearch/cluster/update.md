# yc managed-elasticsearch cluster update

Modify configuration or attributes of a ElasticSearch cluster.

#### Command Usage

Syntax: 

`yc managed-elasticsearch cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the ElasticSearch cluster.|
|`--name`|<b>`string`</b><br/>Name of the ElasticSearch cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>New name for the ElasticSearch cluster|
|`--description`|<b>`string`</b><br/>New description for the ElasticSearch cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the ElasticSearch cluster as key-value pairs. Existing set of labels will be completely overwritten.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the ElasticSearch cluster.|
|`--service-account-id`|<b>`string`</b><br/>Service account for the Elasticsearch cluster.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--version`|<b>`string`</b><br/>Set new version of the Elasticsearch server software|
|`--edition`|<b>`string`</b><br/>Set new Elasticsearch server edition|
|`--plugins`|<b>`value[,value]`</b><br/>Set new set of ElasticSearch plugins|
|`--datanode-resource-preset`|<b>`string`</b><br/>New resource preset for computational resources available to a datanode host (CPU, RAM etc.).|
|`--datanode-disk-size`|<b>`byteSize`</b><br/>New storage volume available to a datanode host.|
|`--datanode-disk-type`|<b>`string`</b><br/>New storage type for a datanode host.|
|`--masternode-resource-preset`|<b>`string`</b><br/>New resource preset for computational resources available to a masternode host (CPU, RAM etc.).|
|`--masternode-disk-size`|<b>`byteSize`</b><br/>New storage volume available to a masternode host.|
|`--masternode-disk-type`|<b>`string`</b><br/>New storage type for a masternode host.|
|`--admin-password`|<b>`string`</b><br/>Password for entity. Usage of --read-admin-password is more secure|
|`--read-admin-password`|Read password for entity from input|
|`--generate-admin-password`|Generate random password|
|`--maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Maintenance window settings<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     type of a maintenance window, it can be anytime or weekly. A day and hour of the window needs to be specified with the weekly window itself.</li> <li><code>hour</code>:     Hour of a day in UTC time zone (1-24) for a maintenance window if the window type is weekly.</li> <li><code>day</code>:     Day of the week for a maintenance window if the window type is weekly. One of MON, TUE, WED, THU, FRI, SAT, SUN. Values: 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'</li> </ul>|

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
