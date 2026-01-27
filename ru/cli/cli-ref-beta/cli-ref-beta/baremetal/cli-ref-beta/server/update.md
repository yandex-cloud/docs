---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/server/update.md
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
|| `--labels` | `stringToString`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the server. The name must be unique within the folder. ||
|| `--network-interfaces` | `shorthand/json`

Network configuration for the server. Specifies how the network interface is configured to interact with other servers on the internal network and on the internet. Currently up to 2 network interfaces are supported: required private network interface and optional public network interface.

Shorthand Syntax:

```hcl
[
  {
    id = str,
    subnet = private-subnet={
      private-subnet-id = str
    } | public-subnet={
      public-subnet-id = str
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "id": "str",
    "subnet": {
      "private-subnet": {
        "private-subnet-id": "str"
      },
      "public-subnet": {
        "public-subnet-id": "str"
      }
    }
  }, ...
]
```

Fields:

```
id -> (string)
  ID of the network interface. Should not be specified when creating a server.
subnet -> (oneof<private-subnet|public-subnet>)
  Oneof subnet field
  private-subnet -> (struct)
    Private subnet.
    private-subnet-id -> (string)
      ID of the private subnet.
  public-subnet -> (struct)
    Public subnet.
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