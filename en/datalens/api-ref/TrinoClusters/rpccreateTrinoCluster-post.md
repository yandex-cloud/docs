<div class="openapi">

# 🚧 [Experimental] Create Trino cluster

<!-- markdownlint-disable-file -->

Creates a Trino cluster and returns an asynchronous operation.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createTrinoCluster
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
  "catalogsConfig": [
    {
      "catalogId": "example"
    }
  ],
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

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Name of the Trino cluster.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `63`

_Pattern:_{.json-schema-reset .json-schema-assertion} `^[a-zA-Z0-9_-]+$`

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
||

_catalogsConfig_{.json-schema-reset .json-schema-property}
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

REST catalogs to attach to the cluster.

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

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Description of the Trino cluster.

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

Trino cluster labels.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
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

Retry policy. The service default is used when omitted.

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

Trino version. The service default is used when omitted.

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