---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/getStreamKey.md
---

# Video API, REST: StreamLine.getStreamKey
Returns unique stream key.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}:getStreamKey
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
streamLineId | <p>ID of the line.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "key": "string"
}
```
Push stream key.
 
Field | Description
--- | ---
key | **string**<br><p>Unique stream key.</p> 