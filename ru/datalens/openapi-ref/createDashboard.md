---
editable: false
---

# DataLens API: 🚧 [Experimental] Create dashboard

## HTTP request

```
POST https://api.datalens.tech/rpc/createDashboard
```

## Body parameters

**Request schema: application/json**

```json
{
  "entry": "unknown",
  "mode": "string"
}
```

#|
||Field | Description ||
|| entry | All of **[Entry0](#Entry0)** & **[Entry1](#Entry1)** ||
|| mode | **enum**

Required field. 

- `save`
- `publish` ||
|#

## Entry0 {#Entry0}

#|
||Field | Description ||
|| data | **[Data](#Data)**

Required field.  ||
|| meta | **object \| null**

Required field.  ||
|| annotation | **[Annotation](#Annotation)**

Required field.  ||
|#

## Data {#Data}

#|
||Field | Description ||
|| counter | **integer**

Required field.  ||
|| salt | **string**

Required field.  ||
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

## Annotation {#Annotation}

#|
||Field | Description ||
|| description | **string**

Required field.  ||
|#

## Entry1 {#Entry1}

#|
||Field | Description ||
|| key | **string** ||
|| workbookId | **string** ||
|| name | **string** ||
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
  }
}
```

#|
||Field | Description ||
|| entry | **[Entry](#Entry)**

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
|| data | **[Data](#Data-1)**

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

## Data {#Data-1}

#|
||Field | Description ||
|| counter | **integer**

Required field.  ||
|| salt | **string**

Required field.  ||
|| schemeVersion | **enum**

Required field. 

- `8` ||
|| tabs[] | **[TabsItem](#TabsItem-1)**

Required field.  ||
|| settings | **[Settings](#Settings-1)**

Required field.  ||
|| supportDescription | **string** ||
|| accessDescription | **string** ||
|#

## TabsItem {#TabsItem-1}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| title | **string**

Required field.  ||
|| items[] | **unknown**

Required field.  ||
|| layout[] | **[LayoutItem](#LayoutItem-1)**

Required field.  ||
|| connections[] | **[ConnectionsItem](#ConnectionsItem-1)**

Required field.  ||
|| aliases | **[Aliases](#Aliases-1)**

Required field.  ||
|#

## LayoutItem {#LayoutItem-1}

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

## ConnectionsItem {#ConnectionsItem-1}

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

## Aliases {#Aliases-1}

#|
||Field | Description ||
|| default[] | **string** ||
|#

## Settings {#Settings-1}

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