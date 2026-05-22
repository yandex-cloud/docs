---
editable: false
---

# DataLens API: 🚧 [Experimental] Update wizard chart

## HTTP request

```
POST https://api.datalens.tech/rpc/updateWizardChart
```

## Body parameters

**Request schema: application/json**

```json
{
  "entryId": "string",
  "template": "string",
  "annotation": {
    "description": "string"
  },
  "mode": "string",
  "data": {
    "string": "unknown"
  }
}
```

#|
||Field | Description ||
|| entryId | **string**

Required field.  ||
|| template | **enum**

Required field. 

- `datalens` ||
|| annotation | **[Annotation](#Annotation)**

Required field.  ||
|| mode | **enum**

Required field. 

- `save`
- `publish` ||
|| data | **object** (map<**string**, **unknown**>)

Required field.  ||
|#

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