---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method get
Returns the specified PostgreSQL Database resource.
 
To get the list of available PostgreSQL Database resources, make a [list](/docs/managed-postgresql/api-ref/Database/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the PostgreSQL cluster that the database belongs to. To get the cluster ID use a [list](/docs/managed-postgresql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
databaseName | Required. Name of the PostgreSQL Database resource to return. To get the name of the database use a [list](/docs/managed-postgresql/api-ref/Database/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "owner": "string",
  "lcCollate": "string",
  "lcCtype": "string",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }
  ]
}
```
A PostgreSQL Database resource. For more information, see 
the [Developer's Guide](/docs/managed-postgresql/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the PostgreSQL cluster that the database belongs to.</p> 
owner | **string**<br><p>Name of the user assigned as the owner of the database.</p> 
lcCollate | **string**<br><p>POSIX locale for string sorting order. Can only be set at creation time.</p> 
lcCtype | **string**<br><p>POSIX locale for character classification. Can only be set at creation time.</p> 
extensions[] | **object**<br><p>PostgreSQL extensions enabled for the database.</p> 
extensions[].<br>name | **string**<br><p>Name of the extension, e.g. ``pg_trgm`` or ``pg_btree``. Extensions supported by Managed Service for PostgreSQL are <a href="/docs/managed-postgresql/operations/cluster-extensions">listed in the Developer's Guide</a>.</p> 
extensions[].<br>version | **string**<br><p>Version of the extension.</p> 