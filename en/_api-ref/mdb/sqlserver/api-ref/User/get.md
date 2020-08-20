---
editable: false
---

# Method get
Returns the specified SQLServer user.
 
To get the list of available SQLServer users, make a [list](/docs/managed-sqlserver/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the SQLServer cluster.  The maximum string length in characters is 50.
userName | Required. Required.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ]
}
```
A sqlserver user. For more information, see
the [documentation](/docs/managed-sqlserver/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the sqlserver user.</p> 
clusterId | **string**<br><p>ID of the sqlserver cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li> <li>DB_SECURITYADMIN: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li> <li>DB_ACCESSADMIN: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li> <li>DB_BACKUPOPERATOR: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li> <li>DB_DDLADMIN: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li> <li>DB_DATAWRITER: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li> <li>DB_DATAREADER: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li> <li>DB_DENYDATAWRITER: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li> <li>DB_DENYDATAREADER: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li> </ul> 