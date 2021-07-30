---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method create
Creates an SQL Server cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
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
    "access": {
      "dataLens": true
    },

    // `configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`
    "sqlserverConfig_2016Sp2Std": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    "sqlserverConfig_2016Sp2Ent": {
      "maxDegreeOfParallelism": "integer",
      "costThresholdForParallelism": "integer",
      "auditLevel": "integer",
      "fillFactorPercent": "integer",
      "optimizeForAdHocWorkloads": true
    },
    // end of the list of possible fields`configSpec`

  },
  "databaseSpecs": [
    {
      "name": "string"
    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true,
  "sqlcollation": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the SQL Server cluster in.</p> <p>To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the SQL Server cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the SQL Server cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the SQL Server cluster as ``key:value`` pairs. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Deployment environment of the SQL Server cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>SQL Server and hosts configuration for the cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of SQL Server used in the cluster.</p> <p>Possible values:</p> <ul> <li>2016sp2</li> </ul> 
configSpec.<br>resources | **object**<br>Resources allocated to SQL Server hosts.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Start time for the daily backup in UTC timezone<br><p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>access | **object**<br>Access policy to DB<br>
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std | **object**<br>Configuration for an SQL Server 2016 SP2 Standard edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`<br><br><p>SQL Server 2016 SP2 Standard edition supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 - do not log login attempts,</li> <li>1 - log only failed login attempts,</li> <li>2 - log only successful login attempts (not recommended),</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Std.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent | **object**<br>Configuration for an SQL Server 2016 SP2 Enterprise edition cluster. <br>`configSpec` includes only one of the fields `sqlserverConfig_2016Sp2Std`, `sqlserverConfig_2016Sp2Ent`<br><br><p>SQL Server 2016 SP2 Enterprise edition supported configuration options are listed here.</p> <p>Detailed description for each set of options is available in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Any options that are not listed here are not supported.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>maxDegreeOfParallelism | **integer** (int64)<br><p>Limits the number of processors to use in parallel plan execution per task.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 1 to 99, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>costThresholdForParallelism | **integer** (int64)<br><p>Specifies the threshold at which SQL Server creates and runs parallel plans for queries.</p> <p>SQL Server creates and runs a parallel plan for a query only when the estimated cost to run a serial plan for the same query is higher than the value of the option.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-cost-threshold-for-parallelism-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 5 to 32767, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>auditLevel | **integer** (int64)<br><p>Describes how to configure login auditing to monitor SQL Server Database Engine login activity. Possible values:</p> <ul> <li>0 - do not log login attempts,</li> <li>1 - log only failed login attempts,</li> <li>2 - log only successful login attempts (not recommended),</li> <li>3 - log all login attempts (not recommended).</li> </ul> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/ssms/configure-login-auditing-sql-server-management-studio?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 3, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>fillFactorPercent | **integer** (int64)<br><p>Manages the fill factor server configuration option. When an index is created or rebuilt the fill factor determines the percentage of space on each index leaf-level page to be filled with data, reserving the rest as free space for future growth.</p> <p>Values 0 and 100 mean full page usage (no space reserved).</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-fill-factor-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
configSpec.<br>sqlserverConfig_2016Sp2Ent.<br>optimizeForAdHocWorkloads | **boolean** (boolean)<br><p>Determines whether plans should be cached only after second execution. Allows to avoid SQL cache bloat because of single-use plans.</p> <p>See in-depth description in <a href="https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/optimize-for-ad-hoc-workloads-server-configuration-option?view=sql-server-2016">SQL Server documentation</a>.</p> 
databaseSpecs[] | **object**<br><p>One or more configurations of databases to be created in the SQL Server cluster.</p> 
databaseSpecs[].<br>name | **string**<br><p>Required. Name of the database.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
userSpecs[] | **object**<br><p>One or more configurations of database users to be created in the SQL Server cluster.</p> 
userSpecs[].<br>name | **string**<br><p>Required. Name of the SQL Server user.</p> <p>The maximum string length in characters is 32. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
userSpecs[].<br>password | **string**<br><p>Required. Password of the SQL Server user.</p> <p>The string length in characters must be 8-128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database the permission grants access to.</p> 
userSpecs[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Members of this fixed database role can perform all configuration and maintenance activities on the database, and can also drop the database in SQL Server.</li> <li>DB_SECURITYADMIN: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li> <li>DB_ACCESSADMIN: Members of this fixed database role can add or remove access to the database for Windows logins, Windows groups, and SQL Server logins.</li> <li>DB_BACKUPOPERATOR: Members of this fixed database role can back up the database.</li> <li>DB_DDLADMIN: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li> <li>DB_DATAWRITER: Members of this fixed database role can add, delete, or change data in all user tables.</li> <li>DB_DATAREADER: Members of this fixed database role can read all data from all user tables.</li> <li>DB_DENYDATAWRITER: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> <li>DB_DENYDATAREADER: Members of this fixed database role cannot read any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> </ul> 
hostSpecs[] | **object**<br><p>One or more configurations of hosts to be created in the SQL Server cluster.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> <p>To get the list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-sqlserver/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with ``assignPublicIp`` set as needed.</p> <p>Possible values:</p> <ul> <li>false - don't assign a public IP to the host.</li> <li>true - the host should have a public IP address.</li> </ul> 
networkId | **string**<br><p>ID of the network to create the SQL Server cluster in.</p> <p>The maximum string length in characters is 50.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
sqlcollation | **string**<br><p>name of SQL Collation that cluster will be created with</p> <p>The maximum string length in characters is 100.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 