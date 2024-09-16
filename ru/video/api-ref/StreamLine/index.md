---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/index.md
---

# Video API, REST: StreamLine methods
Stream line management service.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the line.</p> 
channelId | **string**<br><p>ID of the channel where the line was created.</p> 
title | **string**<br><p>Line title.</p> 
thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
createdAt | **string** (date-time)<br><p>Time when line was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Time of last line update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
rtmpPush | **object** <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
rtmpPush.<br>url | **string**<br><p>RTMP server url.</p> 
srtPush | **object** <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
srtPush.<br>url | **string**<br><p>SRT server url.</p> 
rtmpPull | **object** <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
rtmpPull.<br>url | **string**<br><p>RTMP url for receiving video signal.</p> 
srtPull | **object** <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
srtPull.<br>url | **string**<br><p>SRT url for receiving video signal.</p> 
tcpPull | **object** <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
tcpPull.<br>url | **string**<br><p>TCP url for receiving video signal.</p> 
rtspPull | **object** <br> includes only one of the fields `rtmpPush`, `srtPush`, `rtmpPull`, `srtPull`, `tcpPull`, `rtspPull`<br>
rtspPull.<br>url | **string**<br><p>RTSP url for receiving video signal.</p> 
manualLine | **object** <br> includes only one of the fields `manualLine`, `autoLine`<br><br><p>Manual line type.</p> 
autoLine | **object** <br> includes only one of the fields `manualLine`, `autoLine`<br><br><p>Auto line type.</p> 
autoLine.<br>status | **string**<br><p>Status of auto line.</p> <p>Auto line status.</p> <ul> <li>AUTO_LINE_STATUS_UNSPECIFIED: Auto line status unspecified. - DEACTIVATED: Auto line deactivated.</li> <li>ACTIVE: Auto line active.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Create stream line.
[delete](delete.md) | Delete stream line.
[get](get.md) | Returns the specific stream line.
[getStreamKey](getStreamKey.md) | Returns unique stream key.
[list](list.md) | List lines for channel.
[performAction](performAction.md) | Perform an action on the line.
[update](update.md) | Update stream line.
[updateStreamKey](updateStreamKey.md) | Change stream key.