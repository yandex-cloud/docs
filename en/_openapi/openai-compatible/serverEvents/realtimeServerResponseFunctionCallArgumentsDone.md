---
editable: false
---

# REST: response.function_call_arguments.done

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/response.function_call_arguments.done
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
  "call_id": "string",
  "arguments": "string"
}
```

Returned when model-generated function call arguments are done streaming.

#|
||Field | Description ||
|| type | **enum**

Required field. The event type, must be `response.function_call_arguments.done`.

- `response.function_call_arguments.done` ||
|| event_id | **string**

Required field. The unique ID of the server event. ||
|| response_id | **string**

Required field. The ID of the response. ||
|| output_index | **integer**

Required field. The index of the output item in the response. ||
|| item_id | **string**

Required field. The ID of the function call item. ||
|| call_id | **string**

Required field. The ID of the function call. ||
|| arguments | **string**

Required field. The final arguments as a JSON string. ||
|#

## Response {#200}

**HTTP Code: 200**

OK