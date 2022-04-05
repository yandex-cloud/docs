---
editable: false
sourcePath: en/_api-ref/iam/api-ref/ServiceAccount/list.md
---

# Method list
Retrieves the list of ServiceAccount resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list service accounts in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/iam/api-ref/ServiceAccount/list#query_params), the service returns a [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/iam/api-ref/ServiceAccount/list#query_params) to the [nextPageToken](/docs/iam/api-ref/ServiceAccount/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [ServiceAccount.name](/docs/iam/api-ref/ServiceAccount#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "serviceAccounts": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
serviceAccounts[] | **object**<br><p>A ServiceAccount resource. For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>.</p> 
serviceAccounts[].<br>id | **string**<br><p>ID of the service account.</p> 
serviceAccounts[].<br>folderId | **string**<br><p>ID of the folder that the service account belongs to.</p> 
serviceAccounts[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
serviceAccounts[].<br>name | **string**<br><p>Name of the service account. The name is unique within the cloud. 3-63 characters long.</p> 
serviceAccounts[].<br>description | **string**<br><p>Description of the service account. 0-256 characters long.</p> 
serviceAccounts[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> to continue paging through the results.</p> 