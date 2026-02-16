---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/node-group/create.md
---

# yc container node-group create

Create a node group.

#### Command Usage

Syntax:

`yc container node-group create <NODE-GROUP-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the node group. ||
|| `--description` | `string`

New description for the node group. ||
|| `--labels` | `key=value[,key=value...]`

List of node group labels as key-value pairs. ||
|| `--cluster-id` | `string`

ID of the Kubernetes cluster. ||
|| `--cluster-name` | `string`

Name of the Kubernetes cluster. ||
|| `--platform` | `string`

Specifies platform for instances in the node group. ||
|| `--metadata` | `key=value[,key=value...]`

Metadata for instances in the node group. ||
|| `--metadata-from-file` | `key=value[,key=value...]`

Same as --metadata except that the value for the entry will be read from a local file. ||
|| `--template-labels` | `key=value[,key=value...]`

List of platform (not Kubernetes) labels for Compute Cloud instances in the node group as key-value pairs.
No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_./\\@0-9a-z]*'. ||
|| `--template-labels-from-file` | `key=value[,key=value...]`

Same as --template-labels except that the list of key-value pairs for the entry will be read from a local file. ||
|| `--public-ip` | Set when node group needs external public IP. ||
|| `--memory` | `byteSize`

Specifies how much memory instances should have. ||
|| `--cores` | `int`

Specifies how many CPU cores instances should have. ||
|| `--core-fraction` | `int`

Specifies baseline performance for a core in percent. ||
|| `--gpus` | `int`

Specifies how many GPUs instances should have. ||
|| `--preemptible` | Specifies if created nodes will be preemptible. ||
|| `--gpu-cluster-id` | `string`

Specifies if created nodes will be part of the GPU cluster. ||
|| `--gpu-environment` | `string`

Specifies GPU environment for created nodes. Values: 'runc-drivers-cuda', 'runc' ||
|| `--disk-type` | `string`

Specifies boot disk type for instances, valid values: network-ssd\|network-hdd ||
|| `--disk-size` | `byteSize`

Specifies boot disk size for instances. ||
|| `--fixed-size` | `int`

Specifies fixed scale policy size. ||
|| `--auto-scale` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Auto scale policy for Node Group.

Possible property names:

- `min`: Minimum number of nodes in the node group.

- `max`: Maximum number of nodes in the node group.

- `initial`: Initial number of nodes in the node group. ||
|| `--location` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of node group locations.

Possible property names:

- `subnet-id`: Subnet id.

- `subnet-name`: Subnet name.

- `zone`: Zone of the subnet. ||
|| `--version` | `string`

Node Kubernetes components version. Default depends on Cluster release channel. See available in 'yc managed-kubernetes list-versions'. ||
|| `--allowed-unsafe-sysctls` | `value[,value]`

List of strings containing allowed unsafe sysctls for use on nodes. ||
|| `--node-labels` | `key=value[,key=value...]`

Kubernetes labels that are assigned to the nodes of the node group. ||
|| `--node-taints` | `value[,value]`

Kubernetes taints that are applied to the nodes of the node group. ||
|| `--auto-upgrade` | Sets auto upgrade maintenance policy. 'true' by default.
Policy defines if Node Group can be upgraded to newer version revision in specified maintenance window.
Auto upgrade is 'graceful': new nodes are created, while old nodes drained by one. Please setup Pod Disruption Budget, for graceful pods drain.
For details about PDB see https://kubernetes.io/docs/tasks/run-application/configure-pdb/
New revision contains can contain bug and security fixes, so it's recommended to leave this policy enabled. Node Group never upgraded to another major version automatically, even with this policy set to true.
Examples: '--auto-upgrade=false', '--auto-upgrade' ||
|| `--auto-repair` | Sets auto repair maintenance policy. 'true' by default.
Policy defines if nodes seems to be broken can be recreated automatically.
Examples: '--auto-repair=false', '--auto-repair' ||
|| `--anytime-maintenance-window` | Allow maintenance anytime. This is default maintenance window. ||
|| `--daily-maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Allow maintenance everyday specified days of week in the specified time window.

Flag can be used multiple times, to define different time windows for different days of week.

Examples:

    --daily-maintenance-window 'start=22:00,duration=10h

    --daily-maintenance-window 'start=03:00,duration=8h30m

Possible property names:

- `start`: Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'

- `duration`: Maintenance window duration in interval [1h; 24h]. Example: '12h30m' ||
|| `--weekly-maintenance-window` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Allow maintenance on specified days of week in the specified time window.

Flag can be used multiple times, to define different time windows for different days of week.

Examples:

    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h

    --weekly-maintenance-window 'days=weekend,start=03:00,duration=8h30m

Possible property names:

- `days`: List of days of the week on which maintenance is allowed in specified time window.

- `Allowed values: weekdays, weekend, monday, tuesday, wednesday, thursday, friday, saturday, sunday, mon, tue, wed, thu, fri, sat, sun, all.`: 
- `Examples: 'weekend', '[weekdays,saturday]', '[monday,wednesday,friday]'`: 
- `start`: Time of day in UTC time zone, HH:MM 24-hour clock format, since when maintenance operations are allowed. Example: '02:30'

- `duration`: Maintenance window duration in interval [1h; 24h]. Example: '12h30m' ||
|| `--max-expansion` | `int`

Number of extra nodes to be created on each upgrade of the node group.
Must be used in conjunction with --max-unavailable flag. ||
|| `--max-unavailable` | `int`

Number of nodes that can be unavailable at the same time on each upgrade of the node group.
Must be used in conjunction with --max-expansion flag. ||
|| `--network-interface` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Adds a network interface to the node group.

Possible property names:

- `subnets`: Specifies the subnets for the interface, subnets=[id1,id2],subnets=id3It is expected, that there is one subnet for each node group location zone.Can use either names or subnet ids, or both.

- `ipv4-address`: Use 'auto' to assigns internal IPv4 address to the interface.Use 'nat' to use One-to-One NAT on the interface.

- `ipv6-address`: Use 'auto' to assigns internal IPv6 address to the interface.Use 'nat' to use One-to-One NAT on the interface.

- `security-group-ids`: Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3 ||
|| `--placement-group` | `string`

Placement policy group for the node group. Can be either name or ID. ||
|| `--network-acceleration-type` | `string`

Type of a network acceleration for nodes. Values: 'standard', 'software-accelerated' ||
|| `--container-runtime` | `string`

Type of a container runtime for nodes. Values: 'docker', 'containerd' ||
|| `--node-name` | `string`

Name of the node.
In order to be unique it must contain at least one of the instance unique placeholders like {instance_group.id}, {instance.short_id}, {instance.index}.
See Compute service Instance-group metadata doc for full list.
Example: --node-name=prod-node-{instance.short_id} ||
|| `--container-network-settings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Container network settings for nodes.

Possible property names:

- `pod-mtu`: MTU for pods.

- `Value must be in interval 1000 - 8910 if set.`: 
- `Can't be used on clusters with Cilium or Calico.`:  ||
|| `--enable-workload-identity-federation` | Enable Workload Identity Federation for Node Group. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#