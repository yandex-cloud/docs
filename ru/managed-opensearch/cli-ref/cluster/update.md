---
editable: false
---

# yc managed-opensearch cluster update

Update a managed OpenSearchCluster.

#### Command Usage

Syntax:

`yc managed-opensearch cluster update <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--id` | `string`

ID of the OpenSearch cluster. ||
|| `--name` | `string`

Name of the OpenSearch cluster. ||
|| `--max-clause-count` | `int`

Maximum amount of clauses to use in a query. ||
|| `--fielddata-cache-size` | `string`

Data field cache size. ||
|| `--reindex-remote-whitelist` | `value[,value]`

Comma-separated list of host:port pairs indicating the remote sources to be reindexed. ||
|| `--snapshot-schedule` | `string`

Snapshot schedule type. Supported: 'hourly', 'daily', 'weekly'. Leave empty for default settings. ||
|| `--snapshot-day` | `string`

For weekly schedule, the day of the week ('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun') to start snapshot. ||
|| `--snapshot-hour` | `int`

For daily/weekly schedule, the hour (0-23) of the day ) to start snapshot. ||
|| `--snapshot-minute` | `int`

For any schedule, the minute (0-59) of the hour to start snapshot. ||
|| `--snapshot-max-age-days` | `int`

Max snapshot age in days. 7 days minimum. ||
|| `--new-name` | `string`

Name of the cluster. ||
|| `--description` | `string`

Description of the cluster. ||
|| `--labels` | `key=value[,key=value...]`

A list of labels given as key=value pairs. ||
|| `--security-group-names` | `value[,value]`

A comma-separated list of security group names to be used for the cluster. ||
|| `--security-group-ids` | `value[,value]`

A comma-separated list of security group IDs to be used for the cluster. ||
|| `--service-account-id` | `string`

service account id. ||
|| `--service-account-name` | `string`

ID of the service account to be used for the cluster. ||
|| `--delete-protection` | `string`

Wether to inhibit or not cluster deletion. Supported values: 'true' or 'false' ||
|| `--maintenance` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Cluster maintenance window configuration. It defaults to anytime maintenance schedule.

Possible property names:

- `schedule`: Cluster maintenance window schedule type. Supported values: 'anytime', 'weekly'

- `weekday`: For the weekly maintenance schedule, it specifies the day of the week (mon, tue, wed, thu, fry, sat, sun).

- `hour`: For the weekly maintenance schedule, it specifies the maintenance start hour of the day. It defaults to 0. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--version` | `string`

OpenSearch version. ||
|| `--admin-password` | `string`

New password for entity. It is not secure to specify password in command line. To avoid it you can omit this flag and enter password when prompted. ||
|| `--generate-admin-password` | Generate random password ||
|| `--data-transfer-access` | `string`

Wether to allow or deny access to Data Transfer. ||
|| `--serverless-access` | `string`

Wether to allow or deny access to Serverless. ||
|| `--plugins` | `value[,value]`

OpenSearch plugins. ||
|| `--set-keystore-settings` | `key=value[,key=value...]`

A comma-separated list of keystore settings to add/replace given as key=value pairs. Old entries not listed here will be left unchanged. ||
|| `--remove-keystore-settings` | `value[,value]`

A comma-separated list of keystore settings to remove. ||
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