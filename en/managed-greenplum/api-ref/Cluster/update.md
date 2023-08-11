---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/Cluster/update.md
---

# Managed Service for Greenplum® API, REST: Cluster.update
Updates the specified Greenplum® cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Greenplum® cluster resource to update. To get the Greenplum® cluster ID, use a <a href="/docs/managed-greenplum/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "userPassword": "string",
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
  "deletionProtection": true,
  "configSpec": {
    "pool": {
      "mode": "string",
      "size": "integer",
      "clientIdleTimeout": "integer"
    },
    "backgroundActivities": {
      "tableSizes": {
        "starts": [
          {
            "hours": "string",
            "minutes": "string"
          }
        ]
      },
      "analyzeAndVacuum": {
        "start": {
          "hours": "string",
          "minutes": "string"
        },
        "analyzeTimeout": "integer",
        "vacuumTimeout": "integer"
      }
    },

    // `configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`, `greenplumConfig_6_21`, `greenplumConfig_6_22`
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
      "gpWorkfileCompression": true,
      "maxStatementMem": "integer",
      "logStatement": "string"
    },
    "greenplumConfig_6_21": {
      "maxConnections": "integer",
      "maxSlotWalKeepSize": "integer",
      "gpWorkfileLimitPerSegment": "integer",
      "gpWorkfileLimitPerQuery": "integer",
      "gpWorkfileLimitFilesPerQuery": "integer",
      "maxPreparedTransactions": "integer",
      "gpWorkfileCompression": true,
      "maxStatementMem": "integer",
      "logStatement": "string",
      "gpAddColumnInheritsTableSetting": true
    },
    "greenplumConfig_6_22": {
      "maxConnections": "integer",
      "maxSlotWalKeepSize": "integer",
      "gpWorkfileLimitPerSegment": "integer",
      "gpWorkfileLimitPerQuery": "integer",
      "gpWorkfileLimitFilesPerQuery": "integer",
      "maxPreparedTransactions": "integer",
      "gpWorkfileCompression": true,
      "maxStatementMem": "integer",
      "logStatement": "string",
      "gpAddColumnInheritsTableSetting": true
    },
    // end of the list of possible fields`configSpec`

  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Greenplum® cluster resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the Greenplum® cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Greenplum® cluster as ``key:value`` pairs. For example, ``"project":"mvp"`` or ``"source":"dictionary"``.</p> <p>The new set of labels completely replaces the old one. To add a label, request the current set with the <a href="/docs/managed-greenplum/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-greenplum/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
