---
editable: false
---

# EventRouter Service, gRPC: EventService.Send

Send events to bus.

## gRPC request

**rpc Send ([SendEventsRequest](#yandex.cloud.serverless.eventrouter.v1.SendEventsRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## SendEventsRequest {#yandex.cloud.serverless.eventrouter.v1.SendEventsRequest}

```json
{
  "connector_id": "string",
  "message": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| connector_id | **string**

Required field. ID of the connector to send events. ||
|| message[] | **string**

Batch of events bodies.

The number of elements must be in the range 1-100. The maximum string length in characters for each value is 262144. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#