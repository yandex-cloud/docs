---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/baremetal/cli-ref-beta/server/reinstall.md
---

# yc beta baremetal server reinstall

Reinstalls the specified server.

#### Command Usage

Syntax:

`yc beta baremetal server reinstall <SERVER-ID>`

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
|| `--os-settings-spec` | `shorthand/json`

Operating system specific settings for provisioning the server.

Shorthand Syntax:

```hcl
{
  image-id = str,
  password = password-lockbox-secret={
    key = str,
    secret-id = str,
    version-id = str
  } | password-plain-text=str,
  ssh-key = ssh-public-key=str | user-ssh-id=str,
  storages = [
    {
      partitions = [
        {
          mount-point = str,
          size-gib = int,
          type = EXT4|SWAP|EXT3|XFS
        }, ...
      ],
      storage-type = disk={
        id = str,
        size-gib = int,
        type = HDD|SSD|NVME
      } | raid={
        disks = [
          {
            id = str,
            size-gib = int,
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
  "image-id": "str",
  "password": {
    "password-lockbox-secret": {
      "key": "str",
      "secret-id": "str",
      "version-id": "str"
    },
    "password-plain-text": "str"
  },
  "ssh-key": {
    "ssh-public-key": "str",
    "user-ssh-id": "str"
  },
  "storages": [
    {
      "partitions": [
        {
          "mount-point": "str",
          "size-gib": "int",
          "type": "EXT4|SWAP|EXT3|XFS"
        }, ...
      ],
      "storage-type": {
        "disk": {
          "id": "str",
          "size-gib": "int",
          "type": "HDD|SSD|NVME"
        },
        "raid": {
          "disks": [
            {
              "id": "str",
              "size-gib": "int",
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
    size-gib -> (int)
      Size of the storage partition in gibibytes (2^30 bytes).
    type -> (struct)
      Partition type.
  storage-type -> (oneof<disk|raid>)
    Oneof storage-type field
    disk -> (struct)
      Disk storage.
      id -> (string)
        ID of the disk.
      size-gib -> (int)
        Size of the disk in gibibytes (2^30 bytes).
      type -> (struct)
        Type of the disk drive.
    raid -> (struct)
      RAID storage.
      disks -> ([]struct)
        Array of disks in the RAID configuration.
        id -> (string)
          ID of the disk.
        size-gib -> (int)
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
|| `--server-id` | `string`

ID of the server to reinstall. To get the server ID, use a [ServerService.List] request. ||
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