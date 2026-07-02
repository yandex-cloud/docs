[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > [Справочник CLI (англ.)](../../index.md) > [v1alpha](../index.md) > [private-subnet](index.md) > update

# yc baremetal v1alpha private-subnet update

Updates the specified private subnet.

#### Command Usage

Syntax:

`yc baremetal v1alpha private-subnet update <PRIVATE-SUBNET-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--id` | `string`

ID of the PrivateSubnet resource to update. To get the private subnet ID, use a [PrivateSubnetService.List] request. ||
|| `--name` | `string`

Name of the private subnet. The name must be unique within the folder. ||
|| `--description` | `string`

Description of the private subnet. ||
|| `--vrf-options-spec` | `shorthand/json`

VRF options. Optional.

{% cut "Description" %}

> - vrf-id (string)\
ID of the VRF to create private subnet in. To get the VRF ID, use a [VrfService.List] request.
> - cidr (string)\
CIDR block. The range of internal addresses that are defined for this private subnet, as specified in RFC1918. For example, 10.0.0.0/22 or 192.168.0.0/24.
> - dhcp-options (structure)\
DHCP options for the subnet. The absence or null value indicates that DHCP is disabled.
>> - start-ip (string)\
Start IP address of the DHCP range (inclusive). The absence or null value indicates that calculation will be performed based on CIDR.
>> - end-ip (string)\
End IP address of the DHCP range (inclusive). The absence or null value indicates that calculation will be performed based on CIDR.
> - gateway-ip (string)\
Gateway IP address for the subnet.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  cidr = string,
  dhcp-options = {
    end-ip = string,
    start-ip = string
  },
  gateway-ip = string,
  vrf-id = string
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "cidr": "string",
  "dhcp-options": {
    "end-ip": "string",
    "start-ip": "string"
  },
  "gateway-ip": "string",
  "vrf-id": "string"
}
```

{% endcut %} ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal v1alpha private-subnet update --example-json > request.json
or
yc baremetal v1alpha private-subnet update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v1alpha private-subnet update -r request.json
or
yc baremetal v1alpha private-subnet update -r request.yaml ||
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
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#