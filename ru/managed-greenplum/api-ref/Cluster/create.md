---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/api-ref/Cluster/create.md
---

# Method create
Creates a Greenplum® cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "config": {
    "version": "string",
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true,
      "webSql": true,
      "dataTransfer": true
    },
    "zoneId": "string",
    "subnetId": "string",
    "assignPublicIp": true
  },
  "masterConfig": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "segmentConfig": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "masterHostCount": "string",
  "segmentInHost": "string",
  "segmentHostCount": "string",
  "userName": "string",
  "userPassword": "string",
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true,
  "hostGroupIds": [
    "string"
  ],
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "configSpec": {
    "pool": {
      "mode": "string",
      "size": "integer",
      "clientIdleTimeout": "integer"
    },

    // `configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`
    "greenplumConfig_6_17": {
      "maxConnections": "integer",
      "maxSlotWalKeepSize": "integer",
      "gpWorkfileLimitPerSegment": "integer",
      "gpWorkfileLimitPerQuery": "integer",
      "gpWorkfileLimitFilesPerQuery": "integer",
      "maxPreparedTransactions": "integer",
      "gpWorkfileCompression": true
    },
    "greenplumConfig_6_19": {
      "maxConnections": "integer",
      "maxSlotWalKeepSize": "integer",
      "gpWorkfileLimitPerSegment": "integer",
      "gpWorkfileLimitPerQuery": "integer",
      "gpWorkfileLimitFilesPerQuery": "integer",
      "maxPreparedTransactions": "integer",
      "gpWorkfileCompression": true
    },
    // end of the list of possible fields`configSpec`

  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the Greenplum® cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the Greenplum® cluster. The name must be unique within the folder. Maximum 63 characters.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the Greenplum® cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Greenplum® cluster as ``key:value`` pairs. Maximum 64 per resource. For example, &quot;project&quot;:&quot;mvp&quot; or &quot;source&quot;:&quot;dictionary&quot;.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Required. Deployment environment of the Greenplum® cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
config | **object**<br><p>Greenplum® cluster configuration.</p> <p>Greenplum® cluster configuration.</p> 
config.<br>version | **string**<br><p>Version of the Greenplum® server software.</p> 
config.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>access | **object**<br><p>Access policy for external services.</p> <p>Greenplum® cluster access options.</p> 
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allows data export from the cluster to Yandex DataLens.</p> 
config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allows SQL queries to the cluster databases from the Yandex Cloud management console.</p> 
config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
config.<br>zoneId | **string**<br><p>ID of the availability zone the cluster belongs to. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
config.<br>subnetId | **string**<br><p>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see <a href="/docs/managed-greenplum/api-ref/Cluster#representation">Cluster.networkId</a>).</p> <p>The maximum string length in characters is 50.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>Whether or not the cluster has a public IP address.</p> <p>After the cluster has been created, this setting cannot be changed.</p> 
masterConfig | **object**<br><p>Configuration of the Greenplum® master subcluster.</p> <p>Configuration of the master subcluster.</p> 
masterConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum® master subcluster hosts.</p> <p>A list of computational resources allocated to a host.</p> 
masterConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host. Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
masterConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
masterConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
segmentConfig | **object**<br><p>Configuration of the Greenplum® segment subcluster.</p> <p>Configuration of the segment subcluster.</p> 
segmentConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum® segment subcluster hosts.</p> <p>A list of computational resources allocated to a host.</p> 
segmentConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host. Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
segmentConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
segmentConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
masterHostCount | **string** (int64)<br><p>Number of hosts in the master subcluster.</p> 
segmentInHost | **string** (int64)<br><p>Number of segments per host.</p> 
segmentHostCount | **string** (int64)<br><p>Number of hosts in the segment subcluster.</p> 
userName | **string**<br><p>Owner user name.</p> 
userPassword | **string**<br><p>Required. Owner user password. Must be 8-128 characters long</p> <p>The string length in characters must be 8-128.</p> 
networkId | **string**<br><p>Required. ID of the network to create the cluster in.</p> <p>The maximum string length in characters is 50.</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
deletionProtection | **boolean** (boolean)<br><p>Whether or not cluster is protected from being deleted.</p> 
hostGroupIds[] | **string**<br><p>Host groups to place VMs of the cluster in.</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> <p>A Greenplum® cluster maintenance window. Should be defined by either one of the two options.</p> 
maintenanceWindow.<br>anytime | **object**<br>An any-time maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br><p>An any-time maintenance window.</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>A weekly maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br><p>A weekly maintenance window.</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
configSpec | **object**<br><p>Configuration of greenplum and odyssey</p> 
configSpec.<br>pool | **object**<br>Odyssey pool settings<br><p>Route server configuration.</p> 
configSpec.<br>pool.<br>mode | **string**<br><p>Route server pool mode.</p> <p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
configSpec.<br>pool.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy. Set to zero to disable the limit.</p> 
configSpec.<br>pool.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds. A server connection closes after it has been idle for the specified duration. Set to zero to disable the limit.</p> 
configSpec.<br>greenplumConfig_6_17 | **object** <br>`configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`<br><br>
configSpec.<br>greenplumConfig_6_17.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
configSpec.<br>greenplumConfig_6_17.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
configSpec.<br>greenplumConfig_6_17.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the &quot;prepared&quot; state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
configSpec.<br>greenplumConfig_6_19 | **object** <br>`configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`<br><br>
configSpec.<br>greenplumConfig_6_19.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
configSpec.<br>greenplumConfig_6_19.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
configSpec.<br>greenplumConfig_6_19.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the &quot;prepared&quot; state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 