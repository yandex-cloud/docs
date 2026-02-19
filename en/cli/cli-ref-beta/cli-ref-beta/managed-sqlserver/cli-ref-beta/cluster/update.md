---
editable: false
noIndex: true
---

# yc beta managed-sqlserver cluster update

Modifies the specified SQL Server cluster.

#### Command Usage

Syntax:

`yc beta managed-sqlserver cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the SQL Server cluster to update. To get the SQL Server cluster ID, use a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

New configuration and resources for hosts in the SQL Server cluster.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    web-sql = boolean
  },
  backup-window-start = timeofday,
  resources = {
    disk-size = integer,
    disk-type-id = string,
    resource-preset-id = string
  },
  secondary-connections = SECONDARY_CONNECTIONS_OFF|SECONDARY_CONNECTIONS_READ_ONLY,
  sqlserver-config = sqlserver-config-2016sp2ent={
    audit-level = integer,
    cost-threshold-for-parallelism = integer,
    fill-factor-percent = integer,
    max-degree-of-parallelism = integer,
    optimize-for-ad-hoc-workloads = boolean
  } | sqlserver-config-2016sp2std={
    audit-level = integer,
    cost-threshold-for-parallelism = integer,
    fill-factor-percent = integer,
    max-degree-of-parallelism = integer,
    optimize-for-ad-hoc-workloads = boolean
  } | sqlserver-config-2017ent={
    audit-level = integer,
    cost-threshold-for-parallelism = integer,
    fill-factor-percent = integer,
    max-degree-of-parallelism = integer,
    optimize-for-ad-hoc-workloads = boolean
  } | sqlserver-config-2017std={
    audit-level = integer,
    cost-threshold-for-parallelism = integer,
    fill-factor-percent = integer,
    max-degree-of-parallelism = integer,
    optimize-for-ad-hoc-workloads = boolean
  } | sqlserver-config-2019ent={
    audit-level = integer,
    cost-threshold-for-parallelism = integer,
    fill-factor-percent = integer,
    max-degree-of-parallelism = integer,
    optimize-for-ad-hoc-workloads = boolean
  } | sqlserver-config-2019std={
    audit-level = integer,
    cost-threshold-for-parallelism = integer,
    fill-factor-percent = integer,
    max-degree-of-parallelism = integer,
    optimize-for-ad-hoc-workloads = boolean
  },
  version = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "web-sql": "boolean"
  },
  "backup-window-start": "timeofday",
  "resources": {
    "disk-size": "integer",
    "disk-type-id": "string",
    "resource-preset-id": "string"
  },
  "secondary-connections": "SECONDARY_CONNECTIONS_OFF|SECONDARY_CONNECTIONS_READ_ONLY",
  "sqlserver-config": {
    "sqlserver-config-2016sp2ent": {
      "audit-level": "integer",
      "cost-threshold-for-parallelism": "integer",
      "fill-factor-percent": "integer",
      "max-degree-of-parallelism": "integer",
      "optimize-for-ad-hoc-workloads": "boolean"
    },
    "sqlserver-config-2016sp2std": {
      "audit-level": "integer",
      "cost-threshold-for-parallelism": "integer",
      "fill-factor-percent": "integer",
      "max-degree-of-parallelism": "integer",
      "optimize-for-ad-hoc-workloads": "boolean"
    },
    "sqlserver-config-2017ent": {
      "audit-level": "integer",
      "cost-threshold-for-parallelism": "integer",
      "fill-factor-percent": "integer",
      "max-degree-of-parallelism": "integer",
      "optimize-for-ad-hoc-workloads": "boolean"
    },
    "sqlserver-config-2017std": {
      "audit-level": "integer",
      "cost-threshold-for-parallelism": "integer",
      "fill-factor-percent": "integer",
      "max-degree-of-parallelism": "integer",
      "optimize-for-ad-hoc-workloads": "boolean"
    },
    "sqlserver-config-2019ent": {
      "audit-level": "integer",
      "cost-threshold-for-parallelism": "integer",
      "fill-factor-percent": "integer",
      "max-degree-of-parallelism": "integer",
      "optimize-for-ad-hoc-workloads": "boolean"
    },
    "sqlserver-config-2019std": {
      "audit-level": "integer",
      "cost-threshold-for-parallelism": "integer",
      "fill-factor-percent": "integer",
      "max-degree-of-parallelism": "integer",
      "optimize-for-ad-hoc-workloads": "boolean"
    }
  },
  "version": "string"
}
```

