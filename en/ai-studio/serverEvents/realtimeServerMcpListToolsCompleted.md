---
editable: false
---

# REST: mcp_list_tools.completed

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/mcp_list_tools.completed
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

Returned when listing MCP tools is completed.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `mcp_list_tools.completed`.

- `mcp_list_tools.completed` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the MCP list tools item. ||
|#

## Response {#200}

**HTTP Code: 200**

OK