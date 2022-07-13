---
editable: false
---

# Method listOperations
Lists operations for the specified group.
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups/{groupId}/operations
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
groupId | <p>Required. ID of the Group resource to list operations for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/organization/api-ref/Group/listOperations#query_params">pageSize</a>, the service returns a <a href="/docs/organization/api-ref/Group/listOperations#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. Set <a href="/docs/organization/api-ref/Group/listOperations#query_params">pageToken</a> to the <a href="/docs/organization/api-ref/Group/listOperations#responses">nextPageToken</a> returned by a previous list request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "operations": [
    {
      "id": "string",
      "description": "string",
      "createdAt": "string",
      "createdBy": "string",
      "modifiedAt": "string",
      "done": true,
      "metadata": "object",

      // `operations[]` includes only one of the fields `error`, `response`
      "error": {
        "code": "integer",
        "message": "string",
        "details": [
          "object"
        ]
      },
      "response": "object",
      // end of the list of possible fields`operations[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
operations[] | **object**<br><p>List of operations for the specified group.</p> 
operations[].<br>id | **string**<br><p>ID of the operation.</p> 
operations[].<br>description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
operations[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
operations[].<br>createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
operations[].<br>modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
operations[].<br>done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
operations[].<br>metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
operations[].<br>error | **object**<br>The error result of the operation in case of failure or cancellation. <br>`operations[]` includes only one of the fields `error`, `response`<br>
operations[].<br>error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
operations[].<br>error.<br>message | **string**<br><p>An error message.</p> 
operations[].<br>error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
operations[].<br>response | **object** <br>`operations[]` includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/organization/api-ref/Group/listOperations#query_params">pageSize</a>, use the <a href="/docs/organization/api-ref/Group/listOperations#responses">nextPageToken</a> as the value for the <a href="/docs/organization/api-ref/Group/listOperations#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/organization/api-ref/Group/listOperations#responses">nextPageToken</a> to continue paging through the results.</p> 