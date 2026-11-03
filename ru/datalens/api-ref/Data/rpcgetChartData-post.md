<div class="openapi">

# 🚧 [Experimental] Get chart data

<!-- markdownlint-disable-file -->

Runs a saved Wizard, QL, or Editor chart with the supplied parameters and returns flat tables. Pivot tables are not supported. Editor charts require Editor.setRawData(). Large integers in Wizard results may lose precision. Limits across all results: 100000 rows, 100000 cells, 1000 tables and 100000 schema columns; up to 800 columns per table. Exceeding a limit returns HTTP 422; results are not truncated.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getChartData
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

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "chartId": "example",
  "params": {}
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_chartId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Saved chart ID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property}
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

Chart parameters, including table pagination. Saved chart settings apply.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

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
  "chartType": "wizard",
  "results": [
    {
      "schema": [
        {}
      ],
      "rows": [
        [
          null
        ]
      ]
    }
  ]
}
```

{% endcut %}

{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [GetWizardChartDataResult](#entity-GetWizardChartDataResult)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "chartType": "wizard",
    "results": [
      {
        "schema": [
          {
            "name": "example",
            "guid": "example",
            "type": "date"
          }
        ],
        "rows": [
          [
            null
          ]
        ]
      }
    ]
  }
  ```

  {% endcut %}

- **Type**: [GetQLChartDataResult](#entity-GetQLChartDataResult)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "chartType": "ql",
    "results": [
      {
        "schema": [
          {
            "name": "example",
            "type": "example"
          }
        ],
        "rows": [
          [
            null
          ]
        ]
      }
    ]
  }
  ```

  {% endcut %}

- **Type**: [GetEditorChartDataResult](#entity-GetEditorChartDataResult)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "chartType": "editor",
    "results": [
      {
        "schema": [
          {
            "name": "example"
          }
        ],
        "rows": [
          [
            null
          ]
        ]
      }
    ]
  }
  ```

  {% endcut %}

{% endcut %}

</div>

<div class="openapi-entity">

### GetWizardChartDataResult {#entity-GetWizardChartDataResult}

#|
|| **Name** | **Description** ||
||

_chartType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `wizard`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_results_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_rows_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown[][]

Values ordered according to schema.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  [
    null
  ]
]
```

{% endcut %}
{.table-cell}
||
||

_schema_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `date`, `genericdatetime`, `datetimetz`, `integer`, `uinteger`, `string`, `float`, `boolean`, `geopoint`, `geopolygon`, `markup`, `heatmap`, `array_int`, `array_float`, `array_str`, `unsupported`, `hierarchy`, `tree_str`, `tree_int`, `tree_float`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field GUID, when provided by the source.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Columns in row value order.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "name": "example",
    "guid": "example",
    "type": "date"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Tables in query and block order. Results with different schemas are returned separately.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "schema": [
      {
        "name": "example",
        "guid": "example",
        "type": "date"
      }
    ],
    "rows": [
      [
        null
      ]
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "chartType": "wizard",
  "results": [
    {
      "schema": [
        {
          "name": "example",
          "guid": "example",
          "type": "date"
        }
      ],
      "rows": [
        [
          null
        ]
      ]
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GetQLChartDataResult {#entity-GetQLChartDataResult}

#|
|| **Name** | **Description** ||
||

_chartType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ql`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_results_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_rows_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown[][]

Values ordered according to schema.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  [
    null
  ]
]
```

{% endcut %}
{.table-cell}
||
||

_schema_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

QL value type, for example "number" or "string". Numeric values may be returned as strings.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Columns in row value order.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "name": "example",
    "type": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Tables in query and block order. Results with different schemas are returned separately.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "schema": [
      {
        "name": "example",
        "type": "example"
      }
    ],
    "rows": [
      [
        null
      ]
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "chartType": "ql",
  "results": [
    {
      "schema": [
        {
          "name": "example",
          "type": "example"
        }
      ],
      "rows": [
        [
          null
        ]
      ]
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GetEditorChartDataResult {#entity-GetEditorChartDataResult}

#|
|| **Name** | **Description** ||
||

_chartType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `editor`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_results_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_rows_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown[][]

Values ordered according to schema.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  [
    null
  ]
]
```

{% endcut %}
{.table-cell}
||
||

_schema_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Columns in row value order.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "name": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Tables in query and block order. Results with different schemas are returned separately.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "schema": [
      {
        "name": "example"
      }
    ],
    "rows": [
      [
        null
      ]
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "chartType": "editor",
  "results": [
    {
      "schema": [
        {
          "name": "example"
        }
      ],
      "rows": [
        [
          null
        ]
      ]
    }
  ]
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.