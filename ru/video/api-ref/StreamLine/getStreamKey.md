---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}:getStreamKey
    method: get
    path:
      type: object
      properties:
        streamLineId:
          description: |-
            **string**
            Required field. ID of the stream line for which to retrieve the stream key.
            The stream line must be a push-type input (RTMP push or SRT push).
          type: string
      required:
        - streamLineId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/StreamLine/getStreamKey.md
---

# Video API, REST: StreamLine.GetStreamKey

Retrieves the unique stream key for a push-type stream line.
This key is used to authenticate when pushing video streams to the platform.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/streamLines/{streamLineId}:getStreamKey
```

## Path parameters

#|
||Field | Description ||
|| streamLineId | **string**

Required field. ID of the stream line for which to retrieve the stream key.
The stream line must be a push-type input (RTMP push or SRT push). ||
|#

## Response {#yandex.cloud.video.v1.PushStreamKey}

**HTTP Code: 200 - OK**

```json
{
  "key": "string"
}
```

Represents the stream key used for pushing video streams.

#|
||Field | Description ||
|| key | **string**

The unique stream key. ||
|#