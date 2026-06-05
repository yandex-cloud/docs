---
canonical: https://yandex.cloud/en/docs/cli/cli-ref/smartcaptcha/cli-ref/v1/captcha/update
editable: false
---

# yc smartcaptcha v1 captcha update

Updates the specified captcha.

#### Command Usage

Syntax:

`yc smartcaptcha v1 captcha update <CAPTCHA-ID>`

#### Flags

#|
||Flag | Description ||
|| `--update-mask` | `[]string`

Field paths for FieldMask: each segment may be proto snake_case or CLI kebab-case (e.g. name, labels, network-interface). Repeat the flag or use comma-separated values. When set and non-empty, takes precedence over update_mask in the request body/file and over mask inferred from -r. If omitted or empty, the mask is built from the fields you pass (changed flags, JSON/shorthand, and request file when update_mask is absent there). ||
|| `--id` | `string`

ID of the captcha to update. ||
|| `--name` | `string`

Name of the captcha. The name must be unique within the folder. ||
|| `--allowed-sites` | `[]string`

List of allowed host names, see documentation. ||
|| `--complexity` | `enum`

Complexity of the captcha. Possible Values: 'easy', 'medium', 'hard', 'force-hard' ||
|| `--style-json` | `string`

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| `--turn-off-hostname-check` | Turn off host name check, see documentation. ||
|| `--pre-check-type` | `enum`

Basic check type of the captcha. Possible Values: 'checkbox', 'slider' ||
|| `--challenge-type` | `enum`

Additional task type of the captcha. Possible Values: 'image-text', 'silhouettes', 'kaleidoscope' ||
|| `--security-rules` | `shorthand/json`

List of security rules.

{% cut "Description" %}

