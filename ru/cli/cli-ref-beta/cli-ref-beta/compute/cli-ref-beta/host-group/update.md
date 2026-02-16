---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/host-group/update.md
---

# yc beta compute host-group update

Updates the specified host group.

#### Command Usage

Syntax:

`yc beta compute host-group update <HOST-GROUP-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the group. ||
|| `--host-group-id` | `string`

ID of the host group to update. To get the host group ID, use an [HostGroupService.List] request. ||
|| `--labels` | `stringToString`

Resource labels as 'key:value' pairs. The existing set of 'labels' is completely replaced by the provided set. ||
|| `--maintenance-policy` | `enum`

Behaviour on maintenance events Possible Values: 'restart', 'migrate' ||
|| `--name` | `string`

Name of the group. ||
|| `--scale-policy` | `shorthand/json`

Scale policy. Only fixed number of hosts are supported at this moment.

Shorthand Syntax:

```hcl
{
  scale-type = fixed-scale={
    size = int
  }
}
```

JSON Syntax:

```json
{
  "scale-type": {
    "fixed-scale": {
      "size": "int"
    }
  }
}
```

Fields:

```
scale-type -> (oneof<fixed-scale>)
  Oneof scale-type field
  fixed-scale -> (struct)
    size -> (int)
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