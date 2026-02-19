---
editable: false
noIndex: true
---

# yc beta load-balancer target-group update

Updates the specified target group.

#### Command Usage

Syntax:

`yc beta load-balancer target-group update <TARGET-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the target group. ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs. The existing set of '' labels '' is completely replaced with the provided set. ||
|| `--name` | `string`

Name of the target group. The name must be unique within the folder. ||
|| `--target-group-id` | `string`

ID of the TargetGroup resource to update. To get the target group ID, use a [TargetGroupService.List] request. ||
|| `--targets` | `shorthand/json`

A new list of targets for this target group.

Shorthand Syntax:

```hcl
[
  {
    address = string,
    subnet-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "address": "string",
    "subnet-id": "string"
  }, ...
]
```

Fields:

```
address -> (string)
  IP address of the target.
subnet-id -> (string)
  ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone.
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