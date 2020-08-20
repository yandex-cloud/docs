---
editable: false
---

# Cluster
A set of methods for managing sqlserver clusters.
## JSON Representation {#representation}
```json 
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
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the sqlserver cluster. This ID is assigned by Managed Service for sqlserver at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the sqlserver cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the sqlserver cluster. The name must be unique within the folder, comply with RFC 1035 and be 1-63 characters long.</p> 
description | **string**<br><p>Description of the sqlserver cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the sqlserver cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the sqlserver cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the sqlserver cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the sqlserver cluster.</p> 
config | **object**<br><p>Configuration of the sqlserver cluster.</p> 
config.<br>version | **string**<br><p>Version of sqlserver server software.</p> 
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
config.<br>backupWindowStart | **object**<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>sqlserverConfig_2016Sp2 | **object**<br>
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig | **object**<br><p>Effective settings for a sqlserver 2016 sp2 cluster (a combination of settings defined in <code>userConfig</code> and <code>defaultConfig</code>).</p> <p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig | **object**<br><p>User-defined settings for a sqlserver 2016 sp2 cluster.</p> <p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig | **object**<br><p>Default configuration for a sqlserver 2016 sp2 cluster.</p> <p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (<code>health</code> for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (<code>health</code> for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (<code>health</code> for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (<code>health</code> for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[backup](backup.md) | Creates a backup for the specified sqlserver cluster.
[create](create.md) | Creates a sqlserver cluster in the specified folder.
[delete](delete.md) | Deletes the specified sqlserver cluster.
[get](get.md) | Returns the specified sqlserver cluster.
[list](list.md) | Retrieves the list of sqlserver clusters that belong to the specified folder.
[listBackups](listBackups.md) | Retrieves the list of available backups for the specified sqlserver cluster.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified sqlserver cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified sqlserver cluster. For more information about logs, see the [Logs](/docs/managed-sqlserver/concepts/logs) section in the documentation.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified sqlserver cluster.
[move](move.md) | Moves the specified sqlserver cluster to the specified folder.
[restore](restore.md) | Creates a new sqlserver cluster using the specified backup.
[start](start.md) | Starts the specified sqlserver cluster.
[stop](stop.md) | Stops the specified sqlserver cluster.
[update](update.md) | Modifies the specified sqlserver cluster.