---
editable: false
noIndex: true
---

# yc beta compute reserved-instance-pool update

Updates the specified reserved instance pool.

#### Command Usage

Syntax:

`yc beta compute reserved-instance-pool update <RESERVED-INSTANCE-POOL-ID>`

#### Flags

#|
||Flag | Description ||
|| `--allow-oversubscription` | Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots). While running instances are still limited by available slots, stopped instances can exceed this limit. Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|| `--allow-pending-slots` | This field affects only the current request and allows size-increasing operation to complete successfully even when there are not enough resources. In such cases, some of the new pool slots become "pending", meaning they cannot be used until resources become available. Pending slots automatically convert to normal slots when sufficient resources are available. ||
|| `--description` | `string`

Description of the reserved instance pool. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--name` | `string`

New name for the reserved instance pool. ||
|| `--reserved-instance-pool-id` | `string`

ID of the reserved instance pool to update. To get the reserved instance pool ID, use a [ReservedInstancePoolService.List] request. ||
|| `--size` | `int`

Desired size of the pool. ||
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