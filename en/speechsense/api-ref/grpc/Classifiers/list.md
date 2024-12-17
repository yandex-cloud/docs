---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Classifiers/list.md
---

# Talk Analytics API, gRPC: ClassifiersService.List

Rpc for listing classifiers in a project

## gRPC request

**rpc List ([ListClassifiersRequest](#yandex.cloud.speechsense.v1.ListClassifiersRequest)) returns ([ListClassifiersResponse](#yandex.cloud.speechsense.v1.ListClassifiersResponse))**

## ListClassifiersRequest {#yandex.cloud.speechsense.v1.ListClassifiersRequest}

```json
{
  "project_id": "string"
}
```

#|
||Field | Description ||
|| project_id | **string**

Project id ||
|#

## ListClassifiersResponse {#yandex.cloud.speechsense.v1.ListClassifiersResponse}

```json
{
  "classifiers": [
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
|| classifiers[] | **[Classifier](#yandex.cloud.speechsense.v1.Classifier)**

Classifiers belonging to the given project ||
|#

## Classifier {#yandex.cloud.speechsense.v1.Classifier}

#|
||Field | Description ||
|| id | **string**

Classifier id ||
|| name | **string**

Classifier name ||
|| description | **string**

Classifier description ||
|#