---
editable: false
noIndex: true
---

# yc beta baremetal server update

Updates the specified server.

#### Command Usage

Syntax:

`yc beta baremetal server update <SERVER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the server. ||
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
|| `--server-id` | `string`

ID of the server to update. To get the server ID, use a [ServerService.List] request. ||
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