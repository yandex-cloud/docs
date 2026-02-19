---
editable: false
noIndex: true
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
|| `--labels` | `map<string><string>`

 ||
|| `--location-id` | `string`

 ||
|| `--monitoring-config` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  alerts = [
    {
      alert-id = string,
      alert-parameters = [
        {
          parameter = double-parameter-value={
            name = string,
            value = float64
          } | integer-parameter-value={
            name = string,
            value = integer
          } | label-list-parameter-value={
            name = string,
            values = string,...
          } | text-list-parameter-value={
            name = string,
            values = string,...
          } | text-parameter-value={
            name = string,
            value = string
          }
        }, ...
      ],
      alert-template-id = string,
      alert-thresholds = [
        {
          parameter = double-parameter-value={
            name = string,
            value = float64
          } | integer-parameter-value={
            name = string,
            value = integer
          } | label-list-parameter-value={
            name = string,
            values = string,...
          } | text-list-parameter-value={
            name = string,
            values = string,...
          } | text-parameter-value={
            name = string,
            value = string
          }
        }, ...
      ],
      description = string,
      name = string,
      notification-channels = [
        {
          notification-channel-id = string,
          notify-about-statuses = [
            ALERT_EVALUATION_STATUS_OK|ALERT_EVALUATION_STATUS_NO_DATA|ALERT_EVALUATION_STATUS_ERROR|ALERT_EVALUATION_STATUS_ALARM|ALERT_EVALUATION_STATUS_WARN, ...
          ],
          repeate-notify-delay-ms = integer
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
      "alert-id": "string",
      "alert-parameters": [
        {
          "parameter": {
            "double-parameter-value": {
              "name": "string",
              "value": "float64"
            },
            "integer-parameter-value": {
              "name": "string",
              "value": "integer"
            },
            "label-list-parameter-value": {
              "name": "string",
              "values": [
                "string", ...
              ]
            },
            "text-list-parameter-value": {
              "name": "string",
              "values": [
                "string", ...
              ]
            },
            "text-parameter-value": {
              "name": "string",
              "value": "string"
            }
          }
        }, ...
      ],
      "alert-template-id": "string",
      "alert-thresholds": [
        {
          "parameter": {
            "double-parameter-value": {
              "name": "string",
              "value": "float64"
            },
            "integer-parameter-value": {
              "name": "string",
              "value": "integer"
            },
            "label-list-parameter-value": {
              "name": "string",
              "values": [
                "string", ...
              ]
            },
            "text-list-parameter-value": {
              "name": "string",
              "values": [
                "string", ...
              ]
            },
            "text-parameter-value": {
              "name": "string",
              "value": "string"
            }
          }
        }, ...
      ],
      "description": "string",
      "name": "string",
      "notification-channels": [
        {
          "notification-channel-id": "string",
          "notify-about-statuses": [
            "ALERT_EVALUATION_STATUS_OK|ALERT_EVALUATION_STATUS_NO_DATA|ALERT_EVALUATION_STATUS_ERROR|ALERT_EVALUATION_STATUS_ALARM|ALERT_EVALUATION_STATUS_WARN", ...
          ],
          "repeate-notify-delay-ms": "integer"
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
        value -> (float64)
          Required. Parameter value
      integer-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (integer)
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
        value -> (float64)
          Required. Parameter value
      integer-parameter-value -> (struct)
        name -> (string)
          Required. Parameter name
        value -> (integer)
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
    repeate-notify-delay-ms -> (integer)
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
      target = cpu-utilization-percent=integer
    },
    max-size = integer,
    min-size = integer
  } | fixed-scale={
    size = integer
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
            "cpu-utilization-percent": "integer"
          }
        }
      },
      "max-size": "integer",
      "min-size": "integer"
    },
    "fixed-scale": {
      "size": "integer"
    }
  }
}
```

Fields:

```
scale-type -> (oneof<auto-scale|fixed-scale>)
  Oneof scale-type field
  fixed-scale -> (struct)
    size -> (integer)
  auto-scale -> (struct)
    max-size -> (integer)
      Maximum number of nodes to which autoscaling can scale the database.
    min-size -> (integer)
      Minimum number of nodes to which autoscaling can scale the database.
    auto-scale-type -> (oneof<target-tracking>)
      Oneof auto-scale-type field
      target-tracking -> (struct)
        target -> (oneof<cpu-utilization-percent>)
          Oneof target field
          cpu-utilization-percent -> (integer)
            A percentage of database nodes average CPU utilization.
