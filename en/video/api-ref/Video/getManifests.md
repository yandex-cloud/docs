---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/getManifests.md
---

# Video API, REST: Video.getManifests
Returns manifest urls.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}:getManifests
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
videoId | <p>ID of the video.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "manifests": [
    {
      "url": "string",
      "type": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
manifests[] | **object**
manifests[].<br>url | **string**
manifests[].<br>type | **string**