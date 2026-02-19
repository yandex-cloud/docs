---
editable: false
noIndex: true
---

# yc beta application-load-balancer load-balancer get-target-states

Returns the statuses of all targets of the specified backend group in all their availability zones.

#### Command Usage

Syntax:

`yc beta application-load-balancer load-balancer get-target-states <LOAD-BALANCER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--backend-group-id` | `string`

ID of the backend group that the target group is attributed to. ||
|| `--load-balancer-id` | `string`

ID of the application load balancer that the backend group is attributed to. ||
|| `--target-group-id` | `string`

ID of the target group to get target states of. ||
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