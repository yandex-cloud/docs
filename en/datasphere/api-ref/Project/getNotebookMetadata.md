---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/Project/getNotebookMetadata.md
---

# Method getNotebookMetadata
Returns metadata of the specified notebook.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v1/projects/{projectId}:notebookMetadata
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the project, for which to return notebook metadata.</p> <p>The maximum string length in characters is 200.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
notebookPath | <p>Required. Path of the notebook to get metadata.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "notebookId": "string",
  "createdAt": "string",
  "modifiedAt": "string",
  "contentLength": "string",
  "cellIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
notebookId | **string**<br><p>ID of the specified notebook.</p> 
createdAt | **string** (date-time)<br><p>The time the notebook was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
modifiedAt | **string** (date-time)<br><p>The time the notebook was modified last time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
contentLength | **string** (int64)<br><p>Content length of the specified notebook.</p> 
cellIds[] | **string**<br><p>Cell ids of the specified notebook.</p> 