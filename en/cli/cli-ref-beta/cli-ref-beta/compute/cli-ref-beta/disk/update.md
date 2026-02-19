---
editable: false
noIndex: true
---

# yc beta compute disk update

Updates the specified disk.

#### Command Usage

Syntax:

`yc beta compute disk update <DISK-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the disk. ||
|| `--disk-id` | `string`

ID of the Disk resource to update. To get the disk ID use a [DiskService.List] request. ||
|| `--disk-placement-policy` | `shorthand/json`

Placement policy configuration.

Shorthand Syntax:

```hcl
{
  placement-group-id = string,
  placement-group-partition = integer
}
```

JSON Syntax:

```json
{
  "placement-group-id": "string",
  "placement-group-partition": "integer"
}
```

Fields:

```
placement-group-id -> (string)
  Placement group ID.
placement-group-partition -> (integer)
``` ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--name` | `string`

Name of the disk. ||
|| `--size` | `int`

Size of the disk, specified in bytes. ||
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