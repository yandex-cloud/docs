---
editable: false
noIndex: true
---

# yc beta vpc security-group create

Creates a security group in the specified folder and network.

#### Command Usage

Syntax:

`yc beta vpc security-group create <FOLDER-ID>`

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
|| `--description` | `string`

Description of the security group. ||
|| `--folder-id` | `string`

ID of the folder for this request to create a security group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs. ||
|| `--name` | `string`

Name of the security group. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the Network to create security group for. ||
|| `--rule-specs` | `shorthand/json`

Security rules specifications.

Shorthand Syntax:

```hcl
[
  {
    description = string,
    direction = INGRESS|EGRESS,
    labels = {key=string, key=...},
    ports = {
      from-port = integer,
      to-port = integer
    },
    protocol = protocol-name=string | protocol-number=integer,
    target = cidr-blocks={
      v4-cidr-blocks = string,...,
      v6-cidr-blocks = string,...
    } | predefined-target=string | security-group-id=string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "description": "string",
    "direction": "INGRESS|EGRESS",
    "labels": {
      "<key>": "string", ...
    },
    "ports": {
      "from-port": "integer",
      "to-port": "integer"
    },
    "protocol": {
      "protocol-name": "string",
      "protocol-number": "integer"
    },
    "target": {
      "cidr-blocks": {
        "v4-cidr-blocks": [
          "string", ...
        ],
        "v6-cidr-blocks": [
          "string", ...
        ]
      },
      "predefined-target": "string",
      "security-group-id": "string"
    }
  }, ...
]
```

Fields:

```
description -> (string)
  Description of the security rule.
direction -> (struct)
  The direction of network traffic allowed by this rule.
labels -> (map[string,string])
  Rule labels as '' key:value '' pairs.
ports -> (struct)
  The range of ports that allow traffic to pass through. Null value means any port.
  from-port -> (integer)
    The lowest port in the range.
  to-port -> (integer)
    The highest port in the range.
protocol -> (oneof<protocol-name|protocol-number>)
  Oneof protocol field
  protocol-name -> (string)
    Protocol name.
  protocol-number -> (integer)
    Protocol number from IANA protocol numbers.
target -> (oneof<cidr-blocks|predefined-target|security-group-id>)
  Oneof target field
  cidr-blocks -> (struct)
    CIDR blocks to allow to recieve or send traffic.
    v4-cidr-blocks -> ([]string)
      IPv4 CIDR blocks to allow traffic to.
    v6-cidr-blocks -> ([]string)
      IPv6 CIDR blocks to allow traffic to.
  security-group-id -> (string)
    ID of the security group to add rule to.
  predefined-target -> (string)
    Predefined target. See documentation for more information.
``` ||
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