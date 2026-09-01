[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Data](index.md) > 🚧 [Experimental] Get dataset data

<div class="openapi">

# 🚧 [Experimental] Get dataset data

<!-- markdownlint-disable-file -->

Returns up to `limit` rows from the specified dataset. If `sort` is omitted, neither the row order nor the subset selected by `limit` is guaranteed and may change between requests. Every field used in `sort` must also be included in `columns`. An `offset` greater than zero requires a non-empty `sort`. For stable pagination, sorting should define a total order; add tie-breaking fields when sort values may repeat.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getDatasetData
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
  "datasetId": "example",
  "workbookId": "example",
  "columns": [
    "example"
  ],
  "filters": [
    {
      "guid": "example",
      "operation": "in",
      "values": [
        "example"
      ]
    }
  ],
  "params": [
    {
      "guid": "example",
      "value": "example"
    }
  ],
  "sort": [
    {
      "guid": "example",
      "direction": "asc"
    }
  ],
  "limit": 1,
  "offset": 0
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_columns_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Dataset field GUIDs to return.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

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

_datasetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset ID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_guid_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset field GUID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operation_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Filter operation.

_Enum:_{.json-schema-reset .json-schema-value} `in`, `nin`, `isnull`, `isnotnull`, `between`, `eq`, `ne`, `gt`, `lt`, `gte`, `lte`, `istartswith`, `startswith`, `iendswith`, `endswith`, `icontains`, `contains`, `noticontains`, `notcontains`, `leneq`, `lenne`, `lengt`, `lengte`, `lenlt`, `lenlte`
{.table-cell}
||
||

_values_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: array" %}

{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: number

- **Type**: boolean

{% endcut %}

{% endcut %}

Filter values; the required count depends on the operation.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Filters to apply.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "guid": "example",
    "operation": "in",
    "values": [
      "example"
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Maximum number of rows to return. Defaults to 100. Without sort, the selected rows and their order are not guaranteed.

_Min value:_{.json-schema-reset .json-schema-assertion} `1`

_Max value:_{.json-schema-reset .json-schema-assertion} `100000`
{.table-cell}
||
||

_offset_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Number of rows to skip. Values greater than zero require a non-empty sort.

_Min value:_{.json-schema-reset .json-schema-assertion} `0`
{.table-cell}
||
||

_params_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_guid_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset parameter GUID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_value_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: number

- **Type**: boolean

{% endcut %}

Parameter value.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Dataset parameter values.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "guid": "example",
    "value": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_sort_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_direction_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Sort direction.

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset field GUID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Sorting rules. Use a unique tie-breaking field to make pagination deterministic.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "guid": "example",
    "direction": "asc"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Workbook ID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
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
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_rows_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown[][]

Rows with values ordered according to schema.

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

_guid_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset field GUID.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset field name.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Dataset field data type.

_Enum:_{.json-schema-reset .json-schema-value} `date`, `genericdatetime`, `datetimetz`, `integer`, `uinteger`, `string`, `float`, `boolean`, `geopoint`, `geopolygon`, `markup`, `heatmap`, `array_int`, `array_float`, `array_str`, `unsupported`, `hierarchy`, `tree_str`, `tree_int`, `tree_float`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Returned columns in row value order.

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

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.