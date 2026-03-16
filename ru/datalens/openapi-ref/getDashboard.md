---
editable: false
---

# DataLens API: 🚧 [Experimental] Get dashboard

Returns the specified dashboard.

## HTTP request

```
POST https://api.datalens.tech/rpc/getDashboard
```

## Body parameters

**Request schema: application/json**

```json
{
  "dashboardId": "string",
  "revId": "string",
  "includePermissions": "boolean",
  "includeLinks": "boolean",
  "includeFavorite": "boolean",
  "branch": "string",
  "workbookId": "string"
}
```

#|
||Field | Description ||
|| dashboardId | **string**

Required field. ID of the dashboard to return. You can find it in the dashboard settings in DataLens interface. ||
|| revId | **string** 

Version ID for the dashboard. ||
|| includePermissions | **boolean** 

Include information on configured dashboard permissions in the response. ||
|| includeLinks | **boolean** 

Include information on configured links in the response. ||
|| includeFavorite | **boolean** 

Include favorite status in the response. ||
|| branch | **enum**

- `published` — whether the dashboard is published;
- `saved` — whether the dashboard is saved; ||
|| workbookId | **string** 

ID of the workbook the dashboard belongs to. ||
|#

## Response {#200}

**HTTP Code: 200**

Response

**Response schema: application/json**

```json
{
  "entry": {
    "annotation": "object | null",
    "createdAt": "string",
    "createdBy": "string",
    "data": {
      "counter": "integer",
      "salt": "string",
      "schemeVersion": "number",
      "tabs": [
        {
          "id": "string",
          "title": "string",
          "items": [
            {
              "<allOf>": [
                {
                  "id": "string",
                  "namespace": "string",
                  "type": "string"
                },
                "unknown"
              ]
            }
          ],
          "layout": [
            {
              "i": "string",
              "h": "number",
              "w": "number",
              "x": "number",
              "y": "number",
              "parent": "string"
            }
          ],
          "connections": [
            {
              "from": "string",
              "to": "string",
              "kind": "string"
            }
          ],
          "aliases": {
            "default": [
              "array"
            ]
          }
        }
      ],
      "settings": {
        "autoupdateInterval": "unknown",
        "maxConcurrentRequests": "unknown",
        "loadPriority": "string",
        "silentLoading": "boolean",
        "dependentSelectors": "boolean",
        "globalParams": {
          "string": "unknown"
        },
        "hideTabs": "boolean",
        "hideDashTitle": "boolean",
        "expandTOC": "boolean",
        "assistantEnabled": "boolean"
      },
      "supportDescription": "string",
      "accessDescription": "string"
    },
    "entryId": "string",
    "hidden": "boolean",
    "key": "unknown",
    "links": "object | null",
    "meta": "object | null",
    "public": "boolean",
    "publishedId": "string | null",
    "revId": "string",
    "savedId": "string",
    "scope": "string",
    "tenantId": "string",
    "type": "string",
    "updatedAt": "string",
    "updatedBy": "string",
    "version": "number",
    "workbookId": "unknown"
  },
  "isFavorite": "boolean",
  "permissions": {
    "execute": "boolean",
    "read": "boolean",
    "edit": "boolean",
    "admin": "boolean"
  }
}
```

#|
||Field | Description ||
|| entry | **[Entry](#Entry)**

Required field.  ||
|| isFavorite | **boolean** ||
|| permissions | **[Permissions](#Permissions)**

Required field.  ||
|#

## Entry {#Entry}

#|
||Field | Description ||
|| annotation | **object \| null** ||
|| createdAt | **string**

Required field.  ||
|| createdBy | **string**

Required field.  ||
|| data | **[Data](#Data)**

Required field.  ||
|| entryId | **string**

Required field.  ||
|| hidden | **boolean**

Required field.  ||
|| key | Any of **null** \| **string** \| **null** ||
|| links | **object \| null** ||
|| meta | **object \| null**

Required field.  ||
|| public | **boolean**

Required field.  ||
|| publishedId | **string \| null**

Required field.  ||
|| revId | **string**

Required field.  ||
|| savedId | **string**

Required field.  ||
|| scope | **enum**

Required field. 

- `dash` ||
|| tenantId | **string**

Required field.  ||
|| type | **enum**

Required field. 

- `` ||
|| updatedAt | **string**

Required field.  ||
|| updatedBy | **string**

Required field.  ||
|| version | **enum**

Required field. 

- `1` ||
|| workbookId | Any of **null** \| **string** \| **null** ||
|#

## Data {#Data}

#|
||Field | Description ||
|| counter | **integer**

Required field.  ||
|| salt | **string**

Required field.  ||
|| schemeVersion | **enum**

Required field. 

- `8` ||
|| tabs[] | **[TabsItem](#TabsItem)**

Required field.  ||
|| settings | **[Settings](#Settings)**

Required field.  ||
|| supportDescription | **string** ||
|| accessDescription | **string** ||
|#

## TabsItem {#TabsItem}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| title | **string**

Required field.  ||
|| items[] | **unknown**

Required field.  ||
|| layout[] | **[LayoutItem](#LayoutItem)**

Required field.  ||
|| connections[] | **[ConnectionsItem](#ConnectionsItem)**

Required field.  ||
|| aliases | **[Aliases](#Aliases)**

Required field.  ||
|#

## LayoutItem {#LayoutItem}

#|
||Field | Description ||
|| i | **string**

Required field.  ||
|| h | **number**

Required field.  ||
|| w | **number**

Required field.  ||
|| x | **number**

Required field.  ||
|| y | **number**

Required field.  ||
|| parent | **string** ||
|#

## ConnectionsItem {#ConnectionsItem}

#|
||Field | Description ||
|| from | **string**

Required field.  ||
|| to | **string**

Required field.  ||
|| kind | **enum**

Required field. 

- `ignore` ||
|#

## Aliases {#Aliases}

#|
||Field | Description ||
|| default[] | **string** ||
|#

## Settings {#Settings}

#|
||Field | Description ||
|| autoupdateInterval | Any of **number** \| **null** \| **null** ||
|| maxConcurrentRequests | Any of **number** \| **null** \| **null** ||
|| loadPriority | **enum**

- `charts`
- `selectors` ||
|| silentLoading | **boolean**

Required field.  ||
|| dependentSelectors | **boolean**

Required field.  ||
|| globalParams | **object** (map<**string**, **unknown**>) ||
|| hideTabs | **boolean**

Required field.  ||
|| hideDashTitle | **boolean** ||
|| expandTOC | **boolean**

Required field.  ||
|| assistantEnabled | **boolean** ||
|#

## Permissions {#Permissions}

#|
||Field | Description ||
|| execute | **boolean**

Required field.  ||
|| read | **boolean**

Required field.  ||
|| edit | **boolean**

Required field.  ||
|| admin | **boolean**

Required field.  ||
|#