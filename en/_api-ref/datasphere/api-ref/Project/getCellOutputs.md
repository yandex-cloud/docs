---
editable: false
---

# Method getCellOutputs
Returns outputs of the specified cell.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v1/projects/{projectId}:cellOutputs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the project to return cell outputs for.</p> <p>The maximum string length in characters is 200.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cellId | <p>Required. ID of the cell to return outputs for.</p> <p>The maximum string length in characters is 200.</p> 
checkpointId | <p>ID of the checkpoint to return cell outputs for.</p> 
startAt | <p>Timestamp from which to return outputs.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
 
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