---
editable: false
sourcePath: en/_api-ref/lockbox/api-ref/Secret/listVersions.md
---

# Method listVersions
Retrieves the list of versions of the specified secret.
 

 
## HTTP request {#https-request}
```
GET https://lockbox.{{ api-host }}/lockbox/v1/secrets/{secretId}/versions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
secretId | <p>Required. ID of the secret to list versions for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a [ListVersionsRequest.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the [ListVersionsRequest.next_page_token] returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
    {
      "id": "string",
      "secretId": "string",
      "createdAt": "string",
      "destroyAt": "string",
      "description": "string",
      "status": "string",
      "payloadEntryKeys": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
versions[] | **object**<br><p>List of versions for the specified secret.</p> 
versions[].<br>id | **string**<br><p>ID of the version.</p> 
versions[].<br>secretId | **string**<br><p>ID of the secret that the version belongs to.</p> 
versions[].<br>createdAt | **string** (date-time)<br><p>Time when the version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
versions[].<br>destroyAt | **string** (date-time)<br><p>Time when the version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
versions[].<br>description | **string**<br><p>Description of the version.</p> 
versions[].<br>status | **string**<br><p>Status of the secret.</p> <ul> <li>ACTIVE: The version is active and the secret payload can be accessed.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
versions[].<br>payloadEntryKeys[] | **string**<br><p>Keys of the entries contained in the version payload.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/lockbox/api-ref/Secret/listVersions#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/lockbox/api-ref/Secret/listVersions#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 