[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [baremetal](../../index.md) > [v1alpha](../index.md) > [server](index.md) > reinstall

# yc baremetal v1alpha server reinstall

Reinstalls the specified server.

#### Command Usage

Syntax:

`yc baremetal v1alpha server reinstall <SERVER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--id` | `string`

ID of the server to reinstall. To get the server ID, use a [ServerService.List] request. ||
|| `--os-settings-spec` | `shorthand/json`

Operating system specific settings for provisioning the server.

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
|| `--name` | `string`

Resolve id by resource name within the current scope. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal v1alpha server reinstall --example-json > request.json
or
yc baremetal v1alpha server reinstall --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v1alpha server reinstall -r request.json
or
yc baremetal v1alpha server reinstall -r request.yaml ||
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