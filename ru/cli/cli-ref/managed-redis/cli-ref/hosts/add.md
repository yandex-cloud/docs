---
editable: false
---

# yc managed-redis hosts add

Create new hosts for the cluster in the specified availability zones

#### Command Usage

Syntax:

`yc managed-redis hosts add [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Redis cluster id. ||
|| `--cluster-name` | `string`

Redis cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Configurations for Redis hosts that should be added to the cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `assign-public-ip`: Whether the host should get a public IP address.

- `replica-priority`: Replica priority (100 by default)

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `shard-name`: Shard name host belong to. ||
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