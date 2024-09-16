---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/get.md
---

# Video API, REST: StreamLine.get
Returns the specific stream line.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
streamLineId | <p>ID of the line.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "channelId": "string",
  "title": "string",
  "thumbnailId": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "labels": "object",

  //  includes only one of the fields `manualLine`, `autoLine`
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
  // end of the list of possible fields

  "manualLine": {},
  "autoLine": {
    "status": "string"
  }
}
```
Entity that is responsible for the incoming video signal settings.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the line.</p> 
channelId | **string**<br><p>ID of the channel where the line was created.</p> 
title | **string**<br><p>Line title.</p> 
thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
createdAt | **string** (date-time)<br><p>Time when line was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Time of last line update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
rtmpPush | **object**<br>RTMP push input type. <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
rtmpPush.<br>url | **string**<br><p>RTMP server url.</p> 
srtPush | **object**<br>SRT push input type. <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
srtPush.<br>url | **string**<br><p>SRT server url.</p> 
rtmpPull | **object**<br>RTMP pull input type. <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
rtmpPull.<br>url | **string**<br><p>RTMP url for receiving video signal.</p> 
srtPull | **object**<br>SRT pull input type. <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
srtPull.<br>url | **string**<br><p>SRT url for receiving video signal.</p> 
tcpPull | **object**<br>TCP pull input type. <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
tcpPull.<br>url | **string**<br><p>TCP url for receiving video signal.</p> 
rtspPull | **object**<br>RTSP pull input type. <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
rtspPull.<br>url | **string**<br><p>RTSP url for receiving video signal.</p> 
manualLine | **object**<br>Manual control of stream. <br> includes only one of the fields `manualLine`, `autoLine`<br>
autoLine | **object**<br>Automatic control of stream. <br> includes only one of the fields `manualLine`, `autoLine`<br>
autoLine.<br>status | **string**<br><p>Status of auto line.</p> <p>Auto line status.</p> <ul> <li>AUTO_LINE_STATUS_UNSPECIFIED: Auto line status unspecified. - DEACTIVATED: Auto line deactivated.</li> <li>ACTIVE: Auto line active.</li> </ul> 