---
editable: false
noIndex: true
---

# yc beta managed-greenplum resource-group update

Update resource group

#### Command Usage

Syntax:

`yc beta managed-greenplum resource-group update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

 ||
|| `--resource-group` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  concurrency = int,
  cpu-rate-limit = int,
  is-user-defined = bool,
  memory-limit = int,
  memory-shared-quota = int,
  memory-spill-ratio = int,
  name = str
}
```

JSON Syntax:

```json
{
  "concurrency": "int",
  "cpu-rate-limit": "int",
  "is-user-defined": "bool",
  "memory-limit": "int",
  "memory-shared-quota": "int",
  "memory-spill-ratio": "int",
  "name": "str"
}
```

Fields:

```
concurrency -> (int)
  References to CONCURRENCY from gp resource group parameter
cpu-rate-limit -> (int)
  References to CPU_RATE_LIMIT from gp resource group parameter
is-user-defined -> (bool)
memory-limit -> (int)
  References to MEMORY_LIMIT from gp resource group parameter
memory-shared-quota -> (int)
  References to MEMORY_SHARED_QUOTA from gp resource group parameter
memory-spill-ratio -> (int)
  References to MEMORY_SPILL_RATIO from gp resource group parameter
name -> (string)
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