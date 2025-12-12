---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dataproc/cli-ref-beta/cluster/update.md
---

# yc beta dataproc cluster update

Updates the configuration of the specified cluster.

#### Command Usage

Syntax: 

`yc beta dataproc cluster update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--autoscaling-service-account-id`|<b>`string`</b><br/>ID of the new service account to be used by the Instance Groups service.|
|`--bucket`|<b>`string`</b><br/>Name of the new Object Storage bucket to use for Yandex Data Processing jobs.|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to update. To get the cluster ID, make a [ClusterService.List] request.|
|`--config-spec`|<b>`shorthand/json`</b><br/>Configuration and resources for hosts that should be created with the Yandex Data Processing cluster.<br/>Shorthand Syntax:<br/>{<br/>hadoop = {<br/>initialization-actions = [<br/>{<br/>args = str,...,<br/>timeout = int,<br/>uri = str<br/>}, ...<br/>],<br/>oslogin-enabled = bool,<br/>properties = {key=str, key=...},<br/>services = HDFS\|YARN\|MAPREDUCE\|HIVE\|TEZ\|ZOOKEEPER\|HBASE\|SQOOP\|FLUME\|SPARK\|ZEPPELIN\|OOZIE\|LIVY,...,<br/>ssh-public-keys = str,...<br/>},<br/>subclusters-spec = [<br/>{<br/>autoscaling-config = {<br/>cpu-utilization-target = double,<br/>decommission-timeout = int,<br/>max-hosts-count = int,<br/>measurement-duration = duration,<br/>preemptible = bool,<br/>stabilization-duration = duration,<br/>warmup-duration = duration<br/>},<br/>hosts-count = int,<br/>id = str,<br/>name = str,<br/>resources = {<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"hadoop": {<br/>"initialization-actions": [<br/>{<br/>"args": [<br/>"str", ...<br/>],<br/>"timeout": "int",<br/>"uri": "str"<br/>}, ...<br/>],<br/>"oslogin-enabled": "bool",<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"services": [<br/>"HDFS\|YARN\|MAPREDUCE\|HIVE\|TEZ\|ZOOKEEPER\|HBASE\|SQOOP\|FLUME\|SPARK\|ZEPPELIN\|OOZIE\|LIVY", ...<br/>],<br/>"ssh-public-keys": [<br/>"str", ...<br/>]<br/>},<br/>"subclusters-spec": [<br/>{<br/>"autoscaling-config": {<br/>"cpu-utilization-target": "double",<br/>"decommission-timeout": "int",<br/>"max-hosts-count": "int",<br/>"measurement-duration": "duration",<br/>"preemptible": "bool",<br/>"stabilization-duration": "duration",<br/>"warmup-duration": "duration"<br/>},<br/>"hosts-count": "int",<br/>"id": "str",<br/>"name": "str",<br/>"resources": {<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>hadoop -> (struct)<br/>Hadoop specific options<br/>initialization-actions -> ([]struct)<br/>Set of init-actions<br/>args -> ([]string)<br/>Arguments to the initialization action<br/>timeout -> (int)<br/>Execution timeout<br/>uri -> (string)<br/>URI of the executable file<br/>oslogin-enabled -> (bool)<br/>Oslogin enable on cluster nodes<br/>properties -> (map[string,string])<br/>Properties set for all hosts in '*-site.xml' configurations. The key should indicate the service and the property. For example, use the key 'hdfs:dfs.replication' to set the 'dfs.replication' property in the file '/etc/hadoop/conf/hdfs-site.xml'.<br/>services -> ([]int)<br/>Set of services used in the cluster (if empty, the default set is used).<br/>ssh-public-keys -> ([]string)<br/>List of public SSH keys to access to cluster hosts.<br/>subclusters-spec -> ([]struct)<br/>New configuration for subclusters in a cluster.<br/>autoscaling-config -> (struct)<br/>Configuration for instance group based subclusters<br/>cpu-utilization-target -> (double)<br/>Defines an autoscaling rule based on the average CPU utilization of the instance group.<br/>decommission-timeout -> (int)<br/>Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120<br/>max-hosts-count -> (int)<br/>Upper limit for total instance subcluster count.<br/>measurement-duration -> (duration)<br/>Time in seconds allotted for averaging metrics.<br/>preemptible -> (bool)<br/>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see documentation.<br/>stabilization-duration -> (duration)<br/>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.<br/>warmup-duration -> (duration)<br/>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.<br/>hosts-count -> (int)<br/>Number of hosts in the subcluster.<br/>id -> (string)<br/>ID of the subcluster to update. To get the subcluster ID make a [SubclusterService.List] request.<br/>name -> (string)<br/>Name of the subcluster.<br/>resources -> (struct)<br/>Resource configuration for each host in the subcluster.<br/>disk-size -> (int)<br/>Volume of the storage available to a host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive.<br/>resource-preset-id -> (string)<br/>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.|
|`--decommission-timeout`|<b>`int`</b><br/>Timeout to gracefully decommission nodes. In seconds. Default value: 0|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster|
|`--description`|<b>`string`</b><br/>New description for the cluster.|
|`--labels`|<b>`stringToString`</b><br/>A new set of cluster labels as 'key:value' pairs.|
|`--log-group-id`|<b>`string`</b><br/>ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service|
|`--name`|<b>`string`</b><br/>New name for the Yandex Data Processing cluster. The name must be unique within the folder.|
|`--security-group-ids`|<b>`strings`</b><br/>User security groups.|
|`--service-account-id`|<b>`string`</b><br/>ID of the new service account to be used by the Yandex Data Processing manager agent.|
|`--ui-proxy`|Enable UI Proxy feature.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
