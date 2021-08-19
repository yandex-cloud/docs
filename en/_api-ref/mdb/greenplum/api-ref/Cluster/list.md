---
editable: false
---

# Method list
Retrieves a list of Greenplum clusters that belong
to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/managed-greenplum/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list Greenplum clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-greenplum/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-greenplum/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-greenplum/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-greenplum/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-greenplum/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  The maximum string length in characters is 1000.
 
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
        "access": {
          "dataLens": true,
          "webSql": true
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
        },
        "config": {
          "effectiveConfig": {
            "logLevel": "string",
            "maxConnections": "integer",
            "timezone": "string"
          },
          "userConfig": {
            "logLevel": "string",
            "maxConnections": "integer",
            "timezone": "string"
          },
          "defaultConfig": {
            "logLevel": "string",
            "maxConnections": "integer",
            "timezone": "string"
          }
        }
      },
      "segmentConfig": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "config": {
          "effectiveConfig": {
            "logLevel": "string",
            "maxConnections": "integer"
          },
          "userConfig": {
            "logLevel": "string",
            "maxConnections": "integer"
          },
          "defaultConfig": {
            "logLevel": "string",
            "maxConnections": "integer"
          }
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
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>A Greenplum Cluster resource. For more information, see the</p> 
clusters[].<br>id | **string**<br><p>ID of the Greenplum cluster. This ID is assigned by MDB at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Greenplum cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Required. Name of the Greenplum cluster. The name is unique within the folder. 1-63 characters long.</p> <p>The maximum string length in characters is 63.</p> 
clusters[].<br>config | **object**<br><p>Green plum cluster config</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of the Greenplum server software.</p> 
clusters[].<br>config.<br>backupWindowStart | **object**<br><p>Time to start the daily backup, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>access | **object**<br><p>Access policy for external services.</p> 
clusters[].<br>config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow to export data from the cluster to Yandex DataLens.</p> 
clusters[].<br>config.<br>access.<br>webSql | **boolean** (boolean)<br><p>Allow SQL queries to the cluster databases from the Yandex.Cloud management console.</p> 
clusters[].<br>config.<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
clusters[].<br>config.<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-greenplum/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>The maximum string length in characters is 50.</p> 
clusters[].<br>config.<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with ``assignPublicIp`` set as needed.</p> <p>Possible values:</p> <ul> <li>false - don't assign a public IP to the master hosts.</li> <li>true - the master hosts should have a public IP address.</li> </ul> 
clusters[].<br>description | **string**<br><p>Description of the Greenplum cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the Greenplum cluster as ``key:value`` pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the Greenplum cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Monitoring system metadata.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the Greenplum cluster.</p> 
clusters[].<br>masterConfig | **object**<br><p>Configuration of the Greenplum master subcluster.</p> <p>Configuration of master subcluster</p> 
clusters[].<br>masterConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum master subcluster hosts.</p> 
clusters[].<br>masterConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>masterConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
clusters[].<br>masterConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
clusters[].<br>masterConfig.<br>config | **object**<br><p>Configuration settings of a Greenplum master server.</p> 
clusters[].<br>masterConfig.<br>config.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum master subcluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Greenplum master subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>masterConfig.<br>config.<br>effectiveConfig.<br>logLevel | **string**<br><p>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>masterConfig.<br>config.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
clusters[].<br>masterConfig.<br>config.<br>effectiveConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
clusters[].<br>masterConfig.<br>config.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum master subcluster.</p> <p>Greenplum master subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>masterConfig.<br>config.<br>userConfig.<br>logLevel | **string**<br><p>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>masterConfig.<br>config.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
clusters[].<br>masterConfig.<br>config.<br>userConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
clusters[].<br>masterConfig.<br>config.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum master subcluster.</p> <p>Greenplum master subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>masterConfig.<br>config.<br>defaultConfig.<br>logLevel | **string**<br><p>Logging level for the Greenplum master subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>masterConfig.<br>config.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
clusters[].<br>masterConfig.<br>config.<br>defaultConfig.<br>timezone | **string**<br><p>The server's time zone to be used in DateTime fields conversions. Specified as an IANA identifier.</p> 
clusters[].<br>segmentConfig | **object**<br><p>Configuration of the Greenplum segment subcluster.</p> <p>Configuration of segmet subcluster</p> 
clusters[].<br>segmentConfig.<br>resources | **object**<br><p>Resources allocated to Greenplum segment subcluster hosts.</p> 
clusters[].<br>segmentConfig.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>segmentConfig.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
clusters[].<br>segmentConfig.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
clusters[].<br>segmentConfig.<br>config | **object**<br><p>Configuration settings of a Greenplum segment server.</p> 
clusters[].<br>segmentConfig.<br>config.<br>effectiveConfig | **object**<br><p>Required. Effective settings for a Greenplum segment subcluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Greenplum segment subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>segmentConfig.<br>config.<br>effectiveConfig.<br>logLevel | **string**<br><p>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>segmentConfig.<br>config.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
clusters[].<br>segmentConfig.<br>config.<br>userConfig | **object**<br><p>User-defined settings for a Greenplum segment subcluster.</p> <p>Greenplum segment subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>segmentConfig.<br>config.<br>userConfig.<br>logLevel | **string**<br><p>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>segmentConfig.<br>config.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
clusters[].<br>segmentConfig.<br>config.<br>defaultConfig | **object**<br><p>Default configuration for a Greenplum segment subcluster.</p> <p>Greenplum segment subcluster configuration options. Detailed description for each set of options</p> <p>Any options not listed here are not supported.</p> 
clusters[].<br>segmentConfig.<br>config.<br>defaultConfig.<br>logLevel | **string**<br><p>Logging level for the Greenplum segment subcluster. Possible values: TRACE, DEBUG, INFORMATION, WARNING, ERROR.</p> 
clusters[].<br>segmentConfig.<br>config.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>Maximum number of inbound connections.</p> 
clusters[].<br>masterHostCount | **string** (int64)<br><p>Number of hosts of the master subcluster</p> 
clusters[].<br>segmentHostCount | **string** (int64)<br><p>Number of hosts of the segment subcluster</p> 
clusters[].<br>segmentInHost | **string** (int64)<br><p>Number of segments in the host</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
clusters[].<br>maintenanceWindow | **object**<br><p>Window of maintenance operations.</p> 
clusters[].<br>maintenanceWindow.<br>anytime | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`clusters[].maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br>
clusters[].<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
clusters[].<br>plannedOperation | **object**<br><p>Maintenance operation planned at nearest maintenance_window.</p> 
clusters[].<br>plannedOperation.<br>info | **string**<br><p>The maximum string length in characters is 256.</p> 
clusters[].<br>plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>securityGroupIds[] | **string**<br><p>User security groups</p> 
clusters[].<br>userName | **string**<br><p>Owner user name</p> 
clusters[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-greenplum/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-greenplum/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-greenplum/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-greenplum/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 