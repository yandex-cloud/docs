---
editable: false
noIndex: true
---

# yc beta cic private-connection update

Updates a PrivateConnection resource using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta cic private-connection update <PRIVATE-CONNECTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Optional description of the privateConnection. 0-256 characters long. ||
|| `--ipv4-peering` | `shorthand/json`

IPv4 peering config of connection

Shorthand Syntax:

```hcl
{
  cloud-bgp-asn = int,
  cloud-ip = str,
  peer-bgp-asn = int,
  peer-bgp-md5-key = str,
  peer-ip = str,
  peering-subnet = str
}
```

JSON Syntax:

```json
{
  "cloud-bgp-asn": "int",
  "cloud-ip": "str",
  "peer-bgp-asn": "int",
  "peer-bgp-md5-key": "str",
  "peer-ip": "str",
  "peering-subnet": "str"
}
```

Fields:

```
cloud-bgp-asn -> (int)
  CloudBgpAsn.
cloud-ip -> (string)
  CloudIp. It's an ip with just an ipAddress format without mask.
peer-bgp-asn -> (int)
  PeerBgpAsn. PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).
peer-bgp-md5-key -> (string)
  PeerBgpMd5Key. Optional.
peer-ip -> (string)
  PeerIp. It's an ip with just an ipAddress format without mask.
peering-subnet -> (string)
  PeeringSubnet. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
``` ||
|| `--ipv4-static-routes` | `shorthand/json`

IPv4 StaticRoute config of connection

Shorthand Syntax:

```hcl
[
  {
    prefix = str
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "prefix": "str"
  }, ...
]
```

Fields:

```
prefix -> (string)
  Prefix. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
``` ||
|| `--labels` | `stringToString`

Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'. ||
|| `--name` | `string`

Name of the privateConnection. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''. ||
|| `--private-connection-id` | `string`

ID of the PrivateConnection resource. ||
|| `--region-id` | `string`

ID of the region that the privateConnection belongs to. ||
|| `--trunk-connection-id` | `string`

ID of the trunk_connection that the privateConnection belongs to. ||
|| `--vlan-id` | `int`

VLAN_ID that the privateConnection uses in multiplexing. Not used in connections over partners-II Value range: [1, 4095] ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#