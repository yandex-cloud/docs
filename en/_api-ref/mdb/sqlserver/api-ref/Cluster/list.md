---
editable: false
---

# Method list
Retrieves the list of SQL Server clusters that belong to the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list SQL Server clusters in.  To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name to filter by. Currently you can only use filtering with the [Cluster.name](/docs/managed-sqlserver/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  Example of a filter: `name NOT IN 'test,beta'`.  The maximum string length in characters is 1000.
 
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
clusters[] | **object**<br><p>An SQL Server cluster. For more information, see the <a href="/docs/managed-sqlserver/concepts">Concepts</a> section of the documentation.</p> 
clusters[].<br>id | **string**<br><p>ID of the SQL Server cluster. This ID is assigned by Managed Service for SQL Server at creation time.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder the SQL Server cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the SQL Server cluster.</p> <p>The name must be unique within the folder, comply with RFC 1035 and be 1-63 characters long.</p> 
clusters[].<br>description | **string**<br><p>Description of the SQL Server cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Custom labels for the SQL Server cluster as `key:value` pairs. Maximum 64 per resource.</p> 
clusters[].<br>environment | **string**<br><p>Deployment environment of the SQL Server cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Description of monitoring systems relevant to the SQL Server cluster.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the SQL Server cluster.</p> 
clusters[].<br>config | **object**<br><p>Configuration of the SQL Server cluster.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Version of the SQL Server.</p> 
clusters[].<br>config.<br>resources | **object**<br>Resources allocated to SQL Server hosts.<br>
clusters[].<br>config.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
clusters[].<br>config.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
clusters[].<br>config.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
clusters[].<br>config.<br>backupWindowStart | **object**<br>Start time for the daily backup in UTC timezone<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2 | **object**<br>Configuration of the SQL Server 2016sp2 instance.<br>
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig | **object**<br><p>Effective settings for an SQL Server 2016 SP2 cluster (a combination of settings defined in `userConfig` and `defaultConfig`).</p> <p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>effectiveConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig | **object**<br><p>User-defined settings for an SQL Server 2016 SP2 cluster.</p> <p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>userConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig | **object**<br><p>Default configuration for an SQL Server 2016 SP2 cluster.</p> <p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>config.<br>sqlserverConfig_2016Sp2.<br>defaultConfig.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
clusters[].<br>networkId | **string**<br><p>ID of the network the cluster belongs to.</p> 
clusters[].<br>health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (`health` of all hosts in the cluster is `UNKNOWN`).</li> <li>ALIVE: Cluster is alive and well (`health` of all hosts in the cluster is `ALIVE`).</li> <li>DEAD: Cluster is inoperable (`health` of all hosts in the cluster is `DEAD`).</li> <li>DEGRADED: Cluster is in degraded state (`health` of at least one of the hosts in the cluster is not `ALIVE`).</li> </ul> 
clusters[].<br>status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/list#query_params">pageSize</a>, use the `next_page_token` as the value for the <a href="/docs/managed-sqlserver/api-ref/Cluster/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results.</p> 