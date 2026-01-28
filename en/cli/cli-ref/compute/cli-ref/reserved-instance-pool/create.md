---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/reserved-instance-pool/create.md
---

# yc compute reserved-instance-pool create

Create a reserved instance pool

#### Command Usage

Syntax:

`yc compute reserved-instance-pool create <RESERVED-INSTANCE-POOL-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the reserved instance pool. ||
|| `--description` | `string`

Specifies a textual description of the reserved instance pool. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--zone-id` | `string`

The zone of the reserved instance pool to create. ||
|| `--memory` | `byteSize`

Specifies how much memory instances of the reserved instance pool should have. ||
|| `--cores` | `int`

Specifies how many CPU cores instances of the reserved instance pool should have. ||
|| `--gpus` | `int`

Specifies how many GPUs instances of the reserved instance pool should have. ||
|| `--platform` | `string`

Specifies platform for the instances of the reserved instance pool. ||
|| `--gpu-cluster-id` | `string`

GPU cluster to create the instances of the reserved instance pool in. ||
|| `--gpu-cluster-name` | `string`

GPU cluster to create the instances of the reserved instance pool in. ||
|| `--network-settings` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Network settings for instances of the reserved instance pool.

Possible property names:

- `type`: Type of a network for instances of the reserved instance pool. Values: standard, software-accelerated ||
|| `--size` | `int`

Total number of instances (reserved or allocated) the reserved instance pool should have. ||
|| `--allow-oversubscription` | Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots).While running instances are still limited by available slots, stopped instances can exceed this limit.Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
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