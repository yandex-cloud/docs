---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/getStreamKey.md
---

# Video API, REST: StreamLine.GetStreamKey {#GetStreamKey}

Returns unique stream key.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}:getStreamKey
```

## Path parameters

#|
||Field | Description ||
|| streamLineId | **string**

Required field. ID of the line. ||
|#

## Response {#yandex.cloud.video.v1.PushStreamKey}

**HTTP Code: 200 - OK**

```json
{
  "key": "string"
}
```

Push stream key.

#|
||Field | Description ||
|| key | **string**

Unique stream key. ||
|#