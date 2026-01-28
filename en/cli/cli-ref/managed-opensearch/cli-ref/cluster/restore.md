---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-opensearch/cli-ref/cluster/restore.md
---

# yc managed-opensearch cluster restore

Restore a managed OpenSearch cluster from a backup.

#### Command Usage

Syntax:

`yc managed-opensearch cluster restore`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--backup-id` | `string`

ID of the backup to use for restoring a managed OpenSearch cluster. ||
|| `--name` | `string`

Name of the OpenSearchCluster. ||
|| `--description` | `string`

Description of the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A list of labels given as key=value pairs. ||
|| `--environment` | `string`

Name of the environment wherein deploying the cluster. Supported values: 'production' (default), 'prestable'. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--security-group-names` | `value[,value]`

A comma-separated list of security group names to be used for the cluster. ||
|| `--security-group-ids` | `value[,value]`

A comma-separated list of security group IDs to be used for the cluster. ||
|| `--service-account-id` | `string`

service account id. ||
|| `--service-account-name` | `string`

ID of the service account to be used for the cluster. ||
|| `--delete-protection` | Wether to inhibit or not cluster deletion. ||
|| `--maintenance` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Cluster maintenance window configuration. It defaults to anytime maintenance schedule.

Possible property names:

- `schedule`: Cluster maintenance window schedule type. Supported values: 'anytime', 'weekly'

- `weekday`: For the weekly maintenance schedule, it specifies the day of the week (mon, tue, wed, thu, fry, sat, sun).

- `hour`: For the weekly maintenance schedule, it specifies the maintenance start hour of the day. It defaults to 0. ||
|| `--version` | `string`

OpenSearch version. ||
|| `--admin-password` | `string`

Password for entity. Usage of --read-admin-password is more secure ||
|| `--read-admin-password` | Read password for entity from input ||
|| `--generate-admin-password` | Generate random password ||
|| `--data-transfer-access` | Wether to allow or deny access to Data Transfer. ||
|| `--serverless-access` | Wether to allow or deny access to Serverless. ||
|| `--plugins` | `value[,value]`

OpenSearch plugins. ||
|| `--advanced-params` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Advanced OpenSearch configuration parameters.

Possible property names:

- `max-clause-count`: Maximum amount of clauses to use in a query.

- `fielddata-cache-size`: Data field cache size.

- `reindex-remote-whitelist`: Comma-separated list of host:port pairs indicating the remote sources to be reindexed. ||
|| `--keystore-settings` | `key=value[,key=value...]`

A comma-separated list of keystore settings given as key=value pairs. ||
|| `--opensearch-node-group` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for OpenSearch node groups.

Possible property names:

- `name`: Name of the node group to be created

- `resource-preset-id`: ID of the resource preset to use for creating the node group. (required)

- `disk-size`: Disk size to attach to the selected resource preset. (required)

- `disk-type-id`: Disk type to use with the selected resource preset. It defaults to 'network-ssd'.

- `hosts-count`: Number of hosts to be created within the node group.

- `zone-ids`: IDs of the availability zones the hosts belong to. (required)

- `subnet-names`: Names of the subnets that the hosts belong to.

- `subnet-ids`: IDs of the subnets that the hosts belong to.

- `assign-public-ip`: Determines whether a public IP is assigned to the hosts in the group.

- `roles`: Roles to be given to the hosts in the node group. Supported values: 'manager', 'data', 'data+manager' (or 'manager+data') ||
|| `--dashboards-node-group` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for Dashboards node groups.

Possible property names:

- `name`: Name of the node group to be created

- `resource-preset-id`: ID of the resource preset to use for creating the node group. (required)

- `disk-size`: Disk size to attach to the selected resource preset. (required)

- `disk-type-id`: Disk type to use with the selected resource preset. It defaults to 'network-ssd'.

- `hosts-count`: Number of hosts to be created within the node group.

- `zone-ids`: IDs of the availability zones the hosts belong to. (required)

- `subnet-names`: Names of the subnets that the hosts belong to.

- `subnet-ids`: IDs of the subnets that the hosts belong to.

- `assign-public-ip`: Determines whether a public IP is assigned to the hosts in the group. ||
|| `--disk-encryption-key-id` | `string`

ID of the KMS key for cluster disk encryption. Empty input will remove the use of encryption. ||
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