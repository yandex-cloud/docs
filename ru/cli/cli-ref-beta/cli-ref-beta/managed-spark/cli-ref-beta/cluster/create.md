---
editable: false
noIndex: true
---

# yc beta managed-spark cluster create

Creates a Spark cluster.

#### Command Usage

Syntax:

`yc beta managed-spark cluster create <FOLDER-ID>`

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
|| `--config` | `shorthand/json`

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
|| `--folder-id` | `string`

ID of the folder to create Spark cluster in. ||
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

Name of the Spark cluster. The name must be unique within the folder. ||
|| `--network` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  security-group-ids = string,...,
  subnet-ids = string,...
}
```

JSON Syntax:

```json
{
  "security-group-ids": [
    "string", ...
  ],
  "subnet-ids": [
    "string", ...
  ]
}
```

Fields:

```
security-group-ids -> ([]string)
  User security groups
subnet-ids -> ([]string)
  IDs of VPC network subnets where instances of the cluster are attached.
``` ||
|| `--service-account-id` | `string`

Service account that will be used to access YC resources ||
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