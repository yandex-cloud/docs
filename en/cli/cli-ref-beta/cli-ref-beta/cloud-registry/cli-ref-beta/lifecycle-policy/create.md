---
editable: false
noIndex: true
---

# yc beta cloud-registry lifecycle-policy create

Creates a lifecycle policy in the specified registry.

#### Command Usage

Syntax:

`yc beta cloud-registry lifecycle-policy create <REGISTRY-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--description` | `string`

Description of the lifecycle policy. 0-1024 characters long. ||
|| `--name` | `string`

Name of the lifecycle policy. ||
|| `--registry-id` | `string`

ID of the registry to create a lifecycle policy in. ||
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
      condition = always=boolean | older-than-days=integer | version-condition={
        versions-count-greater-than = integer
      },
      cooldown-period-days = integer,
      type = HARD_DELETE|SOFT_DELETE
    } | keep-by-age={
      younger-than-days = integer
    } | keep-by-version={
      keep-versions-count = integer
    },
    path-prefix = string,
    version-regexp = string
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
          "always": "boolean",
          "older-than-days": "integer",
          "version-condition": {
            "versions-count-greater-than": "integer"
          }
        },
        "cooldown-period-days": "integer",
        "type": "HARD_DELETE|SOFT_DELETE"
      },
      "keep-by-age": {
        "younger-than-days": "integer"
      },
      "keep-by-version": {
        "keep-versions-count": "integer"
      }
    },
    "path-prefix": "string",
    "version-regexp": "string"
  }, ...
]
```

Fields:

```
path-prefix -> (string)
  Path prefix to which the rule applies.
version-regexp -> (string)
  Regular expression pattern to match package version or docker tag.
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
    younger-than-days -> (integer)
      Keep artifacts younger than this number of days.
  keep-by-version -> (struct)
    Rule that keeps artifacts by version count.
    keep-versions-count -> (integer)
      Number of versions to keep.
  delete -> (struct)
    Rule that deletes artifacts.
    cooldown-period-days -> (integer)
      Cooldown period in days before deletion.
    type -> (struct)
      Type of deletion.
    condition -> (oneof<always|older-than-days|version-condition>)
      Oneof condition field
      older-than-days -> (integer)
        Delete artifacts older than specified days.
      version-condition -> (struct)
        Delete artifacts by version count condition.
        versions-count-greater-than -> (integer)
          Delete when version count exceeds this number.
      always -> (boolean)
        Always delete (use with caution).
``` ||
|| `--state` | `enum`

Initial state of the lifecycle policy. Possible Values: 'disabled', 'enabled' ||
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