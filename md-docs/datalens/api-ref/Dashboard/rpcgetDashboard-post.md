[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Dashboard](index.md) > Get dashboard

<div class="openapi">

# Get dashboard

<!-- markdownlint-disable-file -->

Returns the specified dashboard.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getDashboard
```

</div>

</div>

</div>

### Headers

#|
|| **Name** | **Description** ||
||

_x-dl-api-version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

API version header.

_Const:_{.json-schema-reset .json-schema-value} `2`

_Example:_{.json-schema-reset .json-schema-example} `2`
{.table-cell}
||
||

_x-dl-audit-mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `true`

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "dashboardId": "example",
  "revId": "example",
  "includePermissions": true,
  "includeLinks": true,
  "includeFavorite": true,
  "branch": "saved",
  "workbookId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_dashboardId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_branch_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryBranch](#entity-EntryBranch)

Entry branch: saved or published.

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`
{.table-cell}
||
||

_includeFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_includeLinks_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### EntryBranch {#entity-EntryBranch}

Entry branch: saved or published.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "entry": {
    "annotation": {
      "description": "example"
    },
    "createdAt": "example",
    "createdBy": "example",
    "data": {
      "counter": 1,
      "salt": "example",
      "schemeVersion": 8,
      "tabs": [
        {
          "id": "example",
          "title": "example",
          "hidden": true,
          "items": [
            null
          ],
          "layout": [
            null
          ],
          "connections": [
            null
          ],
          "aliases": {},
          "globalItems": [
            null
          ],
          "settings": {}
        }
      ],
      "settings": {
        "autoupdateInterval": 30,
        "maxConcurrentRequests": 1,
        "loadPriority": "charts",
        "silentLoading": true,
        "dependentSelectors": true,
        "globalParams": {},
        "signedGlobalParams": {},
        "hideTabs": true,
        "hideDashTitle": true,
        "expandTOC": true,
        "backgroundSettings": {
          "color": null
        },
        "widgetsSettings": {
          "borderRadius": 0.5,
          "backgroundSettings": {}
        },
        "loadOnlyVisibleCharts": true,
        "margins": [
          null
        ],
        "enableAssistant": true,
        "aiChatHistoryEnabled": true
      },
      "supportDescription": "example",
      "accessDescription": "example",
      "description": "example"
    },
    "entryId": "example",
    "hidden": true,
    "key": "example",
    "links": {},
    "meta": {},
    "public": true,
    "publishedId": "example",
    "revId": "example",
    "savedId": "example",
    "scope": "dash",
    "tenantId": "example",
    "type": "",
    "updatedAt": "example",
    "updatedBy": "example",
    "revUpdatedAt": "example",
    "revUpdatedBy": "example",
    "version": 1,
    "workbookId": "example"
  },
  "isFavorite": true,
  "permissions": {
    "execute": true,
    "read": true,
    "edit": true,
    "admin": true
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entry_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashboardV1](#entity-DashboardV1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "annotation": {
    "description": "example"
  },
  "createdAt": "example",
  "createdBy": "example",
  "data": {
    "counter": 1,
    "salt": "example",
    "schemeVersion": 8,
    "tabs": [
      {
        "id": "example",
        "title": "example",
        "hidden": true,
        "items": [
          null
        ],
        "layout": [
          {}
        ],
        "connections": [
          {}
        ],
        "aliases": {
          "default": [
            null
          ]
        },
        "globalItems": [
          null
        ],
        "settings": {
          "fixedHeaderCollapsedDefault": true,
          "isGoldenset": true
        }
      }
    ],
    "settings": {
      "autoupdateInterval": 30,
      "maxConcurrentRequests": 1,
      "loadPriority": "charts",
      "silentLoading": true,
      "dependentSelectors": true,
      "globalParams": {},
      "signedGlobalParams": {},
      "hideTabs": true,
      "hideDashTitle": true,
      "expandTOC": true,
      "backgroundSettings": {
        "color": {}
      },
      "widgetsSettings": {
        "borderRadius": 0.5,
        "backgroundSettings": {
          "color": null
        }
      },
      "loadOnlyVisibleCharts": true,
      "margins": [
        null
      ],
      "enableAssistant": true,
      "aiChatHistoryEnabled": true
    },
    "supportDescription": "example",
    "accessDescription": "example",
    "description": "example"
  },
  "entryId": "example",
  "hidden": true,
  "key": "example",
  "links": {},
  "meta": {},
  "public": true,
  "publishedId": "example",
  "revId": "example",
  "savedId": "example",
  "scope": "dash",
  "tenantId": "example",
  "type": "",
  "updatedAt": "example",
  "updatedBy": "example",
  "revUpdatedAt": "example",
  "revUpdatedBy": "example",
  "version": 1,
  "workbookId": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_isFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryPermissions](#entity-EntryPermissions)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "execute": true,
  "read": true,
  "edit": true,
  "admin": true
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DashColorByTheme {#entity-DashColorByTheme}

#|
|| **Name** | **Description** ||
||

_dark_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Color for the dark theme.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_light_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Color for the light theme.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "light": "example",
  "dark": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashStringDefaultValue {#entity-DashStringDefaultValue}

A dashboard parameter value represented by one or multiple strings.

{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: string[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}

{% endcut %}

_Example:_{.json-schema-reset .json-schema-example} `example`

</div>

<div class="openapi-entity">

### DashControlElement {#entity-DashControlElement}

{% cut "**One of 4 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _elementType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Select control type.

  _Const:_{.json-schema-reset .json-schema-value} `select`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _accentType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  Control accent style.

  _Const:_{.json-schema-reset .json-schema-value} `info`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultValue_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: string[]

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    [
      "example"
    ]
    ```

    {% endcut %}

  {% endcut %}

  Default selected value or values.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _fieldType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Type of the field used by the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _hint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control hint text.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _innerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Title displayed inside the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _multiselectable_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether multiple values can be selected.
  {.table-cell}
  ||
  ||

  _operation_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Filtering operation.

  _Enum:_{.json-schema-reset .json-schema-value} `IN`, `NIN`, `EQ`, `NE`, `GT`, `LT`, `GTE`, `LTE`, `ISNULL`, `ISNOTNULL`, `ISTARTSWITH`, `STARTSWITH`, `IENDSWITH`, `ENDSWITH`, `ICONTAINS`, `CONTAINS`, `NOTICONTAINS`, `NOTCONTAINS`, `BETWEEN`, `LENEQ`, `LENGT`, `LENGTE`, `LENLT`, `LENLTE`, `NO_SELECTED_VALUES`
  {.table-cell}
  ||
  ||

  _required_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the control value is required.
  {.table-cell}
  ||
  ||

  _showHint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control hint.
  {.table-cell}
  ||
  ||

  _showInnerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the title inside the control.
  {.table-cell}
  ||
  ||

  _showTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control title.
  {.table-cell}
  ||
  ||

  _titlePlacement_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control title placement.

  _Enum:_{.json-schema-reset .json-schema-value} `hide`, `left`, `top`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _elementType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Date control type.

  _Const:_{.json-schema-reset .json-schema-value} `date`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _accentType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  Control accent style.

  _Const:_{.json-schema-reset .json-schema-value} `info`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultValue_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Default date value.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _fieldType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Type of the field used by the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _hint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control hint text.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _innerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Title displayed inside the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _isRange_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the control selects a date range.
  {.table-cell}
  ||
  ||

  _operation_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Filtering operation.

  _Enum:_{.json-schema-reset .json-schema-value} `IN`, `NIN`, `EQ`, `NE`, `GT`, `LT`, `GTE`, `LTE`, `ISNULL`, `ISNOTNULL`, `ISTARTSWITH`, `STARTSWITH`, `IENDSWITH`, `ENDSWITH`, `ICONTAINS`, `CONTAINS`, `NOTICONTAINS`, `NOTCONTAINS`, `BETWEEN`, `LENEQ`, `LENGT`, `LENGTE`, `LENLT`, `LENLTE`, `NO_SELECTED_VALUES`
  {.table-cell}
  ||
  ||

  _required_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the control value is required.
  {.table-cell}
  ||
  ||

  _showHint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control hint.
  {.table-cell}
  ||
  ||

  _showInnerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the title inside the control.
  {.table-cell}
  ||
  ||

  _showTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control title.
  {.table-cell}
  ||
  ||

  _titlePlacement_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control title placement.

  _Enum:_{.json-schema-reset .json-schema-value} `hide`, `left`, `top`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "isRange": true,
    "elementType": "date",
    "defaultValue": "example"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _elementType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Input control type.

  _Const:_{.json-schema-reset .json-schema-value} `input`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _accentType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  Control accent style.

  _Const:_{.json-schema-reset .json-schema-value} `info`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultValue_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Default input value.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _fieldType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Type of the field used by the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _hint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control hint text.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _innerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Title displayed inside the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _operation_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Filtering operation.

  _Enum:_{.json-schema-reset .json-schema-value} `IN`, `NIN`, `EQ`, `NE`, `GT`, `LT`, `GTE`, `LTE`, `ISNULL`, `ISNOTNULL`, `ISTARTSWITH`, `STARTSWITH`, `IENDSWITH`, `ENDSWITH`, `ICONTAINS`, `CONTAINS`, `NOTICONTAINS`, `NOTCONTAINS`, `BETWEEN`, `LENEQ`, `LENGT`, `LENGTE`, `LENLT`, `LENLTE`, `NO_SELECTED_VALUES`
  {.table-cell}
  ||
  ||

  _required_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the control value is required.
  {.table-cell}
  ||
  ||

  _showHint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control hint.
  {.table-cell}
  ||
  ||

  _showInnerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the title inside the control.
  {.table-cell}
  ||
  ||

  _showTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control title.
  {.table-cell}
  ||
  ||

  _titlePlacement_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control title placement.

  _Enum:_{.json-schema-reset .json-schema-value} `hide`, `left`, `top`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "elementType": "input",
    "defaultValue": "example"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _defaultValue_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Default checkbox value.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _elementType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Checkbox control type.

  _Const:_{.json-schema-reset .json-schema-value} `checkbox`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _accentType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string &#124; null

  Control accent style.

  _Const:_{.json-schema-reset .json-schema-value} `info`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _fieldType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Type of the field used by the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _hint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control hint text.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _innerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Title displayed inside the control.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _operation_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Filtering operation.

  _Enum:_{.json-schema-reset .json-schema-value} `IN`, `NIN`, `EQ`, `NE`, `GT`, `LT`, `GTE`, `LTE`, `ISNULL`, `ISNOTNULL`, `ISTARTSWITH`, `STARTSWITH`, `IENDSWITH`, `ENDSWITH`, `ICONTAINS`, `CONTAINS`, `NOTICONTAINS`, `NOTCONTAINS`, `BETWEEN`, `LENEQ`, `LENGT`, `LENGTE`, `LENLT`, `LENLTE`, `NO_SELECTED_VALUES`
  {.table-cell}
  ||
  ||

  _required_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the control value is required.
  {.table-cell}
  ||
  ||

  _showHint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control hint.
  {.table-cell}
  ||
  ||

  _showInnerTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the title inside the control.
  {.table-cell}
  ||
  ||

  _showTitle_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the control title.
  {.table-cell}
  ||
  ||

  _titlePlacement_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control title placement.

  _Enum:_{.json-schema-reset .json-schema-value} `hide`, `left`, `top`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "elementType": "checkbox",
    "defaultValue": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "required": true,
  "showHint": true,
  "showTitle": true,
  "hint": "example",
  "accentType": "info",
  "fieldType": "example",
  "innerTitle": "example",
  "showInnerTitle": true,
  "operation": "IN",
  "titlePlacement": "hide",
  "multiselectable": true,
  "elementType": "select",
  "defaultValue": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashControlSourceDataset {#entity-DashControlSourceDataset}

Dataset control source.

{% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

- **Type**: [DashControlElement](#entity-DashControlElement)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _datasetFieldId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source dataset field identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _datasetId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source dataset identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _datasetFieldType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Source dataset field type.

  _Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`, `PSEUDO`, `PARAMETER`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "datasetId": "example",
    "datasetFieldId": "example",
    "datasetFieldType": "DIMENSION"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "required": true,
  "showHint": true,
  "showTitle": true,
  "hint": "example",
  "accentType": "info",
  "fieldType": "example",
  "innerTitle": "example",
  "showInnerTitle": true,
  "operation": "IN",
  "titlePlacement": "hide",
  "multiselectable": true,
  "elementType": "select",
  "defaultValue": "example",
  "datasetId": "example",
  "datasetFieldId": "example",
  "datasetFieldType": "DIMENSION"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashControlSourceManual {#entity-DashControlSourceManual}

Manual control source.

{% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

- **Type**: [DashControlElement](#entity-DashControlElement)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example"
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _fieldName_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Parameter name for the manual control.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _acceptableValues_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: object[]

    #|
    ||

    _title_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    **Type**: string

    Label for the allowed value.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _value_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    **Type**: string

    Allowed control value.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    [
      {
        "value": "example",
        "title": "example"
      }
    ]
    ```

    {% endcut %}

  - **Type**: object

    #|
    ||

    _from_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    **Type**: string

    Start of the allowed value range.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _to_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    **Type**: string

    End of the allowed value range.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "from": "example",
      "to": "example"
    }
    ```

    {% endcut %}

  {% endcut %}

  Values accepted by the manual control.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "value": "example",
      "title": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "fieldName": "example",
    "acceptableValues": [
      {
        "value": "example",
        "title": "example"
      }
    ]
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "required": true,
  "showHint": true,
  "showTitle": true,
  "hint": "example",
  "accentType": "info",
  "fieldType": "example",
  "innerTitle": "example",
  "showInnerTitle": true,
  "operation": "IN",
  "titlePlacement": "hide",
  "multiselectable": true,
  "elementType": "select",
  "defaultValue": "example",
  "fieldName": "example",
  "acceptableValues": [
    {
      "value": "example",
      "title": "example"
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashControlSourceExternal {#entity-DashControlSourceExternal}

External control source.

#|
|| **Name** | **Description** ||
||

_chartId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Source chart identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "chartId": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashControl {#entity-DashControl}

Control item data.

{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _source_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DashControlSourceDataset](#entity-DashControlSourceDataset)

  Dataset control source.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example",
    "datasetId": "example",
    "datasetFieldId": "example",
    "datasetFieldType": "DIMENSION"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _sourceType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dataset control source type.

  _Const:_{.json-schema-reset .json-schema-value} `dataset`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control title.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _autoHeight_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to adjust the control height to its content.
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Control background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Control border radius.
  {.table-cell}
  ||
  ||

  _impactTabsIds_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: array &#124; null

  Identifiers of the tabs where the control is displayed when 'impactType' is 'currentTab' or 'selectedTabs'.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Determines where the control is displayed: 'allTabs' on all tabs, 'currentTab' on its current tab, 'selectedTabs' on the tabs listed in 'impactTabsIds', and 'asGroup' according to the containing group's settings.

  _Enum:_{.json-schema-reset .json-schema-value} `allTabs`, `currentTab`, `selectedTabs`, `asGroup`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "autoHeight": true,
    "sourceType": "dataset",
    "source": {
      "required": true,
      "showHint": true,
      "showTitle": true,
      "hint": "example",
      "accentType": "info",
      "fieldType": "example",
      "innerTitle": "example",
      "showInnerTitle": true,
      "operation": "IN",
      "titlePlacement": "hide",
      "multiselectable": true,
      "elementType": "select",
      "defaultValue": "example",
      "datasetId": "example",
      "datasetFieldId": "example",
      "datasetFieldType": "DIMENSION"
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _source_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DashControlSourceManual](#entity-DashControlSourceManual)

  Manual control source.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example",
    "fieldName": "example",
    "acceptableValues": [
      {
        "value": "example",
        "title": "example"
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _sourceType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Manual control source type.

  _Const:_{.json-schema-reset .json-schema-value} `manual`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control title.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _autoHeight_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to adjust the control height to its content.
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Control background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Control border radius.
  {.table-cell}
  ||
  ||

  _impactTabsIds_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: array &#124; null

  Identifiers of the tabs where the control is displayed when 'impactType' is 'currentTab' or 'selectedTabs'.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Determines where the control is displayed: 'allTabs' on all tabs, 'currentTab' on its current tab, 'selectedTabs' on the tabs listed in 'impactTabsIds', and 'asGroup' according to the containing group's settings.

  _Enum:_{.json-schema-reset .json-schema-value} `allTabs`, `currentTab`, `selectedTabs`, `asGroup`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "autoHeight": true,
    "sourceType": "manual",
    "source": {
      "required": true,
      "showHint": true,
      "showTitle": true,
      "hint": "example",
      "accentType": "info",
      "fieldType": "example",
      "innerTitle": "example",
      "showInnerTitle": true,
      "operation": "IN",
      "titlePlacement": "hide",
      "multiselectable": true,
      "elementType": "select",
      "defaultValue": "example",
      "fieldName": "example",
      "acceptableValues": [
        {}
      ]
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _source_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DashControlSourceExternal](#entity-DashControlSourceExternal)

  External control source.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "chartId": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _sourceType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  External control source type.

  _Const:_{.json-schema-reset .json-schema-value} `external`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control title.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _autoHeight_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to adjust the control height to its content.
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Control background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Control border radius.
  {.table-cell}
  ||
  ||

  _impactTabsIds_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: array &#124; null

  Identifiers of the tabs where the control is displayed when 'impactType' is 'currentTab' or 'selectedTabs'.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Determines where the control is displayed: 'allTabs' on all tabs, 'currentTab' on its current tab, 'selectedTabs' on the tabs listed in 'impactTabsIds', and 'asGroup' according to the containing group's settings.

  _Enum:_{.json-schema-reset .json-schema-value} `allTabs`, `currentTab`, `selectedTabs`, `asGroup`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "autoHeight": true,
    "sourceType": "external",
    "source": {
      "chartId": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "title": "example",
  "impactType": "allTabs",
  "impactTabsIds": [
    "example"
  ],
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "borderRadius": 0.5,
  "autoHeight": true,
  "sourceType": "dataset",
  "source": {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": null,
    "datasetId": "example",
    "datasetFieldId": "example",
    "datasetFieldType": "DIMENSION"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashTabControlItem {#entity-DashTabControlItem}

#|
|| **Name** | **Description** ||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashControl](#entity-DashControl)

Control item data.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "title": "example",
  "impactType": "allTabs",
  "impactTabsIds": [
    "example"
  ],
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "borderRadius": 0.5,
  "autoHeight": true,
  "sourceType": "dataset",
  "source": {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": null,
    "datasetId": "example",
    "datasetFieldId": "example",
    "datasetFieldType": "DIMENSION"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_defaults_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: [DashStringDefaultValue](#entity-DashStringDefaultValue)

A dashboard parameter value represented by one or multiple strings.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Default control values.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dashboard item identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_namespace_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Item namespace.

_Const:_{.json-schema-reset .json-schema-value} `default`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Control item type.

_Const:_{.json-schema-reset .json-schema-value} `control`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_defaultOrderId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Default item order.
{.table-cell}
||
||

_orderId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Current item order.
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "namespace": "default",
  "orderId": 0.5,
  "defaultOrderId": 0.5,
  "type": "control",
  "data": {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "backgroundSettings": {
      "color": {}
    },
    "borderRadius": 0.5,
    "autoHeight": true,
    "sourceType": "dataset",
    "source": {
      "datasetId": "example",
      "datasetFieldId": "example",
      "datasetFieldType": "DIMENSION"
    }
  },
  "defaults": {}
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashGroupControlItem {#entity-DashGroupControlItem}

{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _source_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DashControlSourceDataset](#entity-DashControlSourceDataset)

  Dataset control source.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example",
    "datasetId": "example",
    "datasetFieldId": "example",
    "datasetFieldType": "DIMENSION"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _sourceType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dataset control source type.

  _Const:_{.json-schema-reset .json-schema-value} `dataset`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control title.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaults_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: [DashStringDefaultValue](#entity-DashStringDefaultValue)

  A dashboard parameter value represented by one or multiple strings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Default control values.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactTabsIds_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: array &#124; null

  Identifiers of the tabs where the control is displayed when 'impactType' is 'currentTab' or 'selectedTabs'.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Determines where the control is displayed: 'allTabs' on all tabs, 'currentTab' on its current tab, 'selectedTabs' on the tabs listed in 'impactTabsIds', and 'asGroup' according to the containing group's settings.

  _Enum:_{.json-schema-reset .json-schema-value} `allTabs`, `currentTab`, `selectedTabs`, `asGroup`
  {.table-cell}
  ||
  ||

  _placementMode_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control placement mode.

  _Enum:_{.json-schema-reset .json-schema-value} `auto`, `%`, `px`
  {.table-cell}
  ||
  ||

  _width_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control width.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "id": "example",
    "namespace": "default",
    "defaults": {},
    "placementMode": "auto",
    "width": "example",
    "sourceType": "dataset",
    "source": {
      "required": true,
      "showHint": true,
      "showTitle": true,
      "hint": "example",
      "accentType": "info",
      "fieldType": "example",
      "innerTitle": "example",
      "showInnerTitle": true,
      "operation": "IN",
      "titlePlacement": "hide",
      "multiselectable": true,
      "elementType": "select",
      "defaultValue": "example",
      "datasetId": "example",
      "datasetFieldId": "example",
      "datasetFieldType": "DIMENSION"
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _source_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DashControlSourceManual](#entity-DashControlSourceManual)

  Manual control source.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": "example",
    "fieldName": "example",
    "acceptableValues": [
      {
        "value": "example",
        "title": "example"
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _sourceType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Manual control source type.

  _Const:_{.json-schema-reset .json-schema-value} `manual`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Control title.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaults_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: [DashStringDefaultValue](#entity-DashStringDefaultValue)

  A dashboard parameter value represented by one or multiple strings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Default control values.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactTabsIds_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: array &#124; null

  Identifiers of the tabs where the control is displayed when 'impactType' is 'currentTab' or 'selectedTabs'.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _impactType_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Determines where the control is displayed: 'allTabs' on all tabs, 'currentTab' on its current tab, 'selectedTabs' on the tabs listed in 'impactTabsIds', and 'asGroup' according to the containing group's settings.

  _Enum:_{.json-schema-reset .json-schema-value} `allTabs`, `currentTab`, `selectedTabs`, `asGroup`
  {.table-cell}
  ||
  ||

  _placementMode_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control placement mode.

  _Enum:_{.json-schema-reset .json-schema-value} `auto`, `%`, `px`
  {.table-cell}
  ||
  ||

  _width_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control width.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "id": "example",
    "namespace": "default",
    "defaults": {},
    "placementMode": "auto",
    "width": "example",
    "sourceType": "manual",
    "source": {
      "required": true,
      "showHint": true,
      "showTitle": true,
      "hint": "example",
      "accentType": "info",
      "fieldType": "example",
      "innerTitle": "example",
      "showInnerTitle": true,
      "operation": "IN",
      "titlePlacement": "hide",
      "multiselectable": true,
      "elementType": "select",
      "defaultValue": "example",
      "fieldName": "example",
      "acceptableValues": [
        {}
      ]
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "title": "example",
  "impactType": "allTabs",
  "impactTabsIds": [
    "example"
  ],
  "id": "example",
  "namespace": "default",
  "defaults": {},
  "placementMode": "auto",
  "width": "example",
  "sourceType": "dataset",
  "source": {
    "required": true,
    "showHint": true,
    "showTitle": true,
    "hint": "example",
    "accentType": "info",
    "fieldType": "example",
    "innerTitle": "example",
    "showInnerTitle": true,
    "operation": "IN",
    "titlePlacement": "hide",
    "multiselectable": true,
    "elementType": "select",
    "defaultValue": null,
    "datasetId": "example",
    "datasetFieldId": "example",
    "datasetFieldType": "DIMENSION"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashGroupControl {#entity-DashGroupControl}

Control group item data.

#|
|| **Name** | **Description** ||
||

_autoHeight_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether to adjust the group height to its content.
{.table-cell}
||
||

_buttonApply_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether to show the Apply button.
{.table-cell}
||
||

_buttonReset_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether to show the Reset button.
{.table-cell}
||
||

_group_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashGroupControlItem](#entity-DashGroupControlItem)[]

Controls in the group.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "id": "example",
    "namespace": "default",
    "defaults": {},
    "placementMode": "auto",
    "width": "example",
    "sourceType": "dataset",
    "source": {
      "datasetId": "example",
      "datasetFieldId": "example",
      "datasetFieldType": "DIMENSION"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_showGroupName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether to show the control group name.
{.table-cell}
||
||

_backgroundSettings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_color_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [DashColorByTheme](#entity-DashColorByTheme)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

{% endcut %}

Widget background color in hex.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "light": "example",
  "dark": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Control group background settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "color": {
    "light": "example",
    "dark": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_borderRadius_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Control group border radius.
{.table-cell}
||
||

_groupName_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Control group name.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_impactTabsIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

Identifiers of tabs affected by the control group.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
||

_impactType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Tabs affected by the control group.

_Enum:_{.json-schema-reset .json-schema-value} `allTabs`, `currentTab`, `selectedTabs`
{.table-cell}
||
||

_updateControlsOnChange_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether controls update immediately after a value changes.
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "autoHeight": true,
  "buttonApply": true,
  "buttonReset": true,
  "showGroupName": true,
  "groupName": "example",
  "impactType": "allTabs",
  "impactTabsIds": [
    "example"
  ],
  "updateControlsOnChange": true,
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "borderRadius": 0.5,
  "group": [
    {
      "title": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        "example"
      ],
      "id": "example",
      "namespace": "default",
      "defaults": {},
      "placementMode": "auto",
      "width": "example",
      "sourceType": "dataset",
      "source": null
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashTabGroupControlItem {#entity-DashTabGroupControlItem}

#|
|| **Name** | **Description** ||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashGroupControl](#entity-DashGroupControl)

Control group item data.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "autoHeight": true,
  "buttonApply": true,
  "buttonReset": true,
  "showGroupName": true,
  "groupName": "example",
  "impactType": "allTabs",
  "impactTabsIds": [
    "example"
  ],
  "updateControlsOnChange": true,
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "borderRadius": 0.5,
  "group": [
    {
      "title": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        "example"
      ],
      "id": "example",
      "namespace": "default",
      "defaults": {},
      "placementMode": "auto",
      "width": "example",
      "sourceType": "dataset",
      "source": null
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dashboard item identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_namespace_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Item namespace.

_Const:_{.json-schema-reset .json-schema-value} `default`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Control group item type.

_Const:_{.json-schema-reset .json-schema-value} `group_control`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_defaultOrderId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Default item order.
{.table-cell}
||
||

_orderId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Current item order.
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "namespace": "default",
  "orderId": 0.5,
  "defaultOrderId": 0.5,
  "type": "group_control",
  "data": {
    "autoHeight": true,
    "buttonApply": true,
    "buttonReset": true,
    "showGroupName": true,
    "groupName": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "updateControlsOnChange": true,
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "group": [
      {
        "title": "example",
        "impactType": "allTabs",
        "impactTabsIds": [
          null
        ],
        "id": "example",
        "namespace": "default",
        "defaults": {},
        "placementMode": "auto",
        "width": "example",
        "sourceType": "dataset",
        "source": null
      }
    ]
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashTabItem {#entity-DashTabItem}

{% cut "**One of 7 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _text_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Text item content.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _autoHeight_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to adjust the item height to its content.
  {.table-cell}
  ||
  ||

  _background_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: object

    #|
    ||

    _color_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: string

    Legacy background color.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _enabled_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: boolean

    Whether the legacy background is enabled.
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "enabled": true,
      "color": "example"
    }
    ```

    {% endcut %}

  {% endcut %}

  Deprecated. Use backgroundSettings instead.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Text item background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Text item border radius.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Text item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "text": "example",
    "autoHeight": true,
    "background": "example",
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dashboard item identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Item namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Text item type.

  _Const:_{.json-schema-reset .json-schema-value} `text`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultOrderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Default item order.
  {.table-cell}
  ||
  ||

  _orderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Current item order.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "text",
    "data": {
      "text": "example",
      "autoHeight": true,
      "background": "example",
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _size_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Enum:_{.json-schema-reset .json-schema-value} `xl`, `l`, `m`, `s`, `xs`

  - **Type**: object

    #|
    ||

    _fontSize_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    **Type**: number

    Title font size.
    {.table-cell}
    ||
    ||

    _lineHeight_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: number

    Title line height.
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "fontSize": 0.5,
      "lineHeight": 0.5
    }
    ```

    {% endcut %}

  {% endcut %}

  Title size settings.

  _Example:_{.json-schema-reset .json-schema-example} `xl`
  {.table-cell}
  ||
  ||

  _text_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Title text.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _autoHeight_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to adjust the title height to its content.
  {.table-cell}
  ||
  ||

  _background_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: object

    #|
    ||

    _color_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: string

    Legacy background color.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _enabled_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: boolean

    Whether the legacy background is enabled.
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "enabled": true,
      "color": "example"
    }
    ```

    {% endcut %}

  {% endcut %}

  Deprecated. Use backgroundSettings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Title background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Title border radius.
  {.table-cell}
  ||
  ||

  _hint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _enabled_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the title hint is enabled.
  {.table-cell}
  ||
  ||

  _text_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Title hint text.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Title hint settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "enabled": true,
    "text": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _internalMarginsEnabled_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the title includes internal margins. This experimental field may change in future API versions.
  {.table-cell}
  ||
  ||

  _showInTOC_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to show the title in the table of contents.
  {.table-cell}
  ||
  ||

  _textColor_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Deprecated. Use textSettings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _textSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Title text color.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Title text settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Title item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "text": "example",
    "size": "xl",
    "showInTOC": true,
    "autoHeight": true,
    "textColor": "example",
    "textSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "hint": {
      "enabled": true,
      "text": "example"
    },
    "background": "example",
    "backgroundSettings": {
      "color": null
    },
    "borderRadius": 0.5,
    "internalMarginsEnabled": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dashboard item identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Item namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Title item type.

  _Const:_{.json-schema-reset .json-schema-value} `title`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultOrderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Default item order.
  {.table-cell}
  ||
  ||

  _orderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Current item order.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "title",
    "data": {
      "text": "example",
      "size": "xl",
      "showInTOC": true,
      "autoHeight": true,
      "textColor": "example",
      "textSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "hint": {
        "enabled": true,
        "text": "example"
      },
      "background": "example",
      "backgroundSettings": {
        "color": null
      },
      "borderRadius": 0.5,
      "internalMarginsEnabled": true
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _hideTitle_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Whether to hide the widget title.
  {.table-cell}
  ||
  ||

  _tabs_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _chartId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Chart identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Widget tab identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _params_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _[additional]_{.json-schema-reset .json-schema-additional-property}
  {.table-cell}|
  **Type**: [DashStringDefaultValue](#entity-DashStringDefaultValue)

  A dashboard parameter value represented by one or multiple strings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Parameters passed to the chart.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Widget tab title.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _autoHeight_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to adjust the widget height to its content.
  {.table-cell}
  ||
  ||

  _background_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: object

    #|
    ||

    _color_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: string

    Legacy background color.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _enabled_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: boolean

    Whether the legacy background is enabled.
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "enabled": true,
      "color": "example"
    }
    ```

    {% endcut %}

  {% endcut %}

  Deprecated. Use backgroundSettings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _description_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Widget tab description.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _enableActionParams_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether chart actions can update parameters.
  {.table-cell}
  ||
  ||

  _enableDescription_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the widget tab description is enabled.
  {.table-cell}
  ||
  ||

  _enableHint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether the widget tab hint is enabled.
  {.table-cell}
  ||
  ||

  _hint_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Widget tab hint.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _isDefault_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether this is the default widget tab.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Widget tabs.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "id": "example",
      "title": "example",
      "description": "example",
      "hint": "example",
      "enableHint": true,
      "enableDescription": true,
      "chartId": "example",
      "isDefault": true,
      "params": {},
      "autoHeight": true,
      "enableActionParams": true,
      "background": "example"
    }
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Widget background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Widget border radius.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Widget item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "hideTitle": true,
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "tabs": [
      {
        "id": "example",
        "title": "example",
        "description": "example",
        "hint": "example",
        "enableHint": true,
        "enableDescription": true,
        "chartId": "example",
        "isDefault": true,
        "params": {},
        "autoHeight": true,
        "enableActionParams": true,
        "background": "example"
      }
    ]
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dashboard item identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Item namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Widget item type.

  _Const:_{.json-schema-reset .json-schema-value} `widget`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultOrderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Default item order.
  {.table-cell}
  ||
  ||

  _orderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Current item order.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "widget",
    "data": {
      "hideTitle": true,
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5,
      "tabs": [
        {
          "id": "example",
          "title": "example",
          "description": "example",
          "hint": "example",
          "enableHint": true,
          "enableDescription": true,
          "chartId": "example",
          "isDefault": true,
          "params": {},
          "autoHeight": true,
          "enableActionParams": true,
          "background": "example"
        }
      ]
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _src_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Image source URL.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _alt_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Alternative text for the image.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _background_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: object

    #|
    ||

    _color_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: string

    Legacy background color.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _enabled_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: boolean

    Whether the legacy background is enabled.
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "enabled": true,
      "color": "example"
    }
    ```

    {% endcut %}

  {% endcut %}

  Deprecated. Use backgroundSettings.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Image background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Image border radius.
  {.table-cell}
  ||
  ||

  _preserveAspectRatio_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to preserve the image aspect ratio.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Image item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "src": "example",
    "alt": "example",
    "preserveAspectRatio": true,
    "background": "example",
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dashboard item identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Item namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Image item type.

  _Const:_{.json-schema-reset .json-schema-value} `image`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultOrderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Default item order.
  {.table-cell}
  ||
  ||

  _orderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Current item order.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "image",
    "data": {
      "src": "example",
      "alt": "example",
      "preserveAspectRatio": true,
      "background": "example",
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _hideTitle_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Whether to hide the insight widget title.
  {.table-cell}
  ||
  ||

  _prompt_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Prompt used to generate the widget.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _widgetTabId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Neuro widget tab identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _backgroundSettings_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: [DashColorByTheme](#entity-DashColorByTheme)

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "light": "example",
      "dark": "example"
    }
    ```

    {% endcut %}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  {% endcut %}

  Widget background color in hex.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Neuro widget background settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _borderRadius_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Insight widget border radius.
  {.table-cell}
  ||
  ||

  _hideActions_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean

  Whether to hide insight widget actions.
  {.table-cell}
  ||
  ||

  _title_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Neuro widget title.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Neuro widget item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "widgetTabId": "example",
    "title": "example",
    "prompt": "example",
    "hideTitle": true,
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "hideActions": true
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _id_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Dashboard item identifier.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _namespace_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Item namespace.

  _Const:_{.json-schema-reset .json-schema-value} `default`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Insight widget item type.

  _Const:_{.json-schema-reset .json-schema-value} `neuro_widget`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _defaultOrderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Default item order.
  {.table-cell}
  ||
  ||

  _orderId_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Current item order.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "neuro_widget",
    "data": {
      "widgetTabId": "example",
      "title": "example",
      "prompt": "example",
      "hideTitle": true,
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5,
      "hideActions": true
    }
  }
  ```

  {% endcut %}

- **Type**: [DashTabControlItem](#entity-DashTabControlItem)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "control",
    "data": {
      "title": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        "example"
      ],
      "backgroundSettings": {
        "color": {}
      },
      "borderRadius": 0.5,
      "autoHeight": true,
      "sourceType": "dataset",
      "source": {
        "datasetId": "example",
        "datasetFieldId": "example",
        "datasetFieldType": "DIMENSION"
      }
    },
    "defaults": {}
  }
  ```

  {% endcut %}

- **Type**: [DashTabGroupControlItem](#entity-DashTabGroupControlItem)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "group_control",
    "data": {
      "autoHeight": true,
      "buttonApply": true,
      "buttonReset": true,
      "showGroupName": true,
      "groupName": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        "example"
      ],
      "updateControlsOnChange": true,
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5,
      "group": [
        {
          "title": "example",
          "impactType": "allTabs",
          "impactTabsIds": [
            null
          ],
          "id": "example",
          "namespace": "default",
          "defaults": {},
          "placementMode": "auto",
          "width": "example",
          "sourceType": "dataset",
          "source": null
        }
      ]
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "namespace": "default",
  "orderId": 0.5,
  "defaultOrderId": 0.5,
  "type": "text",
  "data": {
    "text": "example",
    "autoHeight": true,
    "background": "example",
    "backgroundSettings": {
      "color": {}
    },
    "borderRadius": 0.5
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashLayoutItem {#entity-DashLayoutItem}

#|
|| **Name** | **Description** ||
||

_h_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Item height in grid units.
{.table-cell}
||
||

_i_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dashboard item identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_w_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Item width in grid units.
{.table-cell}
||
||

_x_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Horizontal grid position.
{.table-cell}
||
||

_y_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Vertical grid position.
{.table-cell}
||
||

_parent_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Parent item identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "i": "example",
  "h": 0.5,
  "w": 0.5,
  "x": 0.5,
  "y": 0.5,
  "parent": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashConnection {#entity-DashConnection}

#|
|| **Name** | **Description** ||
||

_from_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Source widget identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_kind_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Connection type.

_Const:_{.json-schema-reset .json-schema-value} `ignore`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_to_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Target widget identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "from": "example",
  "to": "example",
  "kind": "ignore"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashGlobalItem {#entity-DashGlobalItem}

{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [DashTabControlItem](#entity-DashTabControlItem)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "control",
    "data": {
      "title": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        "example"
      ],
      "backgroundSettings": {
        "color": {}
      },
      "borderRadius": 0.5,
      "autoHeight": true,
      "sourceType": "dataset",
      "source": {
        "datasetId": "example",
        "datasetFieldId": "example",
        "datasetFieldType": "DIMENSION"
      }
    },
    "defaults": {}
  }
  ```

  {% endcut %}

- **Type**: [DashTabGroupControlItem](#entity-DashTabGroupControlItem)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "group_control",
    "data": {
      "autoHeight": true,
      "buttonApply": true,
      "buttonReset": true,
      "showGroupName": true,
      "groupName": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        "example"
      ],
      "updateControlsOnChange": true,
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5,
      "group": [
        {
          "title": "example",
          "impactType": "allTabs",
          "impactTabsIds": [
            null
          ],
          "id": "example",
          "namespace": "default",
          "defaults": {},
          "placementMode": "auto",
          "width": "example",
          "sourceType": "dataset",
          "source": null
        }
      ]
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "namespace": "default",
  "orderId": 0.5,
  "defaultOrderId": 0.5,
  "type": "control",
  "data": {
    "title": "example",
    "impactType": "allTabs",
    "impactTabsIds": [
      "example"
    ],
    "backgroundSettings": {
      "color": null
    },
    "borderRadius": 0.5,
    "autoHeight": true,
    "sourceType": "dataset",
    "source": null
  },
  "defaults": {}
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashTab {#entity-DashTab}

#|
|| **Name** | **Description** ||
||

_aliases_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_default_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[][]

Groups of field names treated as the same parameter.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  [
    "example",
    "example"
  ]
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Field aliases used on the tab.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "default": [
    [
      "example",
      "example"
    ]
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_connections_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashConnection](#entity-DashConnection)[]

Connections between tab items.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "from": "example",
    "to": "example",
    "kind": "ignore"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tab identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_items_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashTabItem](#entity-DashTabItem)[]

Items displayed on the tab.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "text",
    "data": {
      "text": "example",
      "autoHeight": true,
      "background": "example",
      "backgroundSettings": {
        "color": null
      },
      "borderRadius": 0.5
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_layout_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashLayoutItem](#entity-DashLayoutItem)[]

Item layout on the tab.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "i": "example",
    "h": 0.5,
    "w": 0.5,
    "x": 0.5,
    "y": 0.5,
    "parent": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Tab title.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_globalItems_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DashGlobalItem](#entity-DashGlobalItem)[]

Global items visible on the tab.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "namespace": "default",
    "orderId": 0.5,
    "defaultOrderId": 0.5,
    "type": "control",
    "data": {
      "title": "example",
      "impactType": "allTabs",
      "impactTabsIds": [
        null
      ],
      "backgroundSettings": {},
      "borderRadius": 0.5,
      "autoHeight": true,
      "sourceType": "dataset",
      "source": null
    },
    "defaults": {}
  }
]
```

{% endcut %}
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the tab is hidden.
{.table-cell}
||
||

_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_fixedHeaderCollapsedDefault_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the fixed header is collapsed by default.
{.table-cell}
||
||

_isGoldenset_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the tab is the reference tab for the AI assistant.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Tab settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "fixedHeaderCollapsedDefault": true,
  "isGoldenset": true
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "title": "example",
  "hidden": true,
  "items": [
    {
      "id": "example",
      "namespace": "default",
      "orderId": 0.5,
      "defaultOrderId": 0.5,
      "type": "text",
      "data": {
        "text": "example",
        "autoHeight": true,
        "background": null,
        "backgroundSettings": {},
        "borderRadius": 0.5
      }
    }
  ],
  "layout": [
    {
      "i": "example",
      "h": 0.5,
      "w": 0.5,
      "x": 0.5,
      "y": 0.5,
      "parent": "example"
    }
  ],
  "connections": [
    {
      "from": "example",
      "to": "example",
      "kind": "ignore"
    }
  ],
  "aliases": {
    "default": [
      [
        "example",
        "example"
      ]
    ]
  },
  "globalItems": [
    {
      "id": "example",
      "namespace": "default",
      "orderId": 0.5,
      "defaultOrderId": 0.5,
      "type": "control",
      "data": {},
      "defaults": {}
    }
  ],
  "settings": {
    "fixedHeaderCollapsedDefault": true,
    "isGoldenset": true
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashboardV1 {#entity-DashboardV1}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the dashboard was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the dashboard.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_counter_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer

Counter used to generate item identifiers.

_Min value:_{.json-schema-reset .json-schema-assertion} `1`
{.table-cell}
||
||

_salt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Salt used to generate item identifiers.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_schemeVersion_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Dashboard schema version.

_Const:_{.json-schema-reset .json-schema-value} `8`
{.table-cell}
||
||

_settings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_autoupdateInterval_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: number

  _Min value:_{.json-schema-reset .json-schema-assertion} `30`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Automatic refresh interval in seconds.

_Example:_{.json-schema-reset .json-schema-example} `30`
{.table-cell}
||
||

_dependentSelectors_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether selectors can depend on each other.
{.table-cell}
||
||

_expandTOC_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether to expand the table of contents.
{.table-cell}
||
||

_maxConcurrentRequests_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: number

  _Min value:_{.json-schema-reset .json-schema-assertion} `1`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Maximum number of concurrent requests.

_Example:_{.json-schema-reset .json-schema-example} `1`
{.table-cell}
||
||

_silentLoading_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether to suppress the loading indicator.
{.table-cell}
||
||

_aiChatHistoryEnabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether AI chat history is enabled for the dashboard.
{.table-cell}
||
||

_backgroundSettings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_color_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [DashColorByTheme](#entity-DashColorByTheme)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

{% endcut %}

Widget background color in hex.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "light": "example",
  "dark": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Dashboard background settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "color": {
    "light": "example",
    "dark": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_enableAssistant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the Neuroanalyst on a dashboard is enabled.
{.table-cell}
||
||

_globalParams_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: string[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}

{% endcut %}

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Dashboard-wide parameter values.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_hideDashTitle_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to hide the dashboard title.
{.table-cell}
||
||

_hideTabs_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to hide the tab bar.
{.table-cell}
||
||

_loadOnlyVisibleCharts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to load only visible charts.
{.table-cell}
||
||

_loadPriority_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Dashboard loading priority.

_Enum:_{.json-schema-reset .json-schema-value} `charts`, `selectors`
{.table-cell}
||
||

_margins_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown[]

Spacing between dashboard widgets.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  null
]
```

{% endcut %}
{.table-cell}
||
||

_signedGlobalParams_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: string[]

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}

{% endcut %}

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Signed dashboard-wide parameters for secure use cases.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_widgetsSettings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_backgroundSettings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_color_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [DashColorByTheme](#entity-DashColorByTheme)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "light": "example",
    "dark": "example"
  }
  ```

  {% endcut %}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

{% endcut %}

Widget background color in hex.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "light": "example",
  "dark": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Default widget background settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "color": {
    "light": "example",
    "dark": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_borderRadius_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Default widget border radius.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Default visual settings for dashboard widgets.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "borderRadius": 0.5,
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Dashboard settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "autoupdateInterval": 30,
  "maxConcurrentRequests": 1,
  "loadPriority": "charts",
  "silentLoading": true,
  "dependentSelectors": true,
  "globalParams": {},
  "signedGlobalParams": {},
  "hideTabs": true,
  "hideDashTitle": true,
  "expandTOC": true,
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "widgetsSettings": {
    "borderRadius": 0.5,
    "backgroundSettings": {
      "color": null
    }
  },
  "loadOnlyVisibleCharts": true,
  "margins": [
    null
  ],
  "enableAssistant": true,
  "aiChatHistoryEnabled": true
}
```

{% endcut %}
{.table-cell}
||
||

_tabs_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashTab](#entity-DashTab)[]

Dashboard tabs.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "title": "example",
    "hidden": true,
    "items": [
      {
        "id": "example",
        "namespace": "default",
        "orderId": 0.5,
        "defaultOrderId": 0.5,
        "type": "text",
        "data": {}
      }
    ],
    "layout": [
      {
        "i": "example",
        "h": 0.5,
        "w": 0.5,
        "x": 0.5,
        "y": 0.5,
        "parent": "example"
      }
    ],
    "connections": [
      {
        "from": "example",
        "to": "example",
        "kind": "ignore"
      }
    ],
    "aliases": {
      "default": [
        [
          "example",
          "example"
        ]
      ]
    },
    "globalItems": [
      {
        "id": "example",
        "namespace": "default",
        "orderId": 0.5,
        "defaultOrderId": 0.5,
        "type": "control",
        "data": null,
        "defaults": {}
      }
    ],
    "settings": {
      "fixedHeaderCollapsedDefault": true,
      "isGoldenset": true
    }
  }
]
```

{% endcut %}
{.table-cell}
||
||

_accessDescription_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Custom message shown when access is denied.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Deprecated. Use `annotation` from the parent object instead.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_supportDescription_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Custom message shown when contacting support.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Versioned data of the dashboard.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "counter": 1,
  "salt": "example",
  "schemeVersion": 8,
  "tabs": [
    {
      "id": "example",
      "title": "example",
      "hidden": true,
      "items": [
        {}
      ],
      "layout": [
        {
          "i": "example",
          "h": 0.5,
          "w": 0.5,
          "x": 0.5,
          "y": 0.5,
          "parent": "example"
        }
      ],
      "connections": [
        {
          "from": "example",
          "to": "example",
          "kind": "ignore"
        }
      ],
      "aliases": {
        "default": [
          [
            null,
            null
          ]
        ]
      },
      "globalItems": [
        {}
      ],
      "settings": {
        "fixedHeaderCollapsedDefault": true,
        "isGoldenset": true
      }
    }
  ],
  "settings": {
    "autoupdateInterval": 30,
    "maxConcurrentRequests": 1,
    "loadPriority": "charts",
    "silentLoading": true,
    "dependentSelectors": true,
    "globalParams": {},
    "signedGlobalParams": {},
    "hideTabs": true,
    "hideDashTitle": true,
    "expandTOC": true,
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "widgetsSettings": {
      "borderRadius": 0.5,
      "backgroundSettings": {
        "color": null
      }
    },
    "loadOnlyVisibleCharts": true,
    "margins": [
      null
    ],
    "enableAssistant": true,
    "aiChatHistoryEnabled": true
  },
  "supportDescription": "example",
  "accessDescription": "example",
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the dashboard.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the dashboard is hidden.
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Key of the dashboard entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Metadata of the dashboard.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_public_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the dashboard is public.
{.table-cell}
||
||

_publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the published dashboard revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the current dashboard revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the saved dashboard revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Scope of the dashboard entry.

_Const:_{.json-schema-reset .json-schema-value} `dash`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the tenant that owns the dashboard.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the dashboard entry. Always an empty string.

_Const:_{.json-schema-reset .json-schema-value} ``

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the dashboard was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the dashboard.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Schema version of the dashboard.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the workbook containing the dashboard.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Annotation of the dashboard.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Links associated with the dashboard.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_revUpdatedAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Date and time when the current revision was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revUpdatedBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the user who last updated the current revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "annotation": {
    "description": "example"
  },
  "createdAt": "example",
  "createdBy": "example",
  "data": {
    "counter": 1,
    "salt": "example",
    "schemeVersion": 8,
    "tabs": [
      {
        "id": "example",
        "title": "example",
        "hidden": true,
        "items": [
          null
        ],
        "layout": [
          {}
        ],
        "connections": [
          {}
        ],
        "aliases": {
          "default": [
            null
          ]
        },
        "globalItems": [
          null
        ],
        "settings": {
          "fixedHeaderCollapsedDefault": true,
          "isGoldenset": true
        }
      }
    ],
    "settings": {
      "autoupdateInterval": 30,
      "maxConcurrentRequests": 1,
      "loadPriority": "charts",
      "silentLoading": true,
      "dependentSelectors": true,
      "globalParams": {},
      "signedGlobalParams": {},
      "hideTabs": true,
      "hideDashTitle": true,
      "expandTOC": true,
      "backgroundSettings": {
        "color": {}
      },
      "widgetsSettings": {
        "borderRadius": 0.5,
        "backgroundSettings": {
          "color": null
        }
      },
      "loadOnlyVisibleCharts": true,
      "margins": [
        null
      ],
      "enableAssistant": true,
      "aiChatHistoryEnabled": true
    },
    "supportDescription": "example",
    "accessDescription": "example",
    "description": "example"
  },
  "entryId": "example",
  "hidden": true,
  "key": "example",
  "links": {},
  "meta": {},
  "public": true,
  "publishedId": "example",
  "revId": "example",
  "savedId": "example",
  "scope": "dash",
  "tenantId": "example",
  "type": "",
  "updatedAt": "example",
  "updatedBy": "example",
  "revUpdatedAt": "example",
  "revUpdatedBy": "example",
  "version": 1,
  "workbookId": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EntryPermissions {#entity-EntryPermissions}

#|
|| **Name** | **Description** ||
||

_admin_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions for admin.
{.table-cell}
||
||

_edit_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions to edit.
{.table-cell}
||
||

_execute_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions to execute.
{.table-cell}
||
||

_read_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Indicates if there are permissions to read.
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "execute": true,
  "read": true,
  "edit": true,
  "admin": true
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.