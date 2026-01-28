---
editable: false
sourcePath: en/_cli-ref/cli-ref/dataproc/cli-ref/subcluster/update.md
---

# yc dataproc subcluster update

Modify configuration or attributes of a subcluster.

#### Command Usage

Syntax:

`yc dataproc subcluster update <SUBCLUSTER-NAME>|<SUBCLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the cluster. ||
|| `--cluster-name` | `string`

Name of the cluster. ||
|| `--id` | `string`

ID of the subcluster. ||
|| `--name` | `string`

Name of the subcluster. ||
|| `--new-name` | `string`

New name for the subcluster. ||
|| `--decommission-timeout` | `int`

Graceful decommission timeout during update operation (in seconds) in case the operation will require nodes downtime. ||
|| `--resource-preset` | `string`

Preset of computational resources available to a host of a subcluster ||
|| `--disk-size` | `byteSize`

Amount of disk storage available to a host of a subcluster. ||
|| `--hosts-count` | `int`

Specifies a number of hosts in a subcluster. (Minimum number of hosts for autoscaling compute subcluster) ||
|| `--max-hosts-count` | `int`

Specifies a maximum number of hosts for autoscaling compute subcluster. ||
|| `--enable-preemptible` | Enables VMs preemption for autoscaling compute subcluster. ||
|| `--disable-preemptible` | Disables VMs preemption for autoscaling compute subcluster. ||
|| `--warmup-duration` | `duration`

Specifies a warmup duration for autoscaling compute subcluster. ||
|| `--stabilization-duration` | `duration`

Specifies a stabilization duration for autoscaling compute subcluster. ||
|| `--measurement-duration` | `duration`

Specifies a measurement duration for autoscaling compute subcluster. ||
|| `--cpu-utilization-target` | `float`

Specifies a CPU utilization threshold. In percents (10-100). When this threshold is passed the subcluster nodes number will grow. ||
|| `--autoscaling-decommission-timeout` | `int`

Specifies a decommission timeout (in seconds) for nodes during automatic downscaling. ||
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