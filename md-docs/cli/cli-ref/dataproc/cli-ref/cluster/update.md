[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [dataproc](../index.md) > [cluster](index.md) > update

# yc dataproc cluster update

Modify attributes of a cluster.

#### Command Usage

Syntax:

`yc dataproc cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Cluster id. ||
|| `--name` | `string`

Cluster name. ||
|| `--new-name` | `string`

New name for the cluster. ||
|| `--description` | `string`

New description for the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--bucket` | `string`

New Object Storage bucket to be used for Data Proc jobs that are run in the cluster. ||
|| `--service-account-id` | `string`

Service-Account id. ||
|| `--service-account-name` | `string`

Service-Account name. ||
|| `--autoscaling-service-account-id` | `string`

Autoscaling-Service-Account id. ||
|| `--autoscaling-service-account-name` | `string`

Autoscaling-Service-Account name. ||
|| `--decommission-timeout` | `int`

Graceful decommission timeout in seconds. ||
|| `--ui-proxy` | Whether to enable UI Proxy feature. ||
|| `--property` | `[]string`

Properties passed to all hosts *-site.xml configurations in &lt;service&gt;:&lt;property&gt;=&lt;value&gt; format.
For example setting property 'dfs.replication' to 3 in /etc/hadoop/conf/hdfs-site.xml requires specifying --property "hdfs:dfs.replication=3"
This flag can be passed multiple times.
If you previously specified properties when creating a cluster and now want to add new ones, then you need to list the full set of properties, not just the ones that are being added. ||
|| `--security-group-ids` | `[]string`

A list of security groups for the Data Proc cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--log-group-id` | `string`

Id of a log group to write cluster logs to. ||
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