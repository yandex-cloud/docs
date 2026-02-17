---
editable: false
---

# DataLens API: Delete dashboard

## HTTP request

Deletes the specified dashboard.

```
POST https://api.datalens.yandex.net/rpc/deleteDashboard
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

Required field. ID of the dashboard to delete. ||
|| lockToken | **string** ||
|#

## Response {#200}

**HTTP Code: 200**

**Response schema: application/json**

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#