---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/getStreamKey.md
---

# Video API, gRPC: StreamLineService.GetStreamKey {#GetStreamKey}

Returns unique stream key.

## gRPC request

**rpc GetStreamKey ([GetStreamKeyRequest](#yandex.cloud.video.v1.GetStreamKeyRequest)) returns ([PushStreamKey](#yandex.cloud.video.v1.PushStreamKey))**

## GetStreamKeyRequest {#yandex.cloud.video.v1.GetStreamKeyRequest}

```json
{
  "streamLineId": "string"
}
```

#|
||Field | Description ||
|| streamLineId | **string**

ID of the line. ||
|#

## PushStreamKey {#yandex.cloud.video.v1.PushStreamKey}

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