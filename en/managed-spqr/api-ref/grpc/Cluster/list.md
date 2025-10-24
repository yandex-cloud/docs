---
editable: false
sourcePath: en/_api-ref-grpc/mdb/spqr/v1/api-ref/grpc/Cluster/list.md
---

# Managed Service for SPQR API, gRPC: ClusterService.List

Retrieves the list of SPQR Cluster resources that belong
to the specified folder.

## gRPC request

**rpc List ([ListClustersRequest](#yandex.cloud.mdb.spqr.v1.ListClustersRequest)) returns ([ListClustersResponse](#yandex.cloud.mdb.spqr.v1.ListClustersResponse))**

## ListClustersRequest {#yandex.cloud.mdb.spqr.v1.ListClustersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list SPQR clusters in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClustersResponse.next_page_token](#yandex.cloud.mdb.spqr.v1.ListClustersResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListClustersResponse.next_page_token](#yandex.cloud.mdb.spqr.v1.ListClustersResponse) returned by the previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can only use filtering with the [Cluster.name](#yandex.cloud.mdb.spqr.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-zA-Z0-9_-]+`. ||
|#

## ListClustersResponse {#yandex.cloud.mdb.spqr.v1.ListClustersResponse}

```json
{
  "clusters": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "environment": "Environment",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "spqr_config": {
          "router": {
            "config": {
              "show_notice_messages": "google.protobuf.BoolValue",
              "time_quantiles": [
                "double"
              ],
              "default_route_behavior": "DefaultRouteBehavior",
              "prefer_same_availability_zone": "google.protobuf.BoolValue"
            },
            "resources": {
              "resource_preset_id": "string",
              "disk_size": "int64",
              "disk_type_id": "string"
            }
          },
          "coordinator": {
            "config": "CoordinatorSettings",
            "resources": {
              "resource_preset_id": "string",
              "disk_size": "int64",
              "disk_type_id": "string"
            }
          },
          "postgresql": {
            "config": "PostgreSQLSettings",
            "resources": {
              "resource_preset_id": "string",
              "disk_size": "int64",
              "disk_type_id": "string"
            }
          },
          "infra": {
            "resources": {
              "resource_preset_id": "string",
              "disk_size": "int64",
              "disk_type_id": "string"
            },
            "router": {
              "show_notice_messages": "google.protobuf.BoolValue",
              "time_quantiles": [
                "double"
              ],
              "default_route_behavior": "DefaultRouteBehavior",
              "prefer_same_availability_zone": "google.protobuf.BoolValue"
            },
            "coordinator": "CoordinatorSettings"
          },
          "log_level": "LogLevel",
          "balancer": {
            "cpu_threshold": "google.protobuf.DoubleValue",
            "space_threshold": "google.protobuf.DoubleValue",
            "stat_interval_sec": "google.protobuf.Int64Value",
            "max_move_count": "google.protobuf.Int64Value",
            "keys_per_move": "google.protobuf.Int64Value",
            "timeout": "google.protobuf.Int64Value"
          }
        },
        "backup_window_start": "google.type.TimeOfDay",
        "backup_retain_period_days": "google.protobuf.Int64Value",
        "access": {
          "data_lens": "bool",
          "web_sql": "bool",
          "data_transfer": "bool",
          "serverless": "bool"
        },
        "sox_audit": "google.protobuf.BoolValue"
      },
      "network_id": "string",
      "health": "Health",
      "status": "Status",
      "maintenance_window": {
        // Includes only one of the fields `anytime`, `weekly_maintenance_window`
        "anytime": "AnytimeMaintenanceWindow",
        "weekly_maintenance_window": {
          "day": "WeekDay",
          "hour": "int64"
        }
        // end of the list of possible fields
      },
      "planned_operation": {
        "info": "string",
        "delayed_until": "google.protobuf.Timestamp",
        "latest_maintenance_time": "google.protobuf.Timestamp",
        "next_maintenance_window_time": "google.protobuf.Timestamp"
      },
      "security_group_ids": [
        "string"
      ],
      "deletion_protection": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| clusters[] | **[Cluster](#yandex.cloud.mdb.spqr.v1.Cluster)**

List of SPQR Cluster resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClustersRequest.page_size](#yandex.cloud.mdb.spqr.v1.ListClustersRequest), use the `next_page_token` as the value
for the [ListClustersRequest.page_token](#yandex.cloud.mdb.spqr.v1.ListClustersRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Cluster {#yandex.cloud.mdb.spqr.v1.Cluster}

A managed SPQR cluster. For more information, see the [documentation](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the SPQR cluster.
This ID is assigned by MDB at creation time. ||
|| folder_id | **string**

ID of the folder that the SPQR cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the SPQR cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the SPQR cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the SPQR cluster as `` key:value `` pairs. Maximum 64 per resource. ||
|| environment | enum **Environment**

Deployment environment of the SPQR cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.spqr.v1.Monitoring)**

Description of monitoring systems relevant to the SPQR cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.spqr.v1.ClusterConfig)**

Configuration of the SPQR cluster. ||
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-spqr/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.spqr.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.spqr.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|#

## Monitoring {#yandex.cloud.mdb.spqr.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the SPQR cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.spqr.v1.ClusterConfig}

#|
||Field | Description ||
|| spqr_config | **[SPQRConfig](#yandex.cloud.mdb.spqr.v1.SPQRConfig)**

Configuration for SPQR servers in the cluster. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access)**

Access policy to DB ||
|| sox_audit | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## SPQRConfig {#yandex.cloud.mdb.spqr.v1.SPQRConfig}

#|
||Field | Description ||
|| router | **[RouterConfig](#yandex.cloud.mdb.spqr.v1.RouterConfig)**

SPQR router settings. ||
|| coordinator | **[CoordinatorConfig](#yandex.cloud.mdb.spqr.v1.CoordinatorConfig)**

SPQR coordinator settings. ||
|| postgresql | **[PostgreSQLConfig](#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig)**

PostgreSQL settings. ||
|| infra | **[InfraConfig](#yandex.cloud.mdb.spqr.v1.InfraConfig)**

SPQR Infra (router+coordinator) settings. ||
|| log_level | enum **LogLevel**

SPQR default log level

- `LOG_LEVEL_UNSPECIFIED`
- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)**

SPQR Balancer settings. ||
|#

## RouterConfig {#yandex.cloud.mdb.spqr.v1.RouterConfig}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## RouterSettings {#yandex.cloud.mdb.spqr.v1.RouterSettings}

Configuration of a SPQR router.

#|
||Field | Description ||
|| show_notice_messages | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| time_quantiles[] | **double** ||
|| default_route_behavior | enum **DefaultRouteBehavior**

- `DEFAULT_ROUTE_BEHAVIOR_UNSPECIFIED`
- `BLOCK`
- `ALLOW` ||
|| prefer_same_availability_zone | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-spqr/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## CoordinatorConfig {#yandex.cloud.mdb.spqr.v1.CoordinatorConfig}

#|
||Field | Description ||
|| config | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## CoordinatorSettings {#yandex.cloud.mdb.spqr.v1.CoordinatorSettings}

Configuration of a SPQR coordinator.

#|
||Field | Description ||
|| Empty | > ||
|#

## PostgreSQLConfig {#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig}

#|
||Field | Description ||
|| config | **[PostgreSQLSettings](#yandex.cloud.mdb.spqr.v1.PostgreSQLSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## PostgreSQLSettings {#yandex.cloud.mdb.spqr.v1.PostgreSQLSettings}

Configuration of a PostgreSQL.

#|
||Field | Description ||
|| Empty | > ||
|#

## InfraConfig {#yandex.cloud.mdb.spqr.v1.InfraConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)** ||
|| coordinator | **[CoordinatorSettings](#yandex.cloud.mdb.spqr.v1.CoordinatorSettings)** ||
|#

## BalancerSettings {#yandex.cloud.mdb.spqr.v1.BalancerSettings}

#|
||Field | Description ||
|| cpu_threshold | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| space_threshold | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| stat_interval_sec | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| max_move_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| keys_per_move | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|#

## Access {#yandex.cloud.mdb.spqr.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens. ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|| serverless | **bool**

Allow access for Serverless.
NOTE: Do not propagate to public API until Serverless integration is required. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.spqr.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.spqr.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.spqr.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#