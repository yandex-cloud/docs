---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/index.md
---

# Video API, REST: Episode methods
Episode management service.
## JSON Representation {#representation}
```json 
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

  //  includes only one of the fields `publicAccess`, `authSystemAccess`
  "publicAccess": {},
  "authSystemAccess": {},
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the episode.</p> 
streamId | **string**<br><p>ID of the stream. Optional, empty if the episode is linked to the line</p> 
lineId | **string**<br><p>ID of the line. Optional, empty if the episode is linked to the stream</p> 
title | **string**<br><p>Channel title.</p> 
description | **string**<br><p>Channel description.</p> 
thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
startTime | **string** (date-time)<br><p>Episode start time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
finishTime | **string** (date-time)<br><p>Episode finish time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
dvrSeconds | **string** (int64)<br><p>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available.</p> <p>possible values:</p> <ul> <li>``0``: infinite dvr size, the full length of the stream allowed to display</li> <li>``>0``: size of dvr window in seconds, the minimum value is 30s</li> </ul> 
visibilityStatus | **string**
createdAt | **string** (date-time)<br><p>Time when episode was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Time of last episode update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
publicAccess | **object** <br> includes only one of the fields `publicAccess`, `authSystemAccess`<br>
authSystemAccess | **object** <br> includes only one of the fields `publicAccess`, `authSystemAccess`<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Create episode.
[delete](delete.md) | Delete episode.
[get](get.md) | Returns the specific channel.
[getManifests](getManifests.md) | Returns manifest urls.
[getPlayerURL](getPlayerURL.md) | Returns url to the player.
[list](list.md) | List episodes for stream or line.
[performAction](performAction.md) | Perform an action on the episode.
[update](update.md) | Update episode.