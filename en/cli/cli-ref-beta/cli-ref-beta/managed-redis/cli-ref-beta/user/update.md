---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-redis/cli-ref-beta/user/update.md
---

# yc beta managed-redis user update

Updates the specified Redis user.

#### Command Usage

Syntax:

`yc beta managed-redis user update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the Redis cluster the user belongs to. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--enabled` | Is Redis user enabled ||
|| `--passwords` | `strings`

New passwords the Redis user. ||
|| `--permissions` | `shorthand/json`

New set of permissions to grant to the user.

Shorthand Syntax:

```hcl
{
  categories = str,
  commands = str,
  patterns = str,
  pub-sub-channels = str,
  sanitize-payload = str
}
```

JSON Syntax:

```json
{
  "categories": "str",
  "commands": "str",
  "patterns": "str",
  "pub-sub-channels": "str",
  "sanitize-payload": "str"
}
```

Fields:

```
categories -> (str)
  Command categories user has permissions to.
commands -> (str)
  Commands user can execute.
patterns -> (str)
  Keys patterns user has permission to.
pub-sub-channels -> (str)
  Channel patterns user has permissions to.
sanitize-payload -> (str)
  SanitizePayload parameter.
``` ||
|| `--user-name` | `string`

Name of the Redis user to be updated. ||
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