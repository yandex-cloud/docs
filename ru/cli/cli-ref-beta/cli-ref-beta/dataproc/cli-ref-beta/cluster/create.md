---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dataproc/cli-ref-beta/cluster/create.md
---

# yc beta dataproc cluster create

Creates a cluster in the specified folder.

#### Command Usage

Syntax: 

`yc beta dataproc cluster create <AUTOSCALING-SERVICE-ACCOUNT-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--autoscaling-service-account-id`|<b>`string`</b><br/>ID of the service account to be used by the Instance Groups service.|
|`--bucket`|<b>`string`</b><br/>Name of the Object Storage bucket to use for Yandex Data Processing jobs.|
|`--config-spec`|<b>`shorthand/json`</b><br/>Configuration and resources for hosts that should be created with the cluster.<br/><br/>Example:|
|`--config-spec`|<b>`hadoop={initialization-actions=[{args=value,`</b><br/>timeout=1, uri=value}], oslogin-enabled=true, properties={key=value}, services=HDFS, ssh-public-keys=value}, subclusters-spec=[{assign-public-ip=true, autoscaling-config={cpu-utilization-target=1.0, decommission-timeout=1, max-hosts-count=1, measurement-duration=1h30m, preemptible=true, stabilization-duration=1h30m, warmup-duration=1h30m}, hosts-count=1, name=value, resources={disk-size=1, disk-type-id=value, resource-preset-id=value}, role=MASTERNODE, subnet-id=value}], version-id=value<br/><br/>Shorthand Syntax:<br/>{hadoop={initialization-actions=[{args=str,..., timeout=int, uri=str},...], oslogin-enabled=bool, properties={key=str, key=...}, services=HDFS\|YARN\|MAPREDUCE\|HIVE\|TEZ\|ZOOKEEPER\|HBASE\|SQOOP\|FLUME\|SPARK\|ZEPPELIN\|OOZIE\|LIVY,..., ssh-public-keys=str,...}, subclusters-spec=[{assign-public-ip=bool, autoscaling-config={cpu-utilization-target=double, decommission-timeout=int, max-hosts-count=int, measurement-duration=duration, preemptible=bool, stabilization-duration=duration, warmup-duration=duration}, hosts-count=int, name=str, resources={disk-size=int, disk-type-id=str, resource-preset-id=str}, role=MASTERNODE\|DATANODE\|COMPUTENODE, subnet-id=str},...], version-id=str}<br/>Fields:<br/>hadoop            struct    — Yandex Data Processing specific options.<br/>initialization-actions  []struct            — Set of init-actions<br/>args     []string  — Arguments to the initialization action<br/>timeout  int       — Execution timeout<br/>uri      string    — URI of the executable file<br/>oslogin-enabled         bool                — Oslogin enable on cluster nodes<br/>properties              map[string,string]  — Properties set for all hosts in '*-site.xml' configurations. The key should indicate<br/>the service and the property.<br/><br/>For example, use the key 'hdfs:dfs.replication' to set the 'dfs.replication' property<br/>in the file '/etc/hadoop/conf/hdfs-site.xml'.<br/>services                []int               — Set of services used in the cluster (if empty, the default set is used).<br/>ssh-public-keys         []string            — List of public SSH keys to access to cluster hosts.<br/>subclusters-spec  []struct  — Specification for creating subclusters.<br/>assign-public-ip    bool                                             — Assign public ip addresses for all hosts in subcluter.<br/>autoscaling-config  struct                                           — Configuration for instance group based subclusters<br/>cpu-utilization-target  double              — Defines an autoscaling rule based on the average CPU utilization of the instance group.<br/>decommission-timeout    int                 — Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120<br/>max-hosts-count         int                 — Upper limit for total instance subcluster count.<br/>measurement-duration    duration  required  — Time in seconds allotted for averaging metrics.<br/>preemptible             bool                — Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time<br/>if their resources are needed by Compute.<br/>For more information, see [Preemptible Virtual Machines](https://yandex.cloud/ru/docs/compute/concepts/preemptible-vm).<br/>stabilization-duration  duration            — Minimum amount of time in seconds allotted for monitoring before<br/>Instance Groups can reduce the number of instances in the group.<br/>During this time, the group size doesn't decrease, even if the new metric values<br/>indicate that it should.<br/>warmup-duration         duration            — The warmup time of the instance in seconds. During this time,<br/>traffic is sent to the instance, but instance metrics are not collected.<br/>hosts-count         int                                              — Number of hosts in the subcluster.<br/>name                string                                           — Name of the subcluster.<br/>resources           struct                                 required  — Resource configuration for hosts in the subcluster.<br/>disk-size           int     — Volume of the storage available to a host, in bytes.<br/>disk-type-id        string  — Type of the storage environment for the host.<br/>Possible values:<br/>* network-hdd - network HDD drive,<br/>* network-ssd - network SSD drive.<br/>resource-preset-id  string  — ID of the resource preset for computational resources available to a host (CPU, memory etc.).<br/>All available presets are listed in the [documentation](https://yandex.cloud/ru/docs/data-proc/concepts/instance-types).<br/>role                enum<COMPUTENODE\|DATANODE\|MASTERNODE>  required  — Role of the subcluster in the Yandex Data Processing cluster.<br/>subnet-id           string                                 required  — ID of the VPC subnet used for hosts in the subcluster.<br/>version-id        string    — Version of the image for cluster provisioning.<br/><br/>All available versions are listed in the [documentation](https://yandex.cloud/ru/docs/data-proc/concepts/environment).<br/>|
|`--deletion-protection`|Deletion Protection inhibits deletion of the cluster|
|`--description`|<b>`string`</b><br/>Description of the cluster.|
|`--environment`|<b>`enum`</b><br/>Environment of the cluster Possible Values: 'production', 'prestable'|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a cluster in.<br/><br/>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--host-group-ids`|<b>`strings`</b><br/>Host groups to place VMs of cluster on.|
|`--labels`|<b>`stringToString`</b><br/>Cluster labels as 'key:value' pairs.|
|`--log-group-id`|<b>`string`</b><br/>ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service|
|`--name`|<b>`string`</b><br/>Name of the cluster. The name must be unique within the folder.<br/>The name can't be changed after the Yandex Data Processing cluster is created.|
|`--security-group-ids`|<b>`strings`</b><br/>User security groups.|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to be used by the Yandex Data Processing manager agent.|
|`--ui-proxy`|Enable UI Proxy feature.|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the cluster should be placed.<br/><br/>To get the list of available zones make a [yandex.cloud.compute.v1.ZoneService.List] request.|
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
