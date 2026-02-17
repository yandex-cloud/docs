---
editable: false
---

# yc managed-sharded-postgresql cluster add-subcluster

Add a new subcluster to the specified Sharded PostgreSQL cluster

#### Command Usage

Syntax:

`yc managed-sharded-postgresql cluster add-subcluster [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Sharded PostgreSQL cluster id. ||
|| `--cluster-name` | `string`

Sharded PostgreSQL cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--host` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Individual configurations for hosts that should be created for the Sharded PostgreSQL cluster.

Possible property names:

- `zone-id`: ID of the availability zone where the host resides.

- `subnet-id`: ID of the subnet that the host should be created in.

- `subnet-name`: Name of the subnet that the host should be created in.

- `assign-public-ip`: Whether the host should get a public IP address on creation.

- `type`: Type of the host Values: 'router', 'coordinator', 'infra', 'postgresql', 'external-postgresql', 'mdb-postgresql' ||
|| `--resource-preset` | `string`

ID of the preset for computational resources available to a host (CPU, memory etc.). ||
|| `--disk-size` | `byteSize`

Volume of the storage available to a host in GB. ||
|| `--disk-type` | `string`

Type of the storage environment for the host. ||
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