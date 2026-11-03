<div class="openapi">

# 🚧 [Experimental] Run SQL query

<!-- markdownlint-disable-file -->

Runs the specified saved SQL query and returns its result.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/runSqlQuery
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
  "sqlQueryId": "example",
  "params": {}
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_sqlQueryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the SQL query to run.

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
{% cut "**Any of 5 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`

- **Type**: number

- **Type**: boolean

- {% cut "**Type**: array" %}

  {% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: number

  - **Type**: boolean

  {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    "example"
  ]
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _from_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Start of the interval.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _to_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  End of the interval.

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

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Values of the query parameters, keyed by name. A parameter left out here falls back to its default value.

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
  "id": "example",
  "connectionId": "example",
  "tenantId": "example",
  "status": "success",
  "query": "example",
  "statementPositions": [
    [
      null
    ]
  ],
  "results": [
    {
      "status": "success",
      "columns": [
        {}
      ],
      "rows": [
        [
          null
        ]
      ],
      "hasMoreRows": true,
      "affectedRows": 0.5
    }
  ],
  "createdBy": "example",
  "createdAt": "example",
  "updatedAt": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_connectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the connection the query was executed on.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the query run was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who ran the query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the query run.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_query_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Text of the executed query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_results_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: array" %}

{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _columns_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object[]" %}

  #|
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Name of the column.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  Columns of the statement result. Empty for statements that return no rows.

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
  ||

  _hasMoreRows_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: boolean

  Whether the statement returned more rows than included in `rows`.
  {.table-cell}
  ||
  ||

  _rows_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: array" %}

  {% cut "**Any of 5 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: string

    _Example:_{.json-schema-reset .json-schema-example} `example`

  - **Type**: number

  - **Type**: boolean

  - **Type**: null

    _Example:_{.json-schema-reset .json-schema-example} `null`

  - **Type**: null

    _Example:_{.json-schema-reset .json-schema-example} `null`

  {% endcut %}

  {% endcut %}

  Rows of the statement result, with values in the order of the columns.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  [
    [
      "example"
    ]
  ]
  ```

  {% endcut %}
  {.table-cell}
  ||
  ||

  _status_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Status of the statement.

  _Const:_{.json-schema-reset .json-schema-value} `success`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _affectedRows_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: number

  Number of rows affected by the statement.
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "status": "success",
    "columns": [
      {
        "name": "example"
      }
    ],
    "rows": [
      [
        "example"
      ]
    ],
    "hasMoreRows": true,
    "affectedRows": 0.5
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _code_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Error code.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _message_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Error message.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _status_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Status of the statement.

  _Const:_{.json-schema-reset .json-schema-value} `error`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _databaseMessage_{.json-schema-reset .json-schema-property}
  {.table-cell}|
  **Type**: string

  Message returned by the database.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "status": "error",
    "code": "example",
    "message": "example",
    "databaseMessage": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% endcut %}

Results of the executed statements, in the order of the statements.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "status": "success",
    "columns": [
      {
        "name": "example"
      }
    ],
    "rows": [
      [
        null
      ]
    ],
    "hasMoreRows": true,
    "affectedRows": 0.5
  }
]
```

{% endcut %}
{.table-cell}
||
||

_statementPositions_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown[][]

Start and end indexes of the executed statements.

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

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Status of the query run.

_Enum:_{.json-schema-reset .json-schema-value} `success`, `error`, `pending`, `partial_success`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens tenant.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the query run was updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.