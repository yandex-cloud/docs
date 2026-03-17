---
editable: false
---

# REST: response.mcp_call_arguments.delta '[CURRENTLY NOT SUPPORTED]'

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/response.mcp_call_arguments.delta
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "response_id": "string",
  "output_index": "integer",
  "item_id": "string",
  "delta": "string"
}
```

Returned when MCP tool call arguments are updated.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.mcp_call_arguments.delta`.

- `response.mcp_call_arguments.delta` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field. The ID of the response. ||
|| output_index | **integer**

Required field. The index of the output item in the response. ||
|| item_id | **string**

Required field. The ID of the MCP tool call item. ||
|| delta | **string**

Required field. The arguments delta as a JSON string. ||
|#

## Response {#200}

**HTTP Code: 200**

OK