---
editable: false
---

# Method list
Retrieves the list of access keys for the specified service account.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
serviceAccountId | <p>ID of the service account to list access keys for. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request. If not specified, it defaults to the subject that made the request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/AccessKey/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/AccessKey/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/AccessKey/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/AccessKey/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "accessKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "string",
      "description": "string",
      "keyId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
accessKeys[] | **object**<br><p>List of access keys.</p> 
accessKeys[].<br>id | **string**<br><p>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key.</p> 
accessKeys[].<br>serviceAccountId | **string**<br><p>ID of the service account that the access key belongs to.</p> 
accessKeys[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
accessKeys[].<br>description | **string**<br><p>Description of the access key. 0-256 characters long.</p> 
accessKeys[].<br>keyId | **string**<br><p>ID of the access key. The key is AWS compatible.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/AccessKey/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/AccessKey/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/AccessKey/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/AccessKey/list#responses">nextPageToken</a> to continue paging through the results.</p> 