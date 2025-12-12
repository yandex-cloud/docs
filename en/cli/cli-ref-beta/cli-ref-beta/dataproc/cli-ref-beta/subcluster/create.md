---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dataproc/cli-ref-beta/subcluster/create.md
---

# yc beta dataproc subcluster create

Creates a subcluster in the specified cluster.

#### Command Usage

Syntax: 

`yc beta dataproc subcluster create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--autoscaling-config`|<b>`shorthand/json`</b><br/>Configuration for instance group based subclusters<br/>Shorthand Syntax:<br/>{<br/>cpu-utilization-target = double,<br/>decommission-timeout = int,<br/>max-hosts-count = int,<br/>measurement-duration = duration,<br/>preemptible = bool,<br/>stabilization-duration = duration,<br/>warmup-duration = duration<br/>}<br/>JSON Syntax:<br/>"{<br/>"cpu-utilization-target": "double",<br/>"decommission-timeout": "int",<br/>"max-hosts-count": "int",<br/>"measurement-duration": "duration",<br/>"preemptible": "bool",<br/>"stabilization-duration": "duration",<br/>"warmup-duration": "duration"<br/>}"<br/>Fields:<br/>cpu-utilization-target -> (double)<br/>Defines an autoscaling rule based on the average CPU utilization of the instance group.<br/>decommission-timeout -> (int)<br/>Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120<br/>max-hosts-count -> (int)<br/>Upper limit for total instance subcluster count.<br/>measurement-duration -> (duration)<br/>Time in seconds allotted for averaging metrics.<br/>preemptible -> (bool)<br/>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see documentation.<br/>stabilization-duration -> (duration)<br/>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.<br/>warmup-duration -> (duration)<br/>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.|
|`--cluster-id`|<b>`string`</b><br/>ID of the Yandex Data Processing cluster to create a subcluster in. To get a cluster ID, make a [ClusterService.List] request.|
|`--hosts-count`|<b>`int`</b><br/>Number of hosts in the subcluster.|
|`--name`|<b>`string`</b><br/>Name of the subcluster. The name must be unique within the cluster. The name can't be changed when the subcluster is created.|
|`--resources`|<b>`shorthand/json`</b><br/>Resources allocated for each host in the subcluster.<br/>Shorthand Syntax:<br/>{<br/>disk-size = int,<br/>disk-type-id = str,<br/>resource-preset-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"disk-size": "int",<br/>"disk-type-id": "str",<br/>"resource-preset-id": "str"<br/>}"<br/>Fields:<br/>disk-size -> (int)<br/>Volume of the storage available to a host, in bytes.<br/>disk-type-id -> (string)<br/>Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive.<br/>resource-preset-id -> (string)<br/>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.|
|`--role`|<b>`enum`</b><br/>Role that is fulfilled by hosts of the subcluster. Possible Values: 'masternode', 'datanode', 'computenode'|
|`--subnet-id`|<b>`string`</b><br/>ID of the VPC subnet used for hosts in the subcluster.|
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
