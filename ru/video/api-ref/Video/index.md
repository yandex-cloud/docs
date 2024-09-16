---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/index.md
---

# Video API, REST: Video methods
Video management service.
## JSON Representation {#representation}
```json 
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

  //  includes only one of the fields `publicAccess`, `authSystemAccess`
  "publicAccess": {},
  "authSystemAccess": {},
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the video.</p> 
channelId | **string**<br><p>ID of the channel where the video was created.</p> 
title | **string**<br><p>Video title.</p> 
description | **string**<br><p>Video description.</p> 
thumbnailId | **string**<br><p>ID of the thumbnail.</p> 
status | **string**<br>Video status.<br><ul> <li>WAIT_UPLOADING: Waiting for the whole number of bytes to be loaded.</li> <li>PROCESSING: Video processing.</li> <li>READY: Video is ready, processing is completed.</li> <li>ERROR: An error occurred during video processing.</li> </ul> 
duration | **string**<br><p>Video duration. Optional, may be empty until the transcoding result is ready.</p> 
visibilityStatus | **string**<br>Video visibility status.<br><ul> <li>PUBLISHED: Video is published and available for viewing.</li> <li>UNPUBLISHED: Video is unpublished, only admin can watch.</li> </ul> 
createdAt | **string** (date-time)<br><p>Time when video was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Time of last video update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
tusd | **object**
tusd.<br>url | **string**<br><p>URL for uploading video via the tus protocol.</p> 
publicAccess | **object** <br> includes only one of the fields `publicAccess`, `authSystemAccess`<br>
authSystemAccess | **object** <br> includes only one of the fields `publicAccess`, `authSystemAccess`<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Create video.
[delete](delete.md) | Delete video.
[get](get.md) | Returns the specific video.
[getManifests](getManifests.md) | Returns manifest urls.
[getPlayerURL](getPlayerURL.md) | Returns url to the player.
[list](list.md) | List videos for channel.
[performAction](performAction.md) | Perform an action on the episode.
[update](update.md) | Update video.