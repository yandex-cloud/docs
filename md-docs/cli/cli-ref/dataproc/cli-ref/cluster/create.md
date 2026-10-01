[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [dataproc](../index.md) > [cluster](index.md) > create

# yc dataproc cluster create

Create a cluster.

#### Command Usage

Syntax:

`yc dataproc cluster create <CLUSTER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the cluster. ||
|| `--description` | `string`

Description of the cluster. ||
|| `--zone` | `string`

ID of the availability zone where the cluster resides. ||
|| `--service-account-id` | `string`

Service-Account id. ||
|| `--service-account-name` | `string`

Service-Account name. ||
|| `--autoscaling-service-account-id` | `string`

Autoscaling-Service-Account id. ||
|| `--autoscaling-service-account-name` | `string`

Autoscaling-Service-Account name. ||
|| `--version` | `string`

Version of an image for cluster provisioning. ||
|| `--services` | `[]string`

List of used services in a cluster. If no service is specified, the default set will be used.
A list can be specified by listing services separated by commas as well as passing this flag multiple times.
Available services are: 'hdfs', 'yarn', 'mapreduce', 'hive', 'tez', 'zookeeper', 'hbase', 'sqoop', 'flume', 'spark', 'zeppelin'. ||
|| `--property` | `[]string`

Properties passed to all hosts *-site.xml configurations in &lt;service&gt;:&lt;property&gt;=&lt;value&gt; format.
For example setting property 'dfs.replication' to 3 in /etc/hadoop/conf/hdfs-site.xml requires specifying --property "hdfs:dfs.replication=3"
This flag can be passed multiple times. ||
|| `--ssh-public-keys-file` | `string`

Specify a list of SSH public keys that will be set as authorized keys to root user on cluster hosts. ||
|| `--subcluster` | `key=value[,key=value...]`

Specifies options for subclusters. Can be passed multiple times. ||
|| `--initialization-action` | `key=value[,key=value...]`

Specifies initialization action. Can be passed multiple times. ||
|| `--oslogin` | Whether to enable OSLogin feature. ||
|| `--bucket` | `string`

Object Storage bucket to be used for Data Proc jobs that are run in the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A list of cluster labels as key-value pairs. ||
|| `--ui-proxy` | Whether to enable UI Proxy feature. ||
|| `--security-group-ids` | `[]string`

A list of security groups for the Data Proc cluster. ||
|| `--host-group-ids` | `[]string`

A list of host groups to place VMs of cluster on. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--log-group-id` | `string`

Id of a log group to write cluster logs to. ||
|| `--environment` | `string`

Cluster environment. Values: production, prestable. ||
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