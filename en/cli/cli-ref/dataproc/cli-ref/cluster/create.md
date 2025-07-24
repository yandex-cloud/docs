---
editable: false
sourcePath: en/_cli-ref/cli-ref/dataproc/cli-ref/cluster/create.md
---

# yc dataproc cluster create

Create a cluster.

#### Command Usage

Syntax: 

`yc dataproc cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the cluster.|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--zone`|<b>`string`</b><br/>ID of the availability zone where the cluster resides.|
|`--service-account-id`|<b>`string`</b><br/>Service account id.|
|`--service-account-name`|<b>`string`</b><br/>Service account name.|
|`--autoscaling-service-account-id`|<b>`string`</b><br/>Autoscaling service account id.|
|`--autoscaling-service-account-name`|<b>`string`</b><br/>Autoscaling service account name.|
|`--version`|<b>`string`</b><br/>Version of an image for cluster provisioning.|
|`--services`|List of used services in a cluster. If no service is specified, the default set will be used.<br/>A list can be specified by listing services separated by commas as well as passing this flag multiple times.<br/>Available services are: 'hdfs', 'yarn', 'mapreduce', 'hive', 'tez', 'zookeeper', 'hbase', 'sqoop', 'flume', 'spark', 'zeppelin'.<br/>|
|`--property`|<b>`value[,value]`</b><br/>Properties passed to all hosts *-site.xml configurations in \<service\>:\<property\>=\<value\> format.<br/>For example setting property 'dfs.replication' to 3 in /etc/hadoop/conf/hdfs-site.xml requires specifying --property "hdfs:dfs.replication=3"<br/>This flag can be passed multiple times.<br/>|
|`--ssh-public-keys-file`|<b>`string`</b><br/>Specify a list of SSH public keys that will be set as authorized keys to root user on cluster hosts.|
|`--subcluster`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies options for subclusters. Can be passed multiple times.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of a subcluster.</li> <li><code>role</code>:     Role of a subcluster Values: 'masternode', 'datanode', 'computenode'</li> <li><code>resource-preset</code>:     Preset of computational resources available to a host</li> <li><code>disk-type</code>:     Type of the storage environment for a host.</li> <li><code>disk-size</code>:     Amount of disk storage available to a host in GB.</li> <li><code>subnet-name</code>:     Name of the subnet that subcluster's hosts should be created in.</li> <li><code>subnet-id</code>:     ID of the subnet that subcluster's hosts should be created in.</li> <li><code>hosts-count</code>:     Specifies a number of hosts in a subcluster. (Minimum number of hosts for autoscaling compute subcluster)</li> <li><code>assign-public-ip</code>:     Assigns public Ip for all hosts in a subcluster.</li> <li><code>max-hosts-count</code>:     Specifies a maximum number of hosts for autoscaling compute subcluster.</li> <li><code>preemptible</code>:     Enables VMs preemption for autoscaling compute subcluster.</li> <li><code>warmup-duration</code>:     Specifies a warmup duration for autoscaling compute subcluster.</li> <li><code>stabilization-duration</code>:     Specifies a stabilization duration for autoscaling compute subcluster.</li> <li><code>measurement-duration</code>:     Specifies a measurement duration for autoscaling compute subcluster.</li> <li><code>cpu-utilization-target</code>:     Specifies a CPU utilization threshold. In percents (10-100). When this threshold is passed the subcluster nodes number will grow.</li> <li><code>autoscaling-decommission-timeout</code>:     Specifies a decommission timeout (in seconds) for nodes during automatic downscaling.</li> </ul>|
|`--initialization-action`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Specifies initialization action. Can be passed multiple times.<br/><br/>Possible property names:<br/><ul> <li><code>uri</code>:     URI of an initialization action.</li> <li><code>args</code>:     Arguments for initialization action.</li> <li><code>timeout</code>:     Specifies initialization action execution timeout (in seconds).</li> </ul>|
|`--oslogin`|Whether to enable OSLogin feature.|
|`--bucket`|<b>`string`</b><br/>Object Storage bucket to be used for Data Proc jobs that are run in the cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of cluster labels as key-value pairs.|
|`--ui-proxy`|Whether to enable UI Proxy feature.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>A list of security groups for the Data Proc cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/>A list of host groups to place VMs of cluster on.|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster.|
|`--log-group-id`|<b>`string`</b><br/>Id of a log group to write cluster logs to.|
|`--environment`|<b>`string`</b><br/>Cluster environment. Values: production, prestable.|
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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
