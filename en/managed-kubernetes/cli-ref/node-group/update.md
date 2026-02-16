---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kubernetes/cli-ref/node-group/update.md
---

# yc managed-kubernetes node-group update

Modify configuration or attributes of a node group.

#### Command Usage

Syntax:

`yc managed-kubernetes node-group update <NODE-GROUP-NAME>|<NODE-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the node group. ||
|| `--name` | `string`

Name of the node group. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name of the node group. ||
|| `--description` | `string`

New description for the node group. ||
|| `--labels` | `key=value[,key=value...]`

List of node group labels as key-value pairs. ||
|| `--node-labels` | `key=value[,key=value...]`

List of node group NODE labels as key-value pairs. ||
|| `--metadata` | `key=value[,key=value...]`

Metadata for instances in the node group. ||
|| `--metadata-from-file` | `key=value[,key=value...]`

Same as --metadata except that the value for the entry will be read from a local file. ||
|| `--template-labels` | `key=value[,key=value...]`

New list of platform (not Kubernetes) labels for Compute Cloud instances in the node group as key-value pairs. Existing list of labels will be completely overwritten.
No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_./\\@0-9a-z]*'. ||
|| `--template-labels-from-file` | `key=value[,key=value...]`

Same as --template-labels except that the list of key-value pairs for the entry will be read from a local file. ||
|| `--platform` | `string`

Specifies platform for instances in the node group. ||
|| `--memory` | `byteSize`

Specifies how much memory instances should have. ||
|| `--cores` | `int`

Specifies how many CPU cores instances should have. ||
|| `--core-fraction` | `int`

Specifies baseline performance for a core in percent. ||
|| `--gpus` | `int`

Specifies how many GPUs instances should have. ||
|| `--disk-type` | `string`

Specifies the type of the disk to create. ||
|| `--disk-size` | `byteSize`

Specifies the size of the disk. ||
|| `--preemptible` | Specifies if created nodes will be preemptible. ||
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

Node Kubernetes components version. See available in 'yc managed-kubernetes list-versions'. ||
|| `--latest-revision` | Update nodes to latest available revision of current version. NodeGroup.version_info.new_revision_available should be true. ||
|| `--auto-upgrade` | Sets auto upgrade maintenance policy.
Policy defines if Node Group can be upgraded to newer version revision in specified maintenance window.
Auto upgrade is 'graceful': new nodes are created, while old nodes drained by one. Please setup Pod Disruption Budget, for graceful pods drain.
For details about PDB see https://kubernetes.io/docs/tasks/run-application/configure-pdb/
New revision contains can contain bug and security fixes, so it's recommended to leave this policy enabled. Node Group never upgraded to another major version automatically, even with this policy set to true.
Examples: '--auto-upgrade=false', '--auto-upgrade' ||
|| `--auto-repair` | Sets auto repair maintenance policy.
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

Number of extra nodes to be created on each update of the node group.
Must be used in conjunction with --max-unavailable flag. ||
|| `--max-unavailable` | `int`

Number of nodes that can be unavailable at the same time on each update of the node group.
Must be used in conjunction with --max-expansion flag. ||
|| `--network-interface` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Update network interfaces for the node group.

Possible property names:

- `subnets`: Specifies the subnets for the interface, subnets=[id1,id2],subnets=id3It is expected, that there is one subnet for each node group location zone.Can use either names or subnet ids, or both.

- `ipv4-address`: Use 'auto' to assigns internal IPv4 address to the interface.Use 'nat' to use One-to-One NAT on the interface.

- `ipv6-address`: Use 'auto' to assigns internal IPv6 address to the interface.Use 'nat' to use One-to-One NAT on the interface.

- `security-group-ids`: Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3 ||
|| `--node-name` | `string`

Update name of the node.
In order to be unique it must contain at least one of the instance unique placeholders like {instance_group.id}, {instance.short_id}, {instance.index}.
See Compute service Instance-group metadata doc for full list.
Example: --node-name=prod-node-{instance.short_id} ||
|| `--network-acceleration-type` | `string`

Type of a network acceleration for nodes. Values: 'standard', 'software-accelerated' ||
|| `--container-runtime` | `string`

Type of a container runtime settings for nodes. Values: 'docker', 'containerd' ||
|| `--enable-workload-identity-federation` | Enable Workload Identity Federation for Node Group. ||
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