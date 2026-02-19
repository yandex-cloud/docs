---
editable: false
noIndex: true
---

# yc beta baremetal server create

Creates a server in the specified folder.

#### Command Usage

Syntax:

`yc beta baremetal server create <CONFIGURATION-ID>`

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
|| `--configuration-id` | `string`

ID of the configuration to use for the server. To get the configuration ID, use a [ConfigurationService.List] request. ||
|| `--description` | `string`

Description of the server. ||
|| `--folder-id` | `string`

ID of the folder to create server in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--hardware-pool-id` | `string`

ID of the hardware pool that the server belongs to. To get the hardware pool ID, use a [HardwarePoolService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the server. The name must be unique within the folder. ||
|| `--network-interfaces` | `shorthand/json`

Network configuration for the server. Specifies how the network interface is configured to interact with other servers on the internal network and on the internet. Currently up to 2 network interfaces are supported: required private network interface and optional public network interface.

Shorthand Syntax:

```hcl
[
  {
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

JSON Syntax:

```json
[
  {
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

Fields:

```
id -> (string)
  ID of the network interface. Should not be specified when creating a server.
interface -> (oneof<private-interface|public-interface>)
  Oneof interface field
  private-interface -> (struct)
    Private interface.
    ip-address -> (string)
      IPv4 address that is assigned to the server for this network interface. Read only field.
    mac-limit -> (integer)
      Limit of MAC addresses in the native subnet. Read only field.
    native-subnet-id -> (string)
      ID of the private subnet which is used as native subnet for interface.
    vlan-subinterfaces -> ([]struct)
      Array of VLAN subinterfaces. Additional tagged subnets for the interface.
      ip-address -> (string)
        IPv4 address that is assigned to the VLAN subinterface. Read only field.
      mac-limit -> (integer)
        Limit of MAC addresses in the tagged subnet. Read only field.
      tagged-subnet-id -> (string)
        ID of the private subnet which is used as tagged subnet for interface.
  public-interface -> (struct)
    Public interface.
    ip-address -> (string)
      IPv4 address that is assigned to the server for this network interface. Read only field.
    mac-limit -> (integer)
      Limit of MAC addresses in the native subnet. Read only field.
    native-subnet-id -> (string)
      ID of the public subnet which is used as native subnet for interface. Read only field.
    native-subnet-config -> (oneof<native-subnet|new-native-subnet>)
      Oneof native-subnet-config field
      native-subnet -> (struct)
        Use existing native subnet. Input only field.
        subnet-id -> (string)
          ID of the existing public subnet.
      new-native-subnet -> (struct)
        Create new native subnet. Input only field.
        addressing-type -> (struct)
          Addressing type (DHCP | Static).
subnet -> (oneof<private-subnet|public-subnet>)
  Oneof subnet field
  private-subnet -> (struct)
    @deprecated Private subnet.
    private-subnet-id -> (string)
      ID of the private subnet.
  public-subnet -> (struct)
    @deprecated Public subnet.
    public-subnet-id -> (string)
      ID of the public subnet. A new ephemeral public subnet will be created if not specified.
``` ||
|| `--os-settings-spec` | `shorthand/json`

Operating system specific settings for provisioning the server. Optional, if omitted, the server will be created without an operating system.

Shorthand Syntax:

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

JSON Syntax:

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

Fields:

```
image-id -> (string)
  ID of the image that the server was created from.
storages -> ([]struct)
  List of storages to be created on the server. If not specified, the default value based on the selected configuration will be used as the field value.
  partitions -> ([]struct)
    Array of partitions created on the storage.
    mount-point -> (string)
      Storage mount point.
    size-gib -> (integer)
      Size of the storage partition in gibibytes (2^30 bytes).
    type -> (struct)
      Partition type.
  storage-type -> (oneof<disk|raid>)
    Oneof storage-type field
    disk -> (struct)
      Disk storage.
      id -> (string)
        ID of the disk.
      size-gib -> (integer)
        Size of the disk in gibibytes (2^30 bytes).
      type -> (struct)
        Type of the disk drive.
    raid -> (struct)
      RAID storage.
      disks -> ([]struct)
        Array of disks in the RAID configuration.
        id -> (string)
          ID of the disk.
        size-gib -> (integer)
          Size of the disk in gibibytes (2^30 bytes).
        type -> (struct)
          Type of the disk drive.
      type -> (struct)
        RAID type.
password -> (oneof<password-lockbox-secret|password-plain-text>)
  Oneof password field
  password-plain-text -> (string)
    Raw password.
  password-lockbox-secret -> (struct)
    Reference to the Lockbox secret used to obtain the password.
    key -> (string)
      The key used to access a specific secret entry.
    secret-id -> (string)
      The unique identifier for the lockbox secret that contains the user password.
    version-id -> (string)
      The unique identifier for the lockbox version. If omitted, the current version of the secret will be used.
ssh-key -> (oneof<ssh-public-key|user-ssh-id>)
  Oneof ssh-key field
  ssh-public-key -> (string)
    Public SSH key for the server.
  user-ssh-id -> (string)
    ID of the user SSH key to use for the server. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.
``` ||
|| `--rental-period-id` | `string`

A period of time for which the server is rented. To get the rental period ID, use a [RentalPeriodService.List] request. ||
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