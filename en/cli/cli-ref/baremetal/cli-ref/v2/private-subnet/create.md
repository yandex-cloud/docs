---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/baremetal/cli-ref/v2/private-subnet/create/
---

# yc baremetal v2 private-subnet create

Creates a private subnet in the specified folder.

#### Command Usage

Syntax:

`yc baremetal v2 private-subnet create <CLOUD-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cloud-id` | `string`

ID of the parent cloud. To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List] request. ||
|| `--folder-id` | `string`

ID of the parent folder. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--private-subnet` | `shorthand/json`

The private subnet to create.

{% cut "Description" %}

> - cloud-id (string)\
ID of the cloud that the private subnet belongs to.
> - folder-id (string)\
ID of the folder that the private subnet belongs to.
> - name (string)\
Name of the public subnet. The name is unique within the folder.
> - description (string)\
Optional description of the private subnet.
> - hardware-pool-id (string)\
ID of the hardware pool that the private subnet belongs to.
> - vrf-options (structure)\
Optional VRF options for the private subnet. If missing, the private subnet will be unrouted, i.e. it will lack a DHCP server and routing capabilities between this subnet and other private subnets.
>> - vrf-id (string)\
ID of the VRF.
>> - cidr (string)\
CIDR block for the subnet.
>> - dhcp-options (structure)\
DHCP options for the subnet.
>>> - start-ip (string)\
Start IP address of the DHCP range (inclusive).
>>> - end-ip (string)\
End IP address of the DHCP range (inclusive).
>> - gateway-ip (string)\
Gateway IP address for the subnet.
> - annotations (map[string,string])\
Resource annotations as 'key:value' pairs.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  annotations = {key=string, key=...},
  cloud-id = string,
  description = string,
  folder-id = string,
  hardware-pool-id = string,
  name = string,
  vrf-options = {
    cidr = string,
    dhcp-options = {
      end-ip = string,
      start-ip = string
    },
    gateway-ip = string,
    vrf-id = string
  }
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "annotations": {
    "<key>": "string", ...
  },
  "cloud-id": "string",
  "description": "string",
  "folder-id": "string",
  "hardware-pool-id": "string",
  "name": "string",
  "vrf-options": {
    "cidr": "string",
    "dhcp-options": {
      "end-ip": "string",
      "start-ip": "string"
    },
    "gateway-ip": "string",
    "vrf-id": "string"
  }
}
```

{% endcut %} ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal v2 private-subnet create --example-json > request.json
or
yc baremetal v2 private-subnet create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 private-subnet create -r request.json
or
yc baremetal v2 private-subnet create -r request.yaml ||
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