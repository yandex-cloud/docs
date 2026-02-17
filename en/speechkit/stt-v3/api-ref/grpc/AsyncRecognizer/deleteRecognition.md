---
editable: false
---

# SpeechKit Recognition API v3, gRPC: AsyncRecognizer.DeleteRecognition

Deletes results of asynchronous recognition by operation ID.

## gRPC request

**rpc DeleteRecognition ([DeleteRecognitionRequest](#speechkit.stt.v3.DeleteRecognitionRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## DeleteRecognitionRequest {#speechkit.stt.v3.DeleteRecognitionRequest}

```json
{
  "operation_id": "string"
}
```

#|
||Field | Description ||
|| operation_id | **string** ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#