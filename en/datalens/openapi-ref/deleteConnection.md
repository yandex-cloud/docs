---
editable: false
sourcePath: en/_api-ref/datalens-api/openapi-ref/deleteConnection.md
---

# DataLens API: Delete connection

## HTTP request

Deletes the specified connection.

```
POST https://api.datalens.yandex.net/rpc/deleteConnection
```

## Body parameters

**Request schema: application/json**

```json
{
  "connectionId": "string"
}
```

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to delete. You can find it in the connection settings in DataLens interface. ||
|#

## Response {#200}

**HTTP Code: 200**

**Response schema: application/json**

```json
"unknown"
```