``` ||
|| `--security-group-ids` | `[]string`

 ||
|| `--storage-config` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  storage-options = [
    {
      group-count = integer,
      storage-type-id = string
    }, ...
  ],
  storage-size-limit = integer
}
```

JSON Syntax:

```json
{
  "storage-options": [
    {
      "group-count": "integer",
      "storage-type-id": "string"
    }, ...
  ],
  "storage-size-limit": "integer"
}
```

Fields:

```
storage-options -> ([]struct)
  group-count -> (integer)
  storage-type-id -> (string)
storage-size-limit -> (integer)
  output only field: storage size limit of dedicated database.
``` ||
|| `--subnet-ids` | `[]string`

 ||
|| `--zonal-database` | `shorthand/json`

deprecated field

Shorthand Syntax:

```hcl
{
  zone-id = string
}
```

JSON Syntax:

```json
{
  "zone-id": "string"
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
  region-id = string
}
```

JSON Syntax:

```json
{
  "region-id": "string"
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
  assign-public-ips = boolean,
  network-id = string,
  resource-preset-id = string,
  scale-policy = {
    scale-type = auto-scale={
      auto-scale-type = target-tracking={
        target = cpu-utilization-percent=integer
      },
      max-size = integer,
      min-size = integer
    } | fixed-scale={
      size = integer
    }
  },
  security-group-ids = string,...,
  storage-config = {
    storage-options = [
      {
        group-count = integer,
        storage-type-id = string
      }, ...
    ],
    storage-size-limit = integer
  },
  subnet-ids = string,...
}
```

JSON Syntax:

```json
{
  "assign-public-ips": "boolean",
  "network-id": "string",
  "resource-preset-id": "string",
  "scale-policy": {
    "scale-type": {
      "auto-scale": {
        "auto-scale-type": {
          "target-tracking": {
            "target": {
              "cpu-utilization-percent": "integer"
            }
          }
        },
        "max-size": "integer",
        "min-size": "integer"
      },
      "fixed-scale": {
        "size": "integer"
      }
    }
  },
  "security-group-ids": [
    "string", ...
  ],
  "storage-config": {
    "storage-options": [
      {
        "group-count": "integer",
        "storage-type-id": "string"
      }, ...
    ],
    "storage-size-limit": "integer"
  },
  "subnet-ids": [
    "string", ...
  ]
}
```

Fields:

```
assign-public-ips -> (boolean)
network-id -> (string)
resource-preset-id -> (string)
scale-policy -> (struct)
  scale-type -> (oneof<auto-scale|fixed-scale>)
    Oneof scale-type field
    fixed-scale -> (struct)
      size -> (integer)
    auto-scale -> (struct)
      max-size -> (integer)
        Maximum number of nodes to which autoscaling can scale the database.
      min-size -> (integer)
        Minimum number of nodes to which autoscaling can scale the database.
      auto-scale-type -> (oneof<target-tracking>)
        Oneof auto-scale-type field
        target-tracking -> (struct)
          target -> (oneof<cpu-utilization-percent>)
            Oneof target field
            cpu-utilization-percent -> (integer)
              A percentage of database nodes average CPU utilization.
security-group-ids -> ([]string)
storage-config -> (struct)
  storage-options -> ([]struct)
    group-count -> (integer)
    storage-type-id -> (string)
  storage-size-limit -> (integer)
    output only field: storage size limit of dedicated database.
subnet-ids -> ([]string)
``` ||
|| `--serverless-database` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  enable-throttling-rcu-limit = boolean,
  provisioned-rcu-limit = integer,
  storage-size-limit = integer,
  throttling-rcu-limit = integer,
  topic-write-quota = integer
}
```

JSON Syntax:

```json
{
  "enable-throttling-rcu-limit": "boolean",
  "provisioned-rcu-limit": "integer",
  "storage-size-limit": "integer",
  "throttling-rcu-limit": "integer",
  "topic-write-quota": "integer"
}
```

Fields:

```
enable-throttling-rcu-limit -> (boolean)
  If false, the database is throttled by cloud value.
provisioned-rcu-limit -> (integer)
  Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed.
storage-size-limit -> (integer)
  Specify serverless database storage size limit. If zero, default value is applied.
throttling-rcu-limit -> (integer)
  Let's define 1 RU - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If 'enable_throttling_rcu_limit' flag is true, the database will be throttled using 'throttling_rcu_limit' value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set.
topic-write-quota -> (integer)
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