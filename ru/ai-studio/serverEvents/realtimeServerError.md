---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerError.md
---

# REST: error

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/error
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "error": {
    "type": "string",
    "code": "string",
    "message": "string",
    "param": "string | null",
    "event_id": "string | null"
  }
}
```

Returned when an error occurs while processing a client event or during server execution.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `error`.

- `error` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| error | **[RealtimeErrorObject](#RealtimeErrorObject)**

Required field. Details of an error. ||
|#

## RealtimeErrorObject {#RealtimeErrorObject}

Details of an error.

#|
||Field | Description ||
|| type | **string**

Required field. Error type. ||
|| code | **string**

Error code, if available. ||
|| message | **string**

Required field. Human-readable error message. ||
|| param | **string \| null**

Parameter related to the error, if any. ||
|| event_id | **string \| null**

The client-supplied event_id that caused the error, if any. ||
|#

## Response {#200}

**HTTP Code: 200**

OK