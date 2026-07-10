[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Interconnect](../../../index.md) > [Справочник CLI (англ.)](../../index.md) > [v1](../index.md) > [trunk-connection-ticket](index.md) > create

# yc cic v1 trunk-connection-ticket create

Creates a TrunkConnectionTicket in the specified folder and opens a support ticket.

#### Command Usage

Syntax:

`yc cic v1 trunk-connection-ticket create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--folder-id` | `string`

ID of the folder where the future TrunkConnection should be placed. ||
|| `--spec` | `shorthand/json`

Form fields submitted by the client.

{% cut "Description" %}

> - name (string)\
Name of the future TrunkConnection. Must be unique within the folder.
> - description (string)\
Description of the future TrunkConnection.
> - capacity (structure)\
Desired capacity of the TrunkConnection.
> - point-of-presence-id (string)\
ID of the desired PointOfPresence.
> - user-message (string)\
Free-form message from the client to the support team.
> - labels (map[string,string])\
Resource labels as 'key:value' pairs.
> - deletion-protection (boolean)\
Deletion protection flag for the future TrunkConnection.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
{
  capacity = CAPACITY_50_MBPS|CAPACITY_100_MBPS|CAPACITY_200_MBPS|CAPACITY_300_MBPS|CAPACITY_400_MBPS|CAPACITY_500_MBPS|CAPACITY_1_GBPS|CAPACITY_2_GBPS|CAPACITY_3_GBPS|CAPACITY_4_GBPS|CAPACITY_5_GBPS|CAPACITY_10_GBPS|CAPACITY_20_GBPS|CAPACITY_30_GBPS|CAPACITY_40_GBPS|CAPACITY_50_GBPS|CAPACITY_100_GBPS|CAPACITY_200_GBPS,
  deletion-protection = boolean,
  description = string,
  labels = {key=string, key=...},
  name = string,
  point-of-presence-id = string,
  user-message = string
}
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
{
  "capacity": "CAPACITY_50_MBPS|CAPACITY_100_MBPS|CAPACITY_200_MBPS|CAPACITY_300_MBPS|CAPACITY_400_MBPS|CAPACITY_500_MBPS|CAPACITY_1_GBPS|CAPACITY_2_GBPS|CAPACITY_3_GBPS|CAPACITY_4_GBPS|CAPACITY_5_GBPS|CAPACITY_10_GBPS|CAPACITY_20_GBPS|CAPACITY_30_GBPS|CAPACITY_40_GBPS|CAPACITY_50_GBPS|CAPACITY_100_GBPS|CAPACITY_200_GBPS",
  "deletion-protection": "boolean",
  "description": "string",
  "labels": {
    "<key>": "string", ...
  },
  "name": "string",
  "point-of-presence-id": "string",
  "user-message": "string"
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
yc cic v1 trunk-connection-ticket create --example-json > request.json
or
yc cic v1 trunk-connection-ticket create --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc cic v1 trunk-connection-ticket create -r request.json
or
yc cic v1 trunk-connection-ticket create -r request.yaml ||
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