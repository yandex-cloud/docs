<div class="openapi">

# 🚧 [Experimental] Create Spark cluster

<!-- markdownlint-disable-file -->

Creates a Spark cluster and returns an asynchronous operation.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createSparkCluster
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
  "cloudEnvironmentId": "example",
  "name": "example",
  "description": "example",
  "labels": {},
  "config": {
    "sparkVersion": "example",
    "resourcePools": {
      "driver": {
        "resourcePresetId": "example",
        "scalePolicy": {}
      },
      "executor": {
        "resourcePresetId": "example",
        "scalePolicy": {}
      }
    },
    "dependencies": {
      "pipPackages": [
        "example"
      ],
      "debPackages": [
        "example"
      ]
    },
    "logging": {
      "enabled": true
    }
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the cloud environment in which to create the cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens collection in which to create the cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_config_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resourcePools_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_driver_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resourcePresetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Spark resource preset.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scalePolicy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _fixedScale_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _size_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:[1-9]&#124;[1-9]\d&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "size": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "fixedScale": {
      "size": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _autoScale_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _initialSize_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Initial number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0&#124;[1-9]\d?&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _maxSize_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Maximum number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:[1-9]&#124;[1-9]\d&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _minSize_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Minimum number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0&#124;[1-9]\d?&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "minSize": "example",
    "maxSize": "example",
    "initialSize": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "autoScale": {
      "minSize": "example",
      "maxSize": "example",
      "initialSize": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

Resource pool scaling policy.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "fixedScale": {
    "size": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Driver resource pool.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "resourcePresetId": "example",
  "scalePolicy": {
    "fixedScale": {
      "size": "example"
    }
  }
}
```

{% endcut %}
{.table-cell}
||
||

_executor_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resourcePresetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Spark resource preset.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_scalePolicy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: object

  #|
  ||

  _fixedScale_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _size_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:[1-9]&#124;[1-9]\d&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "size": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "fixedScale": {
      "size": "example"
    }
  }
  ```

  {% endcut %}

- **Type**: object

  #|
  ||

  _autoScale_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  {% cut "**Type**: object" %}

  #|
  ||

  _initialSize_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Initial number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0&#124;[1-9]\d?&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _maxSize_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Maximum number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:[1-9]&#124;[1-9]\d&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  ||

  _minSize_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  Minimum number of instances in the resource pool.

  _Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0&#124;[1-9]\d?&#124;100)$`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% endcut %}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "minSize": "example",
    "maxSize": "example",
    "initialSize": "example"
  }
  ```

  {% endcut %}
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "autoScale": {
      "minSize": "example",
      "maxSize": "example",
      "initialSize": "example"
    }
  }
  ```

  {% endcut %}

{% endcut %}

Resource pool scaling policy.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "fixedScale": {
    "size": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Executor resource pool.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "resourcePresetId": "example",
  "scalePolicy": {
    "fixedScale": {
      "size": "example"
    }
  }
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
  "driver": {
    "resourcePresetId": "example",
    "scalePolicy": {
      "fixedScale": {
        "size": "example"
      }
    }
  },
  "executor": {
    "resourcePresetId": "example",
    "scalePolicy": {
      "fixedScale": {
        "size": "example"
      }
    }
  }
}
```

{% endcut %}
{.table-cell}
||
||

_dependencies_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_debPackages_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Debian packages to install in the cluster.

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

_pipPackages_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Python packages to install in the cluster.

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

Packages to install in the cluster.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "pipPackages": [
    "example"
  ],
  "debPackages": [
    "example"
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_logging_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_enabled_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether cluster logging is enabled.
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Cluster logging configuration.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "enabled": true
}
```

{% endcut %}
{.table-cell}
||
||

_sparkVersion_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Spark version. The service default is used when omitted.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "sparkVersion": "example",
  "resourcePools": {
    "driver": {
      "resourcePresetId": "example",
      "scalePolicy": {
        "fixedScale": {}
      }
    },
    "executor": {
      "resourcePresetId": "example",
      "scalePolicy": {
        "fixedScale": {}
      }
    }
  },
  "dependencies": {
    "pipPackages": [
      "example"
    ],
    "debPackages": [
      "example"
    ]
  },
  "logging": {
    "enabled": true
  }
}
```

{% endcut %}
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the Spark cluster.

_Max length:_{.json-schema-reset .json-schema-assertion} `63`

_Pattern:_{.json-schema-reset .json-schema-assertion} `^[a-zA-Z0-9ЁёА-я]\S{1,61}[a-zA-Z0-9ЁёА-я]$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the Spark cluster.

_Max length:_{.json-schema-reset .json-schema-assertion} `200`

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

Spark cluster labels.

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