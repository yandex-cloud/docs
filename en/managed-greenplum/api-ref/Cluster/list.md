---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/Cluster/list.md
---

# Managed Service for Greenplum® API, REST: Cluster.list
Retrieves a list of Greenplum® clusters that belong to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list Greenplum® clusters in.</p> <p>To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-greenplum/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-greenplum/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-greenplum/api-ref/Cluster/list#query_params">pageToken</a> to the <a href="/docs/managed-greenplum/api-ref/Cluster/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li> <p>The field name. Currently you can only use filtering with the <a href="/docs/managed-greenplum/api-ref/Cluster#representation">Cluster.name</a> field.</p> </li> <li> <p>An ``=`` operator.</p> </li> <li> <p>The value in double quotes (``"``). Must be 1-63 characters long and match the regular expression ``[a-zA-Z0-9_-]+``.</p> </li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
        "backupRetainPeriodDays": "integer",
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

        // `clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": {},
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        },
        // end of the list of possible fields`clusters[].maintenanceWindow`

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
        "pxfConfig": {
          "effectiveConfig": {
            "connectionTimeout": "integer",
            "uploadTimeout": "integer",
            "maxThreads": "integer",
            "poolAllowCoreThreadTimeout": true,
            "poolCoreSize": "integer",
            "poolQueueCapacity": "integer",
            "poolMaxSize": "integer",
            "xmx": "integer",
            "xms": "integer"
          },
          "userConfig": {
            "connectionTimeout": "integer",
            "uploadTimeout": "integer",
            "maxThreads": "integer",
            "poolAllowCoreThreadTimeout": true,
            "poolCoreSize": "integer",
            "poolQueueCapacity": "integer",
            "poolMaxSize": "integer",
            "xmx": "integer",
            "xms": "integer"
          },
          "defaultConfig": {
            "connectionTimeout": "integer",
            "uploadTimeout": "integer",
            "maxThreads": "integer",
            "poolAllowCoreThreadTimeout": true,
            "poolCoreSize": "integer",
            "poolQueueCapacity": "integer",
            "poolMaxSize": "integer",
            "xmx": "integer",
            "xms": "integer"
          }
        },

        // `clusters[].clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`
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
        "greenplumConfigSet_6": {
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
        // end of the list of possible fields`clusters[].clusterConfig`

      },
      "cloudStorage": {
        "enable": true
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>List of Greenplum® cluster resources.</p> 
clusters[].<br>id | **string**<br><p>ID of the Greenplum® cluster. This ID is assigned by the platform at the moment of cluster creation.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Greenplum® cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Time when the cluster was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
clusters[].<br>name | **string**<br><p>Required. Name of the Greenplum® cluster. The name is unique within the folder.</p> <p>The maximum string length in characters is 63.</p> 
clusters[].<br>config | **object**<br><p>Greenplum® cluster configuration.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of the Greenplum® server software.</p> 
clusters[].<br>config.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>backupRetainPeriodDays | **integer** (int64)<br><p>Retention policy of automated backups.</p> <p>Acceptable values are 1 to 7, inclusive.</p> 
clusters[].<br>config.<br>access | **object**<br><p>Access policy for external services.</p> 
clusters[].<br>config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allows data export from the cluster to DataLens.</p> 
clusters[].<br>config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allows SQL queries to the cluster databases from the management console.</p> 
clusters[].<br>config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allows access for DataTransfer.</p> 
clusters[].<br>config.<br>zoneId | **string**<br><p>ID of the availability zone the cluster belongs to. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
clusters[].<br>config.<br>subnetId | **string**<br><p>ID of the subnet the cluster belongs to. This subnet should be a part of the cloud network the cluster belongs to (see <a href="/docs/managed-greenplum/api-ref/Cluster#representation">Cluster.networkId</a>).</p> <p>The maximum string length in characters is 50.</p> 
clusters[].<br>config.<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether the cluster has a public IP address.</p> <p>After the cluster has been created, this setting cannot be changed.</p> 
clusters[].<br>description | **string**<br><p>Description of the Greenplum® cluster.</p> <p>The maximum string length in characters is 256.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the Greenplum® cluster as ``key:value`` pairs. Maximum 64 labels per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the Greenplum® cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the Greenplum® cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Greenplum® cluster.</p> 
clusters[].<br>masterConfig | **object**<br><p>Configuration of the Greenplum® master subcluster.</p> 
clusters[].<br>masterConfig.<br>resources | **object**<br><p>Computational resources allocated to Greenplum® master subcluster hosts.</p> 
clusters[].<br>masterConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> <p>Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>masterConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
clusters[].<br>masterConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
clusters[].<br>segmentConfig | **object**<br><p>Configuration of the Greenplum® segment subcluster.</p> 
clusters[].<br>segmentConfig.<br>resources | **object**<br><p>Computational resources allocated to Greenplum® segment subcluster hosts.</p> 
clusters[].<br>segmentConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> <p>Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>segmentConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
clusters[].<br>segmentConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
clusters[].<br>masterHostCount | **string** (int64)<br><p>Number of hosts in the master subcluster.</p> 
clusters[].<br>segmentHostCount | **string** (int64)<br><p>Number of hosts in the segment subcluster.</p> 
clusters[].<br>segmentInHost | **string** (int64)<br><p>Number of segments per host.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the cloud network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: Health of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is working normally (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> <li>UNBALANCED: Cluster is working below capacity (``health`` for at least one host in the cluster is UNBALANCED).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster has encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster has stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>maintenanceWindow | **object**<br><p>A Greenplum® cluster maintenance window. Should be defined by either one of the two options.</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object**<br>An any-time maintenance window. <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>A weekly maintenance window. <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> <ul> <li>MON: Monday</li> <li>TUE: Tuesday</li> <li>WED: Wednesday</li> <li>THU: Thursday</li> <li>FRI: Friday</li> <li>SAT: Saturday</li> <li>SUN: Sunday</li> </ul> 
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Maintenance operation planned at nearest <a href="/docs/managed-greenplum/api-ref/Cluster#representation">maintenanceWindow</a>.</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>The description of the operation.</p> <p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Delay time for the maintenance operation.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups.</p> 
clusters[].<br>userName | **string**<br><p>Owner user name.</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
clusters[].<br>hostGroupIds[] | **string**<br><p>Host groups hosting VMs of the cluster.</p> 
clusters[].<br>clusterConfig | **object**<br><p>Greenplum® and Odyssey® configuration.</p> 
clusters[].<br>clusterConfig.<br>pool | **object**<br>Odyssey® pool settings.
clusters[].<br>clusterConfig.<br>pool.<br>effectiveConfig | **object**<br><p>Required. Effective settings for an Odyssey® pooler (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusters[].<br>clusterConfig.<br>pool.<br>effectiveConfig.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
clusters[].<br>clusterConfig.<br>pool.<br>effectiveConfig.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>effectiveConfig.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>userConfig | **object**<br><p>User-defined settings for an Odyssey® pooler.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>userConfig.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
clusters[].<br>clusterConfig.<br>pool.<br>userConfig.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>userConfig.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>defaultConfig | **object**<br><p>Default configuration for an Odyssey® pooler.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>defaultConfig.<br>mode | **string**<br><p>Route server pool mode.</p> <ul> <li>SESSION: Assign server connection to a client until it disconnects. Default value.</li> <li>TRANSACTION: Assign server connection to a client for a transaction processing.</li> </ul> 
clusters[].<br>clusterConfig.<br>pool.<br>defaultConfig.<br>size | **integer** (int64)<br><p>The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.</p> <p>Set to zero to disable the limit.</p> 
clusters[].<br>clusterConfig.<br>pool.<br>defaultConfig.<br>clientIdleTimeout | **integer** (int64)<br><p>Server pool idle timeout, in seconds.</p> <p>A server connection closes after being idle for the specified time.</p> <p>Set to zero to disable the limit.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities | **object**
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>tableSizes | **object**
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>tableSizes.<br>starts[] | **object**<br><p>The maximum number of elements is 4.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>tableSizes.<br>starts[].<br>hours | **string** (int64)<br><p>Acceptable values are 0 to 23, inclusive.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>tableSizes.<br>starts[].<br>minutes | **string** (int64)<br><p>Acceptable values are 0 to 59, inclusive.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>analyzeAndVacuum | **object**
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>analyzeAndVacuum.<br>start | **object**
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>analyzeAndVacuum.<br>start.<br>hours | **string** (int64)<br><p>Acceptable values are 0 to 23, inclusive.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>analyzeAndVacuum.<br>start.<br>minutes | **string** (int64)<br><p>Acceptable values are 0 to 59, inclusive.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>analyzeAndVacuum.<br>analyzeTimeout | **integer** (int64)<br><p>in seconds 24<em>60</em>60-1 = 86399</p> <p>Acceptable values are 0 to 86399, inclusive.</p> 
clusters[].<br>clusterConfig.<br>backgroundActivities.<br>analyzeAndVacuum.<br>vacuumTimeout | **integer** (int64)<br><p>in seconds 24<em>60</em>60-1 = 86399</p> <p>Acceptable values are 0 to 86399, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig | **object**
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig | **object**<br><p>Required.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>connectionTimeout | **integer** (int64)<br><p>Connection</p> <p>Acceptable values are 5 to 600, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>uploadTimeout | **integer** (int64)<br><p>Acceptable values are 5 to 600, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>maxThreads | **integer** (int64)<br><p>Thread pool</p> <p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>poolAllowCoreThreadTimeout | **boolean** (boolean)
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>poolCoreSize | **integer** (int64)<br><p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>poolQueueCapacity | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>poolMaxSize | **integer** (int64)<br><p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>xmx | **integer** (int64)<br><p>JVM</p> <p>Acceptable values are 64 to 16384, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>effectiveConfig.<br>xms | **integer** (int64)<br><p>Acceptable values are 64 to 16384, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig | **object**<br><p>User-defined settings</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>connectionTimeout | **integer** (int64)<br><p>Connection</p> <p>Acceptable values are 5 to 600, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>uploadTimeout | **integer** (int64)<br><p>Acceptable values are 5 to 600, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>maxThreads | **integer** (int64)<br><p>Thread pool</p> <p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>poolAllowCoreThreadTimeout | **boolean** (boolean)
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>poolCoreSize | **integer** (int64)<br><p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>poolQueueCapacity | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>poolMaxSize | **integer** (int64)<br><p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>xmx | **integer** (int64)<br><p>JVM</p> <p>Acceptable values are 64 to 16384, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>userConfig.<br>xms | **integer** (int64)<br><p>Acceptable values are 64 to 16384, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig | **object**<br><p>Default configuration</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>connectionTimeout | **integer** (int64)<br><p>Connection</p> <p>Acceptable values are 5 to 600, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>uploadTimeout | **integer** (int64)<br><p>Acceptable values are 5 to 600, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>maxThreads | **integer** (int64)<br><p>Thread pool</p> <p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>poolAllowCoreThreadTimeout | **boolean** (boolean)
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>poolCoreSize | **integer** (int64)<br><p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>poolQueueCapacity | **integer** (int64)<br><p>The minimum value is 0.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>poolMaxSize | **integer** (int64)<br><p>Acceptable values are 1 to 1024, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>xmx | **integer** (int64)<br><p>JVM</p> <p>Acceptable values are 64 to 16384, inclusive.</p> 
clusters[].<br>clusterConfig.<br>pxfConfig.<br>defaultConfig.<br>xms | **integer** (int64)<br><p>Acceptable values are 64 to 16384, inclusive.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17 | **object** <br>`clusters[].clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`<br><br><p>Configuration settings version 6.17</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_17.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19 | **object** <br>`clusters[].clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`<br><br><p>Configuration settings version 6.19</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum® cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>effectiveConfig.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>userConfig.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>The maximum size of WAL files that replication slots are allowed to retain in the ``pg_wal`` directory at checkpoint time.</p> <p>More info in <a href="https://www.postgresql.org/docs/current/runtime-config-replication.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>The maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>The maximum disk size that an individual query is allowed to use for creating temporary spill files at each segment.</p> <p>The default value is 0 (no limit).</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>The maximum number of temporary spill files allowed per query at each segment.</p> <p>Spill files, also known as workfiles, are created when a query requires more memory than there is allocated.</p> <p>The current query is terminated if the limit is exceeded.</p> <p>Set to zero to disable the limit.</p> <p>Master session reloads if the parameter changes.</p> <p>Default value is 10000.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>The maximum number of transactions that can be in the ``prepared`` state simultaneously.</p> <p>More info in <a href="https://www.postgresql.org/docs/9.6/runtime-config-resource.html">PostgreSQL® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Whether the spill files are compressed or not.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>The maximum memory limit for a query, in bytes.</p> <p>Helps to avoid out-of-memory errors on a segment host during query processing as a result of setting ``statement_mem`` too high.</p> <p>Taking into account the configuration of a single segment host, calculate ``maxStatementMem`` as follows: ``seghost_physical_memory`` / ``average_number_concurrent_queries``.</p> <p>When changing both ``maxStatementMem`` and ``statement_mem``, ``maxStatementMem`` must be changed first, or listed first in the ``postgresql.conf`` file.</p> <p>Default value is 2097152000 (2000 MB).</p> <p>More info in <a href="https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem">Greenplum® documentation</a>.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_19.<br>defaultConfig.<br>logStatement | **string**<br><p>Logged SQL statements.</p> <p>``PREPARE`` and ``EXPLAIN ANALYZE`` statements are also logged if their contained command belongs to an appropriate type.</p> <p>More info in <a href="https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement">Greenplum® documentation</a>.</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21 | **object** <br>`clusters[].clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`<br>
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum®  cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>effectiveConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>userConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_21.<br>defaultConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22 | **object** <br>`clusters[].clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`<br>
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum®  cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>effectiveConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>userConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum® cluster.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.vmware.com/en/VMware-Greenplum/6/greenplum-database/ref_guide-config_params-guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6_22.<br>defaultConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6 | **object** <br>`clusters[].clusterConfig` includes only one of the fields `greenplumConfigSet_6_17`, `greenplumConfigSet_6_19`, `greenplumConfigSet_6_21`, `greenplumConfigSet_6_22`, `greenplumConfigSet_6`<br>
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>effectiveConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>userConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum.</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections on master segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>maxSlotWalKeepSize | **integer** (int64)<br><p>Specify the maximum size of WAL files that replication slots are allowed to retain in the pg_wal directory at checkpoint time. https://www.postgresql.org/docs/current/runtime-config-replication.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>gpWorkfileLimitPerSegment | **integer** (int64)<br><p>Sets the maximum total disk size that all running queries are allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_segment</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>gpWorkfileLimitPerQuery | **integer** (int64)<br><p>Sets the maximum disk size an individual query is allowed to use for creating temporary spill files at each segment. The default value is 0, which means a limit is not enforced. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_per_query</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>gpWorkfileLimitFilesPerQuery | **integer** (int64)<br><p>Sets the maximum number of temporary spill files (also known as workfiles) allowed per query per segment. Spill files are created when executing a query that requires more memory than it is allocated. The current query is terminated when the limit is exceeded. Set the value to 0 (zero) to allow an unlimited number of spill files. master session reload https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_limit_files_per_query Default value is 10000</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>maxPreparedTransactions | **integer** (int64)<br><p>Sets the maximum number of transactions that can be in the "prepared" state simultaneously https://www.postgresql.org/docs/9.6/runtime-config-resource.html</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>gpWorkfileCompression | **boolean** (boolean)<br><p>Specifies whether the temporary files created, when a hash aggregation or hash join operation spills to disk, are compressed. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#gp_workfile_compression</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>maxStatementMem | **integer** (int64)<br><p>Sets the maximum memory limit for a query. Helps avoid out-of-memory errors on a segment host during query processing as a result of setting statement_mem too high. Taking into account the configuration of a single segment host, calculate max_statement_mem as follows: (seghost_physical_memory) / (average_number_concurrent_queries) When changing both max_statement_mem and statement_mem, max_statement_mem must be changed first, or listed first in the postgresql.conf file. https://greenplum.docs.pivotal.io/6-19/ref_guide/config_params/guc-list.html#max_statement_mem Default value is 2097152000 (2000MB)</p> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>logStatement | **string**<br><p>Controls which SQL statements are logged. DDL logs all data definition commands like CREATE, ALTER, and DROP commands. MOD logs all DDL statements, plus INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE and EXPLAIN ANALYZE statements are also logged if their contained command is of an appropriate type. https://docs.greenplum.org/6-5/ref_guide/config_params/guc-list.html#log_statement Default value is ddl</p> <ul> <li>NONE: None statements are logged.</li> <li>DDL: Logs all data definition commands like ``CREATE``, ``ALTER``, and ``DROP``. Default value.</li> <li>MOD: Logs all ``DDL`` statements, plus ``INSERT``, ``UPDATE``, ``DELETE``, ``TRUNCATE``, and ``COPY FROM``.</li> <li>ALL: Logs all statements.</li> </ul> 
clusters[].<br>clusterConfig.<br>greenplumConfigSet_6.<br>defaultConfig.<br>gpAddColumnInheritsTableSetting | **boolean** (boolean)<br><p>https://docs.vmware.com/en/VMware-Tanzu-Greenplum/6/greenplum-database/GUID-ref_guide-config_params-guc-list.html#gp_add_column_inherits_table_setting</p> 
clusters[].<br>cloudStorage | **object**<br><p>Cloud storage settings</p> <p>Cloud Storage Settings</p> 
clusters[].<br>cloudStorage.<br>enable | **boolean** (boolean)<br><p>enable Cloud Storage for cluster</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-greenplum/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-greenplum/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-greenplum/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-greenplum/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 