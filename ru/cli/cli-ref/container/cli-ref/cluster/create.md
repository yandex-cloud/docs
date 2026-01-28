---
editable: false
sourcePath: en/_cli-ref/cli-ref/container/cli-ref/cluster/create.md
---

# yc container cluster create

Create a Kubernetes cluster.

#### Command Usage

Syntax:

`yc container cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the Kubernetes cluster. ||
|| `--description` | `string`

New description for the Kubernetes cluster. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--labels` | `key=value[,key=value...]`

List of Kubernetes cluster labels as key-value pairs. ||
|| `--zone` | `string`

ID of the availability zone where the Kubernetes cluster zonal master resides. ||
|| `--cluster-ipv4-range` | `string`

IPv4 range for the Kubernetes cluster pods in CIDR notation. ||
|| `--service-ipv4-range` | `string`

IPv4 range for the Kubernetes cluster services in CIDR notation. ||
|| `--cluster-ipv6-range` | `string`

IPv6 range for the Kubernetes cluster pods in CIDR notation. IPv6 only clusters aren't yet supported, specifying this flag is only valid as a part of a dual IPv4/IPv6 stack cluster creation ||
|| `--service-ipv6-range` | `string`

IPv6 range for the Kubernetes cluster services in CIDR notation. IPv6 only clusters aren't yet supported, specifying this flag is only valid as a part of a dual IPv4/IPv6 stack cluster creation ||
|| `--dual-stack` | Create a dual IPv4/IPv6 stack cluster. Specifying this flag will attempt an automatic choice of both IPv4/IPv6 cluster and service CIDRs. ||
|| `--node-ipv4-mask-size` | `int`

Size of the masks that are assigned for each node in the cluster. ||
|| `--subnet-id` | `string`

Subnet id. ||
|| `--subnet-name` | `string`

Subnet name. ||
|| `--public-ip` | Set when the Kubernetes cluster needs an external IPv4. ||
|| `--regional` | Create highly available master for the cluster. Master will be distributed across 3 instances. Equal to --etcd-cluster-size=3 ||
|| `--region` | `string`

ID of the region where regional Kubernetes cluster resides ||
|| `--master-location` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of regional master locations.

Possible property names:

- `subnet-id`: Subnet id.

- `subnet-name`: Subnet name.

- `zone`: Zone of the subnet. ||
|| `--etcd-cluster-size` | `int`

Number of master instances. Can be equal 1 or 3. ||
|| `--release-channel` | `string`

Master and Node Groups release channel. Every release channel have it's own list of available versions and new revisions release policy.
* 'regular' used by default. It usually have one or two stable kubernetes versions available. It's new revisions contains bug and security fixes, but also can contain new well tested features.
* 'rapid' is less stable, but receives new features earlier. Usually have most new kubernetes version available.
* 'stable' is most stable, but it's new revisions contains only critical bug and security fixes. ||
|| `--version` | `string`

Kubernetes master version. Default depends on release channel. See available in 'yc managed-kubernetes list-versions'. ||
|| `--enable-network-policy` | Enable network policy enforcement for the cluster. Calico network policy controller will be used. ||
|| `--service-account-id` | `string`

Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster. ||
|| `--service-account-name` | `string`

Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster. ||
|| `--node-service-account-id` | `string`

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| `--node-service-account-name` | `string`

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| `--auto-upgrade` | Sets auto upgrade maintenance policy. 'true' by default.
This policy defines if the master can be upgraded to a new revision in the specified maintenance window. New revisions usually contain security and bug fixes, so it's recommended to leave this policy enabled.Master never upgraded to another major version automatically, even with this policy set to true.
Examples: '--auto-upgrade=false', '--auto-upgrade' ||
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
|| `--kms-key-id` | `string`

KMS key for Kubernetes secrets encryption. ||
|| `--kms-key-name` | `string`

KMS key for Kubernetes secrets encryption. ||
|| `--security-group-ids` | `value[,value]`

Security group IDs to use for cluster. ||
|| `--master-logging` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configures the logging of Kubernetes master components' logs to Yandex Cloud Logging.

Possible property names:

- `enabled`: Enables sending of master components' logs to Yandex Cloud Logging.

- `log-group-id`: Sets the ID of Yandex Cloud Logging Log group to send logs to.

- `folder-id`: Sets the ID of the folder to send logs to it's default Log group.

- `kube-apiserver-enabled`: Enables sending of kube-apiserver logs to Yandex Cloud Logging.

- `cluster-autoscaler-enabled`: Enables sending of cluster-autoscaler logs to Yandex Cloud Logging.

- `events-enabled`: Enables sending of Kubernetes events to Yandex Cloud Logging.

- `audit-enabled`: Enables sending of Kubernetes audit logs to Yandex Cloud Logging. ||
|| `--cilium` | `PROPERTY=VALUE[,PROPERTY=VALUE...][=`

]
Enable and configure cilium CNI for cluster.
Possible property names: ||
|| `--master-scale-policy` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Enable and configure master scale policy for cluster.

Possible property names:

- `policy`: Defines rules of scaling master instances.

- `min-resource-preset-id`: ID of computing resources preset to be used by master. ||
|| `--enable-workload-identity-federation` | Enable Workload Identity Federation for cluster. ||
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