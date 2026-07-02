[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник CLI (англ.)](../../../index.md) > [baremetal](../index.md) > [vrf](index.md) > create

# yc baremetal vrf create

Creates a VRF in the specified folder.

#### Command Usage

Syntax:

`yc baremetal vrf create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder to create a VRF in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--name` | `string`

Name of the VRF. The name must be unique within the folder. ||
|| `--description` | `string`

Description of the VRF. ||
|| `--static-routes` | `shorthand/json`

VRF static routes.

{% cut "Description" %}

> - destination-cidr (string)\
Destination network CIDR block.
> - next-hop-ip-address (string)\
Next hop host IP address.
> - redistribution-type (structure)\
Redistribution type.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    destination-cidr = string,
    next-hop-ip-address = string,
    redistribution-type = DISABLED|ENABLED
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "destination-cidr": "string",
    "next-hop-ip-address": "string",
    "redistribution-type": "DISABLED|ENABLED"
  }, ...
]
```

{% endcut %} ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request. ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.

The template can be customized and used as input for the command.

Usage example:

1. Generate template:
yc baremetal vrf create --example-json > request.json
or
yc baremetal vrf create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal vrf create -r request.json
or
yc baremetal vrf create -r request.yaml ||
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