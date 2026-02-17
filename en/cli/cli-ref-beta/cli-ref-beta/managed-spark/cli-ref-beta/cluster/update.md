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
    deb-packages = str,...,
    pip-packages = str,...
  },
  history-server = {
    enabled = bool
  },
  metastore = {
    cluster-id = str
  },
  resource-pools = {
    driver = {
      resource-preset-id = str,
      scale-policy = {
        scale-type = auto-scale={
          max-size = int,
          min-size = int
        } | fixed-scale={
          size = int
        }
      }
    },
    executor = {
      resource-preset-id = str,
      scale-policy = {
        scale-type = auto-scale={
          max-size = int,
          min-size = int
        } | fixed-scale={
          size = int
        }
      }
    }
  },
  spark-version = str
}
```

JSON Syntax:

```json
{
  "dependencies": {
    "deb-packages": [
      "str", ...
    ],
    "pip-packages": [
      "str", ...
    ]
  },
  "history-server": {
    "enabled": "bool"
  },
  "metastore": {
    "cluster-id": "str"
  },
  "resource-pools": {
    "driver": {
      "resource-preset-id": "str",
      "scale-policy": {
        "scale-type": {
          "auto-scale": {
            "max-size": "int",
            "min-size": "int"
          },
          "fixed-scale": {
            "size": "int"
          }
        }
      }
    },
    "executor": {
      "resource-preset-id": "str",
      "scale-policy": {
        "scale-type": {
          "auto-scale": {
            "max-size": "int",
            "min-size": "int"
          },
          "fixed-scale": {
            "size": "int"
          }
        }
      }
    }
  },
  "spark-version": "str"
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
  enabled -> (bool)
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
          size -> (int)
        auto-scale -> (struct)
          max-size -> (int)
          min-size -> (int)
  executor -> (struct)
    resource-preset-id -> (string)
      ID of the preset for computational resources allocated to a instance (e.g., CPU, memory, etc.).
    scale-policy -> (struct)
      scale-type -> (oneof<auto-scale|fixed-scale>)
        Oneof scale-type field
        fixed-scale -> (struct)
          size -> (int)
        auto-scale -> (struct)
          max-size -> (int)
          min-size -> (int)
spark-version -> (string)
  Spark version. Format: "Major.Minor"
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

Description of the Spark cluster. 0-256 characters long. ||
|| `--labels` | `stringToString`

 ||
|| `--logging` | `shorthand/json`

Cloud logging configuration

Shorthand Syntax:

```hcl
{
  destination = folder-id=str | log-group-id=str,
  enabled = bool
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "str",
    "log-group-id": "str"
  },
  "enabled": "bool"
}
```

Fields:

```
enabled -> (bool)
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
    hour = int
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
      "hour": "int"
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
    hour -> (int)
      Hour of the day in UTC.
``` ||
|| `--name` | `string`

 ||
|| `--network-spec` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  security-group-ids = str,...
}
```

JSON Syntax:

```json
{
  "security-group-ids": [
    "str", ...
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