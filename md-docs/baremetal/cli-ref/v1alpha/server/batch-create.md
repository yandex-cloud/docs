[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > [Справочник CLI (англ.)](../../index.md) > [v1alpha](../index.md) > [server](index.md) > batch-create

# yc baremetal v1alpha server batch-create

Creates multiple servers in the specified folder.

#### Command Usage

Syntax:

`yc baremetal v1alpha server batch-create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder to list images in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--name` | `string`

Name of the server. The name must be unique within the folder. ||
|| `--description` | `string`

Description of the server. ||
|| `--hardware-pool-id` | `string`

ID of the hardware pool that the server belongs to. To get the hardware pool ID, use a [HardwarePoolService.List] request. ||
|| `--configuration-id` | `string`

ID of the configuration to use for the server. To get the configuration ID, use a [ConfigurationService.List] request. ||
|| `--rental-period-id` | `string`

A period of time for which the server is rented. To get the rental period ID, use a [RentalPeriodService.List] request. ||
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
|| `--os-settings-spec` | `shorthand/json`

Operating system specific settings for provisioning the server. Optional, if omitted, the server will be created without an operating system.

{% cut "Description" %}

> - image-id (string)\
ID of the image that the server was created from.
> - storages ([]structure)\
List of storages to be created on the server. If not specified, the default value based on the selected configuration will be used as the field value.
>> - partitions ([]structure)\
Array of partitions created on the storage.
>>> - type (structure)\
Partition type.
>>> - size-gib (integer)\
Size of the storage partition in gibibytes (2^30 bytes).
>>> - mount-point (string)\
Storage mount point.
>> - storage-type (oneof)\
Oneof storage-type field
>>> - disk (structure)\
Disk storage.
>>>> - id (string)\
ID of the disk.
>>>> - type (structure)\
Type of the disk drive.
>>>> - size-gib (integer)\
Size of the disk in gibibytes (2^30 bytes).
>>> - raid (structure)\
RAID storage.
>>>> - type (structure)\
RAID type.
>>>> - disks ([]structure)\
Array of disks in the RAID configuration.
>>>>> - id (string)\
ID of the disk.
>>>>> - type (structure)\
Type of the disk drive.
>>>>> - size-gib (integer)\
Size of the disk in gibibytes (2^30 bytes).
> - ssh-key (oneof)\
Oneof ssh-key field
>> - ssh-public-key (string)\
Public SSH key for the server.
>> - user-ssh-id (string)\
ID of the user SSH key to use for the server. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.
> - password (oneof)\
Oneof password field
>> - password-plain-text (string)\
Raw password.
>> - password-lockbox-secret (structure)\
Reference to the Lockbox secret used to obtain the password.
>>> - secret-id (string)\
The unique identifier for the lockbox secret that contains the user password.
>>> - version-id (string)\
The unique identifier for the lockbox version. If omitted, the current version of the secret will be used.
>>> - key (string)\
The key used to access a specific secret entry.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  image-id = string,
  password = password-lockbox-secret={
    key = string,
    secret-id = string,
    version-id = string
  } | password-plain-text=string,
  ssh-key = ssh-public-key=string | user-ssh-id=string,
  storages = [
    {
      partitions = [
        {
          mount-point = string,
          size-gib = integer,
          type = EXT4|SWAP|EXT3|XFS
        }, ...
      ],
      storage-type = disk={
        id = string,
        size-gib = integer,
        type = HDD|SSD|NVME
      } | raid={
        disks = [
          {
            id = string,
            size-gib = integer,
            type = HDD|SSD|NVME
          }, ...
        ],
        type = RAID0|RAID1|RAID10
      }
    }, ...
  ]
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
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
    "ssh-public-key": "string",
    "user-ssh-id": "string"
  },
  "storages": [
    {
      "partitions": [
        {
          "mount-point": "string",
          "size-gib": "integer",
          "type": "EXT4|SWAP|EXT3|XFS"
        }, ...
      ],
      "storage-type": {
        "disk": {
          "id": "string",
          "size-gib": "integer",
          "type": "HDD|SSD|NVME"
        },
        "raid": {
          "disks": [
            {
              "id": "string",
              "size-gib": "integer",
              "type": "HDD|SSD|NVME"
            }, ...
          ],
          "type": "RAID0|RAID1|RAID10"
        }
      }
    }, ...
  ]
}
```

{% endcut %} ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--count` | `int`

Number of servers to create. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal v1alpha server batch-create --example-json > request.json
or
yc baremetal v1alpha server batch-create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v1alpha server batch-create -r request.json
or
yc baremetal v1alpha server batch-create -r request.yaml ||
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