---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/getManifests.md
---

# Video API, REST: Episode.getManifests
Returns manifest urls.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getManifests
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
episodeId | <p>ID of the episode.</p> 
 
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