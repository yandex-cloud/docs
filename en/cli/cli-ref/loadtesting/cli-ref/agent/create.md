---
editable: false
---

# yc loadtesting agent create

Create a load testing agent

#### Command Usage

Syntax:

`yc loadtesting agent create <AGENT-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

A name of the load testing agent. ||
|| `--description` | `string`

A description of the load testing agent. ||
|| `--agent-version` | `string`

A version of load testing agent to deploy. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--log-group-id` | `string`

ID of the log group to which the agent send logs. ||
|| `--log-group-name` | `string`

Name of the log group to which the agent send logs. ||
|| `--zone` | `string`

The zone of the instance to create. ||
|| `--platform-id` | `string`

The Compute platform of virtual machine. ||
|| `--metadata` | `key=value[,key=value...]`

Metadata to be made available to the guest operating system running on the instance.
See for details https://yandex.cloud/ru/docs/compute/concepts/vm-metadata ||
|| `--metadata-from-file` | `key=value[,key=value...]`

Same as --metadata except that the value for the entry will be read from a local file. ||
|| `--boot-disk` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specification of a new disk that will be used as a boot disk of the instance.

Possible property names:

- `name`: Specifies the name of the disk.

- `device-name`: Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the agent comput instance.

- `auto-delete`: Specifies if this persistent disk will be automatically deleted when the agent is deleted.

- `type`: The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.

- `size`: The size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively. If not specified, default disk size 15GB is used.

- `block-size`: Specifies the block size of the disk in bytes. You can also use K and M suffixes.

- `disk-placement-group-id`: An ID of the placement group to create the disk in

- `disk-placement-group-name`: A placement group to create the disk in

- `disk-placement-group-partition`: A placement group partition to create the disk in. Used when a placement group is created with the partition strategy. ||
|| `--network-interface` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Adds a network interface to the instance.

Possible property names:

- `subnet-name`: Specifies the subnet that the interface will be part of.

- `subnet-id`: Specifies the ID of the subnet that the interface will be part of.

- `ipv4-address`: Assigns the given internal IPv4 address to the instance that is created. If 'auto' used as value, some unassigned address from the subnet is used.

- `nat-ip-version`: Specifies IP version for One-to-One NAT. Can be 'ipv4'. This flag can be applied to network interfaces with ipv4 address.

- `nat-address`: Specifies public IP address for One-to-One NAT. This flag can be applied to network interfaces with ipv4 address.

- `security-group-ids`: Security groups for the network interface, security-group-ids=[id1,id2],security-group-ids=id3

- `dns-record-spec`: DNS records in format {name=&lt;name&gt;[,ttl=&lt;ttl&gt;][,dns-zone-id=&lt;id&gt;][,ptr={true\|false}]} ||
|| `--memory` | `byteSize`

Specifies how much memory instance should have. ||
|| `--cores` | `int`

Specifies how many CPU cores instance should have. ||
|| `--core-fraction` | `int`

If provided, specifies baseline performance for a core in percent. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--wait-ready` | Wait until an agent connects to the service ||
|| `--wait-ready-timeout` | `duration`

The timeout to interrupt the command if an agent cannot connect to the service within specified period. ||
|| `--service-account-id` | `string`

Service account ID, which token can be obtained inside VM from metadata service. ||
|| `--service-account-name` | `string`

Service account name, which token can be obtained inside VM from metadata service. ||
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