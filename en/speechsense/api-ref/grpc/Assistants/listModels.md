---
editable: false
---

# Talk Analytics API, gRPC: AssistantsService.ListModels

Rpc for listing available assistant models

## gRPC request

**rpc ListModels ([ListModelsRequest](#yandex.cloud.speechsense.v1.ListModelsRequest)) returns ([ListModelsResponse](#yandex.cloud.speechsense.v1.ListModelsResponse))**

## ListModelsRequest {#yandex.cloud.speechsense.v1.ListModelsRequest}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#

## ListModelsResponse {#yandex.cloud.speechsense.v1.ListModelsResponse}

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