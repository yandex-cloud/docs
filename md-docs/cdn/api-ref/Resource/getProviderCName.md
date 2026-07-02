[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud CDN](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Resource](index.md) > GetProviderCName

# Cloud CDN API, REST: Resource.GetProviderCName

Deprecated: Provider-specific CNAME is now available in the `provider_cname` field of each Resource message.

## HTTP request

```
GET https://cdn.api.cloud.yandex.net/cdn/v1/cname/{folderId}
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID to get provider's CNAME.

The maximum string length in characters is 50. ||
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