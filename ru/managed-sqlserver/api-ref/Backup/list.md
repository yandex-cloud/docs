---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method list
Retrieves the list of SQL Server backups available for the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/backups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list backups in.  To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-sqlserver/api-ref/Backup/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, Set `page_token` to the [nextPageToken](/docs/managed-sqlserver/api-ref/Backup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "sourceClusterId": "string",
      "startedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
backups[] | **object**<br><p>An SQL Server backup resource. For more information, see the <a href="/docs/managed-sqlserver/concepts/backup">Backup</a> section in the documentation.</p> 
backups[].<br>id | **string**<br><p>ID of the backup.</p> 
backups[].<br>folderId | **string**<br><p>ID of the folder that the backup belongs to.</p> 
backups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp (i.e. when the backup operation was completed).</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
backups[].<br>sourceClusterId | **string**<br><p>ID of the SQL Server cluster that the backup was created for.</p> 
backups[].<br>startedAt | **string** (date-time)<br><p>Time when the backup operation was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Backup/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-sqlserver/api-ref/Backup/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 