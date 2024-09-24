---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Event/put.md
---

# EventRouter Service, REST: Event.put
Puts event to bus.
 

 
## HTTP request {#https-request}
```
POST https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/events/{busId}:put
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
busId | <p>Required. ID of the bus to put event.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "body": "string"
}
```

 
Field | Description
--- | ---
body | **string**<br><p>Required. Event body.</p> <p>The maximum string length in characters is 262144.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 