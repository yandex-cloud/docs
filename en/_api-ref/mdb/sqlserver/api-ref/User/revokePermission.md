---
editable: false
---

# Method revokePermission
Revokes a permission from the specified SQLServer user.
 

 
## HTTP request {#https-request}
```
POST https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters/{clusterId}/users/{userName}:revokePermission
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the SQLServer cluster the user belongs to. To get the cluster ID, use a [list](/docs/managed-sqlserver/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Required. Name of the user to revoke a permission from. To get the name of the user, use a [list](/docs/managed-sqlserver/api-ref/User/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Body parameters {#body_params}
 
```json 
{
  "permission": {
    "databaseName": "string",
    "roles": [
      "string"
    ]
  }
}
```

 
Field | Description
--- | ---
permission | **object**<br><p>Required. Permission that should be revoked from the specified user.</p> 
permission.<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permission.<br>roles[] | **string**<br><ul> <li>DB_OWNER: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li> <li>DB_SECURITYADMIN: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li> <li>DB_ACCESSADMIN: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li> <li>DB_BACKUPOPERATOR: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li> <li>DB_DDLADMIN: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li> <li>DB_DATAWRITER: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li> <li>DB_DATAREADER: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li> <li>DB_DENYDATAWRITER: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li> <li>DB_DENYDATAREADER: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li> </ul> 
 
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