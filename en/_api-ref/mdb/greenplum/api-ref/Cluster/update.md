---
editable: false
---

# Method update
Updates the specified Greenplum cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/mdb/managed-greenplum/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Greenplum Cluster resource to update. To get the Greenplum cluster ID, use a [list](/docs/managed-greenplum/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "name": "string",
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
      "webSql": true
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
    },
    "config": {
      "logLevel": "string",
      "maxConnections": "integer",
      "timezone": "string",
      "pool": {
        "mode": "string",
        "size": "integer",
        "clientIdleTimeout": "integer"
      },
      "maxPreparedTransactions": "integer",
      "runawayDetectorActivationPercent": "integer",
      "tcpKeepalivesCount": "integer",
      "tcpKeepalivesInterval": "integer",
      "readableExternalTableTimeout": "integer",
      "gpInterconnectSndQueueDepth": "integer",
      "gpInterconnectQueueDepth": "integer",
      "logStatement": "string",
      "logDuration": true,
      "optimizerAnalyzeRootPartition": true,
      "gpExternalMaxSegs": "integer",
      "gpFtsProbeTimeout": "integer",
      "gpWorkfileCompression": true,
      "gpAutostatsModeInFunctions": "string"
    }
  },
  "segmentConfig": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    },
    "config": {
      "logLevel": "string",
      "maxConnections": "integer",
      "maxSlotWalKeepSize": "integer",
      "gpWorkfileLimitPerSegment": "integer",
      "gpWorkfileLimitPerQuery": "integer",
      "gpWorkfileLimitFilesPerQuery": "integer",
      "gpResourceManager": "string",
      "gpResourceGroupCpuLimit": "number",
      "gpResourceGroupMemoryLimit": "number"
    }
  },
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Greenplum Cluster resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the Greenplum cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Greenplum cluster as ``key:value`` pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-greenplum/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-greenplum/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
name | **string**<br><p>New name for the cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
config | **object**<br><p>Greenplum cluster config</p> 
config.<br>version | **string**<br><p>Version of the Greenplum server software.</p> 
config.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>access | **object**<br><p>Access policy for external services.</p> 
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow to export data from the cluster to Yandex DataLens.</p> 
config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the Yandex.Cloud management console.</p> 
config.<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
config.<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-greenplum/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>The maximum string length in characters is 50.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with ``assignPublicIp`` set as needed.</p> <p>Possible values:</p> <ul> <li>false - don't assign a public IP to the master hosts.</li> <li>true - the master hosts should have a public IP address.</li> </ul> 
masterConfig | **object**<br><p>Configuration of the Greenplum master subcluster.</p> <p>Configuration of master subcluster</p> 
masterConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum master subcluster hosts.</p> 
masterConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
masterConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
masterConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
masterConfig.<br>config | **object**<br><p>Configuration settings of a Greenplum master server.</p> <p>Greenplum master subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
masterConfig.<br>config.<br>logLevel | **string**<br><p>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
masterConfig.<br>config.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
masterConfig.<br>config.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
masterConfig.<br>config.<br>pool | **object**<br><p>Odyssey pool settings</p> 
masterConfig.<br>config.<br>pool.<br>mode | **string**<br><p>Odyssey route server pool mode. Default is session mode. https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool-string</p> 
masterConfig.<br>config.<br>pool.<br>size | **integer** (int64)<br><p>Odyssey Server pool size. Keep the number of servers in the pool as much as 'pool_size'. Clients are put in a wait queue, when all servers are busy. Set to zero to disable the limit. https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool_size-integer</p> 
masterConfig.<br>config.<br>pool.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout. Close an server connection when it becomes idle for 'pool_ttl' seconds. Set to zero to disable. https://github.com/yandex/odyssey/blob/master/documentation/configuration.md#pool_ttl-integer</p> 
masterConfig.<br>config.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the &quot;prepared&quot; state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
masterConfig.<br>config.<br>runawayDetectorActivationPercent | **integer** (int64)<br><p>For queries that are managed by resource queues or resource groups, this parameter determines when Greenplum Database terminates running queries based on the amount of memory the queries are using. A value of 100 disables the automatic termination of queries based on the percentage of memory that is utilized. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#runaway_detector_activation_percent</p> 
masterConfig.<br>config.<br>tcpKeepalivesCount | **integer** (int64)<br><p>How many keepalives may be lost before the connection is considered dead. A value of 0 uses the system default. If TCP_KEEPCNT is not supported, this parameter must be 0. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_count</p> 
masterConfig.<br>config.<br>tcpKeepalivesInterval | **integer** (int64)<br><p>How many seconds to wait for a response to a keepalive before retransmitting. A value of 0 uses the system default. If TCP_KEEPINTVL is not supported, this parameter must be 0. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#tcp_keepalives_interval</p> 
masterConfig.<br>config.<br>readableExternalTableTimeout | **integer** (int64)<br><p>When an SQL query reads from an external table, the parameter value specifies the amount of time in seconds that Greenplum Database waits before cancelling the query when data stops being returned from the external table. The default value of 0, specifies no time out. Greenplum Database does not cancel the query. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#readable_external_table_timeout</p> 
masterConfig.<br>config.<br>gpInterconnectSndQueueDepth | **integer** (int64)<br><p>Sets the amount of data per-peer to be queued by the default UDPIFC interconnect on senders. Increasing the depth from its default value will cause the system to use more memory, but may increase performance. Reasonable values for this parameter are between 1 and 4. Increasing the value might radically increase the amount of memory used by the system. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_snd_queue_depth</p> 
masterConfig.<br>config.<br>gpInterconnectQueueDepth | **integer** (int64)<br><p>Sets the amount of data per-peer to be queued by the Greenplum Database interconnect on receivers (when data is received but no space is available to receive it the data will be dropped, and the transmitter will need to resend it) for the default UDPIFC interconnect. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_interconnect_queue_depth</p> 
masterConfig.<br>config.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> 
masterConfig.<br>config.<br>logDuration | **boolean** (boolean)<br><p>Causes the duration of every completed statement which satisfies log_statement to be logged. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_duration</p> 
masterConfig.<br>config.<br>optimizerAnalyzeRootPartition | **boolean** (boolean)<br><p>For a partitioned table, controls whether the ROOTPARTITION keyword is required to collect root partition statistics when the ANALYZE command is run on the table. GPORCA uses the root partition statistics when generating a query plan. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#optimizer_analyze_root_partition</p> 
masterConfig.<br>config.<br>gpExternalMaxSegs | **integer** (int64)<br><p>Sets the number of segments that will scan external table data during an external table operation, the purpose being not to overload the system with scanning data and take away resources from other concurrent operations. This only applies to external tables that use the gpfdist:// protocol to access external table data. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_external_max_segs</p> 
masterConfig.<br>config.<br>gpFtsProbeTimeout | **integer** (int64)<br><p>Specifies the allowed timeout for the fault detection process (ftsprobe) to establish a connection to a segment before declaring it down. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_fts_probe_timeout</p> 
masterConfig.<br>config.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
masterConfig.<br>config.<br>gpAutostatsModeInFunctions | **string**<br><p>https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_autostats_mode_in_functions</p> 
segmentConfig | **object**<br><p>Configuration of the Greenplum segment subcluster.</p> <p>Configuration of segmet subcluster</p> 
segmentConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum segment subcluster hosts.</p> 
segmentConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
segmentConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
segmentConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
segmentConfig.<br>config | **object**<br><p>Configuration settings of a Greenplum segment server.</p> <p>Greenplum segment subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
segmentConfig.<br>config.<br>logLevel | **string**<br><p>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
segmentConfig.<br>config.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
segmentConfig.<br>config.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
segmentConfig.<br>config.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
segmentConfig.<br>config.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
segmentConfig.<br>config.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
segmentConfig.<br>config.<br>gpResourceManager | **string**<br><p>Identifies the resource management scheme currently enabled in the Greenplum Database cluster. The default scheme is to use resource queues. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_manager &quot;group&quot; is the default value</p> 
segmentConfig.<br>config.<br>gpResourceGroupCpuLimit | **number** (float)<br><p>Identifies the maximum percentage of system CPU resources to allocate to resource groups on each Greenplum Database segment node. Note: The gp_resource_group_cpu_limit server configuration parameter is enforced only when resource group-based resource management is active. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_cpu_limit</p> 
segmentConfig.<br>config.<br>gpResourceGroupMemoryLimit | **number** (float)<br><p>Identifies the maximum percentage of system memory resources to allocate to resource groups on each Greenplum Database segment node. Note: The gp_resource_group_memory_limit server configuration parameter is enforced only when resource group-based resource management is active. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_resource_group_memory_limit</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
 
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