---
editable: false
---

# Method list
Retrieves a list of SQLServer users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1alpha/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the cluster to list SQLServer users in. To get the cluster ID, use a [list](/docs/managed-sqlserver/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-sqlserver/api-ref/User/list#query_params), the service returns a [nextPageToken](/docs/managed-sqlserver/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-sqlserver/api-ref/User/list#query_params) to the [nextPageToken](/docs/managed-sqlserver/api-ref/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>A sqlserver user. For more information, see the <a href="/docs/managed-sqlserver/concepts">documentation</a>.</p> 
users[].<br>name | **string**<br><p>Name of the sqlserver user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the sqlserver cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li> <li>DB_SECURITYADMIN: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li> <li>DB_ACCESSADMIN: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li> <li>DB_BACKUPOPERATOR: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li> <li>DB_DDLADMIN: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li> <li>DB_DATAWRITER: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li> <li>DB_DATAREADER: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li> <li>DB_DENYDATAWRITER: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li> <li>DB_DENYDATAREADER: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-sqlserver/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-sqlserver/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-sqlserver/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 