name | **string**<br><p>New name for the cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
config | **object**<br><p>The Greenplum® cluster configuration.</p> 
config.<br>version | **string**<br><p>Version of the Greenplum® server software.</p> 
config.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>access | **object**<br><p>Access policy for external services.</p> 
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allows data export from the cluster to DataLens.</p> 
config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allows SQL queries to the cluster databases from the management console.</p> 
config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allows access for DataTransfer.</p> 
config.<br>zoneId | **string**<br><p>ID of the availability zone the cluster belongs to. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
config.<br>subnetId | **string**<br><p>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see <a href="/docs/managed-greenplum/api-ref/Cluster#representation">Cluster.networkId</a>).</p> <p>The maximum string length in characters is 50.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether the cluster has a public IP address.</p> <p>After the cluster has been created, this setting cannot be changed.</p> 
masterConfig | **object**<br><p>Configuration of the Greenplum® master subcluster.</p> 
masterConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum® master subcluster hosts.</p> 
masterConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> <p>Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
masterConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
masterConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
segmentConfig | **object**<br><p>Configuration of the Greenplum® segment subcluster.</p> 
segmentConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum® segment subcluster hosts.</p> 
segmentConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> <p>Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
segmentConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
segmentConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
userPassword | **string**<br><p>Required. Owner user password.</p> <p>The string length in characters must be 8-128.</p> 
maintenanceWindow | **object**<br><p>The Greenplum® cluster maintenance window. Should be defined by either one of the two options.</p> 
maintenanceWindow.<br>anytime | **object**<br>An any-time maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>A weekly maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> <ul> <li>MON: Monday</li> <li>TUE: Tuesday</li> <li>WED: Wednesday</li> <li>THU: Thursday</li> <li>FRI: Friday</li> <li>SAT: Saturday</li> <li>SUN: Sunday</li> </ul> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
configSpec | **object**<br><p>Settings of the Greenplum® cluster.</p> 
configSpec.<br>pool | **object**<br>Odyssey® pool settings.
configSpec.<br>pool.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
configSpec.<br>pool.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
configSpec.<br>pool.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
configSpec.<br>backgroundActivities | **object**
configSpec.<br>backgroundActivities.<br>tableSizes | **object**
configSpec.<br>backgroundActivities.<br>tableSizes.<br>starts[] | **object**<br><p>The maximum number of elements is 4.</p> 
configSpec.<br>backgroundActivities.<br>tableSizes.<br>starts[].<br>hours | **string** (int64)<br><p>Acceptable values are 0 to 23, inclusive.</p> 
configSpec.<br>backgroundActivities.<br>tableSizes.<br>starts[].<br>minutes | **string** (int64)<br><p>Acceptable values are 0 to 59, inclusive.</p> 
configSpec.<br>backgroundActivities.<br>analyzeAndVacuum | **object**
configSpec.<br>backgroundActivities.<br>analyzeAndVacuum.<br>start | **object**
configSpec.<br>backgroundActivities.<br>analyzeAndVacuum.<br>start.<br>hours | **string** (int64)<br><p>Acceptable values are 0 to 23, inclusive.</p> 
configSpec.<br>backgroundActivities.<br>analyzeAndVacuum.<br>start.<br>minutes | **string** (int64)<br><p>Acceptable values are 0 to 59, inclusive.</p> 
configSpec.<br>backgroundActivities.<br>analyzeAndVacuum.<br>analyzeTimeout | **integer** (int64)<br><p>in seconds 24<em>60</em>60-1 = 86399</p> <p>Acceptable values are 0 to 86399, inclusive.</p> 
configSpec.<br>backgroundActivities.<br>analyzeAndVacuum.<br>vacuumTimeout | **integer** (int64)<br><p>in seconds 24<em>60</em>60-1 = 86399</p> <p>Acceptable values are 0 to 86399, inclusive.</p> 
configSpec.<br>greenplumConfig_6_17 | **object** <br>`configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`, `greenplumConfig_6_21`, `greenplumConfig_6_22`<br>
configSpec.<br>greenplumConfig_6_17.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
configSpec.<br>greenplumConfig_6_17.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_17.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_17.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19 | **object** <br>`configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`, `greenplumConfig_6_21`, `greenplumConfig_6_22`<br>
configSpec.<br>greenplumConfig_6_19.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
configSpec.<br>greenplumConfig_6_19.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
configSpec.<br>greenplumConfig_6_19.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
configSpec.<br>greenplumConfig_6_21 | **object** <br>`configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`, `greenplumConfig_6_21`, `greenplumConfig_6_22`<br>
configSpec.<br>greenplumConfig_6_21.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
configSpec.<br>greenplumConfig_6_21.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
configSpec.<br>greenplumConfig_6_21.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
configSpec.<br>greenplumConfig_6_21.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
configSpec.<br>greenplumConfig_6_21.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
configSpec.<br>greenplumConfig_6_21.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
configSpec.<br>greenplumConfig_6_21.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
configSpec.<br>greenplumConfig_6_21.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
configSpec.<br>greenplumConfig_6_21.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
configSpec.<br>greenplumConfig_6_21.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
configSpec.<br>greenplumConfig_6_22 | **object** <br>`configSpec` includes only one of the fields `greenplumConfig_6_17`, `greenplumConfig_6_19`, `greenplumConfig_6_21`, `greenplumConfig_6_22`<br>
configSpec.<br>greenplumConfig_6_22.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
configSpec.<br>greenplumConfig_6_22.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
configSpec.<br>greenplumConfig_6_22.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
configSpec.<br>greenplumConfig_6_22.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
configSpec.<br>greenplumConfig_6_22.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
configSpec.<br>greenplumConfig_6_22.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
configSpec.<br>greenplumConfig_6_22.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
configSpec.<br>greenplumConfig_6_22.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
configSpec.<br>greenplumConfig_6_22.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
configSpec.<br>greenplumConfig_6_22.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 