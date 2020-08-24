---
editable: false
---

# Method list
Retrieves the list of sqlserver clusters that belong to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list sqlserver clusters in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1alpha.FolderService.List] request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-sqlserver/api-ref/Cluster/list#query_params), the service returns a [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-sqlserver/api-ref/Cluster/list#query_params) to the [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/managed-sqlserver/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  The maximum string length in characters is 1000.
 
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
        "sqlserverConfig_2016Sp2": {
          "effectiveConfig": {
            "maxDegreeOfParallelism": "integer",
            "costThresholdForParallelism": "integer",
            "sqlcollation": "string",
            "auditLevel": "integer",
            "filestreamAccessLevel": "integer",
            "fillFactorPercent": "integer",
            "inDoubtXactResolution": "integer",
            "optimizeForAdHocWorkloads": true,
            "crossDbOwnershipChaining": true
          },
          "userConfig": {
            "maxDegreeOfParallelism": "integer",
            "costThresholdForParallelism": "integer",
            "sqlcollation": "string",
            "auditLevel": "integer",
            "filestreamAccessLevel": "integer",
            "fillFactorPercent": "integer",
            "inDoubtXactResolution": "integer",
            "optimizeForAdHocWorkloads": true,
            "crossDbOwnershipChaining": true
          },
          "defaultConfig": {
            "maxDegreeOfParallelism": "integer",
            "costThresholdForParallelism": "integer",
            "sqlcollation": "string",
            "auditLevel": "integer",
            "filestreamAccessLevel": "integer",
            "fillFactorPercent": "integer",
            "inDoubtXactResolution": "integer",
            "optimizeForAdHocWorkloads": true,
            "crossDbOwnershipChaining": true
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
clusters[] | **object**<br><p>A sqlserver cluster. For more information, see the <a href="/docs/managed-sqlserver/concepts">documentation</a>.</p> 
clusters[].<br>id | **string**<br><p>ID of the sqlserver cluster. This ID is assigned by Managed Service for sqlserver at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the sqlserver cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the sqlserver cluster. The name must be unique within the folder, comply with RFC 1035 and be 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the sqlserver cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the sqlserver cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the sqlserver cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the sqlserver cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the sqlserver cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the sqlserver cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of sqlserver server software.</p> 
clusters[].<br>config.<br>resources | **object**<br>Resources allocated to sqlserver hosts.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Start time for the daily backup in UTC timezone<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2 | **object**<br>Configuration of a sqlserver 2016sp2 server.<br>
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig | **object**<br><p>Effective settings for a sqlserver 2016 sp2 cluster (a combination of settings defined in <code>userConfig</code> and <code>defaultConfig</code>).</p> <p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig | **object**<br><p>User-defined settings for a sqlserver 2016 sp2 cluster.</p> <p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig | **object**<br><p>Default configuration for a sqlserver 2016 sp2 cluster.</p> <p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (<code>health</code> for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (<code>health</code> for at least one host in the cluster is not ALIVE).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/list#query_params">pageSize</a>, use the <a href="/docs/managed-sqlserver/api-ref/Cluster/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-sqlserver/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-sqlserver/api-ref/Cluster/list#responses">nextPageToken</a> to continue paging through the results.</p> 