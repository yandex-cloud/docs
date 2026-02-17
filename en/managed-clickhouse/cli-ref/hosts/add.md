---
editable: false
---

# yc managed-clickhouse hosts add

Add new hosts to the cluster in specified availability zones.

#### Command Usage

Syntax:

`yc managed-clickhouse hosts add [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the ClickHouse cluster. ||
|| `--cluster-name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configurations for ClickHouse hosts that should be added to the cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the new host should reside.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Assign a public IP address to the host being added.

- `shard-name`: Host shard name.

- `type`: Type of the host to be created. Supported values: 'clickhouse', 'zookeeper'. ||
|| `--copy-schema` | Copy schema from replica ||
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