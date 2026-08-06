---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/baremetal/cli-ref/v2/boot-image/create/
---

# yc baremetal v2 boot-image create

Creates a boot image in the specified folder.

#### Command Usage

Syntax:

`yc baremetal v2 boot-image create <CLOUD-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cloud-id` | `string`

ID of the parent cloud. To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List] request. ||
|| `--folder-id` | `string`

ID of the parent folder. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--boot-image` | `shorthand/json`

Boot image to create.

{% cut "Description" %}

> - cloud-id (string)\
ID of the cloud that the image belongs to.
> - folder-id (string)\
ID of the folder that the image belongs to.
> - name (string)\
Name of the image. The name is unique within the folder.
> - description (string)\
Description of the image.
> - uri (string)\
URI of the source image to create the new image from. Currently only supports links to images that are stored in Object Storage. Currently only supports ISO formats.
> - annotations (map[string,string])\
Resource annotations as 'key:value' pairs.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  annotations = {key=string, key=...},
  cloud-id = string,
  description = string,
  folder-id = string,
  name = string,
  uri = string
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "annotations": {
    "<key>": "string", ...
  },
  "cloud-id": "string",
  "description": "string",
  "folder-id": "string",
  "name": "string",
  "uri": "string"
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
yc baremetal v2 boot-image create --example-json > request.json
or
yc baremetal v2 boot-image create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 boot-image create -r request.json
or
yc baremetal v2 boot-image create -r request.yaml ||
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