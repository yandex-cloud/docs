---
editable: false
---

# yc compute instance remove-one-to-one-nat

Remove one-to-one NAT to the specified network interface of virtual machine instance

#### Command Usage

Syntax:

`yc compute instance remove-one-to-one-nat <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--network-interface-index` | `string`

Index of interface to attach one-to-one NAT. ||
|| `--internal-address` | `string`

Internal address of interface to attach one-to-one NAT. ||
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