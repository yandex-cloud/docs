---
editable: false
---

# DataLens API: 🚧 [Experimental] Create QL chart

## HTTP request

```
POST https://api.datalens.tech/rpc/createQLChart
```

## Body parameters

**Request schema: application/json**

```json
{
  "<allOf>": [
    {
      "string": "unknown"
    },
    {
      "key": "string",
      "workbookId": "string",
      "name": "string"
    }
  ]
}
```

All of:

#|
||Field | Description ||
|| template | **enum**

Required field. 

- `ql` ||
|| annotation | **[Annotation](#Annotation)**

Required field.  ||
|| data | **object** (map<**string**, **unknown**>)

Required field.  ||
|#

>

#|
||Field | Description ||
|| key | **string** ||
|| workbookId | **string** ||
|| name | **string** ||
|#

>

## Annotation {#Annotation}

#|
||Field | Description ||
|| description | **string**

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