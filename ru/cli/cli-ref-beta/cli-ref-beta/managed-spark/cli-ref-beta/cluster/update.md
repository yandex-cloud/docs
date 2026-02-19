---
editable: false
noIndex: true
---

# yc beta managed-spark cluster update

Updates configuration of the specified Spark cluster.

#### Command Usage

Syntax:

`yc beta managed-spark cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the Spark cluster. ||
|| `--config-spec` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  dependencies = {
    deb-packages = string,...,
    pip-packages = string,...
  },
  history-server = {
    enabled = boolean
  },
  metastore = {
    cluster-id = string
  },
  resource-pools = {
    driver = {
      resource-preset-id = string,
      scale-policy = {
        scale-type = auto-scale={
          max-size = integer,
          min-size = integer
        } | fixed-scale={
          size = integer
        }
      }
    },
    executor = {
      resource-preset-id = string,
      scale-policy = {
        scale-type = auto-scale={
          max-size = integer,
          min-size = integer
        } | fixed-scale={
          size = integer
        }
      }
    }
  },
  spark-version = string
}
```

JSON Syntax:

```json
{
  "dependencies": {
    "deb-packages": [
      "string", ...
    ],
    "pip-packages": [
      "string", ...
    ]
  },
  "history-server": {
    "enabled": "boolean"
  },
  "metastore": {
    "cluster-id": "string"
  },
  "resource-pools": {
    "driver": {
      "resource-preset-id": "string",
      "scale-policy": {
        "scale-type": {
          "auto-scale": {
            "max-size": "integer",
            "min-size": "integer"
          },
          "fixed-scale": {
            "size": "integer"
          }
        }
      }
    },
    "executor": {
      "resource-preset-id": "string",
      "scale-policy": {
        "scale-type": {
          "auto-scale": {
            "max-size": "integer",
            "min-size": "integer"
          },
          "fixed-scale": {
            "size": "integer"
          }
        }
      }
    }
  },
  "spark-version": "string"
}
```

Fields:

```
dependencies -> (struct)
  Container custom environment dependencies
  deb-packages -> ([]string)
  pip-packages -> ([]string)
history-server -> (struct)
  Configuration for HistoryServer
  enabled -> (boolean)
metastore -> (struct)
  Metastore Cluster
  cluster-id -> (string)
resource-pools -> (struct)
  driver -> (struct)
    resource-preset-id -> (string)
      ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).
    scale-policy -> (struct)
      scale-type -> (oneof<auto-scale|fixed-scale>)
        Oneof scale-type field
        fixed-scale -> (struct)
          size -> (integer)
        auto-scale -> (struct)
          max-size -> (integer)
          min-size -> (integer)
  executor -> (struct)
    resource-preset-id -> (string)
      ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).
    scale-policy -> (struct)
      scale-type -> (oneof<auto-scale|fixed-scale>)
        Oneof scale-type field
        fixed-scale -> (struct)
          size -> (integer)
        auto-scale -> (struct)
          max-size -> (integer)
          min-size -> (integer)
spark-version -> (string)
  Spark version. Format: "Major.Minor"
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the Spark cluster. 0-256 characters long. ||
|| `--labels` | `map<string><string>`

 ||
|| `--logging` | `shorthand/json`

Cloud logging configuration

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string,
  enabled = boolean
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "enabled": "boolean"
}
```

Fields:

```
enabled -> (boolean)
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  folder-id -> (string)
  log-group-id -> (string)
``` ||
|| `--maintenance-window` | `shorthand/json`

Window of maintenance operations.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
  weekly-maintenance-window -> (struct)
    day -> (struct)
    hour -> (integer)
      Hour of the day in UTC.
``` ||
|| `--name` | `string`

 ||
|| `--network-spec` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  security-group-ids = string,...
}
```

JSON Syntax:

```json
{
  "security-group-ids": [
    "string", ...
  ]
}
```

Fields:

```
security-group-ids -> ([]string)
  User security groups.
``` ||
|| `--service-account-id` | `string`

Service account used to access Cloud resources. ||
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