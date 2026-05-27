---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/cloudrouter/cli-ref/v1/routing-instance/update
editable: false
---

# yc cloudrouter v1 routing-instance update

Updates a RoutingInstance resource using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc cloudrouter v1 routing-instance update <ROUTING-INSTANCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc compute instance create -r request.json ||
|| `-e`, `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc compute instance create -r request.yaml ||
|| `--id` | `string`

ID of the RoutingInstance resource to return. ||
|| `--name` | `string`

Name of the RoutingInstance. The name must be unique within the folder. Value must match the regular expression ''\\|a-zA-Z?''. ||
|| `--description` | `string`

Optional description of the RoutingInstance. 0-256 characters long. ||
|| `--vpc-info` | `shorthand/json`

List of the info about vpcNetworks which are attached to the RoutingInstance.

{% cut "Description" %}

> - vpc-network-id (string)\
ID of the vpcNetwork that is attached to the routingInstance.
> - az-infos ([]structure)\
List of the az-related info about vpcNetworks which are attached to routingInstance
>> - manual-info (structure)\
VpcInfo which is set by user
>>> - az-id (string)\
ID of the AZ
>>> - prefixes ([]string)\
List of prefixes to announce

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    az-infos = [
      {
        manual-info = {
          az-id = string,
          prefixes = string,...
        }
      }, ...
    ],
    vpc-network-id = string
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "az-infos": [
      {
        "manual-info": {
          "az-id": "string",
          "prefixes": [
            "string", ...
          ]
        }
      }, ...
    ],
    "vpc-network-id": "string"
  }, ...
]
```

{% endcut %} ||
|| `--cic-private-connection-info` | `shorthand/json`

List of the info about privateConnections which are attached to the RoutingInstance.

{% cut "Description" %}

> - cic-private-connection-id (string)\
ID of the cicPrivateConnection that is attached to the routingInstance.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    cic-private-connection-id = string
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "cic-private-connection-id": "string"
  }, ...
]
```

{% endcut %} ||
|| `--labels` | `map<string><string>`

Resource labels, 'key:value' pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression '[-_0-9a-z]*'. The string length in characters for each key must be 1-63. Each key must match the regular expression '[a-z][-_0-9a-z]*'. ||
|| `--deletion-protection` |  ||
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

CLI syntax: this standalone binary only supports 2 (current). Use main yc for syntax 1. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#
