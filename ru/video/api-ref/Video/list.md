---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/list.md
---

# Video API, REST: Video.list
List videos for channel.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/videos
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
channelId | <p>ID of the channel.</p> 
pageSize | <p>The maximum number of the results per page to return. Default value: 100.</p> 
pageToken | <p>Page token for getting the next page of the result.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields.</p> 
filter | <p>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: ``'`` or ``"`` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title", "status", "visibility_status"] Both snake_case and camelCase are supported for fields.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "videos": [
    {
      "id": "string",
      "channelId": "string",
      "title": "string",
      "description": "string",
      "thumbnailId": "string",
      "status": "string",
      "duration": "string",
      "visibilityStatus": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "labels": "object",
      "tusd": {
        "url": "string"
      },

      // `videos[]` includes only one of the fields `publicAccess`, `authSystemAccess`
      "publicAccess": {},
      "authSystemAccess": {},
      // end of the list of possible fields`videos[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
videos[] | **object**
videos[].<br>id | **string**<br><p>ID of the video.</p> 
videos[].<br>channelId | **string**<br><p>ID of the channel where the video was created.</p> 
videos[].<br>title | **string**<br><p>Video title.</p> 
videos[].<br>description | **string**<br><p>Video description.</p> 
videos[].<br>thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
videos[].<br>status | **string**<br>Video status.<br><ul> <li>WAIT_UPLOADING: Waiting for the whole number of bytes to be loaded.</li> <li>PROCESSING: Video processing.</li> <li>READY: Video is ready, processing is completed.</li> <li>ERROR: An error occurred during video processing.</li> </ul> 
videos[].<br>duration | **string**<br><p>Video duration. Optional, may be empty until the transcoding result is ready.</p> 
videos[].<br>visibilityStatus | **string**<br>Video visibility status.<br><ul> <li>PUBLISHED: Video is published and available for viewing.</li> <li>UNPUBLISHED: Video is unpublished, only admin can watch.</li> </ul> 
videos[].<br>createdAt | **string** (date-time)<br><p>Time when video was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
videos[].<br>updatedAt | **string** (date-time)<br><p>Time of last video update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
videos[].<br>labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
videos[].<br>tusd | **object**<br>Upload video using the tus protocol.
videos[].<br>tusd.<br>url | **string**<br><p>URL for uploading video via the tus protocol.</p> 
videos[].<br>publicAccess | **object**<br>Video is available to everyone. <br>`videos[]` includes only one of the fields `publicAccess`, `authSystemAccess`<br>
videos[].<br>authSystemAccess | **object**<br>Checking access rights using the authorization system. <br>`videos[]` includes only one of the fields `publicAccess`, `authSystemAccess`<br>
nextPageToken | **string**<br><p>Token for getting the next page.</p> 