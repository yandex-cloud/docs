---
editable: false
---

# Identity and Access Management API, REST: ServiceAccount.list
Retrieves the list of ServiceAccount resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/serviceAccounts
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list service accounts in. To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/iam/api-ref/ServiceAccount#representation">ServiceAccount.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
serviceAccounts[] | **object**<br><p>List of ServiceAccount resources.</p> 
serviceAccounts[].<br>id | **string**<br><p>ID of the service account.</p> 
serviceAccounts[].<br>folderId | **string**<br><p>ID of the folder that the service account belongs to.</p> 
serviceAccounts[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
serviceAccounts[].<br>name | **string**<br><p>Name of the service account. The name is unique within the cloud. 3-63 characters long.</p> 
serviceAccounts[].<br>description | **string**<br><p>Description of the service account. 0-256 characters long.</p> 
serviceAccounts[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/ServiceAccount/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/ServiceAccount/list#responses">nextPageToken</a> to continue paging through the results.</p> 