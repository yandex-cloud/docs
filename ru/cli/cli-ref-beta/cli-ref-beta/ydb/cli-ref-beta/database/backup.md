---
editable: false
noIndex: true
---

# yc beta ydb database backup



#### Command Usage

Syntax:

`yc beta ydb database backup <DATABASE-ID>`

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
|| `--backup-settings` | `shorthand/json`

custom backup options, if required.

Shorthand Syntax:

```hcl
{
  backup-schedule = {
    next-execute-time = timestamp,
    policy = daily-backup-schedule={
      execute-time = timeofday
    } | recurring-backup-schedule={
      recurrence = string,
      start-time = timestamp
    } | weekly-backup-schedule={
      days-of-week = [
        {
          days = [
            MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY, ...
          ],
          execute-time = timeofday
        }, ...
      ]
    }
  },
  backup-time-to-live = duration,
  description = string,
  name = string,
  source-paths = string,...,
  source-paths-to-exclude = string,...,
  storage-class = STANDARD|REDUCED_REDUNDANCY|STANDARD_IA|ONEZONE_IA|INTELLIGENT_TIERING|GLACIER|DEEP_ARCHIVE|OUTPOSTS,
  type = SYSTEM|USER
}
```

JSON Syntax:

```json
{
  "backup-schedule": {
    "next-execute-time": "timestamp",
    "policy": {
      "daily-backup-schedule": {
        "execute-time": "timeofday"
      },
      "recurring-backup-schedule": {
        "recurrence": "string",
        "start-time": "timestamp"
      },
      "weekly-backup-schedule": {
        "days-of-week": [
          {
            "days": [
              "MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY", ...
            ],
            "execute-time": "timeofday"
          }, ...
        ]
      }
    }
  },
  "backup-time-to-live": "duration",
  "description": "string",
  "name": "string",
  "source-paths": [
    "string", ...
  ],
  "source-paths-to-exclude": [
    "string", ...
  ],
  "storage-class": "STANDARD|REDUCED_REDUNDANCY|STANDARD_IA|ONEZONE_IA|INTELLIGENT_TIERING|GLACIER|DEEP_ARCHIVE|OUTPOSTS",
  "type": "SYSTEM|USER"
}
```

Fields:

```
backup-schedule -> (struct)
  provide schedule. if empty, backup will be disabled.
  next-execute-time -> (timestamp)
    output only field: when next backup will be executed using provided schedule.
  policy -> (oneof<daily-backup-schedule|recurring-backup-schedule|weekly-backup-schedule>)
    Oneof policy field
    daily-backup-schedule -> (struct)
      execute-time -> (timeofday)
    weekly-backup-schedule -> (struct)
      days-of-week -> ([]struct)
        days -> ([]struct)
        execute-time -> (timeofday)
    recurring-backup-schedule -> (struct)
      recurrence -> (string)
        An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported.
      start-time -> (timestamp)
        Timestamp of the first recurrence.
backup-time-to-live -> (duration)
  provide time to live of backup.
description -> (string)
  human readable description.
name -> (string)
  name of backup settings
source-paths -> ([]string)
  provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database.
source-paths-to-exclude -> ([]string)
  provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded.
storage-class -> (struct)
type -> (struct)
``` ||
|| `--database-id` | `string`

 ||
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