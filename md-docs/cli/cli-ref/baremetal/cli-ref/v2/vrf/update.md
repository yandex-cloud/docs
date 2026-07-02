[Документация Yandex Cloud](../../../../../../index.md) > [Интерфейс командной строки](../../../../../index.md) > [Справочник CLI (англ.)](../../../../index.md) > [baremetal](../../index.md) > [v2](../index.md) > [vrf](index.md) > update

# yc baremetal v2 vrf update

Updates the specified VRF resource.

#### Command Usage

Syntax:

`yc baremetal v2 vrf update <VRF-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--id` | `string`

ID of the VRF. ||
|| `--vrf` | `shorthand/json`

The vrf object to be updated.

{% cut "Description" %}

> - name (string)\
Name of the VRF. Unique within the folder.
> - description (string)\
Optional description of the VRF.
> - static-routes ([]structure)\
Static routes.
>> - destination-cidr (string)\
Destination network CIDR block.
>> - next-hop-ip-address (string)\
Next hop host IP address.
>> - redistribution-type (structure)\
Redistribution type.
> - annotations (map[string,string])\
Resource annotations as 'key:value' pairs.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  annotations = {key=string, key=...},
  description = string,
  name = string,
  static-routes = [
    {
      destination-cidr = string,
      next-hop-ip-address = string,
      redistribution-type = DISABLED|ENABLED
    }, ...
  ]
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "annotations": {
    "<key>": "string", ...
  },
  "description": "string",
  "name": "string",
  "static-routes": [
    {
      "destination-cidr": "string",
      "next-hop-ip-address": "string",
      "redistribution-type": "DISABLED|ENABLED"
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
yc baremetal v2 vrf update --example-json > request.json
or
yc baremetal v2 vrf update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc baremetal v2 vrf update -r request.json
or
yc baremetal v2 vrf update -r request.yaml ||
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