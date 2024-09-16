---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Thumbnail/list.md
---

# Video API, REST: Thumbnail.list
List thumbnails for channel.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/thumbnails
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
channelId | <p>ID of the channel.</p> 
pageSize | <p>The maximum number of the results per page to return. Default value: 100.</p> 
pageToken | <p>Page token for getting the next page of the result.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "thumbnails": [
    {
      "id": "string",
      "channelId": "string",
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
thumbnails[] | **object**<br><p>List of thumbnails.</p> 
thumbnails[].<br>id | **string**<br><p>ID of the thumbnail.</p> 
thumbnails[].<br>channelId | **string**<br><p>ID of the channel where the thumbnail was created.</p> 
thumbnails[].<br>createdAt | **string** (date-time)<br><p>Time when thumbnail was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>Token for getting the next page.</p> 