---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/baremetal/cli-ref/server/update/
---

# yc baremetal server update

Updates the specified server.

#### Command Usage

Syntax:

`yc baremetal server update <SERVER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--id` | `string`

ID of the server to update. To get the server ID, use a [ServerService.List] request. ||
|| `--name` | `string`

Name of the server. The name must be unique within the folder. ||
|| `--description` | `string`

Description of the server. ||
|| `--network-interfaces` | `shorthand/json`

Network configuration for the server. Specifies how the network interface is configured to interact with other servers on the internal network and on the internet. Currently up to 2 network interfaces are supported: required private network interface and optional public network interface.

{% cut "Description" %}

> - id (string)\
ID of the network interface. Should not be specified when creating a server.
> - configuration-network-interface-id (string)\
ID of the configuration network interface that determines the network interface configuration. The configuration network interface defines available modes (public/private) and other properties for the network interface. This field is optional. If not specified, the configuration will be chosen automatically on the server side based on availability. It is recommended to specify this field for deterministic behavior. To get the configuration interface ID, use a [ConfigurationService.ListConfigurationNetworkInterface] request or examine the 'network_interfaces' field in [ConfigurationService.GetConfiguration] response.
> - subnet (oneof)\
Oneof subnet field
>> - private-subnet (structure)\
@deprecated Private subnet.
>>> - private-subnet-id (string)\
ID of the private subnet.
>> - public-subnet (structure)\
@deprecated Public subnet.
>>> - public-subnet-id (string)\
ID of the public subnet. A new ephemeral public subnet will be created if not specified.
> - interface (oneof)\
Oneof interface field
>> - private-interface (structure)\
Private interface.
>>> - native-subnet-id (string)\
ID of the private subnet which is used as native subnet for interface.
>>> - ip-address (string)\
IPv4 address that is assigned to the server for this network interface. Read only field.
>>> - mac-limit (integer)\
Limit of MAC addresses in the native subnet. Read only field.
>>> - vlan-subinterfaces ([]structure)\
Array of VLAN subinterfaces. Additional tagged subnets for the interface.
>>>> - tagged-subnet-id (string)\
ID of the private subnet which is used as tagged subnet for interface.
>>>> - ip-address (string)\
IPv4 address that is assigned to the VLAN subinterface. Read only field.
>>>> - mac-limit (integer)\
Limit of MAC addresses in the tagged subnet. Read only field.
>> - public-interface (structure)\
Public interface.
>>> - ip-address (string)\
IPv4 address that is assigned to the server for this network interface. Read only field.
>>> - native-subnet-id (string)\
ID of the public subnet which is used as native subnet for interface. Read only field.
>>> - mac-limit (integer)\
Limit of MAC addresses in the native subnet. Read only field.
>>> - native-subnet-config (oneof)\
Oneof native-subnet-config field
>>>> - native-subnet (structure)\
Use existing native subnet. Input only field.
>>>>> - subnet-id (string)\
ID of the existing public subnet.
>>>> - new-native-subnet (structure)\
Create new native subnet. Input only field.
>>>>> - addressing-type (structure)\
Addressing type (DHCP \| Static).

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    configuration-network-interface-id = string,
    id = string,
    interface = private-interface={
      ip-address = string,
      mac-limit = integer,
      native-subnet-id = string,
      vlan-subinterfaces = [
        {
          ip-address = string,
          mac-limit = integer,
          tagged-subnet-id = string
        }, ...
      ]
    } | public-interface={
      ip-address = string,
      mac-limit = integer,
      native-subnet-config = native-subnet={
        subnet-id = string
      } | new-native-subnet={
        addressing-type = DHCP|STATIC
      },
      native-subnet-id = string
    },
    subnet = private-subnet={
      private-subnet-id = string
    } | public-subnet={
      public-subnet-id = string
    }
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "configuration-network-interface-id": "string",
    "id": "string",
    "interface": {
      "private-interface": {
        "ip-address": "string",
        "mac-limit": "integer",
        "native-subnet-id": "string",
        "vlan-subinterfaces": [
          {
            "ip-address": "string",
            "mac-limit": "integer",
            "tagged-subnet-id": "string"
          }, ...
        ]
      },
      "public-interface": {
        "ip-address": "string",
        "mac-limit": "integer",
        "native-subnet-config": {
          "native-subnet": {
            "subnet-id": "string"
          },
          "new-native-subnet": {
            "addressing-type": "DHCP|STATIC"
          }
        },
        "native-subnet-id": "string"
      }
    },
    "subnet": {
      "private-subnet": {
        "private-subnet-id": "string"
      },
      "public-subnet": {
        "public-subnet-id": "string"
      }
    }
  }, ...
]
```

{% endcut %} ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal server update --example-json > request.json
or
yc baremetal server update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal server update -r request.json
or
yc baremetal server update -r request.yaml ||
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