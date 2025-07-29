---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kubernetes/cli-ref/cluster/create.md
---

# yc managed-kubernetes cluster create

Create a Kubernetes cluster.

#### Command Usage

Syntax: 

`yc managed-kubernetes cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the Kubernetes cluster.|
|`--description`|<b>`string`</b><br/>New description for the Kubernetes cluster.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>List of Kubernetes cluster labels as key-value pairs.|
|`--zone`|<b>`string`</b><br/>ID of the availability zone where the Kubernetes cluster zonal master resides.|
|`--cluster-ipv4-range`|<b>`string`</b><br/>IPv4 range for the Kubernetes cluster pods in CIDR notation.|
|`--service-ipv4-range`|<b>`string`</b><br/>IPv4 range for the Kubernetes cluster services in CIDR notation.|
|`--cluster-ipv6-range`|<b>`string`</b><br/>IPv6 range for the Kubernetes cluster pods in CIDR notation. IPv6 only clusters aren't yet supported, specifying this flag is only valid as a part of a dual IPv4/IPv6 stack cluster creation|
|`--service-ipv6-range`|<b>`string`</b><br/>IPv6 range for the Kubernetes cluster services in CIDR notation. IPv6 only clusters aren't yet supported, specifying this flag is only valid as a part of a dual IPv4/IPv6 stack cluster creation|
|`--dual-stack`|Create a dual IPv4/IPv6 stack cluster. Specifying this flag will attempt an automatic choice of both IPv4/IPv6 cluster and service CIDRs.|
|`--node-ipv4-mask-size`|<b>`int`</b><br/>Size of the masks that are assigned for each node in the cluster.|
|`--subnet-id`|<b>`string`</b><br/>Subnet id.|
|`--subnet-name`|<b>`string`</b><br/>Subnet name.|
|`--public-ip`|Set when the Kubernetes cluster needs an external IPv4.|
|`--regional`|Create highly available master for the cluster. Master will be distributed across 3 instances. Equal to --etcd-cluster-size=3|
|`--region`|<b>`string`</b><br/>ID of the region where regional Kubernetes cluster resides|
|`--master-location`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of regional master locations.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-id</code>:     Subnet id.</li> <li><code>subnet-name</code>:     Subnet name.</li> <li><code>zone</code>:     Zone of the subnet.</li> </ul>|
|`--etcd-cluster-size`|<b>`int`</b><br/>Number of master instances. Can be equal 1 or 3.|
|`--release-channel`|<b>`string`</b><br/>Master and Node Groups release channel. Every release channel have it's own list of available versions and new revisions release policy.<br/>* 'regular' used by default. It usually have one or two stable kubernetes versions available. It's new revisions contains bug and security fixes, but also can contain new well tested features.<br/>* 'rapid' is less stable, but receives new features earlier. Usually have most new kubernetes version available.<br/>* 'stable' is most stable, but it's new revisions contains only critical bug and security fixes.|
|`--version`|<b>`string`</b><br/>Kubernetes master version. Default depends on release channel. See available in 'yc managed-kubernetes list-versions'.|
|`--enable-network-policy`|Enable network policy enforcement for the cluster. Calico network policy controller will be used.|
|`--service-account-id`|<b>`string`</b><br/>Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster.|
|`--service-account-name`|<b>`string`</b><br/>Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster.|
|`--node-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.|
|`--node-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.|
|`--auto-upgrade`|Sets auto upgrade maintenance policy. 'true' by default.<br/>This policy defines if the master can be upgraded to a new revision in the specified maintenance window. New revisions usually contain security and bug fixes, so it's recommended to leave this policy enabled.Master never upgraded to another major version automatically, even with this policy set to true.<br/>Examples: '--auto-upgrade=false', '--auto-upgrade'|
|`--anytime-maintenance-window`|Allow maintenance anytime. This is default maintenance window.|
|`--daily-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Allow maintenance everyday specified days of week in the specified time window.<br/><br/>Flag can be used multiple times, to define different time windows for different days of week.<br/><br/>Examples:<br/><br/>--daily-maintenance-window 'start=22:00,duration=10h<br/><br/>--daily-maintenance-window 'start=03:00,duration=8h30m<br/><br/>Possible property names:<br/><ul> <li><code>start</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'</li> <li><code>duration</code>:     Maintenance window duration in interval [1h; 24h]. Example: '12h30m'</li> </ul>|
|`--weekly-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Allow maintenance on specified days of week in the specified time window.<br/><br/>Flag can be used multiple times, to define different time windows for different days of week.<br/><br/>Examples:<br/><br/>--weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h<br/><br/>--weekly-maintenance-window 'days=weekend,start=03:00,duration=8h30m<br/><br/>Possible property names:<br/><ul> <li><code>days</code>:     List of days of the week on which maintenance is allowed in specified time window. Allowed values: weekdays, weekend, monday, tuesday, wednesday, thursday, friday, saturday, sunday, mon, tue, wed, thu, fri, sat, sun, all. Examples: 'weekend', '[weekdays,saturday]', '[monday,wednesday,friday]'</li> <li><code>start</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'</li> <li><code>duration</code>:     Maintenance window duration in interval [1h; 24h]. Example: '12h30m'</li> </ul>|
|`--kms-key-id`|<b>`string`</b><br/>KMS key for Kubernetes secrets encryption.|
|`--kms-key-name`|<b>`string`</b><br/>KMS key for Kubernetes secrets encryption.|
|`--security-group-ids`|<b>`value[,value]`</b><br/>Security group IDs to use for cluster.|
|`--master-logging`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Configures the logging of Kubernetes master components' logs to Yandex Cloud Logging.<br/><br/>Possible property names:<br/><ul> <li><code>enabled</code>:     Enables sending of master components' logs to Yandex Cloud Logging.</li> <li><code>log-group-id</code>:     Sets the ID of Yandex Cloud Logging Log group to send logs to.</li> <li><code>folder-id</code>:     Sets the ID of the folder to send logs to it's default Log group.</li> <li><code>kube-apiserver-enabled</code>:     Enables sending of kube-apiserver logs to Yandex Cloud Logging.</li> <li><code>cluster-autoscaler-enabled</code>:     Enables sending of cluster-autoscaler logs to Yandex Cloud Logging.</li> <li><code>events-enabled</code>:     Enables sending of Kubernetes events to Yandex Cloud Logging.</li> <li><code>audit-enabled</code>:     Enables sending of Kubernetes audit logs to Yandex Cloud Logging.</li> </ul>|
|`--cilium`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...][=`</b><br/>]<br/>Enable and configure cilium CNI for cluster.<br/>Possible property names:<br/>|
|`--master-scale-policy`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Enable and configure master scale policy for cluster.<br/><br/>Possible property names:<br/><ul> <li><code>policy</code>:     Defines rules of scaling master instances.</li> <li><code>min-resource-preset-id</code>:     ID of computing resources preset to be used by master.</li> </ul>|
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
