---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/ydb/cli-ref-beta/database/create.md
---

# yc beta ydb database create

Creates a new database.

#### Command Usage

Syntax:

`yc beta ydb database create <FOLDER-ID>`

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
|| `--assign-public-ips` |  ||
|| `--backup-config` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  backup-settings = [
    {
      backup-schedule = {
        next-execute-time = timestamp,
        policy = daily-backup-schedule={
          execute-time = timeofday
        } | recurring-backup-schedule={
          recurrence = str,
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
      description = str,
      name = str,
      source-paths = str,...,
      source-paths-to-exclude = str,...,
      storage-class = STANDARD|REDUCED_REDUNDANCY|STANDARD_IA|ONEZONE_IA|INTELLIGENT_TIERING|GLACIER|DEEP_ARCHIVE|OUTPOSTS,
      type = SYSTEM|USER
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "backup-settings": [
    {
      "backup-schedule": {
        "next-execute-time": "timestamp",
        "policy": {
          "daily-backup-schedule": {
            "execute-time": "timeofday"
          },
          "recurring-backup-schedule": {
            "recurrence": "str",
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
      "description": "str",
      "name": "str",
      "source-paths": [
        "str", ...
      ],
      "source-paths-to-exclude": [
        "str", ...
      ],
      "storage-class": "STANDARD|REDUCED_REDUNDANCY|STANDARD_IA|ONEZONE_IA|INTELLIGENT_TIERING|GLACIER|DEEP_ARCHIVE|OUTPOSTS",
      "type": "SYSTEM|USER"
    }, ...
  ]
}
```

Fields:

```
backup-settings -> ([]struct)
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
|| `--deletion-protection` |  ||
|| `--description` | `string`

 ||
|| `--folder-id` | `string`

 ||
|| `--labels` | `stringToString`

 ||
|| `--location-id` | `string`

 ||
|| `--monitoring-config` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  alerts = [
    {
      alert-id = str,
      alert-parameters = [
        {
          parameter = double-parameter-value={
            name = str,
            value = double
          } | integer-parameter-value={
            name = str,
            value = int
          } | label-list-parameter-value={
            name = str,
            values = str,...
          } | text-list-parameter-value={
            name = str,
            values = str,...
          } | text-parameter-value={
            name = str,
            value = str
          }
        }, ...
      ],
      alert-template-id = str,
      alert-thresholds = [
        {
          parameter = double-parameter-value={
            name = str,
            value = double
          } | integer-parameter-value={
            name = str,
            value = int
          } | label-list-parameter-value={
            name = str,
            values = str,...
          } | text-list-parameter-value={
            name = str,
            values = str,...
          } | text-parameter-value={
            name = str,
            value = str
          }
        }, ...
      ],
      description = str,
      name = str,
      notification-channels = [
        {
          notification-channel-id = str,
          notify-about-statuses = [
            ALERT_EVALUATION_STATUS_OK|ALERT_EVALUATION_STATUS_NO_DATA|ALERT_EVALUATION_STATUS_ERROR|ALERT_EVALUATION_STATUS_ALARM|ALERT_EVALUATION_STATUS_WARN, ...
          ],
          repeate-notify-delay-ms = int
        }, ...
      ]
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "alerts": [
    {
      "alert-id": "str",
      "alert-parameters": [
        {
          "parameter": {
            "double-parameter-value": {
              "name": "str",
              "value": "double"
            },
            "integer-parameter-value": {
              "name": "str",
              "value": "int"
            },
            "label-list-parameter-value": {
              "name": "str",
              "values": [
                "str", ...
              ]
            },
            "text-list-parameter-value": {
              "name": "str",
              "values": [
                "str", ...
              ]
            },
            "text-parameter-value": {
              "name": "str",
              "value": "str"
            }
          }
        }, ...
      ],
      "alert-template-id": "str",
      "alert-thresholds": [
        {
          "parameter": {
            "double-parameter-value": {
              "name": "str",
              "value": "double"
            },
            "integer-parameter-value": {
              "name": "str",
              "value": "int"
            },
            "label-list-parameter-value": {
              "name": "str",
              "values": [
                "str", ...
              ]
            },
            "text-list-parameter-value": {
              "name": "str",
              "values": [
                "str", ...
              ]
            },
            "text-parameter-value": {
              "name": "str",
              "value": "str"
            }
          }
        }, ...
      ],
      "description": "str",
      "name": "str",
      "notification-channels": [
        {
          "notification-channel-id": "str",
          "notify-about-statuses": [
            "ALERT_EVALUATION_STATUS_OK|ALERT_EVALUATION_STATUS_NO_DATA|ALERT_EVALUATION_STATUS_ERROR|ALERT_EVALUATION_STATUS_ALARM|ALERT_EVALUATION_STATUS_WARN", ...
          ],
          "repeate-notify-delay-ms": "int"
        }, ...
      ]
    }, ...
  ]
}
```

Fields:

```
alerts -> ([]struct)
  alert-id -> (string)
    output only field.
  alert-parameters -> ([]struct)
    alert parameters to override.
    parameter -> (oneof<double-parameter-value|integer-parameter-value|label-list-parameter-value|text-list-parameter-value|text-parameter-value>)
      Oneof parameter field
      double-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (double)
          Required. Parameter value
      integer-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (int)
          Required. Parameter value
      text-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (string)
          Required. Parameter value
      text-list-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        values -> ([]string)
          Required. Parameter value
      label-list-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        values -> ([]string)
          Required. Parameter value
  alert-template-id -> (string)
    template of the alert.
  alert-thresholds -> ([]struct)
    alert paratemers to override.
    parameter -> (oneof<double-parameter-value|integer-parameter-value|label-list-parameter-value|text-list-parameter-value|text-parameter-value>)
      Oneof parameter field
      double-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (double)
          Required. Parameter value
      integer-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (int)
          Required. Parameter value
      text-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (string)
          Required. Parameter value
      text-list-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        values -> ([]string)
          Required. Parameter value
      label-list-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        values -> ([]string)
          Required. Parameter value
  description -> (string)
    human readable description of the alert.
  name -> (string)
    name of the alert.
  notification-channels -> ([]struct)
    the notification channels of the alert.
    notification-channel-id -> (string)
    notify-about-statuses -> ([]struct)
    repeate-notify-delay-ms -> (int)
``` ||
|| `--name` | `string`

 ||
|| `--network-id` | `string`

 ||
|| `--resource-preset-id` | `string`

 ||
|| `--scale-policy` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  scale-type = auto-scale={
    auto-scale-type = target-tracking={
      target = cpu-utilization-percent=int
    },
    max-size = int,
    min-size = int
  } | fixed-scale={
    size = int
  }
}
```

JSON Syntax:

```json
{
  "scale-type": {
    "auto-scale": {
      "auto-scale-type": {
        "target-tracking": {
          "target": {
            "cpu-utilization-percent": "int"
          }
        }
      },
      "max-size": "int",
      "min-size": "int"
    },
    "fixed-scale": {
      "size": "int"
    }
  }
}
```

Fields:

```
scale-type -> (oneof<auto-scale|fixed-scale>)
  Oneof scale-type field
  fixed-scale -> (struct)
    size -> (int)
  auto-scale -> (struct)
    max-size -> (int)
      Maximum number of nodes to which autoscaling can scale the database.
    min-size -> (int)
      Minimum number of nodes to which autoscaling can scale the database.
    auto-scale-type -> (oneof<target-tracking>)
      Oneof auto-scale-type field
      target-tracking -> (struct)
        target -> (oneof<cpu-utilization-percent>)
          Oneof target field
          cpu-utilization-percent -> (int)
            A percentage of database nodes average CPU utilization.
``` ||
|| `--security-group-ids` | `strings`

 ||
|| `--storage-config` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  storage-options = [
    {
      group-count = int,
      storage-type-id = str
    }, ...
  ],
  storage-size-limit = int
}
```

JSON Syntax:

```json
{
  "storage-options": [
    {
      "group-count": "int",
      "storage-type-id": "str"
    }, ...
  ],
  "storage-size-limit": "int"
}
```

Fields:

```
storage-options -> ([]struct)
  group-count -> (int)
  storage-type-id -> (string)
storage-size-limit -> (int)
  output only field: storage size limit of dedicated database.
``` ||
|| `--subnet-ids` | `strings`

 ||
|| `--zonal-database` | `shorthand/json`

deprecated field

Shorthand Syntax:

```hcl
{
  zone-id = str
}
```

JSON Syntax:

```json
{
  "zone-id": "str"
}
```

Fields:

```
zone-id -> (string)
``` ||
|| `--regional-database` | `shorthand/json`

deprecated field

Shorthand Syntax:

```hcl
{
  region-id = str
}
```

JSON Syntax:

```json
{
  "region-id": "str"
}
```

Fields:

```
region-id -> (string)
``` ||
|| `--dedicated-database` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  assign-public-ips = bool,
  network-id = str,
  resource-preset-id = str,
  scale-policy = {
    scale-type = auto-scale={
      auto-scale-type = target-tracking={
        target = cpu-utilization-percent=int
      },
      max-size = int,
      min-size = int
    } | fixed-scale={
      size = int
    }
  },
  security-group-ids = str,...,
  storage-config = {
    storage-options = [
      {
        group-count = int,
        storage-type-id = str
      }, ...
    ],
    storage-size-limit = int
  },
  subnet-ids = str,...
}
```

JSON Syntax:

```json
{
  "assign-public-ips": "bool",
  "network-id": "str",
  "resource-preset-id": "str",
  "scale-policy": {
    "scale-type": {
      "auto-scale": {
        "auto-scale-type": {
          "target-tracking": {
            "target": {
              "cpu-utilization-percent": "int"
            }
          }
        },
        "max-size": "int",
        "min-size": "int"
      },
      "fixed-scale": {
        "size": "int"
      }
    }
  },
  "security-group-ids": [
    "str", ...
  ],
  "storage-config": {
    "storage-options": [
      {
        "group-count": "int",
        "storage-type-id": "str"
      }, ...
    ],
    "storage-size-limit": "int"
  },
  "subnet-ids": [
    "str", ...
  ]
}
```

Fields:

```
assign-public-ips -> (bool)
network-id -> (string)
resource-preset-id -> (string)
scale-policy -> (struct)
  scale-type -> (oneof<auto-scale|fixed-scale>)
    Oneof scale-type field
    fixed-scale -> (struct)
      size -> (int)
    auto-scale -> (struct)
      max-size -> (int)
        Maximum number of nodes to which autoscaling can scale the database.
      min-size -> (int)
        Minimum number of nodes to which autoscaling can scale the database.
      auto-scale-type -> (oneof<target-tracking>)
        Oneof auto-scale-type field
        target-tracking -> (struct)
          target -> (oneof<cpu-utilization-percent>)
            Oneof target field
            cpu-utilization-percent -> (int)
              A percentage of database nodes average CPU utilization.
security-group-ids -> ([]string)
storage-config -> (struct)
  storage-options -> ([]struct)
    group-count -> (int)
    storage-type-id -> (string)
  storage-size-limit -> (int)
    output only field: storage size limit of dedicated database.
subnet-ids -> ([]string)
``` ||
|| `--serverless-database` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  enable-throttling-rcu-limit = bool,
  provisioned-rcu-limit = int,
  storage-size-limit = int,
  throttling-rcu-limit = int,
  topic-write-quota = int
}
```

JSON Syntax:

```json
{
  "enable-throttling-rcu-limit": "bool",
  "provisioned-rcu-limit": "int",
  "storage-size-limit": "int",
  "throttling-rcu-limit": "int",
  "topic-write-quota": "int"
}
```

Fields:

```
enable-throttling-rcu-limit -> (bool)
  If false, the database is throttled by cloud value.
provisioned-rcu-limit -> (int)
  Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed.
storage-size-limit -> (int)
  Specify serverless database storage size limit. If zero, default value is applied.
throttling-rcu-limit -> (int)
  Let's define 1 RU - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If 'enable_throttling_rcu_limit' flag is true, the database will be throttled using 'throttling_rcu_limit' value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set.
topic-write-quota -> (int)
  write quota for topic service, defined in bytes per second.
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