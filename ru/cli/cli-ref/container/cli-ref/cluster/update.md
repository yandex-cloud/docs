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

#|
||Flag | Description ||
|| `--id` | `string`

ID of the Kubernetes cluster. ||
|| `--name` | `string`

Name of the Kubernetes cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the Kubernetes cluster. ||
|| `--description` | `string`

Specifies a textual description of the route table. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the Kubernetes cluster as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--default-gateway-v4-address` | `--default-gateway-v4-address`

''
DEPRECATED. IPv4 address for the Kubernetes cluster default gateway.
Feature was deprecated at service preview.
For clusters without gateway, gateway address set is not longer supported.
Existing gateway address change is supported, but deprecated.
Please use --default-gateway-v4-address '' to remove cluster gateway.
But be sure to provide internet access for the nodes: assign public IP
addresses, set up NAT gateway VM instances, or use subnet egress gateways.
Examples:
--default-gateway-v4-address ''
--default-gateway-v4-address '10.0.0.10' ||
|| `--service-account-id` | `string`

Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster. ||
|| `--service-account-name` | `string`

Service account to be used for provisioning Compute and VPC resources for the Kubernetes cluster. ||
|| `--node-service-account-id` | `string`

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| `--node-service-account-name` | `string`

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| `--version` | `string`

Kubernetes master version. See available in 'yc managed-kubernetes list-versions'. ||
|| `--latest-revision` | Update master to latest available revision of current version. Cluster.master.version_info.new_revision_available should be true. ||
|| `--auto-upgrade` | Sets auto upgrade maintenance policy.
This policy defines if the master can be upgraded to a new revision in the specified maintenance window. New revisions usually contain security and bug fixes, so it's recommended to leave this policy enabled.Master never upgraded to another major version automatically, even with this policy set to true.
Examples: '--auto-upgrade=false', '--auto-upgrade' ||
|| `--security-group-ids` | `value[,value]`

Security group IDs to use for cluster. ||
|| `--node-ipv4-mask-size` | `int`

Size of the masks that are assigned for each node in the cluster. ||
|| `--master-location` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

List of regional master locations.

Possible property names:

- `subnet-id`: Subnet id.

- `subnet-name`: Subnet name.

- `zone`: Zone of the subnet. ||
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
|| `--master-scale-policy` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Enable and configure master scale policy for cluster.

Possible property names:

- `policy`: Defines rules of scaling master instances.

- `min-resource-preset-id`: ID of computing resources preset to be used by master. ||
|| `--enable-workload-identity-federation` | Enable Workload Identity Federation for cluster. ||
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