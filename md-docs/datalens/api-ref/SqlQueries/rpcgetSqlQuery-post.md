[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [SqlQueries](index.md) > 🚧 [Experimental] Get SQL query

<div class="openapi">

# 🚧 [Experimental] Get SQL query

<!-- markdownlint-disable-file -->

Returns the specified saved SQL query.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getSqlQuery
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
  "revId": "example",
  "includePermissions": true,
  "includeFavorite": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_sqlQueryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the SQL query to retrieve.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_includeFavorite_{.json-schema-reset .json-schema-property .json-schema-deprecated}_[ ](*Deprecated)_{.openapi-deprecated .openapi-deprecated-compact}
{.table-cell}|
**Type**: boolean

Whether to include the favorite status. Deprecated: the parameter will be removed in a future API version.
{.table-cell}
||
||

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to include SQL query permissions.
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the SQL query revision to retrieve.

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
  "entry": {
    "entryId": "example",
    "scope": "sql_query",
    "type": "example",
    "key": "example",
    "workbookId": "example",
    "collectionId": "example",
    "revId": "example",
    "savedId": "example",
    "publishedId": "example",
    "data": {
      "connectionId": "example",
      "query": "example",
      "statementPositions": [
        [
          null
        ]
      ],
      "params": [
        {}
      ]
    },
    "annotation": {
      "description": "example"
    },
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "revUpdatedBy": "example",
    "revUpdatedAt": "example",
    "tenantId": "example",
    "hidden": true,
    "version": 0.5,
    "links": {}
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
**Type**: [SqlQuery](#entity-SqlQuery)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "entryId": "example",
  "scope": "sql_query",
  "type": "example",
  "key": "example",
  "workbookId": "example",
  "collectionId": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "data": {
    "connectionId": "example",
    "query": "example",
    "statementPositions": [
      [
        null
      ]
    ],
    "params": [
      {
        "name": "example"
      }
    ]
  },
  "annotation": {
    "description": "example"
  },
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "revUpdatedBy": "example",
  "revUpdatedAt": "example",
  "tenantId": "example",
  "hidden": true,
  "version": 0.5,
  "links": {}
}
```

{% endcut %}
{.table-cell}
||
||

_isFavorite_{.json-schema-reset .json-schema-property .json-schema-deprecated}_[ ](*Deprecated)_{.openapi-deprecated .openapi-deprecated-compact}
{.table-cell}|
**Type**: boolean

Whether the SQL query is a favorite. Deprecated: the field will be removed in a future API version.
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
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

{% endcut %}

Permissions for the SQL query.

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

### SqlQuery {#entity-SqlQuery}

#|
|| **Name** | **Description** ||
||

_annotation_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Annotation of the SQL query.

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

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the collection containing the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the SQL query was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_connectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the connection.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_query_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Text of the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_statementPositions_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: unknown[][]

Start and end indexes of the query statements.

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

_params_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: array" %}

{% cut "**All of 2 types**" %}{.json-schema-combinators data-marker=and}

- **Type**: object

  #|
  ||

  _name_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "name": "example"
  }
  ```

  {% endcut %}

- {% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

  - **Type**: object

    #|
    ||

    _type_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `date-interval`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `datetime-interval`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    {% endcut %}

    Type of the parameter.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _defaultValue_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    {% cut "**Type**: object" %}

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

    {% endcut %}

    Default value of the parameter.

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "from": "example",
      "to": "example"
    }
    ```

    {% endcut %}
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "type": "date-interval",
      "defaultValue": {
        "from": "example",
        "to": "example"
      }
    }
    ```

    {% endcut %}

  - **Type**: object

    #|
    ||

    _type_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    {% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `date`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `datetime`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    {% endcut %}

    Type of the parameter.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _defaultValue_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    **Type**: string

    Default value of the parameter.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "type": "date",
      "defaultValue": "example"
    }
    ```

    {% endcut %}

  - **Type**: object

    #|
    ||

    _type_{.json-schema-reset .json-schema-property .json-schema-required}
    {.table-cell}|
    {% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `string`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `number`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    - **Type**: string

      _Const:_{.json-schema-reset .json-schema-value} `boolean`

      _Example:_{.json-schema-reset .json-schema-example} `example`

    {% endcut %}

    Type of the parameter.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    ||

    _defaultValue_{.json-schema-reset .json-schema-property}
    {.table-cell}|
    {% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

    - **Type**: string

      _Example:_{.json-schema-reset .json-schema-example} `example`

    - **Type**: number

    - **Type**: boolean

    {% endcut %}

    Default value of the parameter.

    _Example:_{.json-schema-reset .json-schema-example} `example`
    {.table-cell}
    ||
    |#{.json-schema-properties}

    {% cut "**Example**" %}{.json-schema-example}

    ```json translate=no
    {
      "type": "string",
      "defaultValue": "example"
    }
    ```

    {% endcut %}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "date-interval",
    "defaultValue": {
      "from": "example",
      "to": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% endcut %}

Parameters of the SQL query.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "name": "example",
    "type": "date-interval",
    "defaultValue": {
      "from": "example",
      "to": "example"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Data of the SQL query entry.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connectionId": "example",
  "query": "example",
  "statementPositions": [
    [
      null
    ]
  ],
  "params": [
    {
      "name": "example",
      "type": null,
      "defaultValue": {}
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the SQL query is hidden.
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Key of the SQL query entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_publishedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the published SQL query revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the current SQL query revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_savedId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the saved SQL query revision.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scope_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Scope of the SQL query entry.

_Const:_{.json-schema-reset .json-schema-value} `sql_query`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the tenant that owns the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the SQL query entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the SQL query was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number &#124; null

Schema version of the SQL query.
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the workbook containing the SQL query.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_links_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Links to the entries the SQL query depends on.

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
  "entryId": "example",
  "scope": "sql_query",
  "type": "example",
  "key": "example",
  "workbookId": "example",
  "collectionId": "example",
  "revId": "example",
  "savedId": "example",
  "publishedId": "example",
  "data": {
    "connectionId": "example",
    "query": "example",
    "statementPositions": [
      [
        null
      ]
    ],
    "params": [
      {
        "name": "example"
      }
    ]
  },
  "annotation": {
    "description": "example"
  },
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "revUpdatedBy": "example",
  "revUpdatedAt": "example",
  "tenantId": "example",
  "hidden": true,
  "version": 0.5,
  "links": {}
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.