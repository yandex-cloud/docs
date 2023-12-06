---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-kubernetes/node-group/create.md
---

# yc managed-kubernetes node-group create

Create a node group.

#### Command Usage

Syntax: 

`yc managed-kubernetes node-group create <NODE-GROUP-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Name of the node group.|
|`--description`|<b>`string`</b><br/>New description for the node group.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>List of node group labels as key-value pairs.|
|`--cluster-id`|<b>`string`</b><br/>ID of the Kubernetes cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the Kubernetes cluster.|
|`--platform`|<b>`string`</b><br/>Specifies platform for instances in the node group.|
|`--metadata`|<b>`key=value[,key=value...]`</b><br/>Metadata for instances in the node group.|
|`--metadata-from-file`|<b>`key=value[,key=value...]`</b><br/>Same as --metadata except that the value for the entry will be read from a local file.|
|`--template-labels`|<b>`key=value[,key=value...]`</b><br/>List of platform (not Kubernetes) labels for Compute Cloud instances in the node group as key-value pairs.<br/>No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_./\\@0-9a-z]*'.|
|`--template-labels-from-file`|<b>`key=value[,key=value...]`</b><br/>Same as --template-labels except that the list of key-value pairs for the entry will be read from a local file.|
|`--public-ip`|Set when node group needs external public IP.|
|`--memory`|<b>`byteSize`</b><br/>Specifies how much memory instances should have.|
|`--cores`|<b>`int`</b><br/>Specifies how many CPU cores instances should have.|
|`--core-fraction`|<b>`int`</b><br/>Specifies baseline performance for a core in percent.|
|`--gpus`|<b>`int`</b><br/>Specifies how many GPUs instances should have.|
|`--preemptible`|Specifies if created nodes will be preemptible.|
|`--gpu-cluster-id`|<b>`string`</b><br/>Specifies if created nodes will be part of the GPU cluster.|
|`--gpu-environment`|<b>`string`</b><br/>Specifies GPU environment for created nodes. Values: 'runc-drivers-cuda', 'runc'|
|`--disk-type`|<b>`string`</b><br/>Specifies boot disk type for instances, valid values: network-ssd\|network-hdd|
|`--disk-size`|<b>`byteSize`</b><br/>Specifies boot disk size for instances.|
|`--fixed-size`|<b>`int`</b><br/>Specifies fixed scale policy size.|
|`--auto-scale`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Auto scale policy for Node Group.<br/><br/>Possible property names:<br/><ul> <li><code>min</code>:     Minimum number of nodes in the node group.</li> <li><code>max</code>:     Maximum number of nodes in the node group.</li> <li><code>initial</code>:     Initial number of nodes in the node group.</li> </ul>|
|`--location`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>List of node group locations.<br/><br/>Possible property names:<br/><ul> <li><code>subnet-id</code>:     Subnet id.</li> <li><code>subnet-name</code>:     Subnet name.</li> <li><code>zone</code>:     Zone of the subnet.</li> </ul>|
|`--version`|<b>`string`</b><br/>Node Kubernetes components version. Default depends on Cluster release channel. See available in 'yc managed-kubernetes list-versions'.|
|`--allowed-unsafe-sysctls`|<b>`value[,value]`</b><br/>List of strings containing allowed unsafe sysctls for use on nodes.|
|`--node-labels`|<b>`key=value[,key=value...]`</b><br/>Kubernetes labels that are assigned to the nodes of the node group.|
|`--node-taints`|<b>`value[,value]`</b><br/>Kubernetes taints that are applied to the nodes of the node group.|
|`--auto-upgrade`|Sets auto upgrade maintenance policy. 'true' by default.<br/>Policy defines if Node Group can be upgraded to newer version revision in specified maintenance window.<br/>Auto upgrade is 'graceful': new nodes are created, while old nodes drained by one. Please setup Pod Disruption Budget, for graceful pods drain.<br/>For details about PDB see https://kubernetes.io/docs/tasks/run-application/configure-pdb/<br/>New revision contains can contain bug and security fixes, so it's recommended to leave this policy enabled. Node Group never upgraded to another major version automatically, even with this policy set to true.<br/>Examples: '--auto-upgrade=false', '--auto-upgrade'|
|`--auto-repair`|Sets auto repair maintenance policy. 'true' by default.<br/>Policy defines if nodes seems to be broken can be recreated automatically.<br/>Examples: '--auto-repair=false', '--auto-repair'|
|`--anytime-maintenance-window`|Allow maintenance anytime. This is default maintenance window.|
|`--daily-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Allow maintenance everyday specified days of week in the specified time window.<br/><br/>Flag can be used multiple times, to define different time windows for different days of week.<br/><br/>Examples:<br/><br/>--daily-maintenance-window 'start=22:00,duration=10h<br/><br/>--daily-maintenance-window 'start=03:00,duration=8h30m<br/><br/>Possible property names:<br/><ul> <li><code>start</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'</li> <li><code>duration</code>:     Maintenance window duration in interval [1h; 24h]. Example: '12h30m'</li> </ul>|
|`--weekly-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Allow maintenance on specified days of week in the specified time window.<br/><br/>Flag can be used multiple times, to define different time windows for different days of week.<br/><br/>Examples:<br/><br/>--weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h<br/><br/>--weekly-maintenance-window 'days=weekend,start=03:00,duration=8h30m<br/><br/>Possible property names:<br/><ul> <li><code>days</code>:     List of days of the week on which maintenance is allowed in specified time window. Allowed values: weekdays, weekend, monday, tuesday, wednesday, thursday, friday, saturday, sunday, mon, tue, wed, thu, fri, sat, sun, all. Examples: 'weekend', '[weekdays,saturday]', '[monday,wednesday,friday]'</li> <li><code>start</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'</li> <li><code>duration</code>:     Maintenance window duration in interval [1h; 24h]. Example: '12h30m'</li> </ul>|
|`--max-expansion`|<b>`int`</b><br/>Number of extra nodes to be created on each upgrade of the node group.<br/>Must be used in conjunction with --max-unavailable flag.|
|`--max-unavailable`|<b>`int`</b><br/>Number of nodes that can be unavailable at the same time on each upgrade of the node group.<br/>Must be used in conjunction with --max-expansion flag.|
|`--network-interface`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Adds a network interface to the node group.<br/><br/>Possible property names:<br/><ul> <li><code>subnets</code>:     Specifies the subnets for the interface, subnets=[id1,id2],subnets=id3It is expected, that there is one subnet for each node group location zone.Can use either names or subnet ids, or both.</li> <li><code>ipv4-address</code>:     Use 'auto' to assigns internal IPv4 address to the interface.Use 'nat' to use One-to-One NAT on the interface.</li> <li><code>ipv6-address</code>:     Use 'auto' to assigns internal IPv6 address to the interface.Use 'nat' to use One-to-One NAT on the interface.</li> <li><code>security-group-ids</code>:     Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3</li> </ul>|
|`--placement-group`|<b>`string`</b><br/>Placement policy group for the node group. Can be either name or ID.|
|`--network-acceleration-type`|<b>`string`</b><br/>Type of a network acceleration for nodes. Values: 'standard', 'software-accelerated'|
|`--container-runtime`|<b>`string`</b><br/>Type of a container runtime for nodes. Values: 'docker', 'containerd'|
|`--node-name`|<b>`string`</b><br/>Name of the node.<br/>In order to be unique it must contain at least one of the instance unique placeholders like {instance_group.id}, {instance.short_id}, {instance.index}.<br/>See Compute service Instance-group metadata doc for full list.<br/>Example: --node-name=prod-node-{instance.short_id}|
|`--container-network-settings`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Container network settings for nodes.<br/><br/>Possible property names:<br/><ul> <li><code>pod-mtu</code>:     MTU for pods. Value must be in interval 1000 - 8910 if set. Can't be used on clusters with Cilium or Calico.</li> </ul>|
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
|`-h`,`--help`|Display help for the command.|
