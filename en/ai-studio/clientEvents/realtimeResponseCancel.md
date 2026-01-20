---
editable: false
sourcePath: en/_openapi/openai-compatible/clientEvents/realtimeResponseCancel.md
---

# REST: response.cancel

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/response.cancel
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "response_id": "string"
}
```

Cancel an in-progress response. The server will stop streaming and emit `response.done`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.cancel`.

- `response.cancel` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| response_id | **string**

Optional ID of the response to cancel. If omitted, cancels the most recent in-progress response. ||
|#

## Response {#200}

**HTTP Code: 200**

OK