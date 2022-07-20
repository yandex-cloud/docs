# yc dataproc subcluster create

Create a subcluster.

#### Command Usage

Syntax: 

`yc dataproc subcluster create <SUBCLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the cluster.|
|`--name`|<b>`string`</b><br/>Name of a subcluster.|
|`--role`|<b>`string`</b><br/>Role of a subcluster Values: 'masternode', 'datanode', 'computenode'|
|`--resource-preset`|<b>`string`</b><br/>Preset of computational resources available to a host|
|`--disk-type`|<b>`string`</b><br/>Type of the storage environment for a host.|
|`--subnet-id`|<b>`string`</b><br/>Subnet id.|
|`--subnet-name`|<b>`string`</b><br/>Subnet name.|
|`--disk-size`|<b>`byteSize`</b><br/>Amount of disk storage available to a host in GB.|
|`--hosts-count`|<b>`int`</b><br/>Specifies a number of hosts in a subcluster. (Minimum number of hosts for autoscaling compute subcluster)|
|`--max-hosts-count`|<b>`int`</b><br/>Specifies a maximum number of hosts for autoscaling compute subcluster.|
|`--preemptible`|Enables VMs preemption for autoscaling compute subcluster.|
|`--warmup-duration`|<b>`duration`</b><br/>Specifies a warmup duration for autoscaling compute subcluster.|
|`--stabilization-duration`|<b>`duration`</b><br/>Specifies a stabilization duration for autoscaling compute subcluster.|
|`--measurement-duration`|<b>`duration`</b><br/>Specifies a measurement duration for autoscaling compute subcluster.|
|`--cpu-utilization-target`|<b>`float`</b><br/>Specifies a CPU utilization threshold. In percents (10-100). When this threshold is passed the subcluster nodes number will grow.|
|`--autoscaling-decommission-timeout`|<b>`int`</b><br/>Specifies a decommission timeout (in seconds) for nodes during automatic downscaling.|
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
