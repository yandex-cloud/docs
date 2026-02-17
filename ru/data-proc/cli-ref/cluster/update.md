---
editable: false
---

# yc dataproc cluster update

Modify attributes of a cluster.

#### Command Usage

Syntax:

`yc dataproc cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the cluster. ||
|| `--name` | `string`

Name of the cluster. ||
|| `--new-name` | `string`

New name for the cluster. ||
|| `--description` | `string`

New description for the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A new set of cluster labels as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--bucket` | `string`

New Object Storage bucket to be used for Data Proc jobs that are run in the cluster. ||
|| `--decommission-timeout` | `int`

Graceful decommission timeout in seconds. ||
|| `--ui-proxy` | Whether to enable UI Proxy feature. ||
|| `--property` | `value[,value]`

Properties passed to all hosts *-site.xml configurations in &lt;service&gt;:&lt;property&gt;=&lt;value&gt; format.
For example setting property 'dfs.replication' to 3 in /etc/hadoop/conf/hdfs-site.xml requires specifying --property "hdfs:dfs.replication=3"
This flag can be passed multiple times.
If you previously specified properties when creating a cluster and now want to add new ones, then you need to list the full set of properties, not just the ones that are being added. ||
|| `--security-group-ids` | `value[,value]`

A list of security groups for the Data Proc cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--service-account-id` | `string`

New service account id. ||
|| `--service-account-name` | `string`

New service account name. ||
|| `--autoscaling-service-account-id` | `string`

New autoscaling service account id. ||
|| `--autoscaling-service-account-name` | `string`

New autoscaling service account name. ||
|| `--log-group-id` | `string`

Id of a log group to write cluster logs to. ||
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