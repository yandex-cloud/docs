[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [TrinoClusters](index.md) > 🚧 [Experimental] Get Trino cluster

<div class="openapi">

# 🚧 [Experimental] Get Trino cluster

<!-- markdownlint-disable-file -->

Returns the specified Trino cluster.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getTrinoCluster
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
  "id": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Trino cluster to return.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

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
  "id": "example",
  "clusterId": "example",
  "collectionId": "example",
  "cloudEnvironmentId": "example",
  "name": "example",
  "description": "example",
  "labels": {},
  "config": {
    "trinoVersion": "example",
    "catalogsConfig": [
      {
        "catalogId": "example"
      }
    ],
    "coordinatorConfig": {
      "resources": {
        "resourcePresetId": "example"
      }
    },
    "workerConfig": {
      "resources": {
        "resourcePresetId": "example"
      },
      "scalePolicy": {
        "autoScale": {
          "minCount": "example",
          "maxCount": "example"
        },
        "scaleType": "autoScale"
      }
    },
    "retryPolicy": {
      "policy": "POLICY_UNSPECIFIED"
    }
  },
  "health": "HEALTH_UNKNOWN",
  "status": "STATUS_UNKNOWN",
  "coordinatorUrl": "example",
  "entryId": "example"
}
```

{% endcut %}

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

ID of the managed Trino cluster.

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

_catalogsConfig_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_catalogId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the REST catalog.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

REST catalogs attached to the cluster.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "catalogId": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_coordinatorConfig_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resourcePresetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Trino resource preset.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Resources assigned to the coordinator.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "resourcePresetId": "example"
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
  "resources": {
    "resourcePresetId": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_trinoVersion_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Trino version used by the cluster.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workerConfig_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resources_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_resourcePresetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Trino resource preset.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Resources assigned to each worker.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "resourcePresetId": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_scalePolicy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_autoScale_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_maxCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Maximum number of worker instances.

_Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:[1-9]&#124;[1-5]\d&#124;6[0-4])$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_minCount_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Minimum number of worker instances.

_Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0&#124;[1-5]?\d&#124;6[0-4])$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "minCount": "example",
  "maxCount": "example"
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

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "autoScale": {
    "minCount": "example",
    "maxCount": "example"
  },
  "scaleType": "autoScale"
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
  "resources": {
    "resourcePresetId": "example"
  },
  "scalePolicy": {
    "autoScale": {
      "minCount": "example",
      "maxCount": "example"
    },
    "scaleType": "autoScale"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_retryPolicy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: object &#124; null

Retry policy: QUERY retries a whole query, TASK retries the failed tasks only. Null when not set.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "policy": "POLICY_UNSPECIFIED"
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
  "trinoVersion": "example",
  "catalogsConfig": [
    {
      "catalogId": "example"
    }
  ],
  "coordinatorConfig": {
    "resources": {
      "resourcePresetId": "example"
    }
  },
  "workerConfig": {
    "resources": {
      "resourcePresetId": "example"
    },
    "scalePolicy": {
      "autoScale": {
        "minCount": "example",
        "maxCount": "example"
      },
      "scaleType": "autoScale"
    }
  },
  "retryPolicy": {
    "policy": "POLICY_UNSPECIFIED"
  }
}
```

{% endcut %}
{.table-cell}
||
||

_coordinatorUrl_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Address of the Trino coordinator.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the Trino cluster.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the DataLens entry of the Trino cluster. Empty when the cluster has no entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_health_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Aggregated health of the Trino cluster.

_Enum:_{.json-schema-reset .json-schema-value} `HEALTH_UNKNOWN`, `ALIVE`, `DEAD`, `DEGRADED`
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the Trino cluster.

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

Trino cluster labels.

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

Name of the Trino cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Current status of the Trino cluster.

_Enum:_{.json-schema-reset .json-schema-value} `STATUS_UNKNOWN`, `CREATING`, `RUNNING`, `ERROR`, `STOPPING`, `STOPPED`, `STARTING`, `UPDATING`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.