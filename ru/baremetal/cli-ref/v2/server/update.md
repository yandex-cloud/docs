---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/baremetal/cli-ref/v2/server/update/
---

# yc baremetal v2 server update

Updates the specified server.

#### Command Usage

Syntax:

`yc baremetal v2 server update <SERVER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--id` | `string`

ID of the server. ||
|| `--server` | `shorthand/json`

The server object to be updated

{% cut "Description" %}

> - name (string)\
Name of the server. The display name is unique within the folder.
> - description (string)\
Description of the server.
> - os-settings (structure)\
Operating system specific settings of the server. Optional, will be empty if the server is provisioned without an operating system.
>> - image-id (string)\
ID of the image that the server was created from.
>> - storages ([]structure)\
List of storages. If not specified, the default value based on the selected configuration will be used as the field value.
>>> - partitions ([]structure)\
Array of partitions created on the storage.
>>>> - type (structure)\
Partition type.
>>>> - size-bytes (integer)\
Size of the storage partition.
>>>> - mount-point (string)\
Storage mount point.
>>> - storage-type (oneof)\
Oneof storage-type field
>>>> - disk (structure)\
Disk storage.
>>>>> - id (string)\
ID of the disk.
>>>>> - type (structure)\
Type of the disk drive.
>>>>> - size-bytes (integer)\
Size of the disk.
>>>> - raid (structure)\
RAID storage.
>>>>> - type (structure)\
RAID type.
>>>>> - disks ([]structure)\
Array of disks in the RAID configuration.
>>>>>> - id (string)\
ID of the disk.
>>>>>> - type (structure)\
Type of the disk drive.
>>>>>> - size-bytes (integer)\
Size of the disk.
>> - ssh-key (oneof)\
Oneof ssh-key field
>>> - ssh-public-key-text (string)\
Public SSH key for the server. Input only field.
>>> - user-ssh-id (string)\
ID of the user SSH key to use for the server. Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.
>> - password (oneof)\
Oneof password field
>>> - password-plain-text (string)\
Raw password. Input only field.
>>> - password-lockbox-secret (structure)\
Reference to the Lockbox secret used to obtain the password. Input only field.
>>>> - secret-id (string)\
The unique identifier for the lockbox secret that contains the user password.
>>>> - version-id (string)\
The unique identifier for the lockbox version. If omitted, the current version of the secret will be used.
>>>> - key (string)\
The key used to access a specific secret entry.
> - next-rental-period-id (string)\
A period of time for which a Bare Metal Server will be changed on after ending of current rental period.
> - network-interfaces ([]structure)\
Array of network interfaces that are attached to the instance.
>> - network-interface-id (string)\
ID of the network interface. Should not be specified when creating a server.
>> - configuration-network-interface-id (string)\
ID of the configuration network interface that determines the network interface configuration. The configuration network interface defines available modes (public/private) and other properties for the network interface. This field is optional. If not specified, the configuration will be chosen automatically on the server side based on availability. It is recommended to specify this field for deterministic behavior. To get the configuration interface ID, use a [ConfigurationService.ListConfigurationNetworkInterface] request or examine the 'network_interfaces' field in [ConfigurationService.GetConfiguration] response.
>> - interface (oneof)\
Oneof interface field
>>> - private-interface (structure)\
Private interface.
>>>> - native-subnet-id (string)\
ID of the private subnet which is used as native subnet for interface.
>>>> - vlan-subinterfaces ([]structure)\
Array of VLAN subinterfaces. Additional tagged subnets for the interface.
>>>>> - tagged-subnet-id (string)\
ID of the private subnet which is used as tagged subnet for interface.
>>> - public-interface (structure)\
Public interface.
>>>> - internet-traffic-plan (structure)\
Internet traffic plan. Defines how much data can be transfered with server interface.
>>>> - native-subnet-config (oneof)\
Oneof native-subnet-config field
>>>>> - native-subnet (structure)\
Use existing native subnet.
>>>>>> - subnet-id (string)\
ID of the existing public subnet.
>>>>> - new-native-subnet (structure)\
Create new native subnet.
>>>>>> - addressing-type (structure)\
Addressing type (DHCP \| Static).
> - prolongation-state (structure)\
Prolongation state of the server's rent.
> - annotations (map[string,string])\
Resource labels as 'key:value' pairs.
> - configuration (oneof)\
Oneof configuration field
>> - custom-configuration (structure)\
Custom configuration.
>>> - name (string)\
Name of the configuration.
>>> - cpu (structure)\
CPU configuration.
>>>> - id (string)\
ID of the CPU from configurator.
>>>> - count (integer)\
Number of cpu.
>>> - disk-drives ([]structure)\
Array of disk drive configurations.
>>>> - type (structure)\
Type of the disk drive.
>>>> - count (integer)\
Number of disk drives.
>>>> - size-bytes (integer)\
Size of a single disk drive.
>>> - ram (structure)\
Random-access memory (RAM).
>>>> - id (string)\
ID of the RAM from configurator.
>>>> - size-bytes (integer)\
Ram size.
>> - stock-configuration-id (string)\
ID of the stock configuration.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  annotations = {key=string, key=...},
  configuration = custom-configuration={
    cpu = {
      count = integer,
      id = string
    },
    disk-drives = [
      {
        count = integer,
        size-bytes = integer,
        type = HDD|SSD|NVME
      }, ...
    ],
    name = string,
    ram = {
      id = string,
      size-bytes = integer
    }
  } | stock-configuration-id=string,
  description = string,
  name = string,
  network-interfaces = [
    {
      configuration-network-interface-id = string,
      interface = private-interface={
        native-subnet-id = string,
        vlan-subinterfaces = [
          {
            tagged-subnet-id = string
          }, ...
        ]
      } | public-interface={
        internet-traffic-plan = PLAN_10TB|PLAN_100TB,
        native-subnet-config = native-subnet={
          subnet-id = string
        } | new-native-subnet={
          addressing-type = DHCP|STATIC
        }
      },
      network-interface-id = string
    }, ...
  ],
  next-rental-period-id = string,
  os-settings = {
    image-id = string,
    password = password-lockbox-secret={
      key = string,
      secret-id = string,
      version-id = string
    } | password-plain-text=string,
    ssh-key = ssh-public-key-text=string | user-ssh-id=string,
    storages = [
      {
        partitions = [
          {
            mount-point = string,
            size-bytes = integer,
            type = EXT4|SWAP|EXT3|XFS
          }, ...
        ],
        storage-type = disk={
          id = string,
          size-bytes = integer,
          type = HDD|SSD|NVME
        } | raid={
          disks = [
            {
              id = string,
              size-bytes = integer,
              type = HDD|SSD|NVME
            }, ...
          ],
          type = RAID0|RAID1|RAID10
        }
      }, ...
    ]
  },
  prolongation-state = AUTO_RENEW|NON_RENEWAL
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "annotations": {
    "<key>": "string", ...
  },
  "configuration": {
    "custom-configuration": {
      "cpu": {
        "count": "integer",
        "id": "string"
      },
      "disk-drives": [
        {
          "count": "integer",
          "size-bytes": "integer",
          "type": "HDD|SSD|NVME"
        }, ...
      ],
      "name": "string",
      "ram": {
        "id": "string",
        "size-bytes": "integer"
      }
    },
    "stock-configuration-id": "string"
  },
  "description": "string",
  "name": "string",
  "network-interfaces": [
    {
      "configuration-network-interface-id": "string",
      "interface": {
        "private-interface": {
          "native-subnet-id": "string",
          "vlan-subinterfaces": [
            {
              "tagged-subnet-id": "string"
            }, ...
          ]
        },
        "public-interface": {
          "internet-traffic-plan": "PLAN_10TB|PLAN_100TB",
          "native-subnet-config": {
            "native-subnet": {
              "subnet-id": "string"
            },
            "new-native-subnet": {
              "addressing-type": "DHCP|STATIC"
            }
          }
        }
      },
      "network-interface-id": "string"
    }, ...
  ],
  "next-rental-period-id": "string",
  "os-settings": {
    "image-id": "string",
    "password": {
      "password-lockbox-secret": {
        "key": "string",
        "secret-id": "string",
        "version-id": "string"
      },
      "password-plain-text": "string"
    },
    "ssh-key": {
      "ssh-public-key-text": "string",
      "user-ssh-id": "string"
    },
    "storages": [
      {
        "partitions": [
          {
            "mount-point": "string",
            "size-bytes": "integer",
            "type": "EXT4|SWAP|EXT3|XFS"
          }, ...
        ],
        "storage-type": {
          "disk": {
            "id": "string",
            "size-bytes": "integer",
            "type": "HDD|SSD|NVME"
          },
          "raid": {
            "disks": [
              {
                "id": "string",
                "size-bytes": "integer",
                "type": "HDD|SSD|NVME"
              }, ...
            ],
            "type": "RAID0|RAID1|RAID10"
          }
        }
      }, ...
    ]
  },
  "prolongation-state": "AUTO_RENEW|NON_RENEWAL"
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
yc baremetal v2 server update --example-json > request.json
or
yc baremetal v2 server update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 server update -r request.json
or
yc baremetal v2 server update -r request.yaml ||
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