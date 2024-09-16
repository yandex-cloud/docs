---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/index.md
---

# Video API, REST: Thumbnail methods
Thumbnail management service.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "channelId": "string",
  "createdAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the thumbnail.</p> 
channelId | **string**<br><p>ID of the channel where the thumbnail was created.</p> 
createdAt | **string** (date-time)<br><p>Time when thumbnail was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 

## Methods {#methods}
Method | Description
--- | ---
[batchGenerateDownloadURLs](batchGenerateDownloadURLs.md) | Generate urls for download images.
[create](create.md) | Create thumbnail.
[generateUploadURL](generateUploadURL.md) | Generate url for upload image.
[list](list.md) | List thumbnails for channel.