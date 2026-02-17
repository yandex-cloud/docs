---
editable: false
apiPlayground:
  - url: https://rest-api.speechsense.yandexcloud.net/speechsense/v1/assistants/listModels
    method: post
    path: null
    query: null
    body: null
    definitions: null
---

# Talk Analytics API, REST: Assistants.ListModels

Rpc for listing available assistant models

## HTTP request

```
POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/assistants/listModels
```

## Response {#yandex.cloud.speechsense.v1.ListModelsResponse}

**HTTP Code: 200 - OK**

```json
{
  "models": [
    {
      "id": "string",
      "name": "string",
      "description": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| models[] | **[Model](#yandex.cloud.speechsense.v1.Model)** ||
|#

## Model {#yandex.cloud.speechsense.v1.Model}

#|
||Field | Description ||
|| id | **string**

Model id ||
|| name | **string**

Model name ||
|| description | **string**

Model description ||
|#