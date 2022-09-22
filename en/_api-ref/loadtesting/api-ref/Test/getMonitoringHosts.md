---
editable: false
---

# Method getMonitoringHosts

 

 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/v2/tests/{testId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
testId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
hosts[] | **string**