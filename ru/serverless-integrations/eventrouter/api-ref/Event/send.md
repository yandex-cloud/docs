---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Event/send.md
---

# EventRouter Service, REST: Event.Send

Send events to bus.

## HTTP request

```
POST https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/events/{connectorId}:send
```

## Path parameters

#|
||Field | Description ||
|| connectorId | **string**

Required field. ID of the connector to send events. ||
|#

## Body parameters {#yandex.cloud.serverless.eventrouter.v1.SendEventsRequest}

```json
{
  "message": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| message[] | **string**

Batch of events bodies. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**