---
editable: false
noIndex: true
---

# yc beta dataproc subcluster update

Updates the specified subcluster.

#### Command Usage

Syntax:

`yc beta dataproc subcluster update <SUBCLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--autoscaling-config` | `shorthand/json`

Configuration for instance group based subclusters

Shorthand Syntax:

```hcl
{
  cpu-utilization-target = float64,
  decommission-timeout = integer,
  max-hosts-count = integer,
  measurement-duration = duration,
  preemptible = boolean,
  stabilization-duration = duration,
  warmup-duration = duration
}
```

JSON Syntax:

```json
{
  "cpu-utilization-target": "float64",
  "decommission-timeout": "integer",
  "max-hosts-count": "integer",
  "measurement-duration": "duration",
  "preemptible": "boolean",
  "stabilization-duration": "duration",
  "warmup-duration": "duration"
}
```

Fields:

```
cpu-utilization-target -> (float64)
  Defines an autoscaling rule based on the average CPU utilization of the instance group.
decommission-timeout -> (integer)
  Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120
max-hosts-count -> (integer)
  Upper limit for total instance subcluster count.
measurement-duration -> (duration)
  Time in seconds allotted for averaging metrics.
preemptible -> (boolean)
  Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see documentation.
stabilization-duration -> (duration)
  Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.
warmup-duration -> (duration)
  The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.
``` ||
|| `--cluster-id` | `string`

ID of the cluster to update a subcluster in. To get a cluster ID, make a [ClusterService.List] request. ||
|| `--decommission-timeout` | `int`

Timeout to gracefully decommission nodes. In seconds. Default value: 0 ||
|| `--hosts-count` | `int`

New number of hosts in the subcluster. ||
|| `--name` | `string`

New name for the subcluster. The name must be unique within the cluster. ||
|| `--resources` | `shorthand/json`

New configuration of resources that should be allocated for each host in the subcluster.

Shorthand Syntax:

```hcl
{
  disk-size = integer,
  disk-type-id = string,
  resource-preset-id = string
}
```

JSON Syntax:

```json
{
  "disk-size": "integer",
  "disk-type-id": "string",
  "resource-preset-id": "string"
}
```

Fields:

```
disk-size -> (integer)
  Volume of the storage available to a host, in bytes.
disk-type-id -> (string)
  Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive.
resource-preset-id -> (string)
  ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
``` ||
|| `--subcluster-id` | `string`

ID of the subcluster to update. To get a subcluster ID, make a [SubclusterService.List] request. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#