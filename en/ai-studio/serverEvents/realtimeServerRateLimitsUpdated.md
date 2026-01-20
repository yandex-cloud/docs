---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerRateLimitsUpdated.md
---

# REST: rate_limits.updated '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/rate_limits.updated
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "rate_limits": [
    {}
  ]
}
```

Returned when the server updates rate limit information for the current session.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `rate_limits.updated`.

- `rate_limits.updated` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| rate_limits[] | **object**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK