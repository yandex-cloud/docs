[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник (англ.)](../../../../index.md) > [baremetal](../../index.md) > [v2](../index.md) > [image](index.md) > list-compatible

# yc baremetal v2 image list-compatible

Lists images available for installation on the selected configuration.

#### Command Usage

Syntax:

`yc baremetal v2 image list-compatible <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

Folder of the server being configured. Used to check configuration access. ||
|| `--image-folder-id` | `string`

Folder containing images. Defaults to "baremetal-standard-images". ||
|| `--page-size` | `int`

Maximum number of compatible images to return. Defaults to 20; maximum 1000. ||
|| `--page-token` | `string`

Token from the previous response. Keep the configuration and folders unchanged. ||
|| `--stock-configuration-id` | `string`

ID of an existing stock configuration. ||
|| `--custom-configuration` | `shorthand/json`

Complete custom configuration, in the same format as for server creation. The configuration does not need to be saved first.

{% cut "Description" %}

> - name (string)\
Name of the configuration.
> - cpu (structure)\
CPU configuration.
>> - id (string)\
ID of the CPU from configurator.
>> - count (integer)\
Number of cpu.
> - disk-drives ([]structure)\
Array of disk drive configurations.
>> - type (structure)\
Type of the disk drive.
>> - count (integer)\
Number of disk drives.
>> - size-bytes (integer)\
Size of a single disk drive.
> - ram (structure)\
Random-access memory (RAM).
>> - id (string)\
ID of the RAM from configurator.
>> - size-bytes (integer)\
Ram size.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
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
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
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
}
```

{% endcut %} ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
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