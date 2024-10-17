---
editable: false
sourcePath: en/_api-ref/cdn/v1/api-ref/Resource/getProviderCName.md
---

# Cloud CDN API, REST: Resource.GetProviderCName {#GetProviderCName}

Get Provider's CNAME (edge endpoint) bind to specified folder id.
Returns UNIMPLEMENTED error, if provider doesn't support CNAME request.

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