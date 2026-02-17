---
editable: false
---

# REST: session.update

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/session.update
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "session": "object"
}
```

Send this event to update the session’s configuration. The server responds with `session.updated` showing the full, effective configuration. Only fields present in the `session.update` are updated.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `session.update`.

- `session.update` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| session | **object**

Required field. Session configuration patch. Only fields provided are updated. ||
|#

## Response {#200}

**HTTP Code: 200**

OK