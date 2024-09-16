---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Stream/list.md
---

# Video API, REST: Stream.list
List streams for channel.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/streams
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
channelId | <p>ID of the channel.</p> 
pageSize | <p>The maximum number of the results per page to return. Default value: 100.</p> 
pageToken | <p>Page token for getting the next page of the result.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "title", "startTime", "finishTime", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields.</p> 
filter | <p>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: ``'`` or ``"`` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title", "lineId", "status"] Both snake_case and camelCase are supported for fields.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "streams": [
    {
      "id": "string",
      "channelId": "string",
      "lineId": "string",
      "title": "string",
      "description": "string",
      "thumbnailId": "string",
      "status": "string",
      "startTime": "string",
      "publishTime": "string",
      "finishTime": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "labels": "object",

      // `streams[]` includes only one of the fields `onDemand`, `schedule`
      "onDemand": {},
      "schedule": {
        "startTime": "string",
        "finishTime": "string"
      },
      // end of the list of possible fields`streams[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
streams[] | **object**<br><p>List of streams for channel.</p> 
streams[].<br>id | **string**<br><p>ID of the stream.</p> 
streams[].<br>channelId | **string**<br><p>ID of the channel where the stream was created.</p> 
streams[].<br>lineId | **string**<br><p>ID of the line to which stream is linked.</p> 
streams[].<br>title | **string**<br><p>Stream title.</p> 
streams[].<br>description | **string**<br><p>Stream description.</p> 
streams[].<br>thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
streams[].<br>status | **string**<br>Stream status.<br><ul> <li>OFFLINE: Stream offline.</li> <li>PREPARING: Preparing the infrastructure for receiving video signal.</li> <li>READY: Everything is ready to launch stream.</li> <li>ONAIR: Stream onair.</li> <li>FINISHED: Stream finished.</li> </ul> 
streams[].<br>startTime | **string** (date-time)<br><p>Stream start time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streams[].<br>publishTime | **string** (date-time)<br><p>Stream publish time. Time when stream switched to ONAIR status.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streams[].<br>finishTime | **string** (date-time)<br><p>Stream finish time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streams[].<br>createdAt | **string** (date-time)<br><p>Time when stream was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streams[].<br>updatedAt | **string** (date-time)<br><p>Time of last stream update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streams[].<br>labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
streams[].<br>onDemand | **object**<br>On demand stream. It starts immediately when a signal appears. <br>`streams[]` includes only one of the fields `onDemand`, `schedule`<br>
streams[].<br>schedule | **object**<br>Schedule stream. Determines when to start receiving the signal or finish time. <br>`streams[]` includes only one of the fields `onDemand`, `schedule`<br>
streams[].<br>schedule.<br>startTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streams[].<br>schedule.<br>finishTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
nextPageToken | **string**<br><p>Token for getting the next page.</p> 