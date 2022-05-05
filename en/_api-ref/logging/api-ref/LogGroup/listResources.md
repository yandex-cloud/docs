---
editable: false
---

# Method listResources
Retrieves the resources (type and IDs) in the specified log group.
 

 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/logGroups/{logGroupId}:listResources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | Required. ID of the log group to list resources for.  To get a log group ID make a [list](/docs/logging/api-ref/LogGroup/list) request.  The maximum string length in characters is 64.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
type | Resource type to return resources for.  If not specified, `ListResourcesResponse` will contain information about all resource types.  The maximum string length in characters is 256.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "resources": [
    {
      "type": "string",
      "ids": [
        "string"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
resources[] | **object**<br><p>Log group resource.</p> 
resources[].<br>type | **string**<br><p>Resource type.</p> <p>Collected from log entries inside log group.</p> 
resources[].<br>ids[] | **string**<br><p>List of resource IDs with the same resource type.</p> 