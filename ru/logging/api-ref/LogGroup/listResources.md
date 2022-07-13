---
editable: false
sourcePath: en/_api-ref/logging/api-ref/LogGroup/listResources.md
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
logGroupId | <p>Required. ID of the log group to list resources for.</p> <p>To get a log group ID make a <a href="/docs/logging/api-ref/LogGroup/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
type | <p>Resource type to return resources for.</p> <p>If not specified, ``ListResourcesResponse`` will contain information about all resource types.</p> <p>The maximum string length in characters is 256.</p> 
 
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
resources[] | **object**<br><p>List of resources present in log group.</p> 
resources[].<br>type | **string**<br><p>Resource type.</p> <p>Collected from log entries inside log group.</p> 
resources[].<br>ids[] | **string**<br><p>List of resource IDs with the same resource type.</p> 