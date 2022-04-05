---
editable: false
sourcePath: en/_api-ref/iam/api-ref/ApiKey/list.md
---

# Method list
Retrieves the list of API keys for the specified service account.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
serviceAccountId | ID of the service account to list API keys for. To get the service account ID, use a [list](/docs/iam/api-ref/ServiceAccount/list) request. If not specified, it defaults to the subject that made the request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/iam/api-ref/ApiKey/list#query_params), the service returns a [nextPageToken](/docs/iam/api-ref/ApiKey/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/iam/api-ref/ApiKey/list#query_params) to the [nextPageToken](/docs/iam/api-ref/ApiKey/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
apiKeys[] | **object**<br><p>An ApiKey resource. For more information, see <a href="/docs/iam/concepts/authorization/api-key">Api-Key</a>.</p> 
apiKeys[].<br>id | **string**<br><p>ID of the API Key.</p> 
apiKeys[].<br>serviceAccountId | **string**<br><p>ID of the service account that the API key belongs to.</p> 
apiKeys[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
apiKeys[].<br>description | **string**<br><p>Description of the API key. 0-256 characters long.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/ApiKey/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/ApiKey/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/ApiKey/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/ApiKey/list#responses">nextPageToken</a> to continue paging through the results.</p> 