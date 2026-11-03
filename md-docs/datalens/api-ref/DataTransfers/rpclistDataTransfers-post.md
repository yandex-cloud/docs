[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [DataTransfers](index.md) > 🚧 [Experimental] List data transfers

<div class="openapi">

# 🚧 [Experimental] List data transfers

<!-- markdownlint-disable-file -->

Returns transfers in the specified collection or the current DataLens tenant.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listDataTransfers
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
  "pageSize": "example",
  "pageToken": "example",
  "filter": [
    "example"
  ]
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Collection to list. When omitted, lists transfers in the current DataLens tenant.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filtering is not supported; only an empty array is accepted.

_Max items:_{.json-schema-reset .json-schema-assertion} `0`

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

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Maximum number of transfers, encoded as a string. The default is 100.

_Pattern:_{.json-schema-reset .json-schema-assertion} `^\d+$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Next-page token from the preceding response.

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
  "transfers": [
    {
      "id": "example",
      "collectionId": "example",
      "cloudEnvironmentId": "example",
      "name": "example",
      "description": "example",
      "createdAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "createdById": "example",
      "updatedAt": {
        "seconds": "example",
        "nanos": 0.5
      },
      "updatedById": "example",
      "status": "TRANSFER_STATUS_UNSPECIFIED",
      "labels": {},
      "config": {
        "source": {},
        "destination": {
          "endpoint": "icebergNamespace",
          "icebergNamespace": {}
        },
        "type": {},
        "tables": [
          "example"
        ]
      }
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for the next page of transfers.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_transfers_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DataTransfer](#entity-DataTransfer)[]

Transfers matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "collectionId": "example",
    "cloudEnvironmentId": "example",
    "name": "example",
    "description": "example",
    "createdAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "createdById": "example",
    "updatedAt": {
      "seconds": "example",
      "nanos": 0.5
    },
    "updatedById": "example",
    "status": "TRANSFER_STATUS_UNSPECIFIED",
    "labels": {},
    "config": {
      "source": {
        "endpoint": "postgresConnection",
        "postgresConnection": {}
      },
      "destination": {
        "endpoint": "icebergNamespace",
        "icebergNamespace": {
          "namespaceId": "example"
        }
      },
      "type": {
        "type": "regular",
        "regular": {}
      },
      "tables": [
        "example"
      ]
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### DataTransferIncrementalTable {#entity-DataTransferIncrementalTable}

#|
|| **Name** | **Description** ||
||

_cursorColumn_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Column used to detect new and changed rows.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_initialState_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Initial cursor value for the first transfer run.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tableName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the source table.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tableNamespace_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Namespace or schema of the source table.

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

### DataTransfer {#entity-DataTransfer}

#|
|| **Name** | **Description** ||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the associated cloud environment.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens collection that contains the transfer.

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

_endpoint_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Destination endpoint type.

_Const:_{.json-schema-reset .json-schema-value} `icebergNamespace`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
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
  "endpoint": "icebergNamespace",
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
{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _endpoint_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source endpoint type.

  _Const:_{.json-schema-reset .json-schema-value} `postgresConnection`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
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

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _database_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source database name.

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

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "endpoint": "postgresConnection",
    "postgresConnection": {
      "connectionId": "example",
      "database": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: object

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

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _database_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source database name.

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
  ||

  _endpoint_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source endpoint type.

  _Const:_{.json-schema-reset .json-schema-value} `clickhouseConnection`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "endpoint": "clickhouseConnection",
    "clickhouseConnection": {
      "connectionId": "example",
      "database": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _endpoint_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source endpoint type.

  _Const:_{.json-schema-reset .json-schema-value} `mysqlConnection`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
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

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _database_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Source database name.

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

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "endpoint": "mysqlConnection",
    "mysqlConnection": {
      "connectionId": "example",
      "database": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

Source connection settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "endpoint": "postgresConnection",
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

_tables_{.json-schema-reset .json-schema-property .json-schema-required}
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

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _regular_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _cronExpression_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Five-field cron expression in UTC.

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _tables_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: [DataTransferIncrementalTable](#entity-DataTransferIncrementalTable)[]

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
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Transfer mode.

  _Const:_{.json-schema-reset .json-schema-value} `regular`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "regular",
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

- **Type**: object

  #|
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
  ||

  _type_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Transfer mode.

  _Const:_{.json-schema-reset .json-schema-value} `oneTime`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "oneTime",
    "oneTime": {}
  }
  ```

  {% endcut %}

{% endcut %}

Transfer mode and its settings.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "regular",
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
|#{.json-schema-properties}

{% endcut %}

Transfer configuration.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "source": {
    "endpoint": "postgresConnection",
    "postgresConnection": {
      "connectionId": "example",
      "database": "example"
    }
  },
  "destination": {
    "endpoint": "icebergNamespace",
    "icebergNamespace": {
      "namespaceId": "example"
    }
  },
  "type": {
    "type": "regular",
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

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
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

Time when the transfer was created.

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

_createdById_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the transfer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the transfer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the transfer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_labels_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: string

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

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the transfer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Current status of the transfer.

_Enum:_{.json-schema-reset .json-schema-value} `TRANSFER_STATUS_UNSPECIFIED`, `CREATING`, `CREATED`, `RUNNING`, `STOPPING`, `STOPPED`, `ERROR`, `SNAPSHOTTING`, `DONE`, `PAUSED`, `PREPARING`, `UNKNOWN`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
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

Time when the transfer was last updated.

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

_updatedById_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the transfer.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "collectionId": "example",
  "cloudEnvironmentId": "example",
  "name": "example",
  "description": "example",
  "createdAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "createdById": "example",
  "updatedAt": {
    "seconds": "example",
    "nanos": 0.5
  },
  "updatedById": "example",
  "status": "TRANSFER_STATUS_UNSPECIFIED",
  "labels": {},
  "config": {
    "source": {
      "endpoint": "postgresConnection",
      "postgresConnection": {
        "connectionId": "example",
        "database": "example"
      }
    },
    "destination": {
      "endpoint": "icebergNamespace",
      "icebergNamespace": {
        "namespaceId": "example"
      }
    },
    "type": {
      "type": "regular",
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

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.