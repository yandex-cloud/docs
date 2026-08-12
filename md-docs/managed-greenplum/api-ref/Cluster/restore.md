[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > Restore

# Managed Service for Greenplum® API, REST: Cluster.Restore

Creates a new Greenplum® cluster using the specified backup.

## HTTP request

```
POST https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters:restore
```

## Body parameters {#yandex.cloud.mdb.greenplum.v1.RestoreClusterRequest}

```json
{
  "backupId": "string",
  "time": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "config": {
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": "boolean",
      "webSql": "boolean",
      "dataTransfer": "boolean",
      "yandexQuery": "boolean"
    },
    "zoneId": "string",
    "subnetId": "string",
    "assignPublicIp": "boolean"
  },
  "masterResources": {
    "resourcePresetId": "string",
    "diskSize": "string",
    "diskTypeId": "string"
  },
  "segmentResources": {
    "resourcePresetId": "string",
    "diskSize": "string",
    "diskTypeId": "string"
  },
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": "boolean",
  "hostGroupIds": [
    "string"
  ],
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "segmentHostCount": "string",
  "segmentInHost": "string",
  "restoreOnly": [
    "string"
  ],
  "masterHostGroupIds": [
    "string"
  ],
  "segmentHostGroupIds": [
    "string"
  ],
  "restorePxf": "boolean",
  "restoreHba": "boolean",
  "serviceAccountId": "string",
  "diskEncryptionKeyId": "string"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to create a cluster from.
To get the backup ID, use a [ClusterService.ListBackups](listBackups.md#ListBackups) request. ||
|| time | **string** (date-time)

Timestamp of the moment to which the Greenplum cluster should be restored.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| folderId | **string**

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
|| environment | **enum** (Environment)

Required field. Deployment environment of the Greenplum® cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility. ||
|| config | **[GreenplumRestoreConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumRestoreConfig)**

Greenplum® cluster config. ||
|| masterResources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources of the Greenplum® master subcluster. ||
|| segmentResources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources of the Greenplum® segment subcluster. ||
|| networkId | **string**

Required field. ID of the network to create the cluster in.

The maximum string length in characters is 50. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| hostGroupIds[] | **string**

Host groups to place VMs of cluster on. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)**

A Greenplum® cluster maintenance window. Should be defined by either one of the two options. ||
|| segmentHostCount | **string** (int64)

Number of segment hosts ||
|| segmentInHost | **string** (int64)

Number of segments on each host ||
|| restoreOnly[] | **string**

List of databases and tables to restore

The maximum string length in characters for each value is 256. Each value must match the regular expression ` [a-zA-Z0-9\*_]*(\/[a-zA-Z0-9\*_]*){0,2} `. The maximum number of elements is 50. ||
|| masterHostGroupIds[] | **string**

Host groups hosting VMs of the master subcluster. ||
|| segmentHostGroupIds[] | **string**

Host groups hosting VMs of the segment subcluster. ||
|| restorePxf | **boolean**

Restore PXF settings from original cluster ||
|| restoreHba | **boolean**

Restore HBA settings from original cluster ||
|| serviceAccountId | **string**

Service account that will be used to access a Yandex Cloud resources ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## GreenplumRestoreConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumRestoreConfig}

#|
||Field | Description ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)**

Access policy for external services. ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](../../../compute/api-ref/Zone/list.md#List) request.

The maximum string length in characters is 50. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.networkId](get.md#yandex.cloud.mdb.greenplum.v1.Cluster).

The maximum string length in characters is 50. ||
|| assignPublicIp | **boolean**

Determines whether the host should get a public IP address on creation.
After a host has been created, this setting cannot be changed.
To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.
Possible values:
* `false` - do not assign a public IP to the master host.
* `true` - assign a public IP to the master host. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allows data export from the cluster to DataLens. ||
|| webSql | **boolean**

Allows SQL queries to the cluster databases from the management console. ||
|| dataTransfer | **boolean**

Allows access for DataTransfer. ||
|| yandexQuery | **boolean**

Allow access for YandexQuery. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host.
Available presets are listed in the [documentation](../../concepts/instance-types.md). ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-ssd` or `local-ssd`. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone.

Acceptable values are 1 to 24, inclusive. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#