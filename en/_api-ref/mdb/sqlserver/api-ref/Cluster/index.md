---
editable: false
---

# Cluster
A set of methods for managing SQL Server clusters.
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
id | **string**<br><p>ID of the SQL Server cluster. This ID is assigned by Managed Service for SQL Server at creation time.</p> 
folderId | **string**<br><p>ID of the folder the SQL Server cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the SQL Server cluster.</p> <p>The name must be unique within the folder, comply with RFC 1035 and be 1-63 characters long.</p> 
description | **string**<br><p>Description of the SQL Server cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the SQL Server cluster as `key:value` pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the SQL Server cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the SQL Server cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the SQL Server cluster.</p> 
config | **object**<br><p>Configuration of the SQL Server cluster.</p> 
config.<br>version | **string**<br><p>Version of the SQL Server.</p> 
config.<br>resources | **object**<br>
config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
config.<br>backupWindowStart | **object**<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>sqlserverConfig_2016Sp2 | **object**<br>
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig | **object**<br><p>Effective settings for an SQL Server 2016 SP2 cluster (a combination of settings defined in `userConfig` and `defaultConfig`).</p> <p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig | **object**<br><p>User-defined settings for an SQL Server 2016 SP2 cluster.</p> <p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig | **object**<br><p>Default configuration for an SQL Server 2016 SP2 cluster.</p> <p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
networkId | **string**<br><p>ID of the network the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (`health` of all hosts in the cluster is `UNKNOWN`).</li> <li>ALIVE: Cluster is alive and well (`health` of all hosts in the cluster is `ALIVE`).</li> <li>DEAD: Cluster is inoperable (`health` of all hosts in the cluster is `DEAD`).</li> <li>DEGRADED: Cluster is in degraded state (`health` of at least one of the hosts in the cluster is not `ALIVE`).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[backup](backup.md) | Creates a backup for the specified SQL Server cluster.
[create](create.md) | Creates an SQL Server cluster in the specified folder.
[delete](delete.md) | Deletes the specified SQL Server cluster.
[get](get.md) | Returns the specified SQL Server cluster.
[list](list.md) | Retrieves the list of SQL Server clusters that belong to the specified folder.
[listBackups](listBackups.md) | Retrieves the list of available backups for the specified SQL Server cluster.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified SQL Server cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified SQL Server cluster.
[listOperations](listOperations.md) | Retrieves the list of operations for the specified SQL Server cluster.
[move](move.md) | Moves the specified SQL Server cluster to the specified folder.
[restore](restore.md) | Creates a new SQL Server cluster using the specified backup.
[start](start.md) | Starts the specified SQL Server cluster.
[stop](stop.md) | Stops the specified SQL Server cluster.
[update](update.md) | Modifies the specified SQL Server cluster.