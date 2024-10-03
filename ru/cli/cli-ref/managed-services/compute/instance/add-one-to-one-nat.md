---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance/add-one-to-one-nat.md
---

# yc compute instance add-one-to-one-nat

Add one-to-one NAT to the specified network interface of virtual machine instance

#### Command Usage

Syntax: 

`yc compute instance add-one-to-one-nat <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Instance id.|
|`--name`|<b>`string`</b><br/>Instance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--network-interface-index`|<b>`string`</b><br/>Index of interface to remove one-to-one NAT.|
|`--internal-address`|<b>`string`</b><br/>Internal address of interface to remove one-to-one NAT.|
|`--nat-ip-version`|<b>`string`</b><br/>Specifies IP version for One-to-One NAT. Can be either 'ipv4' or 'ipv6'. This flag can be applied to network interfaces with ipv4 address or both addresses.|
|`--nat-address`|<b>`string`</b><br/>Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address or both addresses.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
