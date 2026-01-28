---
editable: false
sourcePath: en/_cli-ref/cli-ref/compute/cli-ref/instance/relocate.md
---

# yc compute instance relocate

Relocate the specified virtual machine instance to the zone

#### Command Usage

Syntax:

`yc compute instance relocate <INSTANCE-NAME>|<INSTANCE-ID> [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Instance id. ||
|| `--name` | `string`

Instance name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--destination-zone-id` | `string`

The zone to relocate to. ||
|| `--network-interface` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Reconfigure network interface of the instance.

Possible property names:

- `subnet-name`: Specifies the subnet that the interface will be part of.

- `subnet-id`: Specifies the ID of the subnet that the interface will be part of.

- `address`: Assigns the given internal address to the instance that is created. If no address is specified, some unassigned address from the subnet is used.

- `ipv4-address`: Assigns the given internal IPv4 address to the instance that is created. If 'auto' used as value, some unassigned address from the subnet is used.

- `nat-ip-version`: Specifies IP version for One-to-One NAT. Can be 'ipv4'. This flag can be applied to network interfaces with ipv4 address.

- `nat-address`: Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address.

- `security-group-ids`: Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3

- `dns-record-spec`: DNS records in format {name=&lt;name&gt;[,ttl=&lt;ttl&gt;][,dns-zone-id=&lt;id&gt;][,ptr={true\|false}]} ||
|| `--boot-disk-placement-group-id` | `string`

Placement group to move boot disk to. ||
|| `--boot-disk-placement-group-name` | `string`

Placement group to move boot disk to. ||
|| `--boot-disk-placement-group-partition` | `int`

Placement group partition. Used when a placement group is created with the partition strategy. ||
|| `--secondary-disk-placement` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Target placement policies for secondary disks.

Possible property names:

- `disk-name`: The disk which placement policy is to be changes.

- `disk-id`: An ID of the disk which placement policy is to be changes.

- `disk-placement-group-id`: Placement group to move the disk to.

- `disk-placement-group-name`: Placement group to move the disk to.

- `disk-placement-group-partition`: Placement group partition. Used when a placement group is created with the partition strategy. ||
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