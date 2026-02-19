---
editable: false
noIndex: true
---

# yc beta smartcaptcha captcha create

Creates a captcha in the specified folder using the data specified in the request.

#### Command Usage

Syntax:

`yc beta smartcaptcha captcha create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--allowed-sites` | `[]string`

List of allowed host names, see documentation. ||
|| `--challenge-type` | `enum`

Additional task type of the captcha. Possible Values: 'image-text', 'silhouettes', 'kaleidoscope' ||
|| `--complexity` | `enum`

Complexity of the captcha. Possible Values: 'easy', 'medium', 'hard', 'force-hard' ||
|| `--deletion-protection` | Determines whether captcha is protected from being deleted. ||
|| `--description` | `string`

Optional description of the captcha. ||
|| `--disallow-data-processing` | If true, Yandex team won't be able to read internal data. ||
|| `--folder-id` | `string`

ID of the folder to create a captcha in. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the captcha. The name must be unique within the folder. ||
|| `--override-variants` | `shorthand/json`

List of variants to use in security_rules

Shorthand Syntax:

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

JSON Syntax:

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

Fields:

```
challenge-type -> (struct)
  Additional task type of the captcha.
complexity -> (struct)
  Complexity of the captcha.
description -> (string)
  Optional description of the rule. 0-512 characters long.
pre-check-type -> (struct)
  Basic check type of the captcha.
uuid -> (string)
  Unique identifier of the variant.
``` ||
|| `--pre-check-type` | `enum`

Basic check type of the captcha. Possible Values: 'checkbox', 'slider' ||
|| `--security-rules` | `shorthand/json`

List of security rules.

Shorthand Syntax:

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

JSON Syntax:

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

Fields:

```
condition -> (struct)
  The condition for matching the rule.
  headers -> ([]struct)
    Captcha request headers.
    name -> (string)
      Name of header (case insensitive).
    value -> (struct)
      Value of the header.
      match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
        Oneof match field
        exact-match -> (string)
        exact-not-match -> (string)
        prefix-match -> (string)
        prefix-not-match -> (string)
        pire-regex-match -> (string)
        pire-regex-not-match -> (string)
  host -> (struct)
    Host where captcha placed.
    hosts -> ([]struct)
      List of hosts. OR semantics implied.
      match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
        Oneof match field
        exact-match -> (string)
        exact-not-match -> (string)
        prefix-match -> (string)
        prefix-not-match -> (string)
        pire-regex-match -> (string)
        pire-regex-not-match -> (string)
  source-ip -> (struct)
    The IP address of the requester.
    geo-ip-match -> (struct)
      locations -> ([]string)
        ISO 3166-1 alpha 2. OR semantics implied.
    geo-ip-not-match -> (struct)
      locations -> ([]string)
        ISO 3166-1 alpha 2. OR semantics implied.
    ip-ranges-match -> (struct)
      ip-ranges -> ([]string)
        List of IP ranges. OR semantics implied.
    ip-ranges-not-match -> (struct)
      ip-ranges -> ([]string)
        List of IP ranges. OR semantics implied.
  uri -> (struct)
    URI where captcha placed.
    path -> (struct)
      Path of the URI RFC3986.
      match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
        Oneof match field
        exact-match -> (string)
        exact-not-match -> (string)
        prefix-match -> (string)
        prefix-not-match -> (string)
        pire-regex-match -> (string)
        pire-regex-not-match -> (string)
    queries -> ([]struct)
      List of query matchers. AND semantics implied.
      key -> (string)
        Key of the query parameter.
      value -> (struct)
        Value of the query parameter.
        match -> (oneof<exact-match|exact-not-match|pire-regex-match|pire-regex-not-match|prefix-match|prefix-not-match>)
          Oneof match field
          exact-match -> (string)
          exact-not-match -> (string)
          prefix-match -> (string)
          prefix-not-match -> (string)
          pire-regex-match -> (string)
          pire-regex-not-match -> (string)
description -> (string)
  Optional description of the rule. 0-512 characters long.
name -> (string)
  Name of the rule. The name is unique within the captcha. 1-50 characters long.
override-variant-uuid -> (string)
  Variant UUID to show in case of match the rule. Keep empty to use defaults.
priority -> (integer)
  Priority of the rule. Lower value means higher priority.
``` ||
|| `--style-json` | `string`

JSON with variables to define the captcha appearance. For more details see generated JSON in cloud console. ||
|| `--turn-off-hostname-check` | Turn off host name check, see documentation. ||
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
|| `-h`, `--help` | Display help for the command. ||
|#