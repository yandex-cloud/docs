---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/quota-manager/cli-ref-beta/quota-limit/get.md
---

# yc beta quota-manager quota-limit get

Returns the specified quota limit.

#### Command Usage

Syntax:

`yc beta quota-manager quota-limit get <QUOTA-ID>`

#### Flags

#|
||Flag | Description ||
|| `--quota-id` | `string`

The id of the quota to retrieve. ||
|| `--resource` | `shorthand/json`

The resource for which the quota limit is being requested.

Shorthand Syntax:

```hcl
{
  id = str,
  type = str
}
```

JSON Syntax:

```json
{
  "id": "str",
  "type": "str"
}
```

Fields:

```
id -> (string)
  The id if the resource.
type -> (string)
  The type of the resource, e.g. resource-manager.cloud, billing.account.
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