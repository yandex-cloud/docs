---
editable: false
sourcePath: en/_cli-ref/cli-ref/vpc/cli-ref/subnet/update.md
---

# yc vpc subnet update

Modify configuration or attributes of a subnet.

#### Command Usage

Syntax:

`yc vpc subnet update <SUBNET-NAME>|<SUBNET-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Subnet id. ||
|| `--name` | `string`

Subnet name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

New name for a subnet. ||
|| `--description` | `string`

Specifies a textual description of the subnet. ||
|| `--labels` | `key=value[,key=value...]`

New set of labels for the subnet as key-value pairs. Existing set of labels will be completely overwritten. ||
|| `--route-table-id` | `string`

ID of the route table to which the subnetwork belongs. ||
|| `--route-table-name` | `string`

Name of the route table to which the subnetwork belongs. ||
|| `--disassociate-route-table` | Disassociate a route table from the subnet. ||
|| `--domain-name` | `string`

Domain name for a subnet. ||
|| `--domain-name-server` | `value[,value]`

Domain name server for a subnet. ||
|| `--ntp-server` | `value[,value]`

Ntp server for a subnet. ||
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