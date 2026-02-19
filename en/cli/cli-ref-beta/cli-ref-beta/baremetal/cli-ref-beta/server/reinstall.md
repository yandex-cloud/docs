---
editable: false
noIndex: true
---

# yc beta baremetal server reinstall

(-- api-linter: yc::1702::method-verb-prefix=disabled
Required for backward compatibility with old clients. --)
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