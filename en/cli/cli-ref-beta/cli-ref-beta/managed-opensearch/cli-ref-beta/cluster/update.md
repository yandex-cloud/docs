---
editable: false
noIndex: true
---

# yc beta managed-opensearch cluster update

Updates the specified OpenSearch cluster.

#### Command Usage

Syntax:

`yc beta managed-opensearch cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the OpenSearch cluster resource to update. To get the OpenSearch cluster ID, use a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

New cluster configuration

Shorthand Syntax:

```hcl
{
  access = {
    data-transfer = boolean,
    serverless = boolean
  },
  admin-password = string,
  dashboards-spec = {},
  opensearch-spec = {
    config = opensearch-config-2={
      fielddata-cache-size = string,
      max-clause-count = integer,
      reindex-remote-whitelist = string
    },
    plugins = string,...,
    remove-keystore-settings = string,...,
    set-keystore-settings = [
      {
        name = string,
        value = string
      }, ...
    ]
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
  "dashboards-spec": {},
  "opensearch-spec": {
    "config": {
      "opensearch-config-2": {
        "fielddata-cache-size": "string",
        "max-clause-count": "integer",
        "reindex-remote-whitelist": "string"
      }
    },
    "plugins": [
      "string", ...
    ],
    "remove-keystore-settings": [
      "string", ...
    ],
    "set-keystore-settings": [
      {
        "name": "string",
        "value": "string"
      }, ...
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
opensearch-spec -> (struct)
  OpenSearch configuration.
  plugins -> ([]string)
    Names of the cluster plugins.
  remove-keystore-settings -> ([]string)
    Keystore entries names to remove.
  set-keystore-settings -> ([]struct)
    Keystore settings to add/replace. Old entries not listed here will be left unchanged.
    name -> (string)
      Keystore entry name.
    value -> (string)
      Keystore entry value.
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

New description of the OpenSearch cluster. ||
|| `--labels` | `map<string><string>`

Custom labels for the OpenSearch cluster as 'key:value' pairs. For example, '"project": "mvp"' or '"source": "dictionary"'. The new set of labels completely replaces the old one. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
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

New name for the cluster. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to move the cluster to. ||
|| `--security-group-ids` | `[]string`

User security groups ||
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