Fields:

```
access -> (struct)
  Database access policy.
  data-lens -> (boolean)
    Allows access for DataLens.
  web-sql -> (boolean)
    Allows access for Web SQL.
backup-window-start -> (timeofday)
  Start time for the daily backup in UTC timezone.
resources -> (struct)
  Resources allocated to SQL Server hosts.
  disk-size -> (integer)
    Volume of the storage available to a host.
  disk-type-id -> (string)
    Type of the storage environment for the host. Possible values: * 'network-hdd' - network HDD drive; * 'network-ssd' - network SSD drive; * 'local-ssd' - local SSD storage.
  resource-preset-id -> (string)
    ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the documentation.
secondary-connections -> (struct)
  Secondary replicas connection mode
version -> (string)
  Version of SQL Server used in the cluster. Possible values: * 2016sp2std, * 2016sp2ent, * 2017std, * 2017ent, * 2019std, * 2019ent.
sqlserver-config -> (oneof<sqlserver-config-2016sp2ent|sqlserver-config-2016sp2std|sqlserver-config-2017ent|sqlserver-config-2017std|sqlserver-config-2019ent|sqlserver-config-2019std>)
  Oneof sqlserver-config field
  sqlserver-config-2016sp2std -> (struct)
    Configuration for an SQL Server 2016 SP2 Standard edition cluster.
    audit-level -> (integer)
      Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values: * 0 - do not log login attempts; * 1 - log only failed login attempts; * 2 - log only successful login attempts (not recommended); * 3 - log all login attempts (not recommended). See in-depth description in SQL Server documentation.
    cost-threshold-for-parallelism -> (integer)
      Specifies the threshold at which SQL Server creates and runs parallel plans for queries. SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option. See in-depth description in SQL Server documentation.
    fill-factor-percent -> (integer)
      Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth. Values 0 and 100 mean full page usage (no space reserved). See in-depth description in SQL Server documentation.
    max-degree-of-parallelism -> (integer)
      Limits the number of processors to use in parallel plan execution per task. See in-depth description in SQL Server documentation.
    optimize-for-ad-hoc-workloads -> (boolean)
      Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans. See in-depth description in SQL Server documentation.
  sqlserver-config-2016sp2ent -> (struct)
    Configuration for an SQL Server 2016 SP2 Enterprise edition cluster.
    audit-level -> (integer)
      Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values: * 0 - do not log login attempts; * 1 - log only failed login attempts; * 2 - log only successful login attempts (not recommended); * 3 - log all login attempts (not recommended). See in-depth description in SQL Server documentation.
    cost-threshold-for-parallelism -> (integer)
      Specifies the threshold at which SQL Server creates and runs parallel plans for queries. SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option. See in-depth description in SQL Server documentation.
    fill-factor-percent -> (integer)
      Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth. Values 0 and 100 mean full page usage (no space reserved). See in-depth description in SQL Server documentation.
    max-degree-of-parallelism -> (integer)
      Limits the number of processors to use in parallel plan execution per task. See in-depth description in SQL Server documentation.
    optimize-for-ad-hoc-workloads -> (boolean)
      Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans. See in-depth description in SQL Server documentation.
  sqlserver-config-2017std -> (struct)
    Configuration for an SQL Server 2017 Standard edition cluster.
    audit-level -> (integer)
      Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values: * 0 - do not log login attempts; * 1 - log only failed login attempts; * 2 - log only successful login attempts (not recommended); * 3 - log all login attempts (not recommended). See in-depth description in SQL Server documentation.
    cost-threshold-for-parallelism -> (integer)
      Specifies the threshold at which SQL Server creates and runs parallel plans for queries. SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option. See in-depth description in SQL Server documentation.
    fill-factor-percent -> (integer)
      Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth. Values 0 and 100 mean full page usage (no space reserved). See in-depth description in SQL Server documentation.
    max-degree-of-parallelism -> (integer)
      Limits the number of processors to use in parallel plan execution per task. See in-depth description in SQL Server documentation.
    optimize-for-ad-hoc-workloads -> (boolean)
      Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans. See in-depth description in SQL Server documentation.
  sqlserver-config-2017ent -> (struct)
    Configuration for an SQL Server 2017 Enterprise edition cluster.
    audit-level -> (integer)
      Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values: * 0 - do not log login attempts; * 1 - log only failed login attempts; * 2 - log only successful login attempts (not recommended); * 3 - log all login attempts (not recommended). See in-depth description in SQL Server documentation.
    cost-threshold-for-parallelism -> (integer)
      Specifies the threshold at which SQL Server creates and runs parallel plans for queries. SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option. See in-depth description in SQL Server documentation.
    fill-factor-percent -> (integer)
      Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth. Values 0 and 100 mean full page usage (no space reserved). See in-depth description in SQL Server documentation.
    max-degree-of-parallelism -> (integer)
      Limits the number of processors to use in parallel plan execution per task. See in-depth description in SQL Server documentation.
    optimize-for-ad-hoc-workloads -> (boolean)
      Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans. See in-depth description in SQL Server documentation.
  sqlserver-config-2019std -> (struct)
    Configuration for an SQL Server 2019 Standard edition cluster.
    audit-level -> (integer)
      Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values: * 0 - do not log login attempts; * 1 - log only failed login attempts; * 2 - log only successful login attempts (not recommended); * 3 - log all login attempts (not recommended). See in-depth description in SQL Server documentation.
    cost-threshold-for-parallelism -> (integer)
      Specifies the threshold at which SQL Server creates and runs parallel plans for queries. SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option. See in-depth description in SQL Server documentation.
    fill-factor-percent -> (integer)
      Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth. Values 0 and 100 mean full page usage (no space reserved). See in-depth description in SQL Server documentation.
    max-degree-of-parallelism -> (integer)
      Limits the number of processors to use in parallel plan execution per task. See in-depth description in SQL Server documentation.
    optimize-for-ad-hoc-workloads -> (boolean)
      Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans. See in-depth description in SQL Server documentation.
  sqlserver-config-2019ent -> (struct)
    Configuration for an SQL Server 2019 Enterprise edition cluster.
    audit-level -> (integer)
      Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values: * 0 - do not log login attempts; * 1 - log only failed login attempts; * 2 - log only successful login attempts (not recommended); * 3 - log all login attempts (not recommended). See in-depth description in SQL Server documentation.
    cost-threshold-for-parallelism -> (integer)
      Specifies the threshold at which SQL Server creates and runs parallel plans for queries. SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option. See in-depth description in SQL Server documentation.
    fill-factor-percent -> (integer)
      Manages the fill factor server configuration option. When an index is created or rebuilt, the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth. Values 0 and 100 mean full page usage (no space reserved). See in-depth description in SQL Server documentation.
    max-degree-of-parallelism -> (integer)
      Limits the number of processors to use in parallel plan execution per task. See in-depth description in SQL Server documentation.
    optimize-for-ad-hoc-workloads -> (boolean)
      Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans. See in-depth description in SQL Server documentation.
``` ||
|| `--deletion-protection` | Determines whether the cluster is protected from being deleted. ||
|| `--description` | `string`

New description of the SQL Server cluster. ||
|| `--labels` | `map<string><string>`

Custom labels for the SQL Server cluster as 'key:value' pairs. For example, '"project":"mvp"' or '"source":"dictionary"'. The new set of labels completely replaces the old one. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--name` | `string`

New name for the SQL Server cluster. ||
|| `--security-group-ids` | `[]string`

User security groups. ||
|| `--service-account-id` | `string`

ID of the service account used for access to Object Storage. ||
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