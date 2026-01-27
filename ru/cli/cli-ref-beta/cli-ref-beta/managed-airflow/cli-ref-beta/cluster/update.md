---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-airflow/cli-ref-beta/cluster/update.md
---

# yc beta managed-airflow cluster update

Updates the specified Apache Airflow cluster.

#### Command Usage

Syntax:

`yc beta managed-airflow cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the Apache Airflow Cluster resource to update. ||
|| `--code-sync` | `shorthand/json`

Parameters of the location and access to the code that will be executed in the cluster.

Shorthand Syntax:

```hcl
{
  source = git-sync={
    branch = str,
    repo = str,
    ssh-key = str,
    sub-path = str
  } | s3={
    bucket = str
  }
}
```

JSON Syntax:

```json
{
  "source": {
    "git-sync": {
      "branch": "str",
      "repo": "str",
      "ssh-key": "str",
      "sub-path": "str"
    },
    "s3": {
      "bucket": "str"
    }
  }
}
```

Fields:

```
source -> (oneof<git-sync|s3>)
  Oneof source field
  s3 -> (struct)
    bucket -> (string)
      The name of the Object Storage bucket that stores DAG files used in the cluster.
  git-sync -> (struct)
    branch -> (string)
      Git branch name to sync from.
    repo -> (string)
      Git repository URL.
    ssh-key -> (string)
      SSH private key for repository authentication.
    sub-path -> (string)
      Subdirectory path within the repository containing DAG files.
``` ||
|| `--config-spec` | `shorthand/json`

Configuration of Apache Airflow components.

Shorthand Syntax:

```hcl
{
  airflow = {
    config = {key=str, key=...}
  },
  airflow-version = str,
  dag-processor = {
    count = int,
    resources = {
      resource-preset-id = str
    }
  },
  dependencies = {
    deb-packages = str,...,
    pip-packages = str,...
  },
  lockbox = {
    enabled = bool
  },
  python-version = str,
  scheduler = {
    count = int,
    resources = {
      resource-preset-id = str
    }
  },
  triggerer = {
    count = int,
    resources = {
      resource-preset-id = str
    }
  },
  webserver = {
    count = int,
    resources = {
      resource-preset-id = str
    }
  },
  worker = {
    max-count = int,
    min-count = int,
    resources = {
      resource-preset-id = str
    }
  }
}
```

JSON Syntax:

```json
{
  "airflow": {
    "config": {
      "<key>": "str", ...
    }
  },
  "airflow-version": "str",
  "dag-processor": {
    "count": "int",
    "resources": {
      "resource-preset-id": "str"
    }
  },
  "dependencies": {
    "deb-packages": [
      "str", ...
    ],
    "pip-packages": [
      "str", ...
    ]
  },
  "lockbox": {
    "enabled": "bool"
  },
  "python-version": "str",
  "scheduler": {
    "count": "int",
    "resources": {
      "resource-preset-id": "str"
    }
  },
  "triggerer": {
    "count": "int",
    "resources": {
      "resource-preset-id": "str"
    }
  },
  "webserver": {
    "count": "int",
    "resources": {
      "resource-preset-id": "str"
    }
  },
  "worker": {
    "max-count": "int",
    "min-count": "int",
    "resources": {
      "resource-preset-id": "str"
    }
  }
}
```

Fields:

```
airflow -> (struct)
  Configuration of the Apache Airflow application itself.
  config -> (map[string,string])
    Properties to be passed to Apache Airflow configuration file.
airflow-version -> (string)
  Apache Airflow version. Format: "Major.Minor"
dag-processor -> (struct)
  Configuration of dag-processor instances.
  count -> (int)
    The number of dag-processor instances in the cluster.
  resources -> (struct)
    Resources allocated to dag-processor instances.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to an instance (CPU, memory etc.).
dependencies -> (struct)
  The list of additional packages installed in the cluster.
  deb-packages -> ([]string)
    System packages that are installed in the cluster.
  pip-packages -> ([]string)
    Python packages that are installed in the cluster.
lockbox -> (struct)
  Configuration of Lockbox Secret Backend.
  enabled -> (bool)
    The setting allows to enable Lockbox Secret Backend.
python-version -> (string)
  Python version. Format: "Major.Minor"
scheduler -> (struct)
  Configuration of scheduler instances.
  count -> (int)
    The number of scheduler instances in the cluster.
  resources -> (struct)
    Resources allocated to scheduler instances.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to an instance (CPU, memory etc.).
triggerer -> (struct)
  Configuration of triggerer instances.
  count -> (int)
    The number of triggerer instances in the cluster.
  resources -> (struct)
    Resources allocated to triggerer instances.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to an instance (CPU, memory etc.).
webserver -> (struct)
  Configuration of webserver instances.
  count -> (int)
    The number of webserver instances in the cluster.
  resources -> (struct)
    Resources allocated to webserver instances.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to an instance (CPU, memory etc.).
worker -> (struct)
  Configuration of worker instances.
  max-count -> (int)
    The maximum number of worker instances in the cluster.
  min-count -> (int)
    The minimum number of worker instances in the cluster.
  resources -> (struct)
    Resources allocated to worker instances.
    resource-preset-id -> (string)
      ID of the preset for computational resources available to an instance (CPU, memory etc.).
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description of the Apache Airflow cluster. ||
|| `--labels` | `stringToString`

Custom labels for the Apache Airflow cluster as '' key:value '' pairs. For example, "env": "prod". The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--logging` | `shorthand/json`

Cloud Logging configuration.

Shorthand Syntax:

```hcl
{
  destination = folder-id=str | log-group-id=str,
  enabled = bool,
  min-level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "str",
    "log-group-id": "str"
  },
  "enabled": "bool",
  "min-level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL"
}
```

Fields:

```
enabled -> (bool)
  Logs generated by the Airflow components are delivered to Cloud Logging.
min-level -> (struct)
  Minimum log entry level. See [LogLevel.Level] for details.
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  folder-id -> (string)
    Logs should be written to default log group for specified folder.
  log-group-id -> (string)
    Logs should be written to log group resolved by ID.
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

New name of the cluster. ||
|| `--network-spec` | `shorthand/json`

Network related configuration options.

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

Service account used to access Cloud resources. For more information, see documentation. ||
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