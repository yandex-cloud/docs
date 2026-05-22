---
editable: false
---

# DataLens API: Update collection access bindings

## HTTP request

```
POST https://api.datalens.tech/rpc/updateCollectionAccessBindings
```

## Body parameters

**Request schema: application/json**

```json
{
  "collectionId": "string",
  "deltas": [
    {
      "action": "string",
      "accessBinding": {
        "roleId": "string",
        "subject": {
          "id": "string",
          "type": "string"
        }
      }
    }
  ]
}
```

#|
||Field | Description ||
|| collectionId | **string**

Required field.  ||
|| deltas[] | **[DeltasItem](#DeltasItem)**

Required field.  ||
|#

## DeltasItem {#DeltasItem}

#|
||Field | Description ||
|| action | **enum**

Required field. 

- `ADD`
- `REMOVE` ||
|| accessBinding | **[AccessBinding](#AccessBinding)**

Required field.  ||
|#

## AccessBinding {#AccessBinding}

#|
||Field | Description ||
|| roleId | **string**

Required field.  ||
|| subject | **[Subject](#Subject)**

Required field.  ||
|#

## Subject {#Subject}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| type | **enum**

Required field. 

- `system`
- `userAccount`
- `federatedUser`
- `serviceAccount`
- `group`
- `invitee` ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "id": "string",
  "description": "string",
  "createdBy": "string",
  "createdAt": {
    "seconds": "string",
    "nanos": "number"
  },
  "modifiedAt": {
    "seconds": "string",
    "nanos": "number"
  },
  "metadata": {},
  "done": "boolean"
}
```

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| description | **string**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| createdAt | **[CreatedAt](#CreatedAt)**

Required field.  ||
|| modifiedAt | **[ModifiedAt](#ModifiedAt)**

Required field.  ||
|| metadata | **[Metadata](#Metadata)**

Required field.  ||
|| done | **boolean**

Required field.  ||
|#

## CreatedAt {#CreatedAt}

#|
||Field | Description ||
|| seconds | **string**

Required field.  ||
|| nanos | **number** ||
|#

## ModifiedAt {#ModifiedAt}

#|
||Field | Description ||
|| seconds | **string**

Required field.  ||
|| nanos | **number** ||
|#

## Metadata {#Metadata}

#|
||Field | Description ||
|| Empty | > ||
|#