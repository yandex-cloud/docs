---
editable: false
---

# Method update
Modifies the specified sqlserver cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the sqlserver cluster to update. To get the sqlserver cluster ID, use a [list](/docs/managed-sqlserver/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
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
  "name": "string"
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the sqlserver cluster should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the sqlserver cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the sqlserver cluster as <code>key:value</code> pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-sqlserver/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-sqlserver/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of sqlserver used in the cluster. Possible values:</p> <ul> <li>2016sp2</li> </ul> 
configSpec.<br>resources | **object**<br>Resources allocated to sqlserver hosts.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Start time for the daily backup in UTC timezone<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>sqlserverConfig_2016Sp2 | **object**<br>Configuration for a sqlserver 5.7 cluster.<br><p>Options and structure of <code>SQLServerConfig2016sp2</code> reflects sqlserver 2016 sp2 configuration file</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>sp_configure option for contolling degree of parallelism. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>costThresholdForParallelism | **integer** (int64)<br><p>sp_configure option for controling how heavy the query should be to be eligible for parallel plan</p> <p>Acceptable values are 1 to 999999, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>sqlcollation | **string**<br><p>setup option SQLCOLLATION - collation used for system databases across the instance. Not easy to change after installation. Determines if instance is case sensitive, accent sensitive etc.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>auditLevel | **integer** (int64)<br><p>Logon auditing option. 0 - no logon audit, 1 - failed logins only, 2 - Successfull logins only (not recommended),  3 - All logins (not recommended). https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-ver15</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>filestreamAccessLevel | **integer** (int64)<br><p>sp_configure option for managing FILESTREAM technology (storing blob data outside of datase). 0 - FILESTREAM is disabled, 1 - Enables FILESTREAM for Transact-SQL access, 2- Enables FILESTREAM for Transact-SQL and Win32 streaming access. https://docs.microsoft.com/en-us/sql/relational-databases/blob/enable-and-configure-filestream?view=sql-server-ver15 https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/filestream-access-level-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>fillFactorPercent | **integer** (int64)<br><p>sp_configure option for managing database pages fullness. 0 or 100 means full page usage (no space reserve), anything in between equals to percent of fullness maintained when index is created or rebuilt to avoid future page splits https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>inDoubtXactResolution | **integer** (int64)<br><p>sp_configure option. Determines how to resolve the in-doubt distributed transactions. 0 means no autmatic resolution, 1 - assume them commited, 2 - assume them uncommitted and roll them back. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/in-doubt-xact-resolution-server-configuration-option?view=sql-server-ver15</p> <p>Acceptable values are 0 to 2, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>sp_configure option. If enabled then plans are cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-ver15</p> 
configSpec.<br>sqlserverConfig_2016Sp2.<br>crossDbOwnershipChaining | **boolean** (boolean)<br><p>sp_configure option enabling cross db ownership chaining - complex and convoluted security option. Having access to stored procedure in one database that refers to an object in another database that you don't have explicit access, you'll be able to execute the procedure without permission related error. https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/cross-db-ownership-chaining-server-configuration-option?view=sql-server-ver15</p> 
name | **string**<br><p>New name for the cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 