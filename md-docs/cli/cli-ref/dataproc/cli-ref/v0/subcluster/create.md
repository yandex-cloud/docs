[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [dataproc](../../index.md) > [v0](../index.md) > [subcluster](index.md) > create

# yc dataproc v0 subcluster create

Create a subcluster.

#### Command Usage

Syntax:

`yc dataproc v0 subcluster create <SUBCLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Cluster id. ||
|| `--cluster-name` | `string`

Cluster name. ||
|| `--name` | `string`

Name of a subcluster. ||
|| `--role` | `string`

Role of a subcluster ||
|| `--resource-preset` | `string`

Preset of computational resources available to a host ||
|| `--disk-type` | `string`

Type of the storage environment for a host. ||
|| `--subnet-id` | `string`

Subnet id. ||
|| `--subnet-name` | `string`

Subnet name. ||
|| `--disk-size` | `byteSize`

Amount of disk storage available to a host in GB. ||
|| `--hosts-count` | `int`

Specifies a number of hosts in a subcluster. (Minimum number of hosts for autoscaling compute subcluster) ||
|| `--max-hosts-count` | `int`

Specifies a maximum number of hosts for autoscaling compute subcluster. ||
|| `--preemptible` | Enables VMs preemption for autoscaling compute subcluster. ||
|| `--warmup-duration` | `duration`

Specifies a warmup duration for autoscaling compute subcluster. ||
|| `--stabilization-duration` | `duration`

Specifies a stabilization duration for autoscaling compute subcluster. ||
|| `--measurement-duration` | `duration`

Specifies a measurement duration for autoscaling compute subcluster. ||
|| `--cpu-utilization-target` | `float`

Specifies a CPU utilization threshold. In percents (10-100). ||
|| `--autoscaling-decommission-timeout` | `int`

Specifies a decommission timeout (in seconds) for nodes during automatic downscaling. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#