---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-opensearch/cli-ref-beta/cluster/create.md
---

# yc beta managed-opensearch cluster create

Creates an OpenSearch cluster in the specified folder.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster create <FOLDER-ID>`

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
|| `--config-spec` | `shorthand/json`

OpenSearch cluster configuration.

Shorthand Syntax:

```hcl
{
  access = {
    data-transfer = bool,
    serverless = bool
  },
  admin-password = str,
  dashboards-spec = {
    node-groups = [
      {
        assign-public-ip = bool,
        disk-size-autoscaling = {
          disk-size-limit = int,
          emergency-usage-threshold = int,
          planned-usage-threshold = int
        },
        hosts-count = int,
        name = str,
        resources = {
          disk-size = int,
          disk-type-id = str,
          resource-preset-id = str
        },
        subnet-ids = str,...,
        zone-ids = str,...
      }, ...
    ]
  },
  opensearch-spec = {
    config = opensearch-config-2={
      fielddata-cache-size = str,
      max-clause-count = int,
      reindex-remote-whitelist = str
    },
    keystore-settings = [
      {
        name = str,
        value = str
      }, ...
    ],
    node-groups = [
      {
        assign-public-ip = bool,
        disk-size-autoscaling = {
          disk-size-limit = int,
          emergency-usage-threshold = int,
          planned-usage-threshold = int
        },
        hosts-count = int,
        name = str,
        resources = {
          disk-size = int,
          disk-type-id = str,
          resource-preset-id = str
        },
        roles = [
          DATA|MANAGER, ...
        ],
        subnet-ids = str,...,
        zone-ids = str,...
      }, ...
    ],
    plugins = str,...
  },
  snapshot-management = {
    snapshot-max-age-days = int,
    snapshot-schedule = {
      schedule = daily-snapshot-schedule={
        hour = int,
        minute = int
      } | hourly-snapshot-schedule={
        minute = int
      } | weekly-snapshot-schedule={
        day = MON|TUE|WED|THU|FRI|SAT|SUN,
        hour = int,
        minute = int
      }
    }
  },
  version = str
}
```

JSON Syntax:

```json
{
  "access": {
    "data-transfer": "bool",
    "serverless": "bool"
  },
  "admin-password": "str",
  "dashboards-spec": {
    "node-groups": [
      {
        "assign-public-ip": "bool",
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "hosts-count": "int",
        "name": "str",
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        },
        "subnet-ids": [
          "str", ...
        ],
        "zone-ids": [
          "str", ...
        ]
      }, ...
    ]
  },
  "opensearch-spec": {
    "config": {
      "opensearch-config-2": {
        "fielddata-cache-size": "str",
        "max-clause-count": "int",
        "reindex-remote-whitelist": "str"
      }
    },
    "keystore-settings": [
      {
        "name": "str",
        "value": "str"
      }, ...
    ],
    "node-groups": [
      {
        "assign-public-ip": "bool",
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "hosts-count": "int",
        "name": "str",
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        },
        "roles": [
          "DATA|MANAGER", ...
        ],
        "subnet-ids": [
          "str", ...
        ],
        "zone-ids": [
          "str", ...
        ]
      }, ...
    ],
    "plugins": [
      "str", ...
    ]
  },
  "snapshot-management": {
    "snapshot-max-age-days": "int",
    "snapshot-schedule": {
      "schedule": {
        "daily-snapshot-schedule": {
          "hour": "int",
          "minute": "int"
        },
        "hourly-snapshot-schedule": {
          "minute": "int"
        },
        "weekly-snapshot-schedule": {
          "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
          "hour": "int",
          "minute": "int"
        }
      }
    }
  },
  "version": "str"
}
```

Fields:

```
access -> (struct)
  Access policy for external services.
  data-transfer -> (bool)
    Determines whether the access to Data Transfer is allowed.
  serverless -> (bool)
    Determines whether the access to Serverless is allowed.
admin-password -> (string)
  OpenSearch admin password.
