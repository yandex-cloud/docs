---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/generateUploadURL.md
---

# Video API, REST: Thumbnail.generateUploadURL
Generate url for upload image.
 

 
## HTTP request {#https-request}
```
POST https://video.{{ api-host }}/video/v1/thumbnails/{thumbnailId}:generateUploadURL
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
thumbnailId | <p>ID of the thumbnail.</p> 
 
## Body parameters {#body_params}
 
Empty
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "uploadUrl": "string"
}
```

 
Field | Description
--- | ---
uploadUrl | **string**<br><p>Upload url.</p> 