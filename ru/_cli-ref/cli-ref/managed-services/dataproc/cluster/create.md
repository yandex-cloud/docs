# yc dataproc cluster create

Create a cluster.

#### Command Usage

Syntax: 

`yc dataproc cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the cluster.|
|`--description`|<b>`string`</b><br/> Description of the cluster.|
|`--zone`|<b>`string`</b><br/> ID of the availability zone where the cluster resides.|
|`--service-account-id`|<b>`string`</b><br/> Service account id.|
|`--service-account-name`|<b>`string`</b><br/> Service account name.|
|`--version`|<b>`string`</b><br/> Version of an image for cluster provisioning.|
|`--services`| List of used services in a cluster. If no service is specified, the default set will be used. A list can be specified by listing services separated by commas as well as passing this flag multiple times. Available services are: 'hdfs', 'yarn', 'mapreduce', 'hive', 'tez', 'zookeeper', 'hbase', 'sqoop', 'flume', 'spark', 'zeppelin'. |
|`--property`|<b>`value[,value]`</b><br/> Properties passed to all hosts *-site.xml configurations in <service>:<property>=<value> format. For example setting property 'dfs.replication' to 3 in /etc/hadoop/conf/hdfs-site.xml requires specifying --property "hdfs:dfs.replication=3" This flag can be passed multiple times. |
|`--ssh-public-keys-file`|<b>`string`</b><br/> Specify a list of SSH public keys that will be set as authorized keys to root user on cluster hosts.|
|`--subcluster`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Specifies options for subclusters. Can be passed multiple times.  Possible property names:  name Name of a subcluster.  role Role of a subcluster Values: 'masternode', 'datanode', 'computenode'  resource-preset Preset of computational resources available to a host  disk-type Type of the storage environment for a host.  disk-size Amount of disk storage available to a host in GB.  subnet-name Name of the subnet that subcluster's hosts should be created in.  subnet-id ID of the subnet that subcluster's hosts should be created in.  hosts-count Specifies a number of hosts in a subcluster. (Minimum number of hosts for autoscaling compute subcluster)  assign-public-ip Assigns public Ip for all hosts in a subcluster.  max-hosts-count Specifies a maximum number of hosts for autoscaling compute subcluster.  preemptible Enables VMs preemption for autoscaling compute subcluster.  warmup-duration Specifies a warmup duration for autoscaling compute subcluster.  stabilization-duration Specifies a stabilization duration for autoscaling compute subcluster.  measurement-duration Specifies a measurement duration for autoscaling compute subcluster.  cpu-utilization-target Specifies a CPU utilization threshold. In percents (10-100). When this threshold is passed the subcluster nodes number will grow.  autoscaling-decommission-timeout Specifies a decommission timeout (in seconds) for nodes during automatic downscaling.  |
|`--initialization-action`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Specifies initialization action. Can be passed multiple times.  Possible property names:  uri URI of an initialization action.  args Arguments for initialization action.  timeout Specifies initialization action execution timeout (in seconds).  |
|`--bucket`|<b>`string`</b><br/> Object Storage bucket to be used for Data Proc jobs that are run in the cluster.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of cluster labels as key-value pairs.|
|`--ui-proxy`| Whether to enable UI Proxy feature.|
|`--security-group-ids`|<b>`value[,value]`</b><br/> A list of security groups for the Data Proc cluster.|
|`--host-group-ids`|<b>`value[,value]`</b><br/> A list of host groups to place VMs of cluster on.|
|`--deletion-protection`| Deletion Protection inhibits deletion of the cluster.|
|`--log-group-id`|<b>`string`</b><br/> Id of a log group to write cluster logs to.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

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
