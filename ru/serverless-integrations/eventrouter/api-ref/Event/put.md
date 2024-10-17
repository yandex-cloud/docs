---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Event/put.md
---

# EventRouter Service, REST: Event.Put {#Put}

Puts event to bus.

## HTTP request

```
POST https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/events/{busId}:put
```

## Path parameters

#|
||Field | Description ||
|| busId | **string**

Required field. ID of the bus to put event. ||
|#

## Body parameters {#yandex.cloud.serverless.eventrouter.v1.PutEventRequest}

```json
{
  "body": "string"
}
```

#|
||Field | Description ||
|| body | **string**

Required field. Event body. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**