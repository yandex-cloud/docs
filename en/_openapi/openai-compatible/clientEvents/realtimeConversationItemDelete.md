---
editable: false
---

# REST: conversation.item.delete

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/client-events/conversation.item.delete
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

Delete an item from the conversation history. The server responds with `conversation.item.deleted`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.delete`.

- `conversation.item.delete` ||
|| event_id | **string**

Optional client-generated ID used to identify this event. ||
|| item_id | **string**

Required field. The ID of the item to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

OK