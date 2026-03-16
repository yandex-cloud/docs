---
editable: false
---

# DataLens API: CreateFolder

## HTTP request

```
POST https://api.datalens.tech/rpc/createFolder
```

## Body parameters

**Request schema: application/json**

```json
{
  "key": "string",
  "initialPermissions": {
    "acl_adm": [
      {
        "comment": "string",
        "subject": "string"
      }
    ],
    "acl_edit": [
      {
        "comment": "string",
        "subject": "string"
      }
    ],
    "acl_view": [
      {
        "comment": "string",
        "subject": "string"
      }
    ],
    "acl_execute": [
      {
        "comment": "string",
        "subject": "string"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| key | **string**

Required field.  ||
|| initialPermissions | **[InitialPermissions](#InitialPermissions)** ||
|#

## InitialPermissions {#InitialPermissions}

#|
||Field | Description ||
|| acl_adm[] | **[AclAdmItem](#AclAdmItem)**

Required field.  ||
|| acl_edit[] | **[AclEditItem](#AclEditItem)**

Required field.  ||
|| acl_view[] | **[AclViewItem](#AclViewItem)**

Required field.  ||
|| acl_execute[] | **[AclExecuteItem](#AclExecuteItem)**

Required field.  ||
|#

## AclAdmItem {#AclAdmItem}

#|
||Field | Description ||
|| comment | **string**

Required field.  ||
|| subject | **string**

Required field.  ||
|#

## AclEditItem {#AclEditItem}

#|
||Field | Description ||
|| comment | **string**

Required field.  ||
|| subject | **string**

Required field.  ||
|#

## AclViewItem {#AclViewItem}

#|
||Field | Description ||
|| comment | **string**

Required field.  ||
|| subject | **string**

Required field.  ||
|#

## AclExecuteItem {#AclExecuteItem}

#|
||Field | Description ||
|| comment | **string**

Required field.  ||
|| subject | **string**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "entryId": "string",
  "scope": "string",
  "type": "string",
  "key": "string",
  "unversionedData": {},
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "savedId": "string",
  "revId": "string",
  "publishedId": "string | null",
  "tenantId": "string",
  "data": {},
  "meta": {},
  "annotation": "null",
  "hidden": "boolean",
  "mirrored": "boolean",
  "public": "boolean",
  "workbookId": "null",
  "collectionId": "null",
  "version": "null",
  "sourceVersion": "null",
  "links": "null"
}
```

#|
||Field | Description ||
|| entryId | **string**

Required field.  ||
|| scope | **enum**

Required field. 

- `folder` ||
|| type | **enum**

Required field. 

- `` ||
|| key | **string**

Required field.  ||
|| unversionedData | **[UnversionedData](#UnversionedData)**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| updatedAt | **string**

Required field.  ||
|| savedId | **string**

Required field.  ||
|| revId | **string**

Required field.  ||
|| publishedId | **string \| null**

Required field.  ||
|| tenantId | **string**

Required field.  ||
|| data | **[Data](#Data)**

Required field.  ||
|| meta | **[Meta](#Meta)**

Required field.  ||
|| annotation | **null**

Required field.  ||
|| hidden | **boolean**

Required field.  ||
|| mirrored | **boolean**

Required field.  ||
|| public | **boolean**

Required field.  ||
|| workbookId | **null**

Required field.  ||
|| collectionId | **null**

Required field.  ||
|| version | **null**

Required field.  ||
|| sourceVersion | **null**

Required field.  ||
|| links | **null**

Required field.  ||
|#

## UnversionedData {#UnversionedData}

#|
||Field | Description ||
|| Empty | > ||
|#

## Data {#Data}

#|
||Field | Description ||
|| Empty | > ||
|#

## Meta {#Meta}

#|
||Field | Description ||
|| Empty | > ||
|#