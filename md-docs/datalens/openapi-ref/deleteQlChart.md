[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > DataLens Public API > [DataLens API (англ.)](index.md) > deleteQLChart

# DataLens API: Delete QL chart

## HTTP request

```
POST https://api.datalens.tech/rpc/deleteQLChart
```

## Body parameters

**Request schema: application/json**

```json
{
  "chartId": "string"
}
```

#|
||Field | Description ||
|| chartId | **string**

Required field.  ||
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