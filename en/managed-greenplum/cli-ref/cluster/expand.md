---
editable: false
---

# yc managed-greenplum cluster expand

Expands the specified Greenplum cluster

#### Command Usage

Syntax:

`yc managed-greenplum cluster expand <CLUSTER-NAME>|<CLUSTER-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--segment-host-count` | `int`

Number of hosts for add to the segment subcluster. Default is 1. ||
|| `--add-segments-per-host-count` | `int`

Number of segments per host to add. Default is 1. ||
|| `--duration-seconds` | `int`

Redistribute duration, in seconds. Default is 2 hours (7200 seconds) ||
|| `--parallel` | `int`

Redistribute process parallelilsm. Default is 0 for autodetection ||
|| `--close-cluster` | Deny all client connections during the expand operation ||
|| `--delay-redistribution` | Perfrom redistribution process by small chunks as background activity ||
|| `--id` | `string`

Greenplum cluster id. ||
|| `--name` | `string`

Greenplum cluster name. ||
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