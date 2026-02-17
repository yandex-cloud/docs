---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/standardImages/{standardImageId}
    method: get
    path:
      type: object
      properties:
        standardImageId:
          description: |-
            **string**
            ID of the StandardImage resource to return.
            To get the standard image ID, use a [StandardImageService.List](/docs/baremetal/api-ref/StandardImage/list#List) request.
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# BareMetal API, REST: StandardImage.Get

Returns the specific standard Image resource.

To get the list of standard  resources, make a [List](/docs/baremetal/api-ref/StandardImage/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/standardImages/{standardImageId}
```

## Path parameters

#|
||Field | Description ||
|| standardImageId | **string**

Required field. ID of the StandardImage resource to return.

To get the standard image ID, use a [StandardImageService.List](/docs/baremetal/api-ref/StandardImage/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.StandardImage}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "folderId": "string"
}
```

A Standard Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the standard image. ||
|| name | **string**

Name of the standard image. ||
|| folderId | **string**

Folder of standard image. ||
|#