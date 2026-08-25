[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Reports](index.md) > Create report

<div class="openapi">

# Create report

<!-- markdownlint-disable-file -->

Creates a new report.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createReport
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
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "data": {
    "counter": 1,
    "salt": "example",
    "version": 1,
    "slides": [
      {
        "id": "example"
      }
    ],
    "slideGroups": [
      {
        "id": "example",
        "items": [
          null
        ],
        "layout": [
          null
        ],
        "aliases": {},
        "connections": [
          null
        ]
      }
    ],
    "slidesOrder": [
      "example"
    ],
    "visualSettings": {
      "backgroundColor": "example",
      "backgroundSettings": {
        "color": null
      },
      "borderRadius": 0.5,
      "widgetsSettings": {
        "borderRadius": 0.5,
        "internalMarginsEnabled": true
      },
      "theme": "example",
      "contrast": "example",
      "format": "example",
      "orientation": "example",
      "displayVisualGrid": "example",
      "displayDefaultFooter": "example",
      "footerText": "example",
      "displayLink": "example",
      "footerLink": "example",
      "displayOnFirstPage": "example",
      "displayPageNumber": "example"
    },
    "slideSettings": {},
    "settings": {
      "enableAssistant": true,
      "dependentSelectors": true,
      "loadOnlyVisibleCharts": true
    },
    "supportDescription": "example",
    "accessDescription": "example"
  },
  "meta": {},
  "annotation": {
    "description": "example"
  },
  "includePermissions": true,
  "key": "example",
  "workbookId": "example",
  "name": "example"
}
```

{% endcut %}

{% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

- {% cut "**Type**: object" %}

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [ReportData](#entity-ReportData)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "counter": 1,
    "salt": "example",
    "version": 1,
    "slides": [
      {
        "id": "example"
      }
    ],
    "slideGroups": [
      {
        "id": "example",
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
        "aliases": {
          "default": [
            [
              null,
              null
            ]
          ]
        },
        "connections": [
          {
            "from": "example",
            "to": "example",
            "kind": "ignore"
          }
        ]
      }
    ],
    "slidesOrder": [
      "example"
    ],
    "visualSettings": {
      "backgroundColor": "example",
      "backgroundSettings": {
        "color": {
          "light": "example",
          "dark": "example"
        }
      },
      "borderRadius": 0.5,
      "widgetsSettings": {
        "borderRadius": 0.5,
        "internalMarginsEnabled": true
      },
      "theme": "example",
      "contrast": "example",
      "format": "example",
      "orientation": "example",
      "displayVisualGrid": "example",
      "displayDefaultFooter": "example",
      "footerText": "example",
      "displayLink": "example",
      "footerLink": "example",
      "displayOnFirstPage": "example",
      "displayPageNumber": "example"
    },
    "slideSettings": {},
    "settings": {
      "enableAssistant": true,
      "dependentSelectors": true,
      "loadOnlyVisibleCharts": true
    },
    "supportDescription": "example",
    "accessDescription": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _meta_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DashMeta](#entity-DashMeta)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {}
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _annotation_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: [EntryAnnotationArg](#entity-EntryAnnotationArg)

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

  _includePermissions_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: boolean
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "data": {
      "counter": 1,
      "salt": "example",
      "version": 1,
      "slides": [
        {
          "id": "example"
        }
      ],
      "slideGroups": [
        {
          "id": "example",
          "items": [
            null
          ],
          "layout": [
            {}
          ],
          "aliases": {
            "default": [
              null
            ]
          },
          "connections": [
            {}
          ]
        }
      ],
      "slidesOrder": [
        "example"
      ],
      "visualSettings": {
        "backgroundColor": "example",
        "backgroundSettings": {
          "color": {}
        },
        "borderRadius": 0.5,
        "widgetsSettings": {
          "borderRadius": 0.5,
          "internalMarginsEnabled": true
        },
        "theme": "example",
        "contrast": "example",
        "format": "example",
        "orientation": "example",
        "displayVisualGrid": "example",
        "displayDefaultFooter": "example",
        "footerText": "example",
        "displayLink": "example",
        "footerLink": "example",
        "displayOnFirstPage": "example",
        "displayPageNumber": "example"
      },
      "slideSettings": {},
      "settings": {
        "enableAssistant": true,
        "dependentSelectors": true,
        "loadOnlyVisibleCharts": true
      },
      "supportDescription": "example",
      "accessDescription": "example"
    },
    "meta": {},
    "annotation": {
      "description": "example"
    },
    "includePermissions": true
  }
  ```

  {% endcut %}

