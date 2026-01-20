---
editable: false
sourcePath: en/_openapi/openai-compatible/clientEvents/realtimeResponseCreate.md
---

# REST: response.create

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/response.create
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "response": "object"
}
```

Create a model response using the current conversation context and session defaults. The server will stream response events (`response.created`, output deltas, and `response.done`).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.create`.

- `response.create` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| response | **object**

Optional per-response configuration overrides (modalities, instructions, tools, etc.). When omitted, session defaults are used. ||
|#

## Response {#200}

**HTTP Code: 200**

OK