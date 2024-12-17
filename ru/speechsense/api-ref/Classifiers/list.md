---
editable: false
sourcePath: en/_api-ref/speechsense/v1/api-ref/Classifiers/list.md
---

# Talk Analytics API, REST: Classifiers.List

Rpc for listing classifiers in a project

## HTTP request

```
POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/classifiers/list
```

## Body parameters {#yandex.cloud.speechsense.v1.ListClassifiersRequest}

```json
{
  "projectId": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

Project id ||
|#

## Response {#yandex.cloud.speechsense.v1.ListClassifiersResponse}

**HTTP Code: 200 - OK**

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