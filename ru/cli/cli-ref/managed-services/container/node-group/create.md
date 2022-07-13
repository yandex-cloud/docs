---
sourcePath: en/_cli-ref/cli-ref/managed-services/container/node-group/create.md
---
# yc container node-group create

Create a node group.

#### Command Usage

Syntax: 

`yc container node-group create <NODE-GROUP-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the node group.|
|`--description`|<b>`string`</b><br/> New description for the node group.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> List of node group labels as key-value pairs.|
|`--cluster-id`|<b>`string`</b><br/> ID of the Kubernetes cluster.|
|`--cluster-name`|<b>`string`</b><br/> Name of the Kubernetes cluster.|
|`--platform`|<b>`string`</b><br/> Specifies platform for instances in the node group.|
|`--metadata`|<b>`key=value[,key=value...]`</b><br/> Metadata for instances in the node group.|
|`--metadata-from-file`|<b>`key=value[,key=value...]`</b><br/> Same as --metadata except that the value for the entry will be read from a local file.|
|`--public-ip`| Set when node group needs external public IP.|
|`--memory`|<b>`byteSize`</b><br/> Specifies how much memory instances should have.|
|`--cores`|<b>`int`</b><br/> Specifies how many CPU cores instances should have.|
|`--core-fraction`|<b>`int`</b><br/> Specifies baseline performance for a core in percent.|
|`--gpus`|<b>`int`</b><br/> Specifies how many GPUs instances should have.|
|`--preemptible`| Specifies if created nodes will be preemptible.|
|`--disk-type`|<b>`string`</b><br/> Specifies boot disk type for instances, valid values: network-nvme|network-hdd|
|`--disk-size`|<b>`byteSize`</b><br/> Specifies boot disk size for instances.|
|`--fixed-size`|<b>`int`</b><br/> Specifies fixed scale policy size.|
|`--auto-scale`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Auto scale policy for Node Group.  Possible property names:  min Minimum number of nodes in the node group.  max Maximum number of nodes in the node group.  initial Initial number of nodes in the node group.  |
|`--location`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> List of node group locations.  Possible property names:  subnet-id Subnet id.  subnet-name Subnet name.  zone Zone of the subnet.  |
|`--version`|<b>`string`</b><br/> Node Kubernetes components version. Default depends on Cluster release channel. See available in 'yc managed-kubernetes list-versions'.|
|`--allowed-unsafe-sysctls`|<b>`value[,value]`</b><br/> List of strings containing allowed unsafe sysctls for use on nodes.|
|`--node-labels`|<b>`key=value[,key=value...]`</b><br/> Kubernetes labels that are assigned to the nodes of the node group.|
|`--node-taints`|<b>`value[,value]`</b><br/> Kubernetes taints that are applied to the nodes of the node group.|
|`--auto-upgrade`| Sets auto upgrade maintenance policy. 'true' by default. Policy defines if Node Group can be upgraded to newer version revision in specified maintenance window. Auto upgrade is 'graceful': new nodes are created, while old nodes drained by one. Please setup Pod Disruption Budget, for graceful pods drain. For details about PDB see https://kubernetes.io/docs/tasks/run-application/configure-pdb/ New revision contains can contain bug and security fixes, so it's recommended to leave this policy enabled. Node Group never upgraded to another major version automatically, even with this policy set to true. Examples: '--auto-upgrade=false', '--auto-upgrade'|
|`--auto-repair`| Sets auto repair maintenance policy. 'true' by default. Policy defines if nodes seems to be broken can be recreated automatically. Examples: '--auto-repair=false', '--auto-repair'|
|`--anytime-maintenance-window`| Allow maintenance anytime. This is default maintenance window.|
|`--daily-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Allow maintenance everyday specified days of week in the specified time window.  Flag can be used multiple times, to define different time windows for different days of week.  Examples:  --daily-maintenance-window 'start=22:00,duration=10h  --daily-maintenance-window 'start=03:00,duration=8h30m  Possible property names:  start Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'  duration Maintenance window duration in interval [1h; 24h]. Example: '12h30m'  |
|`--weekly-maintenance-window`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Allow maintenance on specified days of week in the specified time window.  Flag can be used multiple times, to define different time windows for different days of week.  Examples:  --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h  --weekly-maintenance-window 'days=weekend,start=03:00,duration=8h30m  Possible property names:  days List of days of the week on which maintenance is allowed in specified time window.  Allowed values: weekdays, weekend, monday, tuesday, wednesday, thursday, friday, saturday, sunday, mon, tue, wed, thu, fri, sat, sun, all.  Examples: 'weekend', '[weekdays,saturday]', '[monday,wednesday,friday]'  start Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'  duration Maintenance window duration in interval [1h; 24h]. Example: '12h30m'  |
|`--max-expansion`|<b>`int`</b><br/> Number of extra nodes to be created on each upgrade of the node group. Must be used in conjunction with --max-unavailable flag.|
|`--max-unavailable`|<b>`int`</b><br/> Number of nodes that can be unavailable at the same time on each upgrade of the node group. Must be used in conjunction with --max-expansion flag.|
|`--network-interface`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Adds a network interface to the node group.  Possible property names:  subnets Specifies the subnets for the interface, subnets=[id1,id2],subnets=id3It is expected, that there is one subnet for each node group location zone.Can use either names or subnet ids, or both.  ipv4-address Use 'auto' to assigns internal IPv4 address to the interface.Use 'nat' to use One-to-One NAT on the interface.  ipv6-address Use 'auto' to assigns internal IPv6 address to the interface.Use 'nat' to use One-to-One NAT on the interface.  security-group-ids Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3  |
|`--placement-group`|<b>`string`</b><br/> Placement policy group for the node group. Can be either name or ID.|
|`--network-acceleration-type`|<b>`string`</b><br/> Type of a network acceleration for nodes. Values: 'standard', 'software-accelerated'|
|`--container-runtime`|<b>`string`</b><br/> Type of a container runtime for nodes. Values: 'docker', 'containerd'|
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
