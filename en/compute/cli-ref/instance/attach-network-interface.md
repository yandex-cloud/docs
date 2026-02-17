---
editable: false
---

# yc compute instance attach-network-interface

Attach the specified network interface to the virtual machine instance

#### Command Usage

Syntax:

`yc compute instance attach-network-interface <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--network-interface-index` | `string`

Index of interface to attach. ||
|| `--subnet-id` | `string`

ID of the subnet to attach the interface to. ||
|| `--subnet-name` | `string`

Name of the subnet to attach the interface to. ||
|| `--ipv4-address` | `string`

Assigns the given internal IPv4 address to the interface that is attached. If 'auto' used as value, some unassigned address from the subnet is used. ||
|| `--nat-ip-version` | `string`

Specifies IP version for One-to-One NAT. Can be either 'ipv4' or 'ipv6'. This flag can be applied to network interfaces with ipv4 address or both addresses. ||
|| `--nat-address` | `string`

Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address or both addresses. ||
|| `--security-group-id` | `value[,value]`

Security groups for the network interface, --security-group-id id1 --security-group-id=id2 ||
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