> - name (string)\
Name of the rule. The name is unique within the captcha. 1-50 characters long.
> - priority (integer)\
Priority of the rule. Lower value means higher priority.
> - description (string)\
Optional description of the rule. 0-512 characters long.
> - condition (structure)\
The condition for matching the rule.
>> - host (structure)\
*AND* semantics implied.
>>> - hosts ([]structure)\
List of hosts. OR semantics implied.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>> - host-matcher (structure)\
Host matcher.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>> - uri (structure)\
URI where captcha placed.
>>> - path (structure)\
Path of the URI RFC3986.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>>> - queries ([]structure)\
*AND* semantics implied
>>>> - key (string)\
Key of the query parameter.
>>>> - value (structure)\
Value of the query parameter.
>>>>> - match (oneof)\
Oneof match field
>>>>>> - exact-match (string)\
Exact match condition.
>>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>>> - prefix-match (string)\
Prefix match condition.
>>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>> - headers ([]structure)\
Captcha request headers.
>>> - name (string)\
Name of header (case insensitive).
>>> - value (structure)\
Value of the header.
>>>> - match (oneof)\
Oneof match field
>>>>> - exact-match (string)\
Exact match condition.
>>>>> - exact-not-match (string)\
Exact not match condition.
>>>>> - prefix-match (string)\
Prefix match condition.
>>>>> - prefix-not-match (string)\
Prefix not match condition.
>>>>> - pire-regex-match (string)\
PIRE regex match condition.
>>>>> - pire-regex-not-match (string)\
PIRE regex not match condition.
>> - source-ip (structure)\
The IP address of the requester.
>>> - ip-ranges-match (structure)\
IP ranges to match with.
>>>> - ip-ranges ([]string)\
*OR* semantics implied.
>>> - ip-ranges-not-match (structure)\
IP ranges to not match with.
>>>> - ip-ranges ([]string)\
*OR* semantics implied.
>>> - geo-ip-match (structure)\
Geo locations to match with.
>>>> - locations ([]string)\
*OR semantics implied. ISO 3166-1 alpha 2
>>> - geo-ip-not-match (structure)\
Geo locations to not match with.
>>>> - locations ([]string)\
*OR semantics implied. ISO 3166-1 alpha 2
> - override-variant-uuid (string)\
Variant UUID to show in case of match the rule. Keep empty to use defaults.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    condition = {
      headers = [
        {
          name = string,
          value = {
            match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }
        }, ...
      ],
      host = {
        host-matcher = {
          match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        },
        hosts = [
          {
            match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
          }, ...
        ]
      },
      source-ip = {
        geo-ip-match = {
          locations = string,...
        },
        geo-ip-not-match = {
          locations = string,...
        },
        ip-ranges-match = {
          ip-ranges = string,...
        },
        ip-ranges-not-match = {
          ip-ranges = string,...
        }
      },
      uri = {
        path = {
          match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
        },
        queries = [
          {
            key = string,
            value = {
              match = exact-match=string | exact-not-match=string | pire-regex-match=string | pire-regex-not-match=string | prefix-match=string | prefix-not-match=string
            }
          }, ...
        ]
      }
    },
    description = string,
    name = string,
    override-variant-uuid = string,
    priority = integer
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "condition": {
      "headers": [
        {
          "name": "string",
          "value": {
            "match": {
              "exact-match": "string",
              "exact-not-match": "string",
              "pire-regex-match": "string",
              "pire-regex-not-match": "string",
              "prefix-match": "string",
              "prefix-not-match": "string"
            }
          }
        }, ...
      ],
      "host": {
        "host-matcher": {
          "match": {
            "exact-match": "string",
            "exact-not-match": "string",
            "pire-regex-match": "string",
            "pire-regex-not-match": "string",
            "prefix-match": "string",
            "prefix-not-match": "string"
          }
        },
        "hosts": [
          {
            "match": {
              "exact-match": "string",
              "exact-not-match": "string",
              "pire-regex-match": "string",
              "pire-regex-not-match": "string",
              "prefix-match": "string",
              "prefix-not-match": "string"
            }
          }, ...
        ]
      },
      "source-ip": {
        "geo-ip-match": {
          "locations": [
            "string", ...
          ]
        },
        "geo-ip-not-match": {
          "locations": [
            "string", ...
          ]
        },
        "ip-ranges-match": {
          "ip-ranges": [
            "string", ...
          ]
        },
        "ip-ranges-not-match": {
          "ip-ranges": [
            "string", ...
          ]
        }
      },
      "uri": {
        "path": {
          "match": {
            "exact-match": "string",
            "exact-not-match": "string",
            "pire-regex-match": "string",
            "pire-regex-not-match": "string",
            "prefix-match": "string",
            "prefix-not-match": "string"
          }
        },
        "queries": [
          {
            "key": "string",
            "value": {
              "match": {
                "exact-match": "string",
                "exact-not-match": "string",
                "pire-regex-match": "string",
                "pire-regex-not-match": "string",
                "prefix-match": "string",
                "prefix-not-match": "string"
              }
            }
          }, ...
        ]
      }
    },
    "description": "string",
    "name": "string",
    "override-variant-uuid": "string",
    "priority": "integer"
  }, ...
]
```

{% endcut %} ||
|| `--deletion-protection` | Determines whether captcha is protected from being deleted. ||
|| `--override-variants` | `shorthand/json`

List of variants to use in security_rules

{% cut "Description" %}

> - uuid (string)\
Unique identifier of the variant.
> - description (string)\
Optional description of the rule. 0-512 characters long.
> - complexity (structure)\
Complexity of the captcha.
> - pre-check-type (structure)\
Basic check type of the captcha.
> - challenge-type (structure)\
Additional task type of the captcha.

{% endcut %}

{% cut "Shorthand Syntax" %}

```hcl
[
  {
    challenge-type = IMAGE_TEXT|SILHOUETTES|KALEIDOSCOPE,
    complexity = EASY|MEDIUM|HARD|FORCE_HARD,
    description = string,
    pre-check-type = CHECKBOX|SLIDER,
    uuid = string
  }, ...
]
```

{% endcut %}

{% cut "JSON Syntax" %}

```json
[
  {
    "challenge-type": "IMAGE_TEXT|SILHOUETTES|KALEIDOSCOPE",
    "complexity": "EASY|MEDIUM|HARD|FORCE_HARD",
    "description": "string",
    "pre-check-type": "CHECKBOX|SLIDER",
    "uuid": "string"
  }, ...
]
```

{% endcut %} ||
|| `--disallow-data-processing` | If true, Yandex team won't be able to read internal data. ||
|| `--description` | `string`

Optional description of the captcha. ||
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
yc smartcaptcha v1 captcha update --example-json > request.json
or
yc smartcaptcha v1 captcha update --example-yaml > request.yaml

2. Edit the template file

3. Run with template:
yc smartcaptcha v1 captcha update -r request.json
or
yc smartcaptcha v1 captcha update -r request.yaml ||
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
