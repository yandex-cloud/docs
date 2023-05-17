---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/dataproc/subcluster/update.md
---

# yc dataproc subcluster update

Modify configuration or attributes of a subcluster.

#### Command Usage

Syntax: 

`yc dataproc subcluster update <SUBCLUSTER-NAME>|<SUBCLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the cluster.|
|`--id`|<b>`string`</b><br/>ID of the subcluster.|
|`--name`|<b>`string`</b><br/>Name of the subcluster.|
|`--new-name`|<b>`string`</b><br/>New name for the subcluster.|
|`--decommission-timeout`|<b>`int`</b><br/>Graceful decommission timeout during update operation (in seconds) in case the operation will require nodes downtime.|
|`--resource-preset`|<b>`string`</b><br/>Preset of computational resources available to a host of a subcluster|
|`--disk-size`|<b>`byteSize`</b><br/>Amount of disk storage available to a host of a subcluster.|
|`--hosts-count`|<b>`int`</b><br/>Specifies a number of hosts in a subcluster. (Minimum number of hosts for autoscaling compute subcluster)|
|`--max-hosts-count`|<b>`int`</b><br/>Specifies a maximum number of hosts for autoscaling compute subcluster.|
|`--enable-preemptible`|Enables VMs preemption for autoscaling compute subcluster.|
|`--disable-preemptible`|Disables VMs preemption for autoscaling compute subcluster.|
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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
