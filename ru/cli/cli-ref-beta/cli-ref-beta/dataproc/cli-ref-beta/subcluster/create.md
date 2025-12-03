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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--autoscaling-config`|<b>`shorthand/json`</b><br/>Configuration for instance group based subclusters<br/><br/>Example:|
|`--autoscaling-config`|<b>`cpu-utilization-target=1.0,`</b><br/>decommission-timeout=1, max-hosts-count=1, measurement-duration=1h30m, preemptible=true, stabilization-duration=1h30m, warmup-duration=1h30m<br/><br/>Shorthand Syntax:<br/>{cpu-utilization-target=double, decommission-timeout=int, max-hosts-count=int, measurement-duration=duration, preemptible=bool, stabilization-duration=duration, warmup-duration=duration}<br/>Fields:<br/>cpu-utilization-target  double              — Defines an autoscaling rule based on the average CPU utilization of the instance group.<br/>decommission-timeout    int                 — Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120<br/>max-hosts-count         int                 — Upper limit for total instance subcluster count.<br/>measurement-duration    duration  required  — Time in seconds allotted for averaging metrics.<br/>preemptible             bool                — Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time<br/>if their resources are needed by Compute.<br/>For more information, see [Preemptible Virtual Machines](https://yandex.cloud/ru/docs/compute/concepts/preemptible-vm).<br/>stabilization-duration  duration            — Minimum amount of time in seconds allotted for monitoring before<br/>Instance Groups can reduce the number of instances in the group.<br/>During this time, the group size doesn't decrease, even if the new metric values<br/>indicate that it should.<br/>warmup-duration         duration            — The warmup time of the instance in seconds. During this time,<br/>traffic is sent to the instance, but instance metrics are not collected.<br/>|
|`--cluster-id`|<b>`string`</b><br/>ID of the Yandex Data Processing cluster to create a subcluster in.<br/><br/>To get a cluster ID, make a [ClusterService.List] request.|
|`--hosts-count`|<b>`int`</b><br/>Number of hosts in the subcluster.|
|`--name`|<b>`string`</b><br/>Name of the subcluster. The name must be unique within the cluster. The name can't be<br/>changed when the subcluster is created.|
|`--resources`|<b>`shorthand/json`</b><br/>Resources allocated for each host in the subcluster.<br/><br/>Example:|
|`--resources`|<b>`disk-size=1,`</b><br/>disk-type-id=value, resource-preset-id=value<br/><br/>Shorthand Syntax:<br/>{disk-size=int, disk-type-id=str, resource-preset-id=str}<br/>Fields:<br/>disk-size           int     — Volume of the storage available to a host, in bytes.<br/>disk-type-id        string  — Type of the storage environment for the host.<br/>Possible values:<br/>* network-hdd - network HDD drive,<br/>* network-ssd - network SSD drive.<br/>resource-preset-id  string  — ID of the resource preset for computational resources available to a host (CPU, memory etc.).<br/>All available presets are listed in the [documentation](https://yandex.cloud/ru/docs/data-proc/concepts/instance-types).<br/>|
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
