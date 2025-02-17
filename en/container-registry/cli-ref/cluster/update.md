---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/cluster/update.md
---

# yc container cluster update

Modify configuration or attributes of a Kubernetes cluster.

#### Command Usage

Syntax: 

`yc container cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>ID of the Kubernetes cluster.|
|`--name`|<b>`string`</b><br/>Name of the Kubernetes cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>A new name of the Kubernetes cluster.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the route table.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New set of labels for the Kubernetes cluster as key-value pairs. Existing set of labels will be completely overwritten.|
|`--default-gateway-v4-address`|<b>`--default-gateway-v4-address`</b><br/>''<br/>DEPRECATED. IPv4 address for the Kubernetes cluster default gateway.<br/>Feature was deprecated at service preview.<br/>For clusters without gateway, gateway address set is not longer supported.<br/>Existing gateway address change is supported, but deprecated.<br/>Please use --default-gateway-v4-address '' to remove cluster gateway.<br/>But be sure to provide internet access for the nodes: assign public IP<br/>addresses, set up NAT gateway VM instances, or use subnet egress gateways.<br/>Examples:<br/>--default-gateway-v4-address ''<br/>--default-gateway-v4-address '10.0.0.10'|
|`--service-account-id`|<b>`string`</b><br/>Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster.|
|`--service-account-name`|<b>`string`</b><br/>Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster.|
|`--node-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.|
|`--node-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.|
|`--version`|<b>`string`</b><br/>Kubernetes master version. See available in 'yc managed-kubernetes list-versions'.|
|`--latest-revision`|Update master to latest available revision of current version. Cluster.master.version_info.new_revision_available should be true.|
|`--auto-upgrade`|Sets auto upgrade maintenance policy.<br/>This policy defines if the master can be upgraded to a new revision in the specified maintenance window. New revisions usually contain security and bug fixes, so it's recommended to leave this policy enabled.Master never upgraded to another major version automatically, even with this policy set to true.<br/>Examples: '--auto-upgrade=false', '--auto-upgrade'|
|`--security-group-ids`|<b>`value[,value]`</b><br/>Security group IDs to use for cluster.|
|`--node-ipv4-mask-size`|<b>`int`</b><br/>Size of the masks that are assigned for each node in the cluster.|
|`--master-location`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of regional master locations.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-id</code>:     Subnet id.</li> <li><code>subnet-name</code>:     Subnet name.</li> <li><code>zone</code>:     Zone of the subnet.</li> </ul>|
|`--anytime-maintenance-window`|Allow maintenance anytime. This is default maintenance window.|
|`--daily-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Allow maintenance everyday specified days of week in the specified time window.<br/><br/>Flag can be used multiple times, to define different time windows for different days of week.<br/><br/>Examples:<br/><br/>--daily-maintenance-window 'start=22:00,duration=10h<br/><br/>--daily-maintenance-window 'start=03:00,duration=8h30m<br/><br/>Possible property names:<br/><ul> <li><code>start</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'</li> <li><code>duration</code>:     Maintenance window duration in interval [1h; 24h]. Example: '12h30m'</li> </ul>|
|`--weekly-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Allow maintenance on specified days of week in the specified time window.<br/><br/>Flag can be used multiple times, to define different time windows for different days of week.<br/><br/>Examples:<br/><br/>--weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h<br/><br/>--weekly-maintenance-window 'days=weekend,start=03:00,duration=8h30m<br/><br/>Possible property names:<br/><ul> <li><code>days</code>:     List of days of the week on which maintenance is allowed in specified time window. Allowed values: weekdays, weekend, monday, tuesday, wednesday, thursday, friday, saturday, sunday, mon, tue, wed, thu, fri, sat, sun, all. Examples: 'weekend', '[weekdays,saturday]', '[monday,wednesday,friday]'</li> <li><code>start</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'</li> <li><code>duration</code>:     Maintenance window duration in interval [1h; 24h]. Example: '12h30m'</li> </ul>|
|`--master-logging`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Configures the logging of Kubernetes master components' logs to Yandex Cloud Logging.<br/><br/>Possible property names:<br/><ul> <li><code>enabled</code>:     Enables sending of master components' logs to Yandex Cloud Logging.</li> <li><code>log-group-id</code>:     Sets the ID of Yandex Cloud Logging Log group to send logs to.</li> <li><code>folder-id</code>:     Sets the ID of the folder to send logs to it's default Log group.</li> <li><code>kube-apiserver-enabled</code>:     Enables sending of kube-apiserver logs to Yandex Cloud Logging.</li> <li><code>cluster-autoscaler-enabled</code>:     Enables sending of cluster-autoscaler logs to Yandex Cloud Logging.</li> <li><code>events-enabled</code>:     Enables sending of Kubernetes events to Yandex Cloud Logging.</li> <li><code>audit-enabled</code>:     Enables sending of Kubernetes audit logs to Yandex Cloud Logging.</li> </ul>|

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
