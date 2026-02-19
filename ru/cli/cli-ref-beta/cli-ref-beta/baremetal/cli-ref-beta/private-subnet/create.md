---
editable: false
noIndex: true
---

# yc beta baremetal private-subnet create

Creates a private subnet in the specified folder.

#### Command Usage

Syntax:

`yc beta baremetal private-subnet create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--description` | `string`

Description of the private subnet. ||
|| `--folder-id` | `string`

ID of the folder to create a private subnet in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--hardware-pool-id` | `string`

ID of the hardware pool where the private subnet resides. To get a list of available hardware pools, use the [HardwarePoolService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the private subnet. The name must be unique within the folder. ||
|| `--vrf-options-spec` | `shorthand/json`

VRF options. Optional.

Shorthand Syntax:

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

JSON Syntax:

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

Fields:

```
cidr -> (string)
  CIDR block. The range of internal addresses that are defined for this private subnet, as specified in RFC1918. For example, 10.0.0.0/22 or 192.168.0.0/24.
dhcp-options -> (struct)
  DHCP options for the subnet. The absence or null value indicates that DHCP is disabled.
  end-ip -> (string)
    End IP address of the DHCP range (inclusive). The absence or null value indicates that calculation will be performed based on CIDR.
  start-ip -> (string)
    Start IP address of the DHCP range (inclusive). The absence or null value indicates that calculation will be performed based on CIDR.
gateway-ip -> (string)
  Gateway IP address for the subnet.
vrf-id -> (string)
  ID of the VRF to create private subnet in. To get the VRF ID, use a [VrfService.List] request.
``` ||
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
|| `-h`, `--help` | Display help for the command. ||
|#