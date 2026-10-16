[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for OpenSearch](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v0](../index.md) > [cluster](index.md) > restore

# yc managed-opensearch v0 cluster restore

Restore a managed OpenSearch cluster from a backup.

#### Command Usage

Syntax:

`yc managed-opensearch v0 cluster restore`

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
|| `--security-group-names` | `[]string`

A comma-separated list of security group names to be used for the cluster. ||
|| `--security-group-ids` | `[]string`

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
|| `--plugins` | `[]string`

OpenSearch plugins. ||
|| `--advanced-params` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Advanced OpenSearch configuration parameters.

Possible property names:

- `max-clause-count`: Defines the maximum product of fields and terms that are queryable simultaneously.

- `fielddata-cache-size`: The maximum size of the field data cache.

- `search-max-buckets`: The maximum number of aggregation buckets allowed in a single response. Default is 65535

- `reindex-remote-whitelist`: Allowed remote hosts

- `http-max-initial-line-length`: Sets the maximum length allowed for HTTP URLs in the initial request line. URLs exceeding this limit will be rejected. Default is **4kb**. ||
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

- `roles`: Roles to be given to the hosts in the node group. Supported values: 'manager', 'data', 'warm', 'ingest', 'data+manager' or 'manager+data', etc. If no node groups have 'ingest' role explicitly set, then all 'data' nodes in cluster will implicitly have 'ingest' role. ||
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
|| `--audit-log` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Audit log settings

Possible property names:

- `compliance-enabled`: Enables audit logging on changes to a security index, such as changes to roles mappings and role creation or deletion.

- `log-request-body`: Includes the body of the request (if available) for both REST and the transport layer.

- `log-search-queries`: Enables indices data read requests logging.

- `log-data-modifications`: Enables indices data write request logging.

- `log-index-metadata-access`: Enables indices metadata requests logging.

- `log-monitoring-checks`: Enables monitoring data requests logging.

- `log-index-maintenance`: Enables indices maintenance requests logging, such as indices refreshes, flushes and merges.

- `log-backup-operations`: Enables snapshots and repositories requests logging.

- `log-authenticated-requests`: Enables logging of successfully authenticated REST requests.

- `log-index-events`: Enables logging of index-level events, such as creating or deleting an index.

- `log-bad-headers`: Enables logging of REST requests containing bad or spoofed security headers. ||
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