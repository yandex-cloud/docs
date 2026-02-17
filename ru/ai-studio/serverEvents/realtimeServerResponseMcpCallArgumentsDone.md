---
editable: false
---

# REST: response.mcp_call_arguments.done

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/response.mcp_call_arguments.done
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
  "arguments": "string"
}
```

Returned when MCP tool call arguments are finalized.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.mcp_call_arguments.done`.

- `response.mcp_call_arguments.done` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field. The ID of the response. ||
|| output_index | **integer**

Required field. The index of the output item in the response. ||
|| item_id | **string**

Required field. The ID of the MCP tool call item. ||
|| arguments | **string**

Required field. The final JSON-encoded arguments string. ||
|#

## Response {#200}

**HTTP Code: 200**

OK