---
editable: false
---

# Managed Service for Greenplum® API, gRPC: ClusterService.Restore

Creates a new Greenplum® cluster using the specified backup.

## gRPC request

**rpc Restore ([RestoreClusterRequest](#yandex.cloud.mdb.greenplum.v1.RestoreClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RestoreClusterRequest {#yandex.cloud.mdb.greenplum.v1.RestoreClusterRequest}

```json
{
  "backup_id": "string",
  "time": "google.protobuf.Timestamp",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "environment": "Environment",
  "config": {
    "backup_window_start": "google.type.TimeOfDay",
    "access": {
      "data_lens": "bool",
      "web_sql": "bool",
      "data_transfer": "bool",
      "yandex_query": "bool"
    },
    "zone_id": "string",
    "subnet_id": "string",
    "assign_public_ip": "bool"
  },
  "master_resources": {
    "resource_preset_id": "string",
    "disk_size": "int64",
    "disk_type_id": "string"
  },
  "segment_resources": {
    "resource_preset_id": "string",
    "disk_size": "int64",
    "disk_type_id": "string"
  },
  "network_id": "string",
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "host_group_ids": [
    "string"
  ],
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "segment_host_count": "int64",
  "segment_in_host": "int64",
  "restore_only": [
    "string"
  ],
  "master_host_group_ids": [
    "string"
  ],
  "segment_host_group_ids": [
    "string"
  ],
  "restore_pxf": "bool",
  "restore_hba": "bool",
  "service_account_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. ID of the backup to create a cluster from.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-greenplum/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|| time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the moment to which the Greenplum cluster should be restored. ||
|| folder_id | **string**

Required field. ID of the folder to create the Greenplum® cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the Greenplum® cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the Greenplum® cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the Greenplum® cluster as `key:value` pairs.
For example, "project":"mvp" or "source":"dictionary".

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| environment | enum **Environment**

Required field. Deployment environment of the Greenplum® cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| config | **[GreenplumRestoreConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumRestoreConfig)**

Greenplum® cluster config. ||
|| master_resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources of the Greenplum® master subcluster. ||
|| segment_resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources of the Greenplum® segment subcluster. ||
|| network_id | **string**

Required field. ID of the network to create the cluster in.

The maximum string length in characters is 50. ||
|| security_group_ids[] | **string**

User security groups. ||
|| deletion_protection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| host_group_ids[] | **string**

Host groups to place VMs of cluster on. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| segment_host_count | **int64**

Number of segment hosts ||
|| segment_in_host | **int64**

Number of segments on each host ||
|| restore_only[] | **string**

List of databases and tables to restore

The maximum string length in characters for each value is 256. Each value must match the regular expression ` [a-zA-Z0-9\*_]*(\/[a-zA-Z0-9\*_]*){0,2} `. The maximum number of elements is 50. ||
|| master_host_group_ids[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segment_host_group_ids[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|| restore_pxf | **bool**

Restore PXF settings from original cluster ||
|| restore_hba | **bool**

Restore HBA settings from original cluster ||
|| service_account_id | **string**

Service account that will be used to access a Yandex Cloud resources ||
|#

## GreenplumRestoreConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumRestoreConfig}

#|
||Field | Description ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**

Access policy for external services. ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request.

The maximum string length in characters is 50. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.network_id](/docs/managed-greenplum/api-ref/grpc/Cluster/get#yandex.cloud.mdb.greenplum.v1.Cluster).

The maximum string length in characters is 50. ||
|| assign_public_ip | **bool**

Determines whether the host should get a public IP address on creation.
After a host has been created, this setting cannot be changed.
To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.
Possible values:
* `false` - do not assign a public IP to the master host.
* `true` - assign a public IP to the master host. ||
|#

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allows data export from the cluster to DataLens. ||
|| web_sql | **bool**

Allows SQL queries to the cluster databases from the management console. ||
|| data_transfer | **bool**

Allows access for DataTransfer. ||
|| yandex_query | **bool**

Allow access for YandexQuery. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources allocated to a host.
Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage used by the host, in bytes. ||
|| disk_type_id | **string**

Type of the storage used by the host: `network-ssd` or `local-ssd`. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.AnytimeMaintenanceWindow)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.AnytimeMaintenanceWindow}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **int64**

Hour of the day in the UTC timezone.

Acceptable values are 1 to 24, inclusive. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#