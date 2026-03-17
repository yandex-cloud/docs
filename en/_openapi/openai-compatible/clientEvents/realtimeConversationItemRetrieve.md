---
editable: false
---

# REST: conversation.item.retrieve

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/conversation.item.retrieve
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item_id": "string"
}
```

Retrieve the server representation of a specific conversation item. Useful for fetching post-processed audio. The server responds with `conversation.item.retrieved`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.retrieve`.

- `conversation.item.retrieve` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| item_id | **string**

Required field. The ID of the item to retrieve. ||
|#

## Response {#200}

**HTTP Code: 200**

OK