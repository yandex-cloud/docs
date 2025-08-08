---
editable: false
apiPlayground:
  - url: https://cdn.{{ api-host }}/cdn/v1/providers
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder that the activate provider belongs to.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/cdn/v1/api-ref/Provider/listActivated.md
---

# Cloud CDN API, REST: Provider.ListActivated

List activated providers for specified client.

## HTTP request

```
GET https://cdn.{{ api-host }}/cdn/v1/providers
```

## Query parameters {#yandex.cloud.cdn.v1.ListActivatedProvidersRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the activate provider belongs to. ||
|#

## Response {#yandex.cloud.cdn.v1.ListActivatedProvidersResponse}

**HTTP Code: 200 - OK**

```json
{
  "providers": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| providers[] | **string**

Creates a list of providers. ||
|#