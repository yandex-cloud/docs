---
editable: false
---

# Method list
Retrieves the list of MySQL clusters that belong to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1alpha/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list MySQL clusters in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-mysql/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-mysql/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-mysql/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-mysql/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-mysql/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  The maximum string length in characters is 1000.
 
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
      "config": {
        "version": "string",
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        },
        "backupWindowStart": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        },
        "mysqlConfig_5_7": {
          "effectiveConfig": {
            "innodbBufferPoolSize": "integer",
            "maxConnections": "integer",
            "longQueryTime": "number"
          },
          "userConfig": {
            "innodbBufferPoolSize": "integer",
            "maxConnections": "integer",
            "longQueryTime": "number"
          },
          "defaultConfig": {
            "innodbBufferPoolSize": "integer",
            "maxConnections": "integer",
            "longQueryTime": "number"
          }
        }
      },
      "networkId": "string",
      "health": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>A MySQL cluster. For more information, see the <a href="/docs/managed-mysql/concepts">documentation</a>.</p> 
clusters[].<br>id | **string**<br><p>ID of the MySQL cluster. This ID is assigned by Managed Service for MySQL at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the MySQL cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the MySQL cluster. The name must be unique within the folder, comply with RFC 1035 and be 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the MySQL cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the MySQL cluster as `key:value` pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the MySQL cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the MySQL cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the MySQL cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the MySQL cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of MySQL server software.</p> 
clusters[].<br>config.<br>resources | **object**<br>Resources allocated to MySQL hosts.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mysql/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7 | **object**<br>Configuration of a MySQL 5.7 server.<br>
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig | **object**<br><p>Effective settings for a MySQL 5.7 cluster (a combination of settings defined in `userConfig` and `defaultConfig`).</p> <p>Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>effectiveConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig | **object**<br><p>User-defined settings for a MySQL 5.7 cluster.</p> <p>Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>userConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig | **object**<br><p>Default configuration for a MySQL 5.7 cluster.</p> <p>Options and structure of `MysqlConfig5_7` reflects MySQL 5.7 configuration file</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>innodbBufferPoolSize | **integer** (int64)<br><p>Size of the InnoDB buffer pool used for caching table and index data.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size">MySQL documentation for the parameter</a>.</p> <p>The minimum value is 5242880.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>maxConnections | **integer** (int64)<br><p>The maximum permitted number of simultaneous client connections.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_max_connections">MySQL documentation for the variable</a>.</p> <p>Acceptable values are 10 to 10000, inclusive.</p> 
clusters[].<br>config.<br>mysqlConfig_5_7.<br>defaultConfig.<br>longQueryTime | **number** (double)<br><p>Time that it takes to process a query before it is considered slow.</p> <p>For details, see <a href="https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_long_query_time">MySQL documentation for the variable</a>.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (`health` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (`health` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (`health` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (`health` for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mysql/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 