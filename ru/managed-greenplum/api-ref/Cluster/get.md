---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/Cluster/get.md
---

# Managed Service for Greenplum® API, REST: Cluster.get
Returns the specified Greenplum® cluster.
 
To get the list of all available Greenplum® clusters, make a [list](/docs/managed-greenplum/api-ref/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Greenplum® cluster resource to return.</p> <p>To get the cluster ID, use a <a href="/docs/managed-greenplum/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
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
  "description": "string",
  "labels": "object",
  "environment": "string",
  "monitoring": [
    {
      "name": "string",
      "description": "string",
      "link": "string"
    }
  ],
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
  "segmentHostCount": "string",
  "segmentInHost": "string",
  "networkId": "string",
  "health": "string",
  "status": "string",
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "string"
  },
  "securityGroupIds": [
    "string"
  ],
  "userName": "string",
  "deletionProtection": true,
  "hostGroupIds": [
    "string"
  ],
  "clusterConfig": {
    "pool": {
      "effectiveConfig": {
        "mode": "string",
        "size": "integer",
        "clientIdleTimeout": "integer"
      },
      "userConfig": {
        "mode": "string",
        "size": "integer",
        "clientIdleTimeout": "integer"
      },
      "defaultConfig": {
        "mode": "string",
        "size": "integer",
        "clientIdleTimeout": "integer"
      }
    },

    // `clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`
    "greenplumConfigSet_6_17": {
      "effectiveConfig": {
        "maxConnections": "integer",
        "maxSlotWalKeepSize": "integer",
        "gpWorkfileLimitPerSegment": "integer",
        "gpWorkfileLimitPerQuery": "integer",
        "gpWorkfileLimitFilesPerQuery": "integer",
        "maxPreparedTransactions": "integer",
        "gpWorkfileCompression": true
      },
      "userConfig": {
        "maxConnections": "integer",
        "maxSlotWalKeepSize": "integer",
        "gpWorkfileLimitPerSegment": "integer",
        "gpWorkfileLimitPerQuery": "integer",
        "gpWorkfileLimitFilesPerQuery": "integer",
        "maxPreparedTransactions": "integer",
        "gpWorkfileCompression": true
      },
      "defaultConfig": {
        "maxConnections": "integer",
        "maxSlotWalKeepSize": "integer",
        "gpWorkfileLimitPerSegment": "integer",
        "gpWorkfileLimitPerQuery": "integer",
        "gpWorkfileLimitFilesPerQuery": "integer",
        "maxPreparedTransactions": "integer",
        "gpWorkfileCompression": true
      }
    },
    "greenplumConfigSet_6_19": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
        "maxConnections": "integer",
        "maxSlotWalKeepSize": "integer",
        "gpWorkfileLimitPerSegment": "integer",
        "gpWorkfileLimitPerQuery": "integer",
        "gpWorkfileLimitFilesPerQuery": "integer",
        "maxPreparedTransactions": "integer",
        "gpWorkfileCompression": true,
        "maxStatementMem": "integer",
        "logStatement": "string"
      }
    },
    "greenplumConfigSet_6_21": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    "greenplumConfigSet_6_22": {
      "effectiveConfig": {
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
      "userConfig": {
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
      "defaultConfig": {
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
      }
    },
    // end of the list of possible fields`clusterConfig`

  }
}
```
A Greenplum® cluster resource.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation.</p> 
folderId | **string**<br><p>ID of the folder that the Greenplum® cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Time when the cluster was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Required. Name of the Greenplum® cluster. The name is unique within the folder.</p> <p>The maximum string length in characters is 63.</p> 
config | **object**<br><p>Greenplum® cluster configuration.</p> 
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
description | **string**<br><p>Description of the Greenplum® cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Greenplum® cluster as ``key:value`` pairs. Maximum 64 labels per resource.</p> 
environment | **string**<br><p>Deployment environment of the Greenplum® cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Greenplum® cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Greenplum® cluster.</p> 
masterConfig | **object**<br><p>Configuration of the Greenplum® master subcluster.</p> 
masterConfig.<br>resources | **object**<br><p>Computational resources allocated to Greenplum® master subcluster hosts.</p> 
masterConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> <p>Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
masterConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
masterConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
segmentConfig | **object**<br><p>Configuration of the Greenplum® segment subcluster.</p> 
segmentConfig.<br>resources | **object**<br><p>Computational resources allocated to Greenplum® segment subcluster hosts.</p> 
segmentConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> <p>Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
segmentConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
segmentConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
masterHostCount | **string** (int64)<br><p>Number of hosts in the master subcluster.</p> 
segmentHostCount | **string** (int64)<br><p>Number of hosts in the segment subcluster.</p> 
segmentInHost | **string** (int64)<br><p>Number of segments per host.</p> 
networkId | **string**<br><p>ID of the cloud network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Health of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is working normally (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> <li>UNBALANCED: Cluster is working below capacity (``health`` for at least one host in the cluster is UNBALANCED).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster has encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster has stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
maintenanceWindow | **object**<br><p>A Greenplum® cluster maintenance window. Should be defined by either one of the two options.</p> 
maintenanceWindow.<br>anytime | **object**<br>An any-time maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>A weekly maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> <ul> <li>MON: Monday</li> <li>TUE: Tuesday</li> <li>WED: Wednesday</li> <li>THU: Thursday</li> <li>FRI: Friday</li> <li>SAT: Saturday</li> <li>SUN: Sunday</li> </ul> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
plannedOperation | **object**<br><p>Maintenance operation planned at nearest <a href="/docs/managed-greenplum/api-ref/Cluster#representation">maintenanceWindow</a>.</p> 
plannedOperation.<br>info | **string**<br><p>The description of the operation.</p> <p>The maximum string length in characters is 256.</p> 
plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Delay time for the maintenance operation.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
userName | **string**<br><p>Owner user name.</p> 
deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
clusterConfig | **object**<br><p>Greenplum® and Odyssey® configuration.</p> 
clusterConfig.<br>pool | **object**<br>Odyssey® pool settings.
clusterConfig.<br>pool.<br>effectiveConfig | **object**<br><p>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusterConfig.<br>pool.<br>effectiveConfig.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
clusterConfig.<br>pool.<br>effectiveConfig.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
clusterConfig.<br>pool.<br>effectiveConfig.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
clusterConfig.<br>pool.<br>userConfig | **object**<br><p>User-defined settings for an Odyssey® pooler.</p> 
clusterConfig.<br>pool.<br>userConfig.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
clusterConfig.<br>pool.<br>userConfig.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
clusterConfig.<br>pool.<br>userConfig.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
clusterConfig.<br>pool.<br>defaultConfig | **object**<br><p>Default configuration for an Odyssey® pooler.</p> 
clusterConfig.<br>pool.<br>defaultConfig.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
clusterConfig.<br>pool.<br>defaultConfig.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
clusterConfig.<br>pool.<br>defaultConfig.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
clusterConfig.<br>greenplumConfigSet_6_17 | **object** <br>`clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`<br><br><p>Configuration settings version 6.17</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19 | **object** <br>`clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`<br><br><p>Configuration settings version 6.19</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_21 | **object** <br>`clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`<br>
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum®  cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusterConfig.<br>greenplumConfigSet_6_22 | **object** <br>`clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`<br>
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum®  cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 