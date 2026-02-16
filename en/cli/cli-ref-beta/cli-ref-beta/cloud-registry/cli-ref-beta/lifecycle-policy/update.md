---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cloud-registry/cli-ref-beta/lifecycle-policy/update.md
---

# yc beta cloud-registry lifecycle-policy update

Updates the specified lifecycle policy.

#### Command Usage

Syntax:

`yc beta cloud-registry lifecycle-policy update <POLICY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the lifecycle policy. 0-1024 characters long. ||
|| `--name` | `string`

Name of the lifecycle policy. ||
|| `--policy-id` | `string`

ID of the lifecycle policy to update. ||
|| `--rules` | `shorthand/json`

List of lifecycle rules.

Shorthand Syntax:

```hcl
[
  {
    filter = docker-filters={
      tag-status = TAG_STATUS_ANY|TAGGED|UNTAGGED
    } | maven-filters={
      version-type = VERSION_TYPE_ANY|RELEASE|SNAPSHOT
    },
    kind = delete={
      condition = always=bool | older-than-days=int | version-condition={
        versions-count-greater-than = int
      },
      cooldown-period-days = int,
      type = HARD_DELETE|SOFT_DELETE
    } | keep-by-age={
      younger-than-days = int
    } | keep-by-version={
      keep-versions-count = int
    },
    path-prefix = str
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "filter": {
      "docker-filters": {
        "tag-status": "TAG_STATUS_ANY|TAGGED|UNTAGGED"
      },
      "maven-filters": {
        "version-type": "VERSION_TYPE_ANY|RELEASE|SNAPSHOT"
      }
    },
    "kind": {
      "delete": {
        "condition": {
          "always": "bool",
          "older-than-days": "int",
          "version-condition": {
            "versions-count-greater-than": "int"
          }
        },
        "cooldown-period-days": "int",
        "type": "HARD_DELETE|SOFT_DELETE"
      },
      "keep-by-age": {
        "younger-than-days": "int"
      },
      "keep-by-version": {
        "keep-versions-count": "int"
      }
    },
    "path-prefix": "str"
  }, ...
]
```

Fields:

```
path-prefix -> (string)
  Path prefix to which the rule applies.
filter -> (oneof<docker-filters|maven-filters>)
  Oneof filter field
  docker-filters -> (struct)
    Docker-specific filters.
    tag-status -> (struct)
      Filter by tag status.
  maven-filters -> (struct)
    Maven-specific filters.
    version-type -> (struct)
      Filter by version type.
kind -> (oneof<delete|keep-by-age|keep-by-version>)
  Oneof kind field
  keep-by-age -> (struct)
    Rule that keeps artifacts by age.
    younger-than-days -> (int)
      Keep artifacts younger than this number of days.
  keep-by-version -> (struct)
    Rule that keeps artifacts by version count.
    keep-versions-count -> (int)
      Number of versions to keep.
  delete -> (struct)
    Rule that deletes artifacts.
    cooldown-period-days -> (int)
      Cooldown period in days before deletion.
    type -> (struct)
      Type of deletion.
    condition -> (oneof<always|older-than-days|version-condition>)
      Oneof condition field
      older-than-days -> (int)
        Delete artifacts older than specified days.
      version-condition -> (struct)
        Delete artifacts by version count condition.
        versions-count-greater-than -> (int)
          Delete when version count exceeds this number.
      always -> (bool)
        Always delete (use with caution).
``` ||
|| `--state` | `enum`

State of the lifecycle policy. Possible Values: 'disabled', 'enabled' ||
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