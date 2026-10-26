[Документация Yandex Cloud](../../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > [cluster](index.md) > restore

# yc managed-greenplum v0 cluster restore

Restore Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum v0 cluster restore [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--backup-id` | `string`

ID of the backup to create a cluster from. ||
|| `--time` | `timestamp`

Timestamp in RFC3339 of the moment to which the Greenplum cluster should be restored. ||
|| `--name` | `string`

Cluster name. ||
|| `--description` | `string`

Cluster description. ||
|| `--environment` | `string`

Cluster environment. Values: production, prestable. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--master-resource-preset` | `string`

ID of the preset for computational resources available on the master host. ||
|| `--master-disk-size` | `byteSize`

Volume of the storage available on the master host in GB. ||
|| `--master-disk-type` | `string`

Type of the storage environment for the master host. ||
|| `--segment-resource-preset` | `string`

ID of the preset for computational resources available on the segment host. ||
|| `--segment-disk-size` | `byteSize`

Volume of the storage available on the segment host in GB. ||
|| `--segment-disk-type` | `string`

Type of the storage environment for the segment host. ||
|| `--datalens-access` | Allow access for DataLens. ||
|| `--websql-access` | Allow access for Web SQL. ||
|| `--datatransfer-access` | Allow access for DataTransfer. ||
|| `--yandexquery-access` | Allow access for Yandex Query. ||
|| `--trino-access` | Allow access for Trino (including TLS for gpfdist). ||
|| `--backup-window-start` | `timeofday`

Start time for the daily backup in UTC timezone. Format: HH:MM:SS ||
|| `--zone-id` | `string`

Network name. ||
|| `--subnet-id` | `string`

Name of the subnet. ||
|| `--assign-public-ip` | Flag to specify if a host requires a public IP address. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--security-group-ids` | `[]string`

A list of security groups for the Greenplum cluster. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster. ||
|| `--host-group-ids` | `[]string`

A list of host groups to place VMs of cluster on. ||
|| `--segment-host-count` | `int`

Number of segment hosts. ||
|| `--segment-in-host` | `int`

Number of segments on host. ||
|| `--restore-only` | `[]string`

A list of databases and tables to restore. ||
|| `--restore-pxf` | Restore PXF settings from the original cluster. ||
|| `--restore-hba` | Restore HBA settings from the original cluster. ||
|| `--master-host-group-ids` | `[]string`

A list of host groups for Greenplum master subcluster. ||
|| `--segment-host-group-ids` | `[]string`

A list of host groups for Greenplum segment subcluster. ||
|| `--service-account` | `string`

ID of the service account used for access Yandex Cloud resources. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. ||
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