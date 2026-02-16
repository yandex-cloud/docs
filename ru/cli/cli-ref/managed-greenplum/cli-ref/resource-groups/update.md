---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-greenplum/cli-ref/resource-groups/update.md
---

# yc managed-greenplum resource-groups update

Update resource group for specified Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum resource-groups update <RESOURCE-GROUP-NAME> [Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Greenplum cluster id. ||
|| `--cluster-name` | `string`

Greenplum cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--concurrency` | `int`

The maximum number of concurrent transactions, including active and idle transactions, that are permitted in the resource group. ||
|| `--cpu-rate-limit` | `int`

The percentage of CPU resources available to this resource group. ||
|| `--memory-limit` | `int`

The percentage of reserved memory resources available to this resource group. ||
|| `--memory-shared-quota` | `int`

The percentage of reserved memory to share across transactions submitted in this resource group. ||
|| `--memory-spill-ratio` | `int`

The memory usage threshold for memory-intensive transactions. When a transaction reaches this threshold, it spills to disk. ||
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