---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/Project/getCellOutputs.md
---


# Method getCellOutputs
Returns outputs of the specified cell.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.api.cloud.yandex.net/datasphere/v1/projects/{projectId}:cellOutputs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | Required. ID of the project to return cell outputs for.  The maximum string length in characters is 200.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cellId | Required. ID of the cell to return outputs for.  The maximum string length in characters is 200.
checkpointId | ID of the checkpoint to return cell outputs for.
startAt | Timestamp from which to return outputs.  String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "outputs": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
outputs[] | **string**<br><p>List of outputs.</p> 