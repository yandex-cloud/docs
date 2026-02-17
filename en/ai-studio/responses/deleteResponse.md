---
editable: false
---

# REST: Delete a model response

Deletes a model response with the given ID.

## HTTP request

```
DELETE https://ai.api.cloud.yandex.net/v1/responses/{response_id}
```

## Path parameters

#|
||Field | Description ||
|| response_id | **string**

Required field. The ID of the response to delete. ||
|#

## Response {#200}

**HTTP Code: 200**

OK

## Response {#404}

**HTTP Code: 404**

Not Found

**Response schema: application/json**

```json
{
  "code": "unknown",
  "message": "string",
  "param": "unknown",
  "type": "string"
}
```

#|
||Field | Description ||
|| code | Any of **string** \| **null** ||
|| message | **string**

Required field.  ||
|| param | Any of **string** \| **null** ||
|| type | **string**

Required field.  ||
|#