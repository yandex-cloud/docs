[Документация Yandex Cloud](../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../index.md) > [Справочник CLI (англ.)](../../../../../index.md) > [smartwebsecurity](../../../index.md) > [v1](../../index.md) > [match-list](../index.md) > [match-list](index.md) > update

# yc smartwebsecurity v1 match-list match-list update

Updates the specified MatchList resource.

#### Command Usage

Syntax:

`yc smartwebsecurity v1 match-list match-list update <LIST-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--list-id` | `string`

ID of the match list to update. ||
|| `--labels` | `map<string><string>`

Labels as '' key:value '' pairs. Maximum of 64 per resource. ||
|| `--name` | `string`

Name of the match list. ||
|| `--description` | `string`

Description of the match list. ||
|| `--items` | `shorthand/json`

Match list items.

{% cut "Description" %}

> - value (string)\
Value of the item.
> - description (string)\
Description of the item.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    description = string,
    value = string
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "description": "string",
    "value": "string"
  }, ...
]
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
yc smartwebsecurity v1 match-list match-list update --example-json > request.json
or
yc smartwebsecurity v1 match-list match-list update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc smartwebsecurity v1 match-list match-list update -r request.json
or
yc smartwebsecurity v1 match-list match-list update -r request.yaml ||
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