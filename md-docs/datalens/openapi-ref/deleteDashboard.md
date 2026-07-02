[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > DataLens Public API > [DataLens API (англ.)](index.md) > deleteDashboard

# DataLens API: Delete dashboard

## HTTP request

```
POST https://api.datalens.tech/rpc/deleteDashboard
```

## Body parameters

**Request schema: application/json**

```json
{
  "dashboardId": "string",
  "lockToken": "string"
}
```

#|
||Field | Description ||
|| dashboardId | **string**

Required field.  ||
|| lockToken | **string** ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#