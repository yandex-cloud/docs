[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > DataLens Public API > [DataLens API (англ.)](index.md) > getRootCollectionPermissions

# DataLens API: Get root collection permissions

## HTTP request

```
POST https://api.datalens.tech/rpc/getRootCollectionPermissions
```

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "createCollectionInRoot": "boolean",
  "createWorkbookInRoot": "boolean"
}
```

#|
||Field | Description ||
|| createCollectionInRoot | **boolean**

Required field.  ||
|| createWorkbookInRoot | **boolean**

Required field.  ||
|#