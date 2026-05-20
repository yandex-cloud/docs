---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cic/cli-ref/v1/private-connection/update
editable: false
---

# yc cic v1 private-connection update

Updates a PrivateConnection resource using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc cic v1 private-connection update <PRIVATE-CONNECTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc compute instance create -r request.json ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc compute instance create -r request.yaml ||
|| `--id` | `string`

ID of the PrivateConnection resource. ||
|| `--name` | `string`

Name of the privateConnection. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''. ||
|| `--description` | `string`

Optional description of the privateConnection. 0-256 characters long. ||
|| `--trunk-connection-id` | `string`

ID of the trunk_connection that the privateConnection belongs to. ||
|| `--vlan-id` | `int`

VLAN_ID that the privateConnection uses in multiplexing. Not used in connections over partners-II Value range: [1, 4095] ||
|| `--ipv4-peering` | `shorthand/json`

IPv4 peering config of connection

{% cut "Description" %}

> - peering-subnet (string)\
PeeringSubnet. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
> - peer-ip (string)\
PeerIp. It's an ip with just an ipAddress format without mask.
> - cloud-ip (string)\
CloudIp. It's an ip with just an ipAddress format without mask.
> - peer-bgp-asn (integer)\
PeerBgpAsn. PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).
> - peer-bgp-md5-key (string)\
PeerBgpMd5Key. Optional.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  cloud-ip = string,
  peer-bgp-asn = integer,
  peer-bgp-md5-key = string,
  peer-ip = string,
  peering-subnet = string
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "cloud-ip": "string",
  "peer-bgp-asn": "integer",
  "peer-bgp-md5-key": "string",
  "peer-ip": "string",
  "peering-subnet": "string"
}
```

{% endcut %} ||
|| `--ipv4-static-routes` | `shorthand/json`

IPv4 StaticRoute config of connection

{% cut "Description" %}

> - prefix (string)\
Prefix. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    prefix = string
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "prefix": "string"
  }, ...
]
```

{% endcut %} ||
|| `--labels` | `map<string><string>`

Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'. ||
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
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
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
|| `--syntax` | `string`

CLI syntax: this standalone binary only supports 2 (current). Use main yc for syntax 1. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
