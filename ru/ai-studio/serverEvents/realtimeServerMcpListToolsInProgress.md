---
editable: false
sourcePath: en/_openapi/openai-compatible/serverEvents/realtimeServerMcpListToolsInProgress.md
---

# REST: mcp_list_tools.in_progress

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/mcp_list_tools.in_progress
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

Returned when listing MCP tools is in progress.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `mcp_list_tools.in_progress`.

- `mcp_list_tools.in_progress` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| item_id | **string**

Required field. The ID of the MCP list tools item. ||
|#

## Response {#200}

**HTTP Code: 200**

OK