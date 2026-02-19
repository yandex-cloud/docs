---
editable: false
noIndex: true
---

# yc beta backup backup list

List backups using filters.

#### Command Usage

Syntax:

`yc beta backup backup list`

#### Flags

#|
||Flag | Description ||
|| `--filter` | `string`

Filter list by various parameters. Supported parameters are: * created_at Supported logic operators: * AND ||
|| `--order-by` | `string`

By which column the listing should be ordered and in which direction, format is "createdAt desc". "createdAt desc" if omitted. ||
|| `--page-size` | `int`

Number of results per page. ||
|| `--page-token` | `string`

Token for the results page. Not allowed to use if listing is performed by specific policy ID. ||
|| `--type` | `enum`

Type of resource. Could be compute VM or baremetal server. Possible Values: 'compute', 'bms', 'external-vm', 'external-server' ||
|| `--compute-instance-id` | `string`

List backups that belongs to specific Compute Cloud instance. ||
|| `--archive` | `shorthand/json`

List backups that belongs to specific archive of specific folder.

Shorthand Syntax:

```hcl
{
  archive-id = string,
  folder-id = string
}
```

JSON Syntax:

```json
{
  "archive-id": "string",
  "folder-id": "string"
}
```

Fields:

```
archive-id -> (string)
  Archive ID.
folder-id -> (string)
  Folder ID.
``` ||
|| `--folder-id` | `string`

List backups that belongs to specific folder. ||
|| `--instance-policy` | `shorthand/json`

List backups that belongs to specific instance and policy at the same time.

Shorthand Syntax:

```hcl
{
  compute-instance-id = string,
  policy-id = string
}
```

JSON Syntax:

```json
{
  "compute-instance-id": "string",
  "policy-id": "string"
}
```

Fields:

```
compute-instance-id -> (string)
  Compute Cloud instance ID.
policy-id -> (string)
  Policy ID.
``` ||
|| `--resource-id` | `string`

List backups by specific resource ID. ||
|| `--policy-id` | `string`

List backups by specific policy ID. ||
|| `--backup` | `shorthand/json`

List backups by specific backup ID.

Shorthand Syntax:

```hcl
{
  backup-id = string,
  folder-id = string
}
```

JSON Syntax:

```json
{
  "backup-id": "string",
  "folder-id": "string"
}
```

Fields:

```
backup-id -> (string)
folder-id -> (string)
``` ||
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