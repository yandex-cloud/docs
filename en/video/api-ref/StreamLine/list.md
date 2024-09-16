---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/list.md
---

# Video API, REST: StreamLine.list
List lines for channel.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/streamLines
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
channelId | <p>ID of the channel.</p> 
pageSize | <p>The maximum number of the results per page to return. Default value: 100.</p> 
pageToken | <p>Page token for getting the next page of the result.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "title", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields.</p> 
filter | <p>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: ``'`` or ``"`` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title"] Both snake_case and camelCase are supported for fields.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "streamLines": [
    {
      "id": "string",
      "channelId": "string",
      "title": "string",
      "thumbnailId": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "labels": "object",

      // `streamLines[]` includes only one of the fields `manualLine`, `autoLine`
      "rtmpPush": {
        "url": "string"
      },
      "srtPush": {
        "url": "string"
      },
      "rtmpPull": {
        "url": "string"
      },
      "srtPull": {
        "url": "string"
      },
      "tcpPull": {
        "url": "string"
      },
      "rtspPull": {
        "url": "string"
      },
      // end of the list of possible fields`streamLines[]`

      "manualLine": {},
      "autoLine": {
        "status": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
streamLines[] | **object**<br><p>List of lines for channel.</p> 
streamLines[].<br>id | **string**<br><p>ID of the line.</p> 
streamLines[].<br>channelId | **string**<br><p>ID of the channel where the line was created.</p> 
streamLines[].<br>title | **string**<br><p>Line title.</p> 
streamLines[].<br>thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
streamLines[].<br>createdAt | **string** (date-time)<br><p>Time when line was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streamLines[].<br>updatedAt | **string** (date-time)<br><p>Time of last line update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
streamLines[].<br>labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
streamLines[].<br>rtmpPush | **object**<br>RTMP push input type. <br>`streamLines[]` includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
streamLines[].<br>rtmpPush.<br>url | **string**<br><p>RTMP server url.</p> 
streamLines[].<br>srtPush | **object**<br>SRT push input type. <br>`streamLines[]` includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
streamLines[].<br>srtPush.<br>url | **string**<br><p>SRT server url.</p> 
streamLines[].<br>rtmpPull | **object**<br>RTMP pull input type. <br>`streamLines[]` includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
streamLines[].<br>rtmpPull.<br>url | **string**<br><p>RTMP url for receiving video signal.</p> 
streamLines[].<br>srtPull | **object**<br>SRT pull input type. <br>`streamLines[]` includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
streamLines[].<br>srtPull.<br>url | **string**<br><p>SRT url for receiving video signal.</p> 
streamLines[].<br>tcpPull | **object**<br>TCP pull input type. <br>`streamLines[]` includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
streamLines[].<br>tcpPull.<br>url | **string**<br><p>TCP url for receiving video signal.</p> 
streamLines[].<br>rtspPull | **object**<br>RTSP pull input type. <br>`streamLines[]` includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
streamLines[].<br>rtspPull.<br>url | **string**<br><p>RTSP url for receiving video signal.</p> 
streamLines[].<br>manualLine | **object**<br>Manual control of stream. <br>`streamLines[]` includes only one of the fields `manualLine`, `autoLine`<br>
streamLines[].<br>autoLine | **object**<br>Automatic control of stream. <br>`streamLines[]` includes only one of the fields `manualLine`, `autoLine`<br>
streamLines[].<br>autoLine.<br>status | **string**<br><p>Status of auto line.</p> <p>Auto line status.</p> <ul> <li>AUTO_LINE_STATUS_UNSPECIFIED: Auto line status unspecified. - DEACTIVATED: Auto line deactivated.</li> <li>ACTIVE: Auto line active.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page.</p> 