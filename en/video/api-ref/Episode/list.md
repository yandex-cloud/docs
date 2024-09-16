---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/list.md
---

# Video API, REST: Episode.list
List episodes for stream or line.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/episodes
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
streamId | <p>ID of the stream.</p> 
lineId | <p>ID of the line.</p> 
pageSize | <p>The maximum number of the results per page to return. Default value: 100.</p> 
pageToken | <p>Page token for getting the next page of the result.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields.</p> 
filter | <p>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: ``'`` or ``"`` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title"] Both snake_case and camelCase are supported for fields.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "episodes": [
    {
      "id": "string",
      "streamId": "string",
      "lineId": "string",
      "title": "string",
      "description": "string",
      "thumbnailId": "string",
      "startTime": "string",
      "finishTime": "string",
      "dvrSeconds": "string",
      "visibilityStatus": "string",
      "createdAt": "string",
      "updatedAt": "string",

      // `episodes[]` includes only one of the fields `publicAccess`, `authSystemAccess`
      "publicAccess": {},
      "authSystemAccess": {},
      // end of the list of possible fields`episodes[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
episodes[] | **object**<br><p>List of episodes for specific parent_id.</p> 
episodes[].<br>id | **string**<br><p>ID of the episode.</p> 
episodes[].<br>streamId | **string**<br><p>ID of the stream. Optional, empty if the episode is linked to the line</p> 
episodes[].<br>lineId | **string**<br><p>ID of the line. Optional, empty if the episode is linked to the stream</p> 
episodes[].<br>title | **string**<br><p>Channel title.</p> 
episodes[].<br>description | **string**<br><p>Channel description.</p> 
episodes[].<br>thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
episodes[].<br>startTime | **string** (date-time)<br><p>Episode start time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
episodes[].<br>finishTime | **string** (date-time)<br><p>Episode finish time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
episodes[].<br>dvrSeconds | **string** (int64)<br><p>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available.</p> <p>possible values:</p> <ul> <li>``0``: infinite dvr size, the full length of the stream allowed to display</li> <li>``>0``: size of dvr window in seconds, the minimum value is 30s</li> </ul> 
episodes[].<br>visibilityStatus | **string**
episodes[].<br>createdAt | **string** (date-time)<br><p>Time when episode was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
episodes[].<br>updatedAt | **string** (date-time)<br><p>Time of last episode update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
episodes[].<br>publicAccess | **object**<br>Episode is available to everyone. <br>`episodes[]` includes only one of the fields `publicAccess`, `authSystemAccess`<br>
episodes[].<br>authSystemAccess | **object**<br>Checking access rights using the authorization system. <br>`episodes[]` includes only one of the fields `publicAccess`, `authSystemAccess`<br>
nextPageToken | **string**<br><p>Token for getting the next page.</p> 