- **Type**: [EntryLocationIdentifiers](#entity-EntryLocationIdentifiers)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "key": "example",
    "workbookId": "example",
    "name": "example"
  }
  ```

  {% endcut %}

{% endcut %}

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

### ReportData {#entity-ReportData}

#|
|| **Name** | **Description** ||
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

_slideGroups_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
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

Field aliases used in the slide group.

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

Connections between slide group items.

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

Slide group identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_items_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: array" %}

{% cut "**One of 7 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

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
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property .json-schema-required}
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

  {% endcut %}

  Deprecated. Use backgroundSettings instead.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "enabled": true,
    "color": "example"
  }
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
    "background": {
      "enabled": true,
      "color": "example"
    },
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
      "background": {
        "enabled": true,
        "color": "example"
      },
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

- **Type**: object

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

  _background_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property .json-schema-required}
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

  {% endcut %}

  Deprecated. Use backgroundSettings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "enabled": true,
    "color": "example"
  }
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
    "background": {
      "enabled": true,
      "color": "example"
    },
    "backgroundSettings": {
      "color": null
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
      "background": {
        "enabled": true,
        "color": "example"
      },
      "backgroundSettings": {
        "color": null
      },
      "borderRadius": 0.5
    }
  }
  ```

  {% endcut %}

- **Type**: object

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

  _background_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _color_{.json-schema-reset .json-schema-property .json-schema-required}
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

  {% endcut %}

  Deprecated. Use backgroundSettings in data instead.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "enabled": true,
    "color": "example"
  }
  ```

  {% endcut %}
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

  Report widget tabs.

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
      "enableActionParams": true,
      "background": {
        "enabled": true,
        "color": "example"
      }
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
        "enableActionParams": true,
        "background": {
          "enabled": true,
          "color": "example"
        }
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
          "enableActionParams": true,
          "background": {
            "enabled": true,
            "color": "example"
          }
        }
      ]
    }
  }
  ```

  {% endcut %}

- **Type**: object

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

