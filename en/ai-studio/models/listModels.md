---
editable: false
sourcePath: en/_openapi/openai-compatible/models/listModels.md
---

# REST: List models

Lists the currently available models, and provides basic information about each one such as the owner and availability.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/models
```

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "object": "string",
  "data": [
    {
      "id": "string",
      "created": "integer",
      "object": "string",
      "owned_by": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| object | **enum**

Required field. 

- `list` ||
|| data[] | **unknown**

Required field. Describes an Yandex Cloud AI Studio model offering that can be used with the API. ||
|#