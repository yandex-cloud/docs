---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/container/cli-ref-beta/lifecycle-policy/update.md
---

# yc beta container lifecycle-policy update

Updates the specified lifecycle policy.

#### Command Usage

Syntax:

`yc beta container lifecycle-policy update <LIFECYCLE-POLICY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of lifecycle policy. ||
|| `--lifecycle-policy-id` | `string`

ID of the lifecycle policy. ||
|| `--name` | `string`

Name of lifecycle policy. ||
|| `--rules` | `shorthand/json`

The rules of the lifecycle policy.

Shorthand Syntax:

```hcl
[
  {
    description = str,
    expire-period = duration,
    retained-top = int,
    tag-regexp = str,
    untagged = bool
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "description": "str",
    "expire-period": "duration",
    "retained-top": "int",
    "tag-regexp": "str",
    "untagged": "bool"
  }, ...
]
```

Fields:

```
description -> (string)
  Description of the lifecycle policy rule.
expire-period -> (duration)
  Period of time for automatic deletion. Period must be a multiple of 24 hours.
retained-top -> (int)
  Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.
tag-regexp -> (string)
  Tag for specifying a filter in the form of a regular expression.
untagged -> (bool)
  Tag for applying the rule to Docker images without tags.
``` ||
|| `--status` | `enum`

Status of the lifecycle policy. Possible Values: 'active', 'disabled' ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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