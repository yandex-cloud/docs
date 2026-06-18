# yc baremetal v2 server reinstall

Reinstalls the specified server.

#### Command Usage

Syntax:

`yc baremetal v2 server reinstall <SERVER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cloud-id` | `string`

ID of the parent cloud. To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List] request. ||
|| `--folder-id` | `string`

ID of the parent folder. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--id` | `string`

ID of the server to reinstall. To get the server ID, use a [ServerService.List] request. ||
|| `--os-settings` | `shorthand/json`

Operating system specific settings for provisioning the server.

{% cut "Description" %}

> - image-id (string)\
ID of the image that the server was created from.
> - storages ([]structure)\
List of storages. If not specified, the default value based on the selected configuration will be used as the field value.
>> - partitions ([]structure)\
Array of partitions created on the storage.
>>> - type (structure)\
Partition type.
>>> - size-bytes (bytes)\
Size of the storage partition.
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
>>>> - size-bytes (bytes)\
Size of the disk.
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
>>>>> - size-bytes (bytes)\
Size of the disk.
> - ssh-key (oneof)\
Oneof ssh-key field
>> - ssh-public-key-text (string)\
Public SSH key for the server. Input only field.
>> - user-ssh-id (string)\
ID of the user SSH key to use for the server. Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List] request.
> - password (oneof)\
Oneof password field
>> - password-plain-text (string)\
Raw password. Input only field.
>> - password-lockbox-secret (structure)\
Reference to the Lockbox secret used to obtain the password. Input only field.
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
  ssh-key = ssh-public-key-text=string | user-ssh-id=string,
  storages = [
    {
      partitions = [
        {
          mount-point = string,
          size-bytes = bytes,
          type = EXT4|SWAP|EXT3|XFS
        }, ...
      ],
      storage-type = disk={
        id = string,
        size-bytes = bytes,
        type = HDD|SSD|NVME
      } | raid={
        disks = [
          {
            id = string,
            size-bytes = bytes,
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
    "ssh-public-key-text": "string",
    "user-ssh-id": "string"
  },
  "storages": [
    {
      "partitions": [
        {
          "mount-point": "string",
          "size-bytes": "bytes",
          "type": "EXT4|SWAP|EXT3|XFS"
        }, ...
      ],
      "storage-type": {
        "disk": {
          "id": "string",
          "size-bytes": "bytes",
          "type": "HDD|SSD|NVME"
        },
        "raid": {
          "disks": [
            {
              "id": "string",
              "size-bytes": "bytes",
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
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal v2 server reinstall --example-json > request.json
or
yc baremetal v2 server reinstall --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 server reinstall -r request.json
or
yc baremetal v2 server reinstall -r request.yaml ||
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