dashboards-spec -> (struct)
  Dashboards configuration.
  node-groups -> ([]struct)
    Dashboards type host groups of the cluster.
    assign-public-ip -> (bool)
      Determines whether a public IP is assigned to the hosts in the group.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (int)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (int)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (int)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    hosts-count -> (int)
      Number of hosts in the group.
    name -> (string)
      Name of the group.
    resources -> (struct)
      Resources allocated to the hosts.
      disk-size -> (int)
        Volume of the storage used by the host, in bytes.
      disk-type-id -> (string)
        Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
      resource-preset-id -> (string)
        ID of the preset for computational resources allocated to a host.
    subnet-ids -> ([]string)
      IDs of the subnets that the hosts belong to.
    zone-ids -> ([]string)
      IDs of the availability zones the hosts belong to.
opensearch-spec -> (struct)
  OpenSearch configuration.
  keystore-settings -> ([]struct)
    Initial cluster keystore settings.
    name -> (string)
      Keystore entry name.
    value -> (string)
      Keystore entry value.
  node-groups -> ([]struct)
    OpenSearch type host groups of the cluster.
    assign-public-ip -> (bool)
      Determines whether a public IP is assigned to the hosts in the group.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (int)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (int)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (int)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    hosts-count -> (int)
      Number of hosts in the group.
    name -> (string)
      Name of the group.
    resources -> (struct)
      Resources allocated to the hosts.
      disk-size -> (int)
        Volume of the storage used by the host, in bytes.
      disk-type-id -> (string)
        Type of the storage used by the host: 'network-hdd', 'network-ssd' or 'local-ssd'.
      resource-preset-id -> (string)
        ID of the preset for computational resources allocated to a host.
    roles -> ([]struct)
      Roles of the hosts in the group.
    subnet-ids -> ([]string)
      IDs of the subnets that the hosts belong to.
    zone-ids -> ([]string)
      IDs of the availability zones the hosts belong to.
  plugins -> ([]string)
    Names of the cluster plugins.
  config -> (oneof<opensearch-config-2>)
    Oneof config field
    opensearch-config-2 -> (struct)
      fielddata-cache-size -> (string)
        the percentage or absolute value (10%, 512mb) of heap space that is allocated to fielddata
      max-clause-count -> (int)
        the maximum number of allowed boolean clauses in a query
      reindex-remote-whitelist -> (string)
snapshot-management -> (struct)
  Snapshot management configuration
  snapshot-max-age-days -> (int)
    Snapshot max age in days
  snapshot-schedule -> (struct)
    Snapshot creation schedule
    schedule -> (oneof<daily-snapshot-schedule|hourly-snapshot-schedule|weekly-snapshot-schedule>)
      Oneof schedule field
      hourly-snapshot-schedule -> (struct)
        Hourly based snapshot schedule
        minute -> (int)
          The minute of the hour at which the backup should be created.
      daily-snapshot-schedule -> (struct)
        Daily based snapshot schedule
        hour -> (int)
          The hour of the day in UTC timezone at which the backup should be created.
        minute -> (int)
          The minute of the hour at which the backup should be created.
      weekly-snapshot-schedule -> (struct)
        Weekly based snapshot schedule
        day -> (struct)
          Day of the week
        hour -> (int)
          The hour of the day in UTC timezone at which the backup should be created.
        minute -> (int)
          The minute of the hour at which the backup should be created.
version -> (string)
  OpenSearch version.
``` ||
|| `--deletion-protection` | Determines whether the cluster is protected from being deleted. ||
|| `--description` | `string`

Description of the OpenSearch cluster. ||
|| `--disk-encryption-key-id` | `string`

ID of the key to encrypt cluster disks. ||
|| `--environment` | `enum`

Deployment environment of the OpenSearch cluster. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the OpenSearch cluster in. ||
|| `--labels` | `stringToString`

Custom labels for the OpenSearch cluster as 'key:value' pairs. For example, '"project": "mvp"' or '"source": "dictionary"'. ||
|| `--maintenance-window` | `shorthand/json`

Cluster maintenance window. Should be defined by either one of the two options.

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
    An any-time maintenance window.
  weekly-maintenance-window -> (struct)
    A weekly maintenance window.
    day -> (struct)
      Day of the week.
    hour -> (int)
      Hour of the day in the UTC timezone.
``` ||
|| `--name` | `string`

Name of the OpenSearch cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--security-group-ids` | `strings`

User security groups. ||
|| `--service-account-id` | `string`

ID of the service account used to access Object Storage. ||
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