- **Type**: object

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

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
  |#{.json-schema-properties}

  {% endcut %}

  Control item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "title": "example",
    "sourceType": "external",
    "source": {
      "chartId": "example"
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
      "sourceType": "external",
      "source": {
        "chartId": "example"
      }
    },
    "defaults": {}
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _data_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
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
  {% cut "**Type**: array" %}

  {% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: object

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

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "title": "example",
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

  - **Type**: object

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

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "title": "example",
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

  {% endcut %}

  Controls in the group.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    {
      "title": "example",
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

  _groupName_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Control group name.

  _Example:_{.json-schema-reset .json-schema-example} `example`
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

  {% endcut %}

  Control group item data.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "autoHeight": true,
    "buttonApply": true,
    "buttonReset": true,
    "showGroupName": true,
    "groupName": "example",
    "updateControlsOnChange": true,
    "group": [
      {
        "title": "example",
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
      "updateControlsOnChange": true,
      "group": [
        {
          "title": "example",
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

- **Type**: object

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

{% endcut %}

{% endcut %}

Items in the slide group.

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
      "background": {
        "enabled": true,
        "color": "example"
      },
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

Item layout in the slide group.

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
|#{.json-schema-properties}

{% endcut %}

Slide groups in the report.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
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
    "aliases": {
      "default": [
        [
          "example",
          "example"
        ]
      ]
    },
    "connections": [
      {
        "from": "example",
        "to": "example",
        "kind": "ignore"
      }
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
||

_slides_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Slide identifier.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Report slides.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_slideSettings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_backgroundColor_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Legacy report background color.

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

Report background settings.

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

Legacy widget border radius.
{.table-cell}
||
||

_contrast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Report contrast level.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayDefaultFooter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the default footer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayLink_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the footer link.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayOnFirstPage_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the footer on the first page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayPageNumber_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show page numbers.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayVisualGrid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the visual grid.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_footerLink_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Footer link URL.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_footerText_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Custom footer text.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_format_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Page format.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_orientation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Page orientation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_theme_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Report theme.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_widgetsSettings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_borderRadius_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Default widget border radius.
{.table-cell}
||
||

_internalMarginsEnabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether widgets include internal margins.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Default visual settings for report widgets.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "borderRadius": 0.5,
  "internalMarginsEnabled": true
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "backgroundColor": "example",
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "borderRadius": 0.5,
  "widgetsSettings": {
    "borderRadius": 0.5,
    "internalMarginsEnabled": true
  },
  "theme": "example",
  "contrast": "example",
  "format": "example",
  "orientation": "example",
  "displayVisualGrid": "example",
  "displayDefaultFooter": "example",
  "footerText": "example",
  "displayLink": "example",
  "footerLink": "example",
  "displayOnFirstPage": "example",
  "displayPageNumber": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Visual settings keyed by slide identifier.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_slidesOrder_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Slide identifiers in display order.

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

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Report schema version.

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_visualSettings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_backgroundColor_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Legacy report background color.

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

Report background settings.

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

Legacy widget border radius.
{.table-cell}
||
||

_contrast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Report contrast level.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayDefaultFooter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the default footer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayLink_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the footer link.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayOnFirstPage_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the footer on the first page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayPageNumber_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show page numbers.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_displayVisualGrid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Whether to show the visual grid.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_footerLink_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Footer link URL.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_footerText_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Custom footer text.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_format_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Page format.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_orientation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Page orientation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_theme_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Report theme.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_widgetsSettings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_borderRadius_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Default widget border radius.
{.table-cell}
||
||

_internalMarginsEnabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether widgets include internal margins.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Default visual settings for report widgets.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "borderRadius": 0.5,
  "internalMarginsEnabled": true
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Default report visual settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "backgroundColor": "example",
  "backgroundSettings": {
    "color": {
      "light": "example",
      "dark": "example"
    }
  },
  "borderRadius": 0.5,
  "widgetsSettings": {
    "borderRadius": 0.5,
    "internalMarginsEnabled": true
  },
  "theme": "example",
  "contrast": "example",
  "format": "example",
  "orientation": "example",
  "displayVisualGrid": "example",
  "displayDefaultFooter": "example",
  "footerText": "example",
  "displayLink": "example",
  "footerLink": "example",
  "displayOnFirstPage": "example",
  "displayPageNumber": "example"
}
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

_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_dependentSelectors_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether selectors can depend on each other.
{.table-cell}
||
||

_enableAssistant_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the report assistant is enabled.
{.table-cell}
||
||

_loadOnlyVisibleCharts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to load only visible charts.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Report behavior settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "enableAssistant": true,
  "dependentSelectors": true,
  "loadOnlyVisibleCharts": true
}
```

{% endcut %}
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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "counter": 1,
  "salt": "example",
  "version": 1,
  "slides": [
    {
      "id": "example"
    }
  ],
  "slideGroups": [
    {
      "id": "example",
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
      "aliases": {
        "default": [
          [
            null,
            null
          ]
        ]
      },
      "connections": [
        {
          "from": "example",
          "to": "example",
          "kind": "ignore"
        }
      ]
    }
  ],
  "slidesOrder": [
    "example"
  ],
  "visualSettings": {
    "backgroundColor": "example",
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "widgetsSettings": {
      "borderRadius": 0.5,
      "internalMarginsEnabled": true
    },
    "theme": "example",
    "contrast": "example",
    "format": "example",
    "orientation": "example",
    "displayVisualGrid": "example",
    "displayDefaultFooter": "example",
    "footerText": "example",
    "displayLink": "example",
    "footerLink": "example",
    "displayOnFirstPage": "example",
    "displayPageNumber": "example"
  },
  "slideSettings": {},
  "settings": {
    "enableAssistant": true,
    "dependentSelectors": true,
    "loadOnlyVisibleCharts": true
  },
  "supportDescription": "example",
  "accessDescription": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DashMeta {#entity-DashMeta}

**Type**: object | null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EntryAnnotationArg {#entity-EntryAnnotationArg}

#|
|| **Name** | **Description** ||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EntryLocationIdentifiers {#entity-EntryLocationIdentifiers}

#|
|| **Name** | **Description** ||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Entry key when creating the entry in a folder.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Entry name when creating the entry in a workbook.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the workbook where the entry should be created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "key": "example",
  "workbookId": "example",
  "name": "example"
}
```

{% endcut %}

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
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "revUpdatedBy": "example",
    "revUpdatedAt": "example",
    "data": {
      "counter": 1,
      "salt": "example",
      "version": 1,
      "slides": [
        {
          "id": "example"
        }
      ],
      "slideGroups": [
        {
          "id": "example",
          "items": [
            null
          ],
          "layout": [
            null
          ],
          "aliases": {},
          "connections": [
            null
          ]
        }
      ],
      "slidesOrder": [
        "example"
      ],
      "visualSettings": {
        "backgroundColor": "example",
        "backgroundSettings": {
          "color": null
        },
        "borderRadius": 0.5,
        "widgetsSettings": {
          "borderRadius": 0.5,
          "internalMarginsEnabled": true
        },
        "theme": "example",
        "contrast": "example",
        "format": "example",
        "orientation": "example",
        "displayVisualGrid": "example",
        "displayDefaultFooter": "example",
        "footerText": "example",
        "displayLink": "example",
        "footerLink": "example",
        "displayOnFirstPage": "example",
        "displayPageNumber": "example"
      },
      "slideSettings": {},
      "settings": {
        "enableAssistant": true,
        "dependentSelectors": true,
        "loadOnlyVisibleCharts": true
      },
      "supportDescription": "example",
      "accessDescription": "example"
    },
    "entryId": "example",
    "key": "example",
    "scope": "report",
    "hidden": true,
    "meta": {},
    "publishedId": "example",
    "savedId": "example",
    "revId": "example",
    "tenantId": "example",
    "type": "",
    "workbookId": "example",
    "collectionId": "example",
    "version": 1,
    "public": false,
    "links": {}
  },
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
**Type**: [ReportV1](#entity-ReportV1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "annotation": {
    "description": "example"
  },
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "revUpdatedBy": "example",
  "revUpdatedAt": "example",
  "data": {
    "counter": 1,
    "salt": "example",
    "version": 1,
    "slides": [
      {
        "id": "example"
      }
    ],
    "slideGroups": [
      {
        "id": "example",
        "items": [
          null
        ],
        "layout": [
          {}
        ],
        "aliases": {
          "default": [
            null
          ]
        },
        "connections": [
          {}
        ]
      }
    ],
    "slidesOrder": [
      "example"
    ],
    "visualSettings": {
      "backgroundColor": "example",
      "backgroundSettings": {
        "color": {}
      },
      "borderRadius": 0.5,
      "widgetsSettings": {
        "borderRadius": 0.5,
        "internalMarginsEnabled": true
      },
      "theme": "example",
      "contrast": "example",
      "format": "example",
      "orientation": "example",
      "displayVisualGrid": "example",
      "displayDefaultFooter": "example",
      "footerText": "example",
      "displayLink": "example",
      "footerLink": "example",
      "displayOnFirstPage": "example",
      "displayPageNumber": "example"
    },
    "slideSettings": {},
    "settings": {
      "enableAssistant": true,
      "dependentSelectors": true,
      "loadOnlyVisibleCharts": true
    },
    "supportDescription": "example",
    "accessDescription": "example"
  },
  "entryId": "example",
  "key": "example",
  "scope": "report",
  "hidden": true,
  "meta": {},
  "publishedId": "example",
  "savedId": "example",
  "revId": "example",
  "tenantId": "example",
  "type": "",
  "workbookId": "example",
  "collectionId": "example",
  "version": 1,
  "public": false,
  "links": {}
}
```

{% endcut %}
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

### EntryAnnotation {#entity-EntryAnnotation}

**Type**: object | null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ReportV1 {#entity-ReportV1}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ReportData](#entity-ReportData)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "counter": 1,
  "salt": "example",
  "version": 1,
  "slides": [
    {
      "id": "example"
    }
  ],
  "slideGroups": [
    {
      "id": "example",
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
      "aliases": {
        "default": [
          [
            null,
            null
          ]
        ]
      },
      "connections": [
        {
          "from": "example",
          "to": "example",
          "kind": "ignore"
        }
      ]
    }
  ],
  "slidesOrder": [
    "example"
  ],
  "visualSettings": {
    "backgroundColor": "example",
    "backgroundSettings": {
      "color": {
        "light": "example",
        "dark": "example"
      }
    },
    "borderRadius": 0.5,
    "widgetsSettings": {
      "borderRadius": 0.5,
      "internalMarginsEnabled": true
    },
    "theme": "example",
    "contrast": "example",
    "format": "example",
    "orientation": "example",
    "displayVisualGrid": "example",
    "displayDefaultFooter": "example",
    "footerText": "example",
    "displayLink": "example",
    "footerLink": "example",
    "displayOnFirstPage": "example",
    "displayPageNumber": "example"
  },
  "slideSettings": {},
  "settings": {
    "enableAssistant": true,
    "dependentSelectors": true,
    "loadOnlyVisibleCharts": true
  },
  "supportDescription": "example",
  "accessDescription": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DashMeta](#entity-DashMeta)

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

_Const:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `report`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} ``

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

_Const:_{.json-schema-reset .json-schema-value} `1`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryAnnotation](#entity-EntryAnnotation)

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

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revUpdatedBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

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
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "revUpdatedBy": "example",
  "revUpdatedAt": "example",
  "data": {
    "counter": 1,
    "salt": "example",
    "version": 1,
    "slides": [
      {
        "id": "example"
      }
    ],
    "slideGroups": [
      {
        "id": "example",
        "items": [
          null
        ],
        "layout": [
          {}
        ],
        "aliases": {
          "default": [
            null
          ]
        },
        "connections": [
          {}
        ]
      }
    ],
    "slidesOrder": [
      "example"
    ],
    "visualSettings": {
      "backgroundColor": "example",
      "backgroundSettings": {
        "color": {}
      },
      "borderRadius": 0.5,
      "widgetsSettings": {
        "borderRadius": 0.5,
        "internalMarginsEnabled": true
      },
      "theme": "example",
      "contrast": "example",
      "format": "example",
      "orientation": "example",
      "displayVisualGrid": "example",
      "displayDefaultFooter": "example",
      "footerText": "example",
      "displayLink": "example",
      "footerLink": "example",
      "displayOnFirstPage": "example",
      "displayPageNumber": "example"
    },
    "slideSettings": {},
    "settings": {
      "enableAssistant": true,
      "dependentSelectors": true,
      "loadOnlyVisibleCharts": true
    },
    "supportDescription": "example",
    "accessDescription": "example"
  },
  "entryId": "example",
  "key": "example",
  "scope": "report",
  "hidden": true,
  "meta": {},
  "publishedId": "example",
  "savedId": "example",
  "revId": "example",
  "tenantId": "example",
  "type": "",
  "workbookId": "example",
  "collectionId": "example",
  "version": 1,
  "public": false,
  "links": {}
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