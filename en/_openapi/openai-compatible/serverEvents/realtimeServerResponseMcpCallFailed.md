---
editable: false
---

# REST: response.mcp_call.failed '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/response.mcp_call.failed
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "output_index": "integer",
  "item_id": "string"
}
```

Returned when an MCP tool call is failed.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.mcp_call.failed`.

- `response.mcp_call.failed` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| output_index | **integer**

Required field. The index of the output item in the response. ||
|| item_id | **string**

Required field. The ID of the MCP tool call item. ||
|#

## Response {#200}

**HTTP Code: 200**

OK