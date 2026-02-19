---
editable: false
noIndex: true
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
    data-transfer = boolean,
    serverless = boolean
  },
  admin-password = string,
  dashboards-spec = {
    node-groups = [
      {
        assign-public-ip = boolean,
        disk-size-autoscaling = {
          disk-size-limit = integer,
          emergency-usage-threshold = integer,
          planned-usage-threshold = integer
        },
        hosts-count = integer,
        name = string,
        resources = {
          disk-size = integer,
          disk-type-id = string,
          resource-preset-id = string
        },
        subnet-ids = string,...,
        zone-ids = string,...
      }, ...
    ]
  },
  opensearch-spec = {
    config = opensearch-config-2={
      fielddata-cache-size = string,
      max-clause-count = integer,
      reindex-remote-whitelist = string
    },
    keystore-settings = [
      {
        name = string,
        value = string
      }, ...
    ],
    node-groups = [
      {
        assign-public-ip = boolean,
        disk-size-autoscaling = {
          disk-size-limit = integer,
          emergency-usage-threshold = integer,
          planned-usage-threshold = integer
        },
        hosts-count = integer,
        name = string,
        resources = {
          disk-size = integer,
          disk-type-id = string,
          resource-preset-id = string
        },
        roles = [
          DATA|MANAGER, ...
        ],
        subnet-ids = string,...,
        zone-ids = string,...
      }, ...
    ],
    plugins = string,...
  },
  snapshot-management = {
    snapshot-max-age-days = integer,
    snapshot-schedule = {
      schedule = daily-snapshot-schedule={
        hour = integer,
        minute = integer
      } | hourly-snapshot-schedule={
        minute = integer
      } | weekly-snapshot-schedule={
        day = MON|TUE|WED|THU|FRI|SAT|SUN,
        hour = integer,
        minute = integer
      }
    }
  },
  version = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-transfer": "boolean",
    "serverless": "boolean"
  },
  "admin-password": "string",
  "dashboards-spec": {
    "node-groups": [
      {
        "assign-public-ip": "boolean",
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "hosts-count": "integer",
        "name": "string",
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        },
        "subnet-ids": [
          "string", ...
        ],
        "zone-ids": [
          "string", ...
        ]
      }, ...
    ]
  },
  "opensearch-spec": {
    "config": {
      "opensearch-config-2": {
        "fielddata-cache-size": "string",
        "max-clause-count": "integer",
        "reindex-remote-whitelist": "string"
      }
    },
    "keystore-settings": [
      {
        "name": "string",
        "value": "string"
      }, ...
    ],
    "node-groups": [
      {
        "assign-public-ip": "boolean",
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "hosts-count": "integer",
        "name": "string",
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        },
        "roles": [
          "DATA|MANAGER", ...
        ],
        "subnet-ids": [
          "string", ...
        ],
        "zone-ids": [
          "string", ...
        ]
      }, ...
    ],
    "plugins": [
      "string", ...
    ]
  },
  "snapshot-management": {
    "snapshot-max-age-days": "integer",
    "snapshot-schedule": {
      "schedule": {
        "daily-snapshot-schedule": {
          "hour": "integer",
          "minute": "integer"
        },
        "hourly-snapshot-schedule": {
          "minute": "integer"
        },
        "weekly-snapshot-schedule": {
          "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
          "hour": "integer",
          "minute": "integer"
        }
      }
    }
  },
  "version": "string"
}
```

Fields:

```
access -> (struct)
  Access policy for external services.
  data-transfer -> (boolean)
    Determines whether the access to Data Transfer is allowed.
  serverless -> (boolean)
    Determines whether the access to Serverless is allowed.
admin-password -> (string)
  OpenSearch admin password.
dashboards-spec -> (struct)
  Dashboards configuration.
  node-groups -> ([]struct)
    Dashboards type host groups of the cluster.
    assign-public-ip -> (boolean)
      Determines whether a public IP is assigned to the hosts in the group.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    hosts-count -> (integer)
      Number of hosts in the group.
    name -> (string)
      Name of the group.
    resources -> (struct)
      Resources allocated to the hosts.
      disk-size -> (integer)
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
    assign-public-ip -> (boolean)
      Determines whether a public IP is assigned to the hosts in the group.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    hosts-count -> (integer)
      Number of hosts in the group.
    name -> (string)
      Name of the group.
    resources -> (struct)
      Resources allocated to the hosts.
      disk-size -> (integer)
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
        The maximum size of the field data cache. May be specified as an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%). This setting is dynamic. If you don't specify this setting, the maximum size is 35%. This value should be smaller than the **indices.breaker.fielddata.limit** Change of the setting is applied with restart. For details, see OpenSearch documentation.
      max-clause-count -> (integer)
        Defines the maximum product of fields and terms that are queryable simultaneously. Before OpenSearch 2.16, a cluster restart was required in order to apply this static setting. Now dynamic, existing search thread pools may use the old static value initially, causing **TooManyClauses** exceptions. New thread pools use the updated value. Default value: **1024**. Change of the setting is applied with restart. For details, see OpenSearch documentation.
      reindex-remote-whitelist -> (string)
        Allowed remote hosts Change of the setting is applied with restart. For details, see OpenSearch documentation.
snapshot-management -> (struct)
  Snapshot management configuration
  snapshot-max-age-days -> (integer)
    Snapshot max age in days
  snapshot-schedule -> (struct)
    Snapshot creation schedule
    schedule -> (oneof<daily-snapshot-schedule|hourly-snapshot-schedule|weekly-snapshot-schedule>)
      Oneof schedule field
      hourly-snapshot-schedule -> (struct)
        Hourly based snapshot schedule
        minute -> (integer)
          The minute of the hour at which the backup should be created.
      daily-snapshot-schedule -> (struct)
        Daily based snapshot schedule
        hour -> (integer)
          The hour of the day in UTC timezone at which the backup should be created.
        minute -> (integer)
          The minute of the hour at which the backup should be created.
      weekly-snapshot-schedule -> (struct)
        Weekly based snapshot schedule
        day -> (struct)
          Day of the week
        hour -> (integer)
          The hour of the day in UTC timezone at which the backup should be created.
        minute -> (integer)
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
|| `--labels` | `map<string><string>`

Custom labels for the OpenSearch cluster as 'key:value' pairs. For example, '"project": "mvp"' or '"source": "dictionary"'. ||
|| `--maintenance-window` | `shorthand/json`

Cluster maintenance window. Should be defined by either one of the two options.

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
    An any-time maintenance window.
  weekly-maintenance-window -> (struct)
    A weekly maintenance window.
    day -> (struct)
      Day of the week.
    hour -> (integer)
      Hour of the day in the UTC timezone.
``` ||
|| `--name` | `string`

Name of the OpenSearch cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the cluster in. ||
|| `--security-group-ids` | `[]string`

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