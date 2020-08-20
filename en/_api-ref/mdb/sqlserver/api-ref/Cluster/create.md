---
editable: false
---

# Method create
Creates a sqlserver cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters
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
  "networkId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the sqlserver cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the sqlserver cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
description | **string**<br><p>Description of the sqlserver cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the sqlserver cluster as <code>key:value</code> pairs. Maximum 64 per resource. For example, &quot;project&quot;: &quot;mvp&quot; or &quot;source&quot;: &quot;dictionary&quot;.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Deployment environment of the sqlserver cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Configuration and resources for hosts that should be created for the sqlserver cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of sqlserver used in the cluster. Possible values:</p> <ul> <li>2016sp2</li> </ul> 
configSpec.<br>resources | **object**<br>Resources allocated to sqlserver hosts.<br>
configSpec.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
configSpec.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
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
databaseSpecs[] | **object**<br><p>Descriptions of databases to be created in the sqlserver cluster.</p> 
databaseSpecs[].<br>name | **string**<br><p>Required. Name of the sqlserver database.</p> <p>The maximum string length in characters is 63. Value must match the regular expression <code>[a-zA-Z0-9_-]*</code>.</p> 
userSpecs[] | **object**<br><p>Descriptions of database logins to be created in the sqlserver cluster.</p> 
userSpecs[].<br>name | **string**<br><p>Required. Name of the sqlserver user.</p> <p>The maximum string length in characters is 32. Value must match the regular expression <code>[a-zA-Z0-9_]*</code>.</p> 
userSpecs[].<br>password | **string**<br><p>Required. Password of the sqlserver user.</p> <p>The string length in characters must be 8-128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Set of permissions to grant to the user.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
userSpecs[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li> <li>DB_SECURITYADMIN: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li> <li>DB_ACCESSADMIN: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li> <li>DB_BACKUPOPERATOR: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li> <li>DB_DDLADMIN: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li> <li>DB_DATAWRITER: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li> <li>DB_DATAREADER: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li> <li>DB_DENYDATAWRITER: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li> <li>DB_DENYDATAREADER: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li> </ul> 
hostSpecs[] | **object**<br><p>Individual configurations for hosts that should be created for the sqlserver cluster.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides. To get a list of available zones, use the [yandex.cloud.compute.v1alpha.ZoneService.List] request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet that the host should belong to. This subnet should be a part of the network that the cluster belongs to. The ID of the network is set in the field <a href="/docs/managed-sqlserver/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether the host should get a public IP address on creation.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign a public IP to a host without one, recreate the host with <code>assignPublicIp</code> set as needed.</p> <p>Possible values:</p> <ul> <li>false — don't assign a public IP to the host.</li> <li>true — the host should have a public IP address.</li> </ul> 
networkId | **string**<br><p>ID of the network to create the cluster in.</p> <p>The maximum string length in characters is 50.</p> 
 
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