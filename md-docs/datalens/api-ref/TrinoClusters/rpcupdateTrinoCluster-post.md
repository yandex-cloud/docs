[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [TrinoClusters](index.md) > 🚧 [Experimental] Update Trino cluster

<div class="openapi">

# 🚧 [Experimental] Update Trino cluster

<!-- markdownlint-disable-file -->

Updates the fields of a Trino cluster named in the update mask (worker configuration, version, retry policy, attached REST catalogs) and returns an asynchronous operation.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateTrinoCluster
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
      "worker_config"
    ]
  },
  "workerConfig": {
    "resources": {
      "resourcePresetId": "example"
    },
    "scalePolicy": {
      "autoScale": {
        "minCount": "example",
        "maxCount": "example"
      }
    }
  },
  "trinoVersion": "example",
  "retryPolicy": {
    "policy": "QUERY"
  },
  "catalogIds": [
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

ID of the Trino cluster to update.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updateMask_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_paths_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

Fields to update, by their proto names. Each path needs its field in the request, except retry_policy, which is removed when its field is left out; a field without its path is rejected.

_Min items:_{.json-schema-reset .json-schema-assertion} `1`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "worker_config"
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Fields of the Trino cluster to update; the others are left as they are.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "paths": [
    "worker_config"
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_catalogIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

IDs of all REST catalogs attached to the cluster after the update.

_Max items:_{.json-schema-reset .json-schema-assertion} `100`

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

_retryPolicy_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_policy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `QUERY`, `TASK`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Retry policy. Name retry_policy in the update mask and leave this field out to take the policy off the cluster.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "policy": "QUERY"
}
```

{% endcut %}
{.table-cell}
||
||

_trinoVersion_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Trino version.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workerConfig_{.json-schema-reset .json-schema-property}
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
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "autoScale": {
    "minCount": "example",
    "maxCount": "example"
  }
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Worker nodes configuration.

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
    }
  }
}
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