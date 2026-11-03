<div class="openapi">

# 🚧 [Experimental] Create data transfer

<!-- markdownlint-disable-file -->

Creates a transfer and returns an asynchronous operation. Use getLakehouseOperation to track completion.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createDataTransfer
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
  "collectionId": "example",
  "name": "example",
  "description": "example",
  "labels": {},
  "config": {
    "source": {
      "postgresConnection": {
        "connectionId": "example",
        "database": "example"
      }
    },
    "destination": {
      "icebergNamespace": {
        "namespaceId": "example"
      }
    },
    "type": {
      "regular": {
        "cronExpression": "example",
        "tables": [
          null
        ]
      }
    },
    "tables": [
      "example"
    ]
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens collection in which to create the transfer.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_config_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_destination_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_icebergNamespace_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_namespaceId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the destination Iceberg namespace.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Iceberg destination namespace settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "namespaceId": "example"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Destination settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "icebergNamespace": {
    "namespaceId": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataTransferSourceArgs](#entity-DataTransferSourceArgs)

Exactly one source connection.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "postgresConnection": {
    "connectionId": "example",
    "database": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataTransferTypeArgs](#entity-DataTransferTypeArgs)

Exactly one transfer mode: regular or one-time.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "regular": {
    "cronExpression": "example",
    "tables": [
      {
        "tableNamespace": "example",
        "tableName": "example",
        "cursorColumn": "example",
        "initialState": "example"
      }
    ]
  }
}
```

{% endcut %}
{.table-cell}
||
||

_tables_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Source tables to transfer.

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

Transfer configuration.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "source": {
    "postgresConnection": {
      "connectionId": "example",
      "database": "example"
    }
  },
  "destination": {
    "icebergNamespace": {
      "namespaceId": "example"
    }
  },
  "type": {
    "regular": {
      "cronExpression": "example",
      "tables": [
        {}
      ]
    }
  },
  "tables": [
    "example"
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the transfer.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `63`

_Pattern:_{.json-schema-reset .json-schema-assertion} `^[a-zA-Z0-9_-]+$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the transfer.

_Max length:_{.json-schema-reset .json-schema-assertion} `256`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_labels_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: string

_Max length:_{.json-schema-reset .json-schema-assertion} `63`

_Pattern:_{.json-schema-reset .json-schema-assertion} `^[-_0-9a-z]*$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Transfer labels.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DataTransferSourceArgs {#entity-DataTransferSourceArgs}

Exactly one source connection.

{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

- {% cut "**Type**: object" %}

  #|
  ||

  _postgresConnection_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _connectionId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the source DataLens connection.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _database_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source database name.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  PostgreSQL source connection settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connectionId": "example",
    "database": "example"
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
    "postgresConnection": {
      "connectionId": "example",
      "database": "example"
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _clickhouseConnection_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _connectionId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the source DataLens connection.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _database_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source database name.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  ClickHouse source connection settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connectionId": "example",
    "database": "example"
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
    "clickhouseConnection": {
      "connectionId": "example",
      "database": "example"
    }
  }
  ```

  {% endcut %}

- {% cut "**Type**: object" %}

  #|
  ||

  _mysqlConnection_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _connectionId_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  ID of the source DataLens connection.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _database_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source database name.

  _Min length:_{.json-schema-reset .json-schema-assertion} `1`

  _Max length:_{.json-schema-reset .json-schema-assertion} `50`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  MySQL source connection settings.

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connectionId": "example",
    "database": "example"
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
    "mysqlConnection": {
      "connectionId": "example",
      "database": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "postgresConnection": {
    "connectionId": "example",
    "database": "example"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataTransferIncrementalTableArgs {#entity-DataTransferIncrementalTableArgs}

#|
|| **Name** | **Description** ||
||

_tableName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the source table.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tableNamespace_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Namespace or schema of the source table.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cursorColumn_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Column used to detect new and changed rows.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_initialState_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Initial cursor value for the first transfer run.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "tableNamespace": "example",
  "tableName": "example",
  "cursorColumn": "example",
  "initialState": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### RegularDataTransferTypeArgs {#entity-RegularDataTransferTypeArgs}

#|
|| **Name** | **Description** ||
||

_regular_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_cronExpression_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Five-field cron expression in UTC.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tables_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataTransferIncrementalTableArgs](#entity-DataTransferIncrementalTableArgs)[]

Incremental snapshot settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "tableNamespace": "example",
    "tableName": "example",
    "cursorColumn": "example",
    "initialState": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Regular transfer settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cronExpression": "example",
  "tables": [
    {
      "tableNamespace": "example",
      "tableName": "example",
      "cursorColumn": "example",
      "initialState": "example"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "regular": {
    "cronExpression": "example",
    "tables": [
      {
        "tableNamespace": "example",
        "tableName": "example",
        "cursorColumn": "example",
        "initialState": "example"
      }
    ]
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### OneTimeDataTransferTypeArgs {#entity-OneTimeDataTransferTypeArgs}

#|
|| **Name** | **Description** ||
||

_oneTime_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
|#{.json-schema-properties}

{% endcut %}

One-time transfer settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "oneTime": {}
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataTransferTypeArgs {#entity-DataTransferTypeArgs}

Exactly one transfer mode: regular or one-time.

{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [RegularDataTransferTypeArgs](#entity-RegularDataTransferTypeArgs)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "regular": {
      "cronExpression": "example",
      "tables": [
        {
          "tableNamespace": "example",
          "tableName": "example",
          "cursorColumn": "example",
          "initialState": "example"
        }
      ]
    }
  }
  ```

  {% endcut %}

- **Type**: [OneTimeDataTransferTypeArgs](#entity-OneTimeDataTransferTypeArgs)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "oneTime": {}
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "regular": {
    "cronExpression": "example",
    "tables": [
      {
        "tableNamespace": "example",
        "tableName": "example",
        "cursorColumn": "example",
        "initialState": "example"
      }
    ]
  }
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
  "id": "example",
  "description": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "createdBy": "example",
  "modifiedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "done": true,
  "metadata": {},
  "error": {
    "code": 0.5,
    "message": "example",
    "details": [
      null
    ]
  },
  "response": {}
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_done_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the operation has completed.
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique ID of the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_metadata_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Service-specific operation metadata.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_seconds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Number of seconds since the Unix epoch.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nanos_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Fractional seconds in nanoseconds.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Time when the operation was created.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the operation creator.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the operation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_error_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_code_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: number

Operation error code.
{.table-cell}
||
||

_message_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Operation error message.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_details_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown[]

Additional operation error details.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  null
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Operation error, if the operation failed.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "code": 0.5,
  "message": "example",
  "details": [
    null
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_modifiedAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_seconds_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Number of seconds since the Unix epoch.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nanos_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Fractional seconds in nanoseconds.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Time when the operation was last modified.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "seconds": "example",
  "nanos": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_response_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Service-specific operation response.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.