<div class="openapi">

# 🚧 [Experimental] Update data transfer

<!-- markdownlint-disable-file -->

Updates transfer labels, type or tables according to the update mask and returns an asynchronous operation.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateDataTransfer
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
  "id": "example",
  "updateMask": {
    "paths": [
      "example"
    ]
  },
  "labels": {},
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

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the transfer to update.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

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
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 3 types**" %}{.json-schema-combinators data-marker=or}

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

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

Transfer mode and its settings.

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

_updateMask_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Fields to update.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "paths": [
    "example"
  ]
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

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