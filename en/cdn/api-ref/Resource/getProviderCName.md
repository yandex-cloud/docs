---
editable: false
apiPlayground:
  - url: https://cdn.{{ api-host }}/cdn/v1/cname/{folderId}
    method: get
    path:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. Folder ID to get provider's CNAME.
          type: string
      required:
        - folderId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/cdn/v1/api-ref/Resource/getProviderCName.md
---

# Cloud CDN API, REST: Resource.GetProviderCName

Deprecated: Provider-specific CNAME is now available in the `provider_cname` field of each Resource message.

## HTTP request

```
GET https://cdn.{{ api-host }}/cdn/v1/cname/{folderId}
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID to get provider's CNAME. ||
|#

## Response {#yandex.cloud.cdn.v1.GetProviderCNameResponse}

**HTTP Code: 200 - OK**

```json
{
  "cname": "string",
  "folderId": "string"
}
```

#|
||Field | Description ||
|| cname | **string**

Provider's CNAME. ||
|| folderId | **string**

ID of the folder that the provider belongs to. ||
|#