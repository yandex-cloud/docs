---
editable: false
noIndex: true
---

# yc beta compute gpu-cluster update

Updates the specified GPU cluster.
Currently only name, description and labels can be updated.

#### Command Usage

Syntax:

`yc beta compute gpu-cluster update <GPU-CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New description of the GPU cluster. ||
|| `--gpu-cluster-id` | `string`

ID of the GPU cluster to update. To get the GPU cluster ID, make a [GpuClusterService.List] request. ||
|| `--labels` | `map<string><string>`

New GPU cluster labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [GpuClusterService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--name` | `string`

New name for the GPU cluster. The name must be unique within the folder. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#