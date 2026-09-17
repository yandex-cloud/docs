---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-clickhouse/cli-ref/v0/cluster/migrate-to-keeper/
---

# yc managed-clickhouse v0 cluster migrate-to-keeper

Migrate a ClickHouse cluster from ZooKeeper to ClickHouse Keeper.

#### Command Usage

Syntax:

`yc managed-clickhouse cluster migrate-to-keeper <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the ClickHouse cluster. ||
|| `--name` | `string`

Name of the ClickHouse cluster. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--resource-preset` | `string`

Resource preset for computational resources available to a ClickHouse Keeper host (CPU, RAM etc.). ||
|| `--disk-size` | `byteSize`

Storage volume available to a ClickHouse Keeper host. ||
|| `--disk-type` | `string`

Storage type for a ClickHouse Keeper host. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configuration of a ClickHouse Keeper host. If omitted, hosts are placed in the same zones as ClickHouse hosts.

Possible property names:

- `zone-id`: ID of the availability zone where the new host should reside.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in. ||
|| `--allow-degradation-to-read-only` | Allow the cluster to degrade to read-only during migration. ||
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