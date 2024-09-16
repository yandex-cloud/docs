---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/batchGenerateDownloadURLs.md
---

# Video API, REST: Thumbnail.batchGenerateDownloadURLs
Generate urls for download images.
 

 
## HTTP request {#https-request}
```
POST https://video.{{ api-host }}/video/v1/thumbnails:batchGenerateDownloadURLs
```
 
## Body parameters {#body_params}
 
```json 
{
  "channelId": "string",
  "thumbnailIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
channelId | **string**<br><p>ID of the channel.</p> 
thumbnailIds[] | **string**<br><p>List of thumbnails IDs.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "downloadUrls": [
    {
      "thumbnailId": "string",
      "downloadUrl": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
downloadUrls[] | **object**<br><p>List of download urls.</p> 
downloadUrls[].<br>thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
downloadUrls[].<br>downloadUrl | **string**<br><p>Download url.</p> 