---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/Project/getCellOutputs.md
---

# DataSphere API v2, REST: Project.getCellOutputs
Returns outputs of the specified cell.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:cellOutputs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the project to return cell outputs for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
cellId | <p>Required. ID of the cell to return outputs for.</p> <p>The maximum string length in characters is 200.</p> 
checkpointId | <p>ID of the checkpoint to return cell outputs for.</p> 
startAt | <p>Timestamp from which to return outputs.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
 
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