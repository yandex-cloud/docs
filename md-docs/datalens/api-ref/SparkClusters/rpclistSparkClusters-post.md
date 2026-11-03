[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [SparkClusters](index.md) > 🚧 [Experimental] List Spark clusters

<div class="openapi">

# 🚧 [Experimental] List Spark clusters

<!-- markdownlint-disable-file -->

Returns a list of Spark clusters available to the current DataLens tenant.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/listSparkClusters
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
  "pageSize": 0,
  "pageToken": "example",
  "filter": [
    "example"
  ],
  "collectionId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_collectionId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the DataLens collection that contains the Spark clusters.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

Filter expressions applied to the Spark cluster list.

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
**Type**: integer

Maximum number of Spark clusters to return. The default is 100.

_Min value:_{.json-schema-reset .json-schema-assertion} `0`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of Spark clusters.

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
  "sparkClusters": [
    {
      "id": "example",
      "clusterId": "example",
      "collectionId": "example",
      "cloudEnvironmentId": "example",
      "name": "example",
      "description": "example",
      "labels": {},
      "config": {
        "sparkVersion": "example",
        "resourcePools": {
          "driver": {},
          "executor": {}
        },
        "dependencies": {
          "pipPackages": [
            null
          ],
          "debPackages": [
            null
          ]
        },
        "logging": {
          "enabled": true
        }
      },
      "health": "HEALTH_UNKNOWN",
      "status": "STATUS_UNSPECIFIED",
      "entryId": "example"
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

Token for the next page of Spark clusters.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sparkClusters_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [SparkCluster](#entity-SparkCluster)[]

Spark clusters matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "clusterId": "example",
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
          "scalePolicy": null
        },
        "executor": {
          "resourcePresetId": "example",
          "scalePolicy": null
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
    },
    "health": "HEALTH_UNKNOWN",
    "status": "STATUS_UNSPECIFIED",
    "entryId": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### SparkCluster {#entity-SparkCluster}

#|
|| **Name** | **Description** ||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the associated cloud environment.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_clusterId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the managed Spark cluster.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_collectionId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens collection that contains the cluster.

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

_dependencies_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Packages installed in the cluster.

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

_logging_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

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
  ||

  _scaleType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `fixedScale`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "fixedScale": {
      "size": "example"
    },
    "scaleType": "fixedScale"
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
  ||

  _scaleType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `autoScale`

  _Example:_{.json-schema-reset .json-schema-example} `example`
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
    },
    "scaleType": "autoScale"
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
  },
  "scaleType": "fixedScale"
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
    },
    "scaleType": "fixedScale"
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
  ||

  _scaleType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `fixedScale`

  _Example:_{.json-schema-reset .json-schema-example} `example`
  {.table-cell}
  ||
  |#{.json-schema-properties}

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "fixedScale": {
      "size": "example"
    },
    "scaleType": "fixedScale"
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
  ||

  _scaleType_{.json-schema-reset .json-schema-property .json-schema-required}
  {.table-cell}|
  **Type**: string

  _Const:_{.json-schema-reset .json-schema-value} `autoScale`

  _Example:_{.json-schema-reset .json-schema-example} `example`
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
    },
    "scaleType": "autoScale"
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
  },
  "scaleType": "fixedScale"
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
    },
    "scaleType": "fixedScale"
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
      },
      "scaleType": "fixedScale"
    }
  },
  "executor": {
    "resourcePresetId": "example",
    "scalePolicy": {
      "fixedScale": {
        "size": "example"
      },
      "scaleType": "fixedScale"
    }
  }
}
```

{% endcut %}
{.table-cell}
||
||

_sparkVersion_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Spark version used by the cluster.

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
        "fixedScale": {},
        "scaleType": "fixedScale"
      }
    },
    "executor": {
      "resourcePresetId": "example",
      "scalePolicy": {
        "fixedScale": {},
        "scaleType": "fixedScale"
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

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the Spark cluster.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens entry of the Spark cluster. Empty when the cluster has no entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_health_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Aggregated health of the Spark cluster.

_Enum:_{.json-schema-reset .json-schema-value} `HEALTH_UNKNOWN`, `ALIVE`, `DEAD`, `DEGRADED`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Spark cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

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

Spark cluster labels.

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

Name of the Spark cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Current status of the Spark cluster.

_Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNSPECIFIED`, `CREATING`, `RUNNING`, `UPDATING`, `ERROR`, `STOPPING`, `STOPPED`, `STARTING`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "clusterId": "example",
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
  },
  "health": "HEALTH_UNKNOWN",
  "status": "STATUS_UNSPECIFIED",
  "entryId": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.