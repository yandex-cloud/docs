---
editable: false
---

# DataLens API: 🚧 [Experimental] Get dashboard

## HTTP request

Returns the specified dashboard.

```
POST https://api.datalens.yandex.net/rpc/getDashboard
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
  "branch": "string"
}
```

#|
||Field | Description ||
|| dashboardId | **string**

Required field. ID of the dashboard to return. You can find it in the dashboard settings in DataLens interface. ||
|| revId | **string** 

Version ID for the dashboard. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/dashboard/versioning). ||
|| includePermissions | **boolean** 

Include information on configured dashboard permissions in the response. For details about managing access, see [documentation](https://docs.yandex-team.ru/cloud/datalens/operations/dashboard/manage-access). ||
|| includeLinks | **boolean** 

Include information on configured links in the response. For details about dashboard links, see [documentation](https://docs.yandex-team.ru/cloud/datalens/dashboard/link). ||
|| includeFavorite | **boolean** 

Include favorite status in the response. ||
|| branch | **enum**

- `published`
- `saved` ||
|#

## Response {#200}

**HTTP Code: 200**

**Response schema: application/json**

```json
{
  "key": "unknown",
  "workbookId": "unknown",
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
  "meta": {
    "string": "string"
  },
  "links": {
    "string": "string"
  },
  "entryId": "string",
  "scope": "string",
  "public": "boolean",
  "isFavorite": "boolean",
  "createdAt": "string",
  "createdBy": "string",
  "updatedAt": "string",
  "updatedBy": "string",
  "revId": "string",
  "savedId": "string",
  "publishedId": "string",
  "type": "string"
}
```

#|
||Field | Description ||
|| key | Any of **null** \| **string** \| **null** 

Key of the dashboard entry. Indicates the path and name of the dashboard. ||
|| workbookId | Any of **null** \| **string** \| **null** 

ID of the workbook the dashboard belongs to. If navigation across folders is enabled and the dashboard belongs to a folder, the value must be `null`. ||
|| data | **[Data](#Data)**

Required field. Dashboard data structure. ||
|| meta | **object** (map<**string**, **string**>)

Required field. Metadata associated with the dashboard. ||
|| links | **object** (map<**string**, **string**>) 

Information about configured links on the dashboard. For details about dashboard links, see [documentation](https://docs.yandex-team.ru/cloud/datalens/dashboard/link). ||
|| entryId | **string**

Required field. Unique identifier of the dashboard entry. ||
|| scope | **enum**

Required field. Type of the entry.

For dashboards takes value:

- `dash` ||
|| public | **boolean**

Required field. Indicates if the dashboard is public. ||
|| isFavorite | **boolean**

Required field. Indicates if the dashboard is marked as favorite. ||
|| createdAt | **string**

Required field. Timestamp when the dashboard was created. ||
|| createdBy | **string**

Required field. User who created the dashboard. ||
|| updatedAt | **string**

Required field. Timestamp when the dashboard was last updated. ||
|| updatedBy | **string**

Required field. User who last updated the dashboard. ||
|| revId | **string**

Required field. Revision ID of the dashboard. ||
|| savedId | **string**

Required field. ID of the saved version of the dashboard. ||
|| publishedId | **string**

Required field. ID of the published version of the dashboard. ||
|| type | **enum**

Required field.

- `` ||
|#

## Data {#Data}

Dashboard data structure.

#|
||Field | Description ||
|| counter | **integer**

Required field. Counter for the dashboard. ||
|| salt | **string**

Required field. Salt used for data hashing. ||
|| schemeVersion | **enum**

- `8` ||
|| tabs[] | **[TabsItem](#TabsItem)**

Required field. List of dashboard tabs. ||
|| settings | **[Settings](#Settings)**

Required field. Dashboard settings. ||
|| supportDescription | **string** 

Description for the window before contacting support. ||
|| accessDescription | **string** 

Access error message for the dashboard. ||
|#

## TabsItem {#TabsItem}

Information about dashboard tab.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the dashboard tab. ||
|| title | **string**

Required field. Title of the dashboard tab. ||
|| items[] | **unknown**

Required field. List of tab items. ||
|| layout[] | **[LayoutItem](#LayoutItem)**

Required field. Layout configuration for the tab. ||
|| connections[] | **[ConnectionsItem](#ConnectionsItem)**

Required field. Connections used in tab items. ||
|| aliases | **[Aliases](#Aliases)**

Required field. Aliases for the tab. ||
|#

## LayoutItem {#LayoutItem}

Layout configuration for the tab.

#|
||Field | Description ||
|| i | **string**

Required field. Identifier for the layout item. ||
|| h | **number**

Required field. Height of the layout item. ||
|| w | **number**

Required field. Width of the layout item. ||
|| x | **number**

Required field. X coordinate of the layout item. ||
|| y | **number**

Required field. Y coordinate of the layout item. ||
|| parent | **string** 

Parent item identifier. ||
|#

## ConnectionsItem {#ConnectionsItem}

Information about connections used in tab.

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

Information about dashboard settings.

#|
||Field | Description ||
|| autoupdateInterval | Any of **number** \| **null** \| **null** 

Auto-update interval setting. ||
|| maxConcurrentRequests | Any of **number** \| **null** \| **null** 

Maximum concurrent requests. ||
|| loadPriority | **enum**

Widget display order on a mobile device:

- `charts` — to load charts at first.
- `selectors` — to load selectors at first. ||
|| silentLoading | **boolean**

Required field. Silent loading flag. ||
|| dependentSelectors | **boolean**

Required field. Dependent selectors flag. ||
|| globalParams | **object** (map<**string**, **unknown**>) 
Global parameters. ||
|| hideTabs | **boolean**

Required field. Hide tabs flag. ||
|| hideDashTitle | **boolean** 
Hide dashboard title flag. ||
|| expandTOC | **boolean**

Required field. Expand table of contents flag. ||
|| assistantEnabled | **boolean** 
Neuroanalyst enabled flag. ||
|#
