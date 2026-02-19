---
editable: false
noIndex: true
---

# yc beta vpc security-group update

Updates the specified security group.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta vpc security-group update <SECURITY-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

New description of the security group. ||
|| `--labels` | `map<string><string>`

Security group labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: 1. Get the current set of labels with a [SecurityGroupService.Get] request. 2. Add or remove a label in this set. 3. Send the new set in this field. ||
|| `--name` | `string`

New name for the security group. The name must be unique within the folder. ||
|| `--rule-specs` | `shorthand/json`

Updated rule list. All existing rules will be replaced with given list.

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
|| `--security-group-id` | `string`

ID of the security group to update. To get the security group ID make a [SecurityGroupService.List] request. ||
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