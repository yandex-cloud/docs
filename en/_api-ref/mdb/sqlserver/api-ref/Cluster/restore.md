---
editable: false
---

# Method restore
Creates a new SQL Server cluster using the specified backup.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters:restore
```
 
## Body parameters {#body_params}
 
```json 
{
  "backupId": "string",
  "time": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
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
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "networkId": "string",
  "folderId": "string"
}
```

 
Field | Description
--- | ---
backupId | **string**<br><p>Required. ID of the backup to create a new cluster from.</p> <p>To get the backup ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/listBackups">listBackups</a> request.</p> 
time | **string** (date-time)<br><p>Required. Timestamp of the moment to which the SQL Server cluster should be restored.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Required. Name of the new SQL Server cluster to be created from the backup. The name must be unique within the folder.</p> <p>Value must match the regular expression `` [a-zA-Z0-9_-]* ``.</p> 
description | **string**<br><p>Description of the new SQL Server cluster to be created from the backup.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the new SQL Server cluster to be created from the backup as `key:value` pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-_0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-_0-9a-z]* ``.</p> 
environment | **string**<br><p>Deployment environment of the new SQL Server cluster to be created from the backup.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Configuration for the new SQL Server cluster to be created from the backup.</p> 
configSpec.<br>version | **string**<br><p>Version of SQL Server used in the cluster.</p> <p>Possible values:</p> <ul> <li>2016sp2</li> </ul> 
configSpec.<br>resources | **object**<br>Resources allocated to SQL Server hosts.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive,</li> <li>local-ssd — local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Start time for the daily backup in UTC timezone<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>sqlserverConfig_2016Sp2 | **object**<br>Configuration for an SQL Server 2016 SP2 cluster.<br><p>SQL Server 2016 SP2 supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>sqlcollation | **string**<br><p>Collation used for databases across the instance. Determines if instance is case sensitive, accent sensitive etc.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/relational-databases/collations/set-or-change-the-server-collation?view=sql-server-2016">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 — do not log login attempts,</li> <li>1 — log only failed login attempts,</li> <li>2 — log only successful login attempts (not recommended),</li> <li>3 — log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>filestreamAccessLevel | **integer** (int64)<br><p>Determines the `FILESTREAM` access level for the SQL Server instance. `FILESTREAM` technology enables SQL Server-based applications to store BLOB data, such as documents and images, on the file system outside of a database. Possible values:</p> <ul> <li>0 — disables `FILESTREAM`,</li> <li>1 — enables `FILESTREAM` for Transact-SQL access,</li> <li>2 — enables `FILESTREAM` for Transact-SQL and Win32 streaming access.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>inDoubtXactResolution | **integer** (int64)<br><p>Determines the default outcome of distributed transactions that the Microsoft Distributed Transaction Coordinator (MS DTC) is unable to resolve (in-doubt distributed transactions). Possible values:</p> <ul> <li>0 — no automatic resolution, recovery fails if MS DTC cannot resolve any in-doubt transactions,</li> <li>1 — assume in-doubt transactions committed,</li> <li>2 — assume in-doubt transactions uncommitted and roll them back.</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>Enables cross-database ownership chaining. Example: having explicit access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
hostSpecs[] | **object**<br><p>Configurations for SQL Server hosts that should be added to the cluster being created from the backup.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> <p>To get the list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-sqlserver/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.</p> <p>Possible values:</p> <ul> <li>false — don't assign a public IP to the host.</li> <li>true — the host should have a public IP address.</li> </ul> 
networkId | **string**<br><p>ID of the network to create the SQL Server cluster in.</p> <p>The maximum string length in characters is 50.</p> 
folderId | **string**<br><p>ID of the folder to create the SQL Server cluster in.</p> <p>To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 