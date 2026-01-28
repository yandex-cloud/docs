---
editable: false
sourcePath: en/_cli-ref/cli-ref/baremetal/cli-ref/private-subnet/update.md
---

# yc baremetal private-subnet update

Update the specified private subnet

#### Command Usage

Syntax:

`yc baremetal private-subnet update <PRIVATE-SUBNET-NAME>|<PRIVATE-SUBNET-ID> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

Private Subnet id. ||
|| `--name` | `string`

Private Subnet name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--new-name` | `string`

A new name of the private subnet. ||
|| `--description` | `string`

Specifies a textual description of the private subnet. ||
|| `--vrf-options` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Specifies a vrf options spec to the private subnet.

Possible property names:

- `vrf-id`: Specifies the vrf id of the vrf options spec.

- `vrf-name`: Specifies the vrf name of the vrf options spec.

- `dhcp`: Specifies the dhcp of the private-subnet. Default value is disabled.

- `cidr`: Specifies the cidr of the vrf options spec.

- `gateway-ip`: Specifies the gateway ip of the vrf options spec. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
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