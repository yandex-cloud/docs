---
editable: false
noIndex: true
---

# yc beta managed-sqlserver cluster restore

Creates a new SQL Server cluster using the specified backup.

#### Command Usage

Syntax:

`yc beta managed-sqlserver cluster restore <BACKUP-ID>`

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
|| `--backup-id` | `string`

ID of the backup to create a new cluster from. To get the backup ID, use a [ClusterService.ListBackups] request. ||
|| `--config-spec` | `shorthand/json`

Configuration for the new SQL Server cluster to be created from the backup.

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

Description of the new SQL Server cluster to be created from the backup. ||
|| `--environment` | `enum`

Deployment environment of the new SQL Server cluster to be created from the backup. Possible Values: 'production', 'prestable' ||
|| `--folder-id` | `string`

ID of the folder to create the SQL Server cluster in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--host-group-ids` | `[]string`

Host groups hosting VMs of the cluster. ||
|| `--host-specs` | `shorthand/json`

Configurations for SQL Server hosts that should be added to the cluster being created from the backup.

Shorthand Syntax:

```hcl
[
  {
    assign-public-ip = boolean,
    subnet-id = string,
    zone-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "assign-public-ip": "boolean",
    "subnet-id": "string",
    "zone-id": "string"
  }, ...
]
```

Fields:

```
assign-public-ip -> (boolean)
  Determines whether the host gets a public IP address on creation. After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with [assign_public_ip] set as needed. Possible values: * 'false' - do not assign a public IP to the host; * 'true' - assign a public IP to the host.
subnet-id -> (string)
  ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field [Cluster.network_id].
zone-id -> (string)
  ID of the availability zone where the host resides. To get the list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request.
``` ||
|| `--labels` | `map<string><string>`

Custom labels for the new SQL Server cluster to be created from the backup as 'key:value' pairs. For example, '"project":"mvp"' or '"source":"dictionary"'. ||
|| `--name` | `string`

Name of the new SQL Server cluster to be created from the backup. The name must be unique within the folder. ||
|| `--network-id` | `string`

ID of the network to create the SQL Server cluster in. ||
|| `--security-group-ids` | `[]string`

User security groups. ||
|| `--service-account-id` | `string`

ID of the service account used for access to Object Storage. ||
|| `--time` | `time`

Timestamp of the moment to which the SQL Server cluster should be restored. (RFC3339) ||
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