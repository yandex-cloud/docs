---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerConversationItemDeleted.md
---

# REST: conversation.item.deleted

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.deleted
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

Returned when an item is deleted by the client with `conversation.item.delete`.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `conversation.item.deleted`.

- `conversation.item.deleted` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the item that was deleted. ||
|#

## Response {#200}

**HTTP Code: 200**

OK