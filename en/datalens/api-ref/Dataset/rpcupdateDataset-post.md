<div class="openapi">

# Update dataset

<!-- markdownlint-disable-file -->

Updates the specified dataset.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateDataset
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

_Const:_{.json-schema-reset .json-schema-value} `2`

_Example:_{.json-schema-reset .json-schema-example} `2`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "datasetId": "example",
  "data": {
    "dataset": {
      "avatar_relations": [
        {
          "conditions": [
            null
          ],
          "id": "example",
          "join_type": "inner",
          "left_avatar_id": "example",
          "managed_by": "user",
          "required": false,
          "right_avatar_id": "example"
        }
      ],
      "cache_invalidation_source": {
        "cache_invalidation_error": null,
        "field": null,
        "filters": [
          {}
        ],
        "mode": "off",
        "sql": "null"
      },
      "component_errors": {
        "items": [
          {}
        ]
      },
      "data_export_forbidden": false,
      "description": "",
      "load_preview_by_default": true,
      "obligatory_filters": [
        null
      ],
      "preview_enabled": false,
      "result_schema": [
        {}
      ],
      "result_schema_aux": {
        "inter_dependencies": {
          "deps": [
            null
          ]
        }
      },
      "revision_id": "null",
      "rls": {},
      "rls2": {},
      "source_avatars": [
        {
          "id": "example",
          "is_root": true,
          "managed_by": "user",
          "source_id": "example",
          "title": "example"
        }
      ],
      "sources": [
        {}
      ],
      "template_enabled": false
    }
  },
  "workbookId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_datasetId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_data_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DatasetUpdate](#entity-DatasetUpdate)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataset": {
    "avatar_relations": [
      {
        "conditions": [
          {}
        ],
        "id": "example",
        "join_type": "inner",
        "left_avatar_id": "example",
        "managed_by": "user",
        "required": false,
        "right_avatar_id": "example"
      }
    ],
    "cache_invalidation_source": {
      "cache_invalidation_error": null,
      "field": null,
      "filters": [
        {
          "default_filters": [],
          "field_guid": "example",
          "id": "example",
          "managed_by": "user",
          "valid": true
        }
      ],
      "mode": "off",
      "sql": "null"
    },
    "component_errors": {
      "items": [
        {
          "errors": [
            null
          ],
          "id": "example",
          "type": "data_source"
        }
      ]
    },
    "data_export_forbidden": false,
    "description": "",
    "load_preview_by_default": true,
    "obligatory_filters": [
      null
    ],
    "preview_enabled": false,
    "result_schema": [
      {
        "aggregation": "none",
        "avatar_id": "example",
        "cast": "string",
        "data_type": "string",
        "description": "example",
        "guid": "example",
        "has_auto_aggregation": true,
        "hidden": false,
        "initial_data_type": "string",
        "lock_aggregation": true,
        "managed_by": "user",
        "source": "example",
        "title": "example",
        "type": "DIMENSION",
        "ui_settings": "",
        "valid": true
      }
    ],
    "result_schema_aux": {
      "inter_dependencies": {
        "deps": [
          {}
        ]
      }
    },
    "revision_id": "null",
    "rls": {},
    "rls2": {},
    "source_avatars": [
      {
        "id": "example",
        "is_root": true,
        "managed_by": "user",
        "source_id": "example",
        "title": "example"
      }
    ],
    "sources": [
      {
        "connection_id": "example",
        "id": "example",
        "index_info_set": null,
        "managed_by": "user",
        "parameters": {},
        "raw_schema": [
          null
        ],
        "source_type": "APPMETRICA_API",
        "title": "example",
        "valid": true
      }
    ],
    "template_enabled": false
  }
}
```

{% endcut %}
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### direct {#entity-direct}

#|
|| **Name** | **Description** ||
||

_calc_mode_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `direct`, `formula`, `result_field`
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "calc_mode": "direct",
  "source": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### formula {#entity-formula}

#|
|| **Name** | **Description** ||
||

_calc_mode_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `direct`, `formula`, `result_field`
{.table-cell}
||
||

_formula_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "calc_mode": "direct",
  "formula": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### result_field {#entity-result_field}

#|
|| **Name** | **Description** ||
||

_calc_mode_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `direct`, `formula`, `result_field`
{.table-cell}
||
||

_field_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "calc_mode": "direct",
  "field_id": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ConditionPartGeneric {#entity-ConditionPartGeneric}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [direct](#entity-direct)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "calc_mode": "direct",
    "source": "example"
  }
  ```

  {% endcut %}

- **Type**: [formula](#entity-formula)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "calc_mode": "direct",
    "formula": "example"
  }
  ```

  {% endcut %}

- **Type**: [result_field](#entity-result_field)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "calc_mode": "direct",
    "field_id": "example"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "calc_mode": "direct",
  "source": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### JoinCondition {#entity-JoinCondition}

#|
|| **Name** | **Description** ||
||

_left_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ConditionPartGeneric](#entity-ConditionPartGeneric)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "calc_mode": "direct",
  "source": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_operator_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `gt`, `lt`, `gte`, `lte`, `eq`, `ne`
{.table-cell}
||
||

_right_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [ConditionPartGeneric](#entity-ConditionPartGeneric)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "calc_mode": "direct",
  "source": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `binary`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "left": {
    "calc_mode": "direct",
    "source": "example"
  },
  "operator": "gt",
  "right": null,
  "type": "binary"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### AvatarRelation {#entity-AvatarRelation}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_conditions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [JoinCondition](#entity-JoinCondition)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "left": {
      "calc_mode": "direct",
      "source": "example"
    },
    "operator": "gt",
    "right": null,
    "type": "binary"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_join_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `inner`, `left`, `right`, `full`
{.table-cell}
||
||

_left_avatar_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `user`

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`
{.table-cell}
||
||

_required_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_right_avatar_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "conditions": [
    {
      "left": {
        "calc_mode": "direct",
        "source": "example"
      },
      "operator": "gt",
      "right": null,
      "type": "binary"
    }
  ],
  "id": "example",
  "join_type": "inner",
  "left_avatar_id": "example",
  "managed_by": "user",
  "required": false,
  "right_avatar_id": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CacheInvalidationError {#entity-CacheInvalidationError}

#|
|| **Name** | **Description** ||
||

_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `info`, `warning`, `critical`
{.table-cell}
||
||

_locator_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_message_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "level": "info",
  "locator": "example",
  "message": "example",
  "title": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### formula1 {#entity-formula1}

#|
|| **Name** | **Description** ||
||

_formula_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_guid_formula_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "formula": "",
  "guid_formula": ""
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CacheInvalidationField {#entity-CacheInvalidationField}

#|
|| **Name** | **Description** ||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_calc_spec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [formula1](#entity-formula1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "formula": "",
  "guid_formula": ""
}
```

{% endcut %}
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `string`

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `string`

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `INVALIDATION CACHE SERVICE FIELD`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "calc_spec": {
    "formula": "",
    "guid_formula": ""
  },
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "title": "INVALIDATION CACHE SERVICE FIELD",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Where {#entity-Where}

#|
|| **Name** | **Description** ||
||

_column_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_operation_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `ISNULL`, `ISNOTNULL`, `GT`, `LT`, `GTE`, `LTE`, `EQ`, `NE`, `STARTSWITH`, `ISTARTSWITH`, `ENDSWITH`, `IENDSWITH`, `CONTAINS`, `ICONTAINS`, `NOTCONTAINS`, `NOTICONTAINS`, `LENEQ`, `LENNE`, `LENGT`, `LENGTE`, `LENLT`, `LENLTE`, `IN`, `NIN`, `BETWEEN`
{.table-cell}
||
||

_values_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: array &#124; null

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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "column": "example",
  "operation": "ISNULL",
  "values": [
    null
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ObligatoryFilter {#entity-ObligatoryFilter}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_default_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Where](#entity-Where)[]

_Default:_{.json-schema-reset .json-schema-value} `[]`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "column": "example",
    "operation": "ISNULL",
    "values": [
      null
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
||

_field_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `user`

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "default_filters": [],
  "field_guid": "example",
  "id": "example",
  "managed_by": "user",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CacheInvalidationSource {#entity-CacheInvalidationSource}

#|
|| **Name** | **Description** ||
||

_cache_invalidation_error_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [CacheInvalidationError](#entity-CacheInvalidationError)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "level": "info",
    "locator": "example",
    "message": "example",
    "title": "example"
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_field_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [CacheInvalidationField](#entity-CacheInvalidationField)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "calc_spec": {
      "formula": "",
      "guid_formula": ""
    },
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "title": "INVALIDATION CACHE SERVICE FIELD",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ObligatoryFilter](#entity-ObligatoryFilter)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "default_filters": [],
    "field_guid": "example",
    "id": "example",
    "managed_by": "user",
    "valid": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `sql`, `formula`, `off`
{.table-cell}
||
||

_sql_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_error": null,
  "field": null,
  "filters": [
    {
      "default_filters": [],
      "field_guid": "example",
      "id": "example",
      "managed_by": "user",
      "valid": true
    }
  ],
  "mode": "off",
  "sql": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ComponentError {#entity-ComponentError}

#|
|| **Name** | **Description** ||
||

_code_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_details_{.json-schema-reset .json-schema-property}
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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_level_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `error`, `warning`
{.table-cell}
||
||

_message_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "code": null,
  "details": {},
  "level": "error",
  "message": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ComponentErrorPack {#entity-ComponentErrorPack}

#|
|| **Name** | **Description** ||
||

_errors_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ComponentError](#entity-ComponentError)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "code": null,
    "details": {},
    "level": "error",
    "message": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `data_source`, `source_avatar`, `avatar_relation`, `field`, `obligatory_filter`, `result_schema`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "errors": [
    {
      "code": null,
      "details": {},
      "level": "error",
      "message": "example"
    }
  ],
  "id": "example",
  "type": "data_source"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ComponentErrorList {#entity-ComponentErrorList}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ComponentErrorPack](#entity-ComponentErrorPack)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "errors": [
      {
        "code": null,
        "details": {},
        "level": "error",
        "message": "example"
      }
    ],
    "id": "example",
    "type": "data_source"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "errors": [
        {
          "code": null,
          "details": {},
          "level": "error",
          "message": "example"
        }
      ],
      "id": "example",
      "type": "data_source"
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### direct1 {#entity-direct1}

#|
|| **Name** | **Description** ||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_avatar_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "avatar_id": "example",
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "source": "example",
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### formula2 {#entity-formula2}

#|
|| **Name** | **Description** ||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_formula_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_formula_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "formula": "",
  "guid": "example",
  "guid_formula": "",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### regex {#entity-regex}

#|
|| **Name** | **Description** ||
||

_pattern_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `regex`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "pattern": "example",
  "type": "regex"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### default {#entity-default}

#|
|| **Name** | **Description** ||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `default`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "default"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ParameterValueConstraint {#entity-ParameterValueConstraint}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 2 types**" %}{.json-schema-combinators data-marker=or}

- **regex**

  **Type**: [regex](#entity-regex)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "pattern": "example",
    "type": "regex"
  }
  ```

  {% endcut %}

- **default**

  **Type**: [default](#entity-default)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "type": "default"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "pattern": "example",
  "type": "regex"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### parameter1 {#entity-parameter1}

#|
|| **Name** | **Description** ||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_default_value_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_template_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_value_constraint_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [ParameterValueConstraint](#entity-ParameterValueConstraint)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "pattern": "example",
    "type": "regex"
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "pattern": "example",
  "type": "regex"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "cast": "string",
  "data_type": "string",
  "default_value": "example",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "template_enabled": false,
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true,
  "value_constraint": {
    "pattern": "example",
    "type": "regex"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ResultSchemaSchemaGeneric {#entity-ResultSchemaSchemaGeneric}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [direct1](#entity-direct1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "avatar_id": "example",
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "source": "example",
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true
  }
  ```

  {% endcut %}

- **Type**: [formula2](#entity-formula2)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "formula": "",
    "guid": "example",
    "guid_formula": "",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true
  }
  ```

  {% endcut %}

- **Type**: [parameter1](#entity-parameter1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "cast": "string",
    "data_type": "string",
    "default_value": "example",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "template_enabled": false,
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true,
    "value_constraint": {
      "pattern": "example",
      "type": "regex"
    }
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "avatar_id": "example",
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "source": "example",
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### FieldInterDependencyItem {#entity-FieldInterDependencyItem}

#|
|| **Name** | **Description** ||
||

_dep_field_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ref_field_ids_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dep_field_id": "example",
  "ref_field_ids": [
    "example"
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### FieldInterDependencyInfo {#entity-FieldInterDependencyInfo}

#|
|| **Name** | **Description** ||
||

_deps_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [FieldInterDependencyItem](#entity-FieldInterDependencyItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "dep_field_id": "example",
    "ref_field_ids": [
      "example"
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "deps": [
    {
      "dep_field_id": "example",
      "ref_field_ids": [
        "example"
      ]
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ResultSchemaAux {#entity-ResultSchemaAux}

#|
|| **Name** | **Description** ||
||

_inter_dependencies_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [FieldInterDependencyInfo](#entity-FieldInterDependencyInfo)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "deps": [
    {
      "dep_field_id": "example",
      "ref_field_ids": [
        "example"
      ]
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
  "inter_dependencies": {
    "deps": [
      {
        "dep_field_id": "example",
        "ref_field_ids": [
          "example"
        ]
      }
    ]
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### RLSSubject {#entity-RLSSubject}

#|
|| **Name** | **Description** ||
||

_subject_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subject_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_subject_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `user`, `group`, `all`, `userid`, `unknown`, `notfound`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subject_id": "example",
  "subject_name": "null",
  "subject_type": "user"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### RLS2ConfigEntry {#entity-RLS2ConfigEntry}

#|
|| **Name** | **Description** ||
||

_subject_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [RLSSubject](#entity-RLSSubject)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subject_id": "example",
  "subject_name": "null",
  "subject_type": "user"
}
```

{% endcut %}
{.table-cell}
||
||

_allowed_value_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_field_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_pattern_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `value`

_Enum:_{.json-schema-reset .json-schema-value} `value`, `all`, `userid`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "allowed_value": "null",
  "field_guid": "null",
  "pattern_type": "value",
  "subject": {
    "subject_id": "example",
    "subject_name": "null",
    "subject_type": "user"
  }
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SourceAvatarStrict {#entity-SourceAvatarStrict}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_is_root_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_source_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "is_root": true,
  "managed_by": "user",
  "source_id": "example",
  "title": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### IndexInfo {#entity-IndexInfo}

#|
|| **Name** | **Description** ||
||

_columns_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string[]

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

_kind_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `table_sorting`, `null`

_Example:_{.json-schema-reset .json-schema-example} `table_sorting`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "columns": [
    "example"
  ],
  "kind": "table_sorting"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SQLParameters {#entity-SQLParameters}

#|
|| **Name** | **Description** ||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_version_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_table_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### generic_native_type {#entity-generic_native_type}

#|
|| **Name** | **Description** ||
||

_name_{.json-schema-reset .json-schema-property}
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

</div>

<div class="openapi-entity">

### common_native_type {#entity-common_native_type}

#|
|| **Name** | **Description** ||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "name": "example",
  "nullable": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### lengthed_native_type {#entity-lengthed_native_type}

#|
|| **Name** | **Description** ||
||

_length_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "length": null,
  "name": "example",
  "nullable": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse_native_type {#entity-clickhouse_native_type}

#|
|| **Name** | **Description** ||
||

_lowcardinality_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "lowcardinality": false,
  "name": "example",
  "nullable": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse_datetimewithtz_native_type {#entity-clickhouse_datetimewithtz_native_type}

#|
|| **Name** | **Description** ||
||

_explicit_timezone_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_lowcardinality_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_timezone_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `UTC`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "explicit_timezone": true,
  "lowcardinality": false,
  "name": "example",
  "nullable": true,
  "timezone_name": "UTC"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse_datetime64_native_type {#entity-clickhouse_datetime64_native_type}

#|
|| **Name** | **Description** ||
||

_precision_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_lowcardinality_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "lowcardinality": false,
  "name": "example",
  "nullable": true,
  "precision": 0
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### clickhouse_datetime64withtz_native_type {#entity-clickhouse_datetime64withtz_native_type}

#|
|| **Name** | **Description** ||
||

_precision_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_explicit_timezone_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_lowcardinality_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_timezone_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `UTC`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "explicit_timezone": true,
  "lowcardinality": false,
  "name": "example",
  "nullable": true,
  "precision": 0,
  "timezone_name": "UTC"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### OneOfNativeType {#entity-OneOfNativeType}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 7 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [generic_native_type](#entity-generic_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "name": "example"
  }
  ```

  {% endcut %}

- **Type**: [common_native_type](#entity-common_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "name": "example",
    "nullable": true
  }
  ```

  {% endcut %}

- **Type**: [lengthed_native_type](#entity-lengthed_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "length": null,
    "name": "example",
    "nullable": true
  }
  ```

  {% endcut %}

- **Type**: [clickhouse_native_type](#entity-clickhouse_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "lowcardinality": false,
    "name": "example",
    "nullable": true
  }
  ```

  {% endcut %}

- **Type**: [clickhouse_datetimewithtz_native_type](#entity-clickhouse_datetimewithtz_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "explicit_timezone": true,
    "lowcardinality": false,
    "name": "example",
    "nullable": true,
    "timezone_name": "UTC"
  }
  ```

  {% endcut %}

- **Type**: [clickhouse_datetime64_native_type](#entity-clickhouse_datetime64_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "lowcardinality": false,
    "name": "example",
    "nullable": true,
    "precision": 0
  }
  ```

  {% endcut %}

- **Type**: [clickhouse_datetime64withtz_native_type](#entity-clickhouse_datetime64withtz_native_type)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "explicit_timezone": true,
    "lowcardinality": false,
    "name": "example",
    "nullable": true,
    "precision": 0,
    "timezone_name": "UTC"
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### RawSchemaColumn {#entity-RawSchemaColumn}

#|
|| **Name** | **Description** ||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_native_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [OneOfNativeType](#entity-OneOfNativeType)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "name": "example"
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_nullable_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_user_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example",
  "has_auto_aggregation": true,
  "lock_aggregation": true,
  "name": "example",
  "native_type": {
    "name": "example"
  },
  "nullable": true,
  "title": "example",
  "user_type": "string"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### APPMETRICA_API {#entity-APPMETRICA_API}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `APPMETRICA_API`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "APPMETRICA_API",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BigQueryTableParameters {#entity-BigQueryTableParameters}

#|
|| **Name** | **Description** ||
||

_dataset_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_version_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_table_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataset_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BIGQUERY_TABLE {#entity-BIGQUERY_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [BigQueryTableParameters](#entity-BigQueryTableParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataset_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `BIGQUERY_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "dataset_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "BIGQUERY_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SubselectParameters {#entity-SubselectParameters}

#|
|| **Name** | **Description** ||
||

_subsql_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BIGQUERY_SUBSELECT {#entity-BIGQUERY_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `BIGQUERY_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "BIGQUERY_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BITRIX_GDS {#entity-BITRIX_GDS}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `BITRIX_GDS`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "BITRIX_GDS",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_BILLING_ANALYTICS_TABLE {#entity-CH_BILLING_ANALYTICS_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_BILLING_ANALYTICS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_BILLING_ANALYTICS_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_YA_MUSIC_PODCAST_STATS_TABLE {#entity-CH_YA_MUSIC_PODCAST_STATS_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_YA_MUSIC_PODCAST_STATS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_YA_MUSIC_PODCAST_STATS_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_TABLE {#entity-CHYT_YTSAURUS_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYTTableListParameters {#entity-CHYTTableListParameters}

#|
|| **Name** | **Description** ||
||

_table_names_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "table_names": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_TABLE_LIST {#entity-CHYT_YTSAURUS_TABLE_LIST}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CHYTTableListParameters](#entity-CHYTTableListParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "table_names": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_TABLE_LIST`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "table_names": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_TABLE_LIST",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYTTableRangeParameters {#entity-CHYTTableRangeParameters}

#|
|| **Name** | **Description** ||
||

_directory_path_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_range_from_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_range_to_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "directory_path": "example",
  "range_from": "example",
  "range_to": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_TABLE_RANGE {#entity-CHYT_YTSAURUS_TABLE_RANGE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CHYTTableRangeParameters](#entity-CHYTTableRangeParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "directory_path": "example",
  "range_from": "example",
  "range_to": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_TABLE_RANGE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "directory_path": "example",
    "range_from": "example",
    "range_to": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_TABLE_RANGE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_SUBSELECT {#entity-CHYT_YTSAURUS_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_TABLE {#entity-CH_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_SUBSELECT {#entity-CH_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EQUEO_CH_TABLE {#entity-EQUEO_CH_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `EQUEO_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "EQUEO_CH_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EXTRACTOR_1C_CH_TABLE {#entity-EXTRACTOR_1C_CH_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `EXTRACTOR_1C_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "EXTRACTOR_1C_CH_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SchematizedParameters {#entity-SchematizedParameters}

#|
|| **Name** | **Description** ||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_version_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_schema_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_table_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GP_TABLE {#entity-GP_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `GP_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "GP_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GP_SUBSELECT {#entity-GP_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `GP_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "GP_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SimpleParameters {#entity-SimpleParameters}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GSHEETS {#entity-GSHEETS}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `GSHEETS`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "GSHEETS",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### JSON_API {#entity-JSON_API}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `JSON_API`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "JSON_API",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### KONTUR_MARKET_CH_TABLE {#entity-KONTUR_MARKET_CH_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `KONTUR_MARKET_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "KONTUR_MARKET_CH_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### METRIKA_API {#entity-METRIKA_API}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `METRIKA_API`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "METRIKA_API",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MONITORING {#entity-MONITORING}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MONITORING`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MONITORING",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MOYSKLAD_CH_TABLE {#entity-MOYSKLAD_CH_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MOYSKLAD_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MOYSKLAD_CH_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MSSQL_TABLE {#entity-MSSQL_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MSSQL_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MSSQL_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MSSQL_SUBSELECT {#entity-MSSQL_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MSSQL_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MSSQL_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MYSQL_TABLE {#entity-MYSQL_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MYSQL_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MYSQL_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MYSQL_SUBSELECT {#entity-MYSQL_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MYSQL_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MYSQL_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ORACLE_TABLE {#entity-ORACLE_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ORACLE_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "ORACLE_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ORACLE_SUBSELECT {#entity-ORACLE_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ORACLE_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "ORACLE_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### PG_TABLE {#entity-PG_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `PG_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "PG_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### PG_SUBSELECT {#entity-PG_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `PG_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "PG_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### PROMQL {#entity-PROMQL}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `PROMQL`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "PROMQL",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_SMB_HEATMAPS_TABLE {#entity-CH_SMB_HEATMAPS_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_SMB_HEATMAPS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_SMB_HEATMAPS_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SnowFlakeTableParameters {#entity-SnowFlakeTableParameters}

#|
|| **Name** | **Description** ||
||

_db_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_table_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "schema": "example",
  "table_name": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SNOWFLAKE_TABLE {#entity-SNOWFLAKE_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SnowFlakeTableParameters](#entity-SnowFlakeTableParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "schema": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `SNOWFLAKE_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "schema": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "SNOWFLAKE_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SPEECHSENSE_TABLE {#entity-SPEECHSENSE_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `SPEECHSENSE_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "SPEECHSENSE_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### TRINO_TABLE {#entity-TRINO_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `TRINO_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "TRINO_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### TRINO_SUBSELECT {#entity-TRINO_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `TRINO_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "TRINO_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_USAGE_TRACKING_TABLE {#entity-CH_USAGE_TRACKING_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_USAGE_TRACKING_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_USAGE_TRACKING_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_USAGE_TRACKING_AGG_TABLE {#entity-CH_USAGE_TRACKING_AGG_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_USAGE_TRACKING_AGG_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_USAGE_TRACKING_AGG_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YDB_TABLE {#entity-YDB_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YDB_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YDB_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YDB_SUBSELECT {#entity-YDB_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YDB_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YDB_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YQ_TABLE {#entity-YQ_TABLE}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YQ_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YQ_TABLE",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YQ_SUBSELECT {#entity-YQ_SUBSELECT}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YQ_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YQ_SUBSELECT",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataSourceStrict {#entity-DataSourceStrict}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 42 types**" %}{.json-schema-combinators data-marker=or}

- **APPMETRICA_API**

  **Type**: [APPMETRICA_API](#entity-APPMETRICA_API)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "APPMETRICA_API",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **BIGQUERY_TABLE**

  **Type**: [BIGQUERY_TABLE](#entity-BIGQUERY_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "dataset_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "BIGQUERY_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **BIGQUERY_SUBSELECT**

  **Type**: [BIGQUERY_SUBSELECT](#entity-BIGQUERY_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "BIGQUERY_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **BITRIX_GDS**

  **Type**: [BITRIX_GDS](#entity-BITRIX_GDS)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "BITRIX_GDS",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_BILLING_ANALYTICS_TABLE**

  **Type**: [CH_BILLING_ANALYTICS_TABLE](#entity-CH_BILLING_ANALYTICS_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_BILLING_ANALYTICS_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_YA_MUSIC_PODCAST_STATS_TABLE**

  **Type**: [CH_YA_MUSIC_PODCAST_STATS_TABLE](#entity-CH_YA_MUSIC_PODCAST_STATS_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_YA_MUSIC_PODCAST_STATS_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_TABLE**

  **Type**: [CHYT_YTSAURUS_TABLE](#entity-CHYT_YTSAURUS_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_TABLE_LIST**

  **Type**: [CHYT_YTSAURUS_TABLE_LIST](#entity-CHYT_YTSAURUS_TABLE_LIST)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "table_names": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_TABLE_LIST",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_TABLE_RANGE**

  **Type**: [CHYT_YTSAURUS_TABLE_RANGE](#entity-CHYT_YTSAURUS_TABLE_RANGE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "directory_path": "example",
      "range_from": "example",
      "range_to": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_TABLE_RANGE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_SUBSELECT**

  **Type**: [CHYT_YTSAURUS_SUBSELECT](#entity-CHYT_YTSAURUS_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_TABLE**

  **Type**: [CH_TABLE](#entity-CH_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_SUBSELECT**

  **Type**: [CH_SUBSELECT](#entity-CH_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **EQUEO_CH_TABLE**

  **Type**: [EQUEO_CH_TABLE](#entity-EQUEO_CH_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "EQUEO_CH_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **EXTRACTOR_1C_CH_TABLE**

  **Type**: [EXTRACTOR_1C_CH_TABLE](#entity-EXTRACTOR_1C_CH_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "EXTRACTOR_1C_CH_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **GP_TABLE**

  **Type**: [GP_TABLE](#entity-GP_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "GP_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **GP_SUBSELECT**

  **Type**: [GP_SUBSELECT](#entity-GP_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "GP_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **GSHEETS**

  **Type**: [GSHEETS](#entity-GSHEETS)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "GSHEETS",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **JSON_API**

  **Type**: [JSON_API](#entity-JSON_API)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "JSON_API",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **KONTUR_MARKET_CH_TABLE**

  **Type**: [KONTUR_MARKET_CH_TABLE](#entity-KONTUR_MARKET_CH_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "KONTUR_MARKET_CH_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **METRIKA_API**

  **Type**: [METRIKA_API](#entity-METRIKA_API)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "METRIKA_API",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **MONITORING**

  **Type**: [MONITORING](#entity-MONITORING)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MONITORING",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **MOYSKLAD_CH_TABLE**

  **Type**: [MOYSKLAD_CH_TABLE](#entity-MOYSKLAD_CH_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MOYSKLAD_CH_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **MSSQL_TABLE**

  **Type**: [MSSQL_TABLE](#entity-MSSQL_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MSSQL_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **MSSQL_SUBSELECT**

  **Type**: [MSSQL_SUBSELECT](#entity-MSSQL_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MSSQL_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **MYSQL_TABLE**

  **Type**: [MYSQL_TABLE](#entity-MYSQL_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MYSQL_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **MYSQL_SUBSELECT**

  **Type**: [MYSQL_SUBSELECT](#entity-MYSQL_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MYSQL_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **ORACLE_TABLE**

  **Type**: [ORACLE_TABLE](#entity-ORACLE_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "ORACLE_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **ORACLE_SUBSELECT**

  **Type**: [ORACLE_SUBSELECT](#entity-ORACLE_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "ORACLE_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **PG_TABLE**

  **Type**: [PG_TABLE](#entity-PG_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "PG_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **PG_SUBSELECT**

  **Type**: [PG_SUBSELECT](#entity-PG_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "PG_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **PROMQL**

  **Type**: [PROMQL](#entity-PROMQL)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "PROMQL",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_SMB_HEATMAPS_TABLE**

  **Type**: [CH_SMB_HEATMAPS_TABLE](#entity-CH_SMB_HEATMAPS_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_SMB_HEATMAPS_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **SNOWFLAKE_TABLE**

  **Type**: [SNOWFLAKE_TABLE](#entity-SNOWFLAKE_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "schema": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "SNOWFLAKE_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **SPEECHSENSE_TABLE**

  **Type**: [SPEECHSENSE_TABLE](#entity-SPEECHSENSE_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "SPEECHSENSE_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **TRINO_TABLE**

  **Type**: [TRINO_TABLE](#entity-TRINO_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "TRINO_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **TRINO_SUBSELECT**

  **Type**: [TRINO_SUBSELECT](#entity-TRINO_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "TRINO_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_USAGE_TRACKING_TABLE**

  **Type**: [CH_USAGE_TRACKING_TABLE](#entity-CH_USAGE_TRACKING_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_USAGE_TRACKING_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **CH_USAGE_TRACKING_AGG_TABLE**

  **Type**: [CH_USAGE_TRACKING_AGG_TABLE](#entity-CH_USAGE_TRACKING_AGG_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_USAGE_TRACKING_AGG_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **YDB_TABLE**

  **Type**: [YDB_TABLE](#entity-YDB_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YDB_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **YDB_SUBSELECT**

  **Type**: [YDB_SUBSELECT](#entity-YDB_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YDB_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **YQ_TABLE**

  **Type**: [YQ_TABLE](#entity-YQ_TABLE)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YQ_TABLE",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

- **YQ_SUBSELECT**

  **Type**: [YQ_SUBSELECT](#entity-YQ_SUBSELECT)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YQ_SUBSELECT",
    "title": "example",
    "valid": true
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "APPMETRICA_API",
  "title": "example",
  "valid": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DatasetContentInternal {#entity-DatasetContentInternal}

#|
|| **Name** | **Description** ||
||

_avatar_relations_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [AvatarRelation](#entity-AvatarRelation)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "conditions": [
      {
        "left": {},
        "operator": "gt",
        "right": null,
        "type": "binary"
      }
    ],
    "id": "example",
    "join_type": "inner",
    "left_avatar_id": "example",
    "managed_by": "user",
    "required": false,
    "right_avatar_id": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_cache_invalidation_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CacheInvalidationSource](#entity-CacheInvalidationSource)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_error": null,
  "field": null,
  "filters": [
    {
      "default_filters": [],
      "field_guid": "example",
      "id": "example",
      "managed_by": "user",
      "valid": true
    }
  ],
  "mode": "off",
  "sql": "null"
}
```

{% endcut %}
{.table-cell}
||
||

_component_errors_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ComponentErrorList](#entity-ComponentErrorList)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "errors": [
        {
          "code": null,
          "details": {},
          "level": "error",
          "message": "example"
        }
      ],
      "id": "example",
      "type": "data_source"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_load_preview_by_default_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_obligatory_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ObligatoryFilter](#entity-ObligatoryFilter)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "default_filters": [],
    "field_guid": "example",
    "id": "example",
    "managed_by": "user",
    "valid": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_preview_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_result_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ResultSchemaSchemaGeneric](#entity-ResultSchemaSchemaGeneric)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "aggregation": "none",
    "avatar_id": "example",
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "source": "example",
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_result_schema_aux_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ResultSchemaAux](#entity-ResultSchemaAux)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "inter_dependencies": {
    "deps": [
      {
        "dep_field_id": "example",
        "ref_field_ids": [
          "example"
        ]
      }
    ]
  }
}
```

{% endcut %}
{.table-cell}
||
||

_revision_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_rls_{.json-schema-reset .json-schema-property}
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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_rls2_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: [RLS2ConfigEntry](#entity-RLS2ConfigEntry)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "allowed_value": "null",
    "field_guid": "null",
    "pattern_type": "value",
    "subject": {
      "subject_id": "example",
      "subject_name": "null",
      "subject_type": "user"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_source_avatars_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceAvatarStrict](#entity-SourceAvatarStrict)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "is_root": true,
    "managed_by": "user",
    "source_id": "example",
    "title": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataSourceStrict](#entity-DataSourceStrict)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": null,
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "APPMETRICA_API",
    "title": "example",
    "valid": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_template_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "avatar_relations": [
    {
      "conditions": [
        {
          "left": {},
          "operator": "gt",
          "right": null,
          "type": "binary"
        }
      ],
      "id": "example",
      "join_type": "inner",
      "left_avatar_id": "example",
      "managed_by": "user",
      "required": false,
      "right_avatar_id": "example"
    }
  ],
  "cache_invalidation_source": {
    "cache_invalidation_error": null,
    "field": null,
    "filters": [
      {
        "default_filters": [],
        "field_guid": "example",
        "id": "example",
        "managed_by": "user",
        "valid": true
      }
    ],
    "mode": "off",
    "sql": "null"
  },
  "component_errors": {
    "items": [
      {
        "errors": [
          {}
        ],
        "id": "example",
        "type": "data_source"
      }
    ]
  },
  "data_export_forbidden": false,
  "description": "",
  "load_preview_by_default": true,
  "obligatory_filters": [
    null
  ],
  "preview_enabled": false,
  "result_schema": [
    {
      "aggregation": "none",
      "avatar_id": "example",
      "cast": "string",
      "data_type": "string",
      "description": "example",
      "guid": "example",
      "has_auto_aggregation": true,
      "hidden": false,
      "initial_data_type": "string",
      "lock_aggregation": true,
      "managed_by": "user",
      "source": "example",
      "title": "example",
      "type": "DIMENSION",
      "ui_settings": "",
      "valid": true
    }
  ],
  "result_schema_aux": {
    "inter_dependencies": {
      "deps": [
        {
          "dep_field_id": "example",
          "ref_field_ids": [
            null
          ]
        }
      ]
    }
  },
  "revision_id": "null",
  "rls": {},
  "rls2": {},
  "source_avatars": [
    {
      "id": "example",
      "is_root": true,
      "managed_by": "user",
      "source_id": "example",
      "title": "example"
    }
  ],
  "sources": [
    {
      "connection_id": "example",
      "id": "example",
      "index_info_set": null,
      "managed_by": "user",
      "parameters": {
        "db_name": "example",
        "db_version": "example",
        "table_name": "example"
      },
      "raw_schema": [
        {}
      ],
      "source_type": "APPMETRICA_API",
      "title": "example",
      "valid": true
    }
  ],
  "template_enabled": false
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CompatConnectionTypeListItem {#entity-CompatConnectionTypeListItem}

#|
|| **Name** | **Description** ||
||

_conn_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "conn_type": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ConnectionListItem {#entity-ConnectionListItem}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_replacement_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CompatConnectionTypeListItem](#entity-CompatConnectionTypeListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "conn_type": null
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "replacement_types": [
    {
      "conn_type": null
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Connections {#entity-Connections}

#|
|| **Name** | **Description** ||
||

_compatible_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CompatConnectionTypeListItem](#entity-CompatConnectionTypeListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "conn_type": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ConnectionListItem](#entity-ConnectionListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "replacement_types": [
      {
        "conn_type": null
      }
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
||

_max_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "conn_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "replacement_types": [
        null
      ]
    }
  ],
  "max": 0
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataTypeListItem {#entity-DataTypeListItem}

#|
|| **Name** | **Description** ||
||

_aggregations_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "none"
]
```

{% endcut %}
{.table-cell}
||
||

_casts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "string"
]
```

{% endcut %}
{.table-cell}
||
||

_filter_operations_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "ISNULL"
]
```

{% endcut %}
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregations": [
    "none"
  ],
  "casts": [
    "string"
  ],
  "filter_operations": [
    "ISNULL"
  ],
  "type": "string"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataTypes {#entity-DataTypes}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataTypeListItem](#entity-DataTypeListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "aggregations": [
      "none"
    ],
    "casts": [
      "string"
    ],
    "filter_operations": [
      "ISNULL"
    ],
    "type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "aggregations": [
        "none"
      ],
      "casts": [
        "string"
      ],
      "filter_operations": [
        "ISNULL"
      ],
      "type": "string"
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### FieldListItem {#entity-FieldListItem}

#|
|| **Name** | **Description** ||
||

_aggregations_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "none"
]
```

{% endcut %}
{.table-cell}
||
||

_casts_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "string"
]
```

{% endcut %}
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregations": [
    "none"
  ],
  "casts": [
    "string"
  ],
  "guid": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Fields {#entity-Fields}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [FieldListItem](#entity-FieldListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "aggregations": [
      "none"
    ],
    "casts": [
      "string"
    ],
    "guid": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "aggregations": [
        "none"
      ],
      "casts": [
        "string"
      ],
      "guid": "example"
    }
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Join {#entity-Join}

#|
|| **Name** | **Description** ||
||

_operators_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "gt"
]
```

{% endcut %}
{.table-cell}
||
||

_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "inner"
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "operators": [
    "gt"
  ],
  "types": [
    "inner"
  ]
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Preview {#entity-Preview}

#|
|| **Name** | **Description** ||
||

_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "enabled": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SourceListItem {#entity-SourceListItem}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_schema_update_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "schema_update_enabled": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Avatars {#entity-Avatars}

#|
|| **Name** | **Description** ||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceListItem](#entity-SourceListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "schema_update_enabled": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_max_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SourceListing {#entity-SourceListing}

#|
|| **Name** | **Description** ||
||

_db_name_label_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_db_name_required_for_search_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_supports_db_name_listing_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_supports_source_pagination_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_supports_source_search_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name_label": "example",
  "db_name_required_for_search": true,
  "supports_db_name_listing": true,
  "supports_source_pagination": true,
  "supports_source_search": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CompatSourceTypeListItem {#entity-CompatSourceTypeListItem}

#|
|| **Name** | **Description** ||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "source_type": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Sources {#entity-Sources}

#|
|| **Name** | **Description** ||
||

_compatible_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CompatSourceTypeListItem](#entity-CompatSourceTypeListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "source_type": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceListItem1](#entity-SourceListItem1)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "schema_update_enabled": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_max_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "source_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Options {#entity-Options}

#|
|| **Name** | **Description** ||
||

_connections_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Connections](#entity-Connections)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "conn_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "replacement_types": [
        null
      ]
    }
  ],
  "max": 0
}
```

{% endcut %}
{.table-cell}
||
||

_data_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataTypes](#entity-DataTypes)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "aggregations": [
        "none"
      ],
      "casts": [
        "string"
      ],
      "filter_operations": [
        "ISNULL"
      ],
      "type": "string"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_fields_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Fields](#entity-Fields)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "aggregations": [
        "none"
      ],
      "casts": [
        "string"
      ],
      "guid": "example"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_join_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Join](#entity-Join)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "operators": [
    "gt"
  ],
  "types": [
    "inner"
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_preview_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Preview](#entity-Preview)

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

_schema_update_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_source_avatars_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Avatars](#entity-Avatars)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}
{.table-cell}
||
||

_source_listing_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceListing](#entity-SourceListing)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name_label": "example",
  "db_name_required_for_search": true,
  "supports_db_name_listing": true,
  "supports_source_pagination": true,
  "supports_source_search": true
}
```

{% endcut %}
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Sources](#entity-Sources)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "source_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}
{.table-cell}
||
||

_supported_functions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

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

_supports_offset_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connections": {
    "compatible_types": [
      {
        "conn_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "replacement_types": [
          null
        ]
      }
    ],
    "max": 0
  },
  "data_types": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "filter_operations": [
          "ISNULL"
        ],
        "type": "string"
      }
    ]
  },
  "fields": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "guid": "example"
      }
    ]
  },
  "join": {
    "operators": [
      "gt"
    ],
    "types": [
      "inner"
    ]
  },
  "preview": {
    "enabled": true
  },
  "schema_update_enabled": true,
  "source_avatars": {
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "source_listing": {
    "db_name_label": "example",
    "db_name_required_for_search": true,
    "supports_db_name_listing": true,
    "supports_source_pagination": true,
    "supports_source_search": true
  },
  "sources": {
    "compatible_types": [
      {
        "source_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "supported_functions": [
    "example"
  ],
  "supports_offset": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DatasetUpdate {#entity-DatasetUpdate}

#|
|| **Name** | **Description** ||
||

_dataset_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DatasetContentInternal](#entity-DatasetContentInternal)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "avatar_relations": [
    {
      "conditions": [
        {
          "left": {},
          "operator": "gt",
          "right": null,
          "type": "binary"
        }
      ],
      "id": "example",
      "join_type": "inner",
      "left_avatar_id": "example",
      "managed_by": "user",
      "required": false,
      "right_avatar_id": "example"
    }
  ],
  "cache_invalidation_source": {
    "cache_invalidation_error": null,
    "field": null,
    "filters": [
      {
        "default_filters": [],
        "field_guid": "example",
        "id": "example",
        "managed_by": "user",
        "valid": true
      }
    ],
    "mode": "off",
    "sql": "null"
  },
  "component_errors": {
    "items": [
      {
        "errors": [
          {}
        ],
        "id": "example",
        "type": "data_source"
      }
    ]
  },
  "data_export_forbidden": false,
  "description": "",
  "load_preview_by_default": true,
  "obligatory_filters": [
    null
  ],
  "preview_enabled": false,
  "result_schema": [
    {
      "aggregation": "none",
      "avatar_id": "example",
      "cast": "string",
      "data_type": "string",
      "description": "example",
      "guid": "example",
      "has_auto_aggregation": true,
      "hidden": false,
      "initial_data_type": "string",
      "lock_aggregation": true,
      "managed_by": "user",
      "source": "example",
      "title": "example",
      "type": "DIMENSION",
      "ui_settings": "",
      "valid": true
    }
  ],
  "result_schema_aux": {
    "inter_dependencies": {
      "deps": [
        {
          "dep_field_id": "example",
          "ref_field_ids": [
            null
          ]
        }
      ]
    }
  },
  "revision_id": "null",
  "rls": {},
  "rls2": {},
  "source_avatars": [
    {
      "id": "example",
      "is_root": true,
      "managed_by": "user",
      "source_id": "example",
      "title": "example"
    }
  ],
  "sources": [
    {
      "connection_id": "example",
      "id": "example",
      "index_info_set": null,
      "managed_by": "user",
      "parameters": {
        "db_name": "example",
        "db_version": "example",
        "table_name": "example"
      },
      "raw_schema": [
        {}
      ],
      "source_type": "APPMETRICA_API",
      "title": "example",
      "valid": true
    }
  ],
  "template_enabled": false
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataset": {
    "avatar_relations": [
      {
        "conditions": [
          {}
        ],
        "id": "example",
        "join_type": "inner",
        "left_avatar_id": "example",
        "managed_by": "user",
        "required": false,
        "right_avatar_id": "example"
      }
    ],
    "cache_invalidation_source": {
      "cache_invalidation_error": null,
      "field": null,
      "filters": [
        {
          "default_filters": [],
          "field_guid": "example",
          "id": "example",
          "managed_by": "user",
          "valid": true
        }
      ],
      "mode": "off",
      "sql": "null"
    },
    "component_errors": {
      "items": [
        {
          "errors": [
            null
          ],
          "id": "example",
          "type": "data_source"
        }
      ]
    },
    "data_export_forbidden": false,
    "description": "",
    "load_preview_by_default": true,
    "obligatory_filters": [
      null
    ],
    "preview_enabled": false,
    "result_schema": [
      {
        "aggregation": "none",
        "avatar_id": "example",
        "cast": "string",
        "data_type": "string",
        "description": "example",
        "guid": "example",
        "has_auto_aggregation": true,
        "hidden": false,
        "initial_data_type": "string",
        "lock_aggregation": true,
        "managed_by": "user",
        "source": "example",
        "title": "example",
        "type": "DIMENSION",
        "ui_settings": "",
        "valid": true
      }
    ],
    "result_schema_aux": {
      "inter_dependencies": {
        "deps": [
          {}
        ]
      }
    },
    "revision_id": "null",
    "rls": {},
    "rls2": {},
    "source_avatars": [
      {
        "id": "example",
        "is_root": true,
        "managed_by": "user",
        "source_id": "example",
        "title": "example"
      }
    ],
    "sources": [
      {
        "connection_id": "example",
        "id": "example",
        "index_info_set": null,
        "managed_by": "user",
        "parameters": {},
        "raw_schema": [
          null
        ],
        "source_type": "APPMETRICA_API",
        "title": "example",
        "valid": true
      }
    ],
    "template_enabled": false
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
  "collection_id": "example",
  "ctime": "example",
  "dataset": {
    "avatar_relations": [
      {
        "conditions": [
          {}
        ],
        "id": "example",
        "join_type": "inner",
        "left_avatar_id": "example",
        "managed_by": "user",
        "required": false,
        "right_avatar_id": "example",
        "virtual": null
      }
    ],
    "cache_invalidation_source": {
      "cache_invalidation_error": null,
      "field": null,
      "filters": [
        {
          "default_filters": [],
          "field_guid": "example",
          "id": "example",
          "managed_by": "user",
          "valid": true
        }
      ],
      "mode": "off",
      "sql": "null"
    },
    "component_errors": {
      "items": [
        {
          "errors": [
            null
          ],
          "id": "example",
          "type": "data_source"
        }
      ]
    },
    "data_export_forbidden": false,
    "description": "",
    "load_preview_by_default": true,
    "obligatory_filters": [
      null
    ],
    "preview_enabled": false,
    "result_schema": [
      {
        "aggregation": "none",
        "aggregation_locked": false,
        "autoaggregated": true,
        "avatar_id": "example",
        "cast": "string",
        "data_type": "string",
        "description": "example",
        "guid": "example",
        "has_auto_aggregation": true,
        "hidden": false,
        "initial_data_type": "string",
        "lock_aggregation": true,
        "managed_by": "user",
        "source": "example",
        "title": "example",
        "type": "DIMENSION",
        "ui_settings": "",
        "valid": true,
        "virtual": null
      }
    ],
    "result_schema_aux": {
      "inter_dependencies": {
        "deps": [
          {}
        ]
      }
    },
    "revision_id": "null",
    "rls": {},
    "rls2": {},
    "source_avatars": [
      {
        "id": "example",
        "is_root": true,
        "managed_by": "user",
        "source_id": "example",
        "title": "example",
        "valid": true,
        "virtual": null
      }
    ],
    "sources": [
      {
        "connection_id": "example",
        "id": "example",
        "index_info_set": null,
        "managed_by": "user",
        "parameter_hash": "example",
        "parameters": {},
        "raw_schema": [
          null
        ],
        "source_type": "APPMETRICA_API",
        "title": "example",
        "valid": true,
        "virtual": null
      }
    ],
    "template_enabled": false
  },
  "full_permissions": {},
  "id": "example",
  "is_favorite": true,
  "key": "example",
  "mtime": "example",
  "name": "example",
  "options": {
    "connections": {
      "compatible_types": [
        {
          "conn_type": null
        }
      ],
      "items": [
        {
          "id": "example",
          "replacement_types": [
            null
          ]
        }
      ],
      "max": 0
    },
    "data_types": {
      "items": [
        {
          "aggregations": [
            null
          ],
          "casts": [
            null
          ],
          "filter_operations": [
            null
          ],
          "type": "string"
        }
      ]
    },
    "fields": {
      "items": [
        {
          "aggregations": [
            null
          ],
          "casts": [
            null
          ],
          "guid": "example"
        }
      ]
    },
    "is_cache_invalidation_enabled_in_conn": true,
    "join": {
      "operators": [
        "gt"
      ],
      "types": [
        "inner"
      ]
    },
    "preview": {
      "enabled": true
    },
    "schema_update_enabled": true,
    "source_avatars": {
      "items": [
        {
          "id": "example",
          "schema_update_enabled": true
        }
      ],
      "max": 0
    },
    "source_listing": {
      "db_name_label": "example",
      "db_name_required_for_search": true,
      "supports_db_name_listing": true,
      "supports_source_pagination": true,
      "supports_source_search": true
    },
    "sources": {
      "compatible_types": [
        {
          "source_type": null
        }
      ],
      "items": [
        {
          "id": "example",
          "schema_update_enabled": true
        }
      ],
      "max": 0
    },
    "supported_functions": [
      "example"
    ],
    "supports_offset": true
  },
  "permissions": {},
  "pub_operation_id": "example",
  "row_count": 0,
  "workbook_id": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_dataset_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DatasetContentInternal](#entity-DatasetContentInternal1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "avatar_relations": [
    {
      "conditions": [
        {
          "left": {},
          "operator": "gt",
          "right": null,
          "type": "binary"
        }
      ],
      "id": "example",
      "join_type": "inner",
      "left_avatar_id": "example",
      "managed_by": "user",
      "required": false,
      "right_avatar_id": "example",
      "virtual": null
    }
  ],
  "cache_invalidation_source": {
    "cache_invalidation_error": null,
    "field": null,
    "filters": [
      {
        "default_filters": [],
        "field_guid": "example",
        "id": "example",
        "managed_by": "user",
        "valid": true
      }
    ],
    "mode": "off",
    "sql": "null"
  },
  "component_errors": {
    "items": [
      {
        "errors": [
          {}
        ],
        "id": "example",
        "type": "data_source"
      }
    ]
  },
  "data_export_forbidden": false,
  "description": "",
  "load_preview_by_default": true,
  "obligatory_filters": [
    null
  ],
  "preview_enabled": false,
  "result_schema": [
    {
      "aggregation": "none",
      "aggregation_locked": false,
      "autoaggregated": true,
      "avatar_id": "example",
      "cast": "string",
      "data_type": "string",
      "description": "example",
      "guid": "example",
      "has_auto_aggregation": true,
      "hidden": false,
      "initial_data_type": "string",
      "lock_aggregation": true,
      "managed_by": "user",
      "source": "example",
      "title": "example",
      "type": "DIMENSION",
      "ui_settings": "",
      "valid": true,
      "virtual": null
    }
  ],
  "result_schema_aux": {
    "inter_dependencies": {
      "deps": [
        {
          "dep_field_id": "example",
          "ref_field_ids": [
            null
          ]
        }
      ]
    }
  },
  "revision_id": "null",
  "rls": {},
  "rls2": {},
  "source_avatars": [
    {
      "id": "example",
      "is_root": true,
      "managed_by": "user",
      "source_id": "example",
      "title": "example",
      "valid": true,
      "virtual": null
    }
  ],
  "sources": [
    {
      "connection_id": "example",
      "id": "example",
      "index_info_set": null,
      "managed_by": "user",
      "parameter_hash": "example",
      "parameters": {
        "db_name": "example",
        "db_version": "example",
        "table_name": "example"
      },
      "raw_schema": [
        {}
      ],
      "source_type": "APPMETRICA_API",
      "title": "example",
      "valid": true,
      "virtual": null
    }
  ],
  "template_enabled": false
}
```

{% endcut %}
{.table-cell}
||
||

_collection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_ctime_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Pattern:_{.json-schema-reset .json-schema-assertion} `null`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_full_permissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_is_favorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_key_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mtime_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Pattern:_{.json-schema-reset .json-schema-assertion} `null`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_options_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Options](#entity-Options1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connections": {
    "compatible_types": [
      {
        "conn_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "replacement_types": [
          null
        ]
      }
    ],
    "max": 0
  },
  "data_types": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "filter_operations": [
          "ISNULL"
        ],
        "type": "string"
      }
    ]
  },
  "fields": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "guid": "example"
      }
    ]
  },
  "is_cache_invalidation_enabled_in_conn": true,
  "join": {
    "operators": [
      "gt"
    ],
    "types": [
      "inner"
    ]
  },
  "preview": {
    "enabled": true
  },
  "schema_update_enabled": true,
  "source_avatars": {
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "source_listing": {
    "db_name_label": "example",
    "db_name_required_for_search": true,
    "supports_db_name_listing": true,
    "supports_source_pagination": true,
    "supports_source_search": true
  },
  "sources": {
    "compatible_types": [
      {
        "source_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "supported_functions": [
    "example"
  ],
  "supports_offset": true
}
```

{% endcut %}
{.table-cell}
||
||

_permissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_pub_operation_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_row_count_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
||

_workbook_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### AvatarRelation {#entity-AvatarRelation1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_conditions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [JoinCondition](#entity-JoinCondition)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "left": {
      "calc_mode": "direct",
      "source": "example"
    },
    "operator": "gt",
    "right": null,
    "type": "binary"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_join_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `inner`, `left`, `right`, `full`
{.table-cell}
||
||

_left_avatar_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `user`

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`
{.table-cell}
||
||

_required_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_right_avatar_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "conditions": [
    {
      "left": {
        "calc_mode": "direct",
        "source": "example"
      },
      "operator": "gt",
      "right": null,
      "type": "binary"
    }
  ],
  "id": "example",
  "join_type": "inner",
  "left_avatar_id": "example",
  "managed_by": "user",
  "required": false,
  "right_avatar_id": "example",
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CacheInvalidationField {#entity-CacheInvalidationField1}

#|
|| **Name** | **Description** ||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_aggregation_locked_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_autoaggregated_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_calc_spec_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [formula1](#entity-formula1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "formula": "",
  "guid_formula": ""
}
```

{% endcut %}
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `string`

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `string`

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `INVALIDATION CACHE SERVICE FIELD`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "aggregation_locked": false,
  "autoaggregated": true,
  "calc_spec": {
    "formula": "",
    "guid_formula": ""
  },
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "title": "INVALIDATION CACHE SERVICE FIELD",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CacheInvalidationSource {#entity-CacheInvalidationSource1}

#|
|| **Name** | **Description** ||
||

_cache_invalidation_error_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [CacheInvalidationError](#entity-CacheInvalidationError)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "level": "info",
    "locator": "example",
    "message": "example",
    "title": "example"
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_field_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [CacheInvalidationField](#entity-CacheInvalidationField1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "aggregation_locked": false,
    "autoaggregated": true,
    "calc_spec": {
      "formula": "",
      "guid_formula": ""
    },
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "title": "INVALIDATION CACHE SERVICE FIELD",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ObligatoryFilter](#entity-ObligatoryFilter)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "default_filters": [],
    "field_guid": "example",
    "id": "example",
    "managed_by": "user",
    "valid": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `off`

_Enum:_{.json-schema-reset .json-schema-value} `sql`, `formula`, `off`
{.table-cell}
||
||

_sql_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_error": null,
  "field": null,
  "filters": [
    {
      "default_filters": [],
      "field_guid": "example",
      "id": "example",
      "managed_by": "user",
      "valid": true
    }
  ],
  "mode": "off",
  "sql": "null"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### direct1 {#entity-direct11}

#|
|| **Name** | **Description** ||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_aggregation_locked_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_autoaggregated_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_avatar_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "aggregation_locked": false,
  "autoaggregated": true,
  "avatar_id": "example",
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "source": "example",
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### formula2 {#entity-formula21}

#|
|| **Name** | **Description** ||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_aggregation_locked_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_autoaggregated_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_formula_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_formula_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "aggregation_locked": false,
  "autoaggregated": true,
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "formula": "",
  "guid": "example",
  "guid_formula": "",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### parameter1 {#entity-parameter11}

#|
|| **Name** | **Description** ||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} `none`

_Enum:_{.json-schema-reset .json-schema-value} `none`, `sum`, `avg`, `min`, `max`, `count`, `countunique`
{.table-cell}
||
||

_aggregation_locked_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_autoaggregated_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_cast_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`
{.table-cell}
||
||

_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_default_value_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_guid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_has_auto_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_hidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_initial_data_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `string`, `integer`, `float`, `date`, `datetime`, `boolean`, `geopoint`, `geopolygon`, `uuid`, `markup`, `datetimetz`, `unsupported`, `array_str`, `array_int`, `array_float`, `tree_str`, `genericdatetime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `string`
{.table-cell}
||
||

_lock_aggregation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_template_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `DIMENSION`, `MEASURE`
{.table-cell}
||
||

_ui_settings_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean &#124; null
{.table-cell}
||
||

_value_constraint_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Any of 2 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [ParameterValueConstraint](#entity-ParameterValueConstraint)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "pattern": "example",
    "type": "regex"
  }
  ```

  {% endcut %}

- **Type**: null

  _Example:_{.json-schema-reset .json-schema-example} `null`

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "pattern": "example",
  "type": "regex"
}
```

{% endcut %}
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "aggregation_locked": false,
  "autoaggregated": true,
  "cast": "string",
  "data_type": "string",
  "default_value": "example",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "template_enabled": false,
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true,
  "value_constraint": {
    "pattern": "example",
    "type": "regex"
  },
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ResultSchemaSchemaGeneric {#entity-ResultSchemaSchemaGeneric1}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 3 types**" %}{.json-schema-combinators data-marker=or}

- **Type**: [direct1](#entity-direct11)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "aggregation_locked": false,
    "autoaggregated": true,
    "avatar_id": "example",
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "source": "example",
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **Type**: [formula2](#entity-formula21)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "aggregation_locked": false,
    "autoaggregated": true,
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "formula": "",
    "guid": "example",
    "guid_formula": "",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **Type**: [parameter1](#entity-parameter11)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "aggregation": "none",
    "aggregation_locked": false,
    "autoaggregated": true,
    "cast": "string",
    "data_type": "string",
    "default_value": "example",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "template_enabled": false,
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true,
    "value_constraint": {
      "pattern": "example",
      "type": "regex"
    },
    "virtual": null
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "aggregation": "none",
  "aggregation_locked": false,
  "autoaggregated": true,
  "avatar_id": "example",
  "cast": "string",
  "data_type": "string",
  "description": "example",
  "guid": "example",
  "has_auto_aggregation": true,
  "hidden": false,
  "initial_data_type": "string",
  "lock_aggregation": true,
  "managed_by": "user",
  "source": "example",
  "title": "example",
  "type": "DIMENSION",
  "ui_settings": "",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SourceAvatarStrict {#entity-SourceAvatarStrict1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_is_root_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_source_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "is_root": true,
  "managed_by": "user",
  "source_id": "example",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### APPMETRICA_API {#entity-APPMETRICA_API1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `APPMETRICA_API`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "APPMETRICA_API",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BIGQUERY_TABLE {#entity-BIGQUERY_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [BigQueryTableParameters](#entity-BigQueryTableParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataset_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `BIGQUERY_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "dataset_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "BIGQUERY_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BIGQUERY_SUBSELECT {#entity-BIGQUERY_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `BIGQUERY_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "BIGQUERY_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### BITRIX_GDS {#entity-BITRIX_GDS1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `BITRIX_GDS`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "BITRIX_GDS",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_BILLING_ANALYTICS_TABLE {#entity-CH_BILLING_ANALYTICS_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_BILLING_ANALYTICS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_BILLING_ANALYTICS_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_YA_MUSIC_PODCAST_STATS_TABLE {#entity-CH_YA_MUSIC_PODCAST_STATS_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_YA_MUSIC_PODCAST_STATS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_YA_MUSIC_PODCAST_STATS_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_TABLE {#entity-CHYT_YTSAURUS_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_TABLE_LIST {#entity-CHYT_YTSAURUS_TABLE_LIST1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CHYTTableListParameters](#entity-CHYTTableListParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "table_names": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_TABLE_LIST`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "table_names": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_TABLE_LIST",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_TABLE_RANGE {#entity-CHYT_YTSAURUS_TABLE_RANGE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CHYTTableRangeParameters](#entity-CHYTTableRangeParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "directory_path": "example",
  "range_from": "example",
  "range_to": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_TABLE_RANGE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "directory_path": "example",
    "range_from": "example",
    "range_to": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_TABLE_RANGE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CHYT_YTSAURUS_SUBSELECT {#entity-CHYT_YTSAURUS_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CHYT_YTSAURUS_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CHYT_YTSAURUS_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_TABLE {#entity-CH_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_SUBSELECT {#entity-CH_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EQUEO_CH_TABLE {#entity-EQUEO_CH_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `EQUEO_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "EQUEO_CH_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EXTRACTOR_1C_CH_TABLE {#entity-EXTRACTOR_1C_CH_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `EXTRACTOR_1C_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "EXTRACTOR_1C_CH_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GP_TABLE {#entity-GP_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `GP_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "GP_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GP_SUBSELECT {#entity-GP_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `GP_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "GP_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### GSHEETS {#entity-GSHEETS1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `GSHEETS`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "GSHEETS",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### JSON_API {#entity-JSON_API1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `JSON_API`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "JSON_API",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### KONTUR_MARKET_CH_TABLE {#entity-KONTUR_MARKET_CH_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `KONTUR_MARKET_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "KONTUR_MARKET_CH_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### METRIKA_API {#entity-METRIKA_API1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `METRIKA_API`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "METRIKA_API",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MONITORING {#entity-MONITORING1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MONITORING`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MONITORING",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MOYSKLAD_CH_TABLE {#entity-MOYSKLAD_CH_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MOYSKLAD_CH_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MOYSKLAD_CH_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MSSQL_TABLE {#entity-MSSQL_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MSSQL_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MSSQL_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MSSQL_SUBSELECT {#entity-MSSQL_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MSSQL_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MSSQL_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MYSQL_TABLE {#entity-MYSQL_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MYSQL_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MYSQL_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### MYSQL_SUBSELECT {#entity-MYSQL_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `MYSQL_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "MYSQL_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ORACLE_TABLE {#entity-ORACLE_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ORACLE_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "ORACLE_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### ORACLE_SUBSELECT {#entity-ORACLE_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `ORACLE_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "ORACLE_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### PG_TABLE {#entity-PG_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `PG_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "PG_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### PG_SUBSELECT {#entity-PG_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `PG_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "PG_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### PROMQL {#entity-PROMQL1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SimpleParameters](#entity-SimpleParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `PROMQL`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {},
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "PROMQL",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_SMB_HEATMAPS_TABLE {#entity-CH_SMB_HEATMAPS_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_SMB_HEATMAPS_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_SMB_HEATMAPS_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SNOWFLAKE_TABLE {#entity-SNOWFLAKE_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SnowFlakeTableParameters](#entity-SnowFlakeTableParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "schema": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `SNOWFLAKE_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "schema": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "SNOWFLAKE_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### SPEECHSENSE_TABLE {#entity-SPEECHSENSE_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `SPEECHSENSE_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "SPEECHSENSE_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### TRINO_TABLE {#entity-TRINO_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SchematizedParameters](#entity-SchematizedParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "schema_name": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `TRINO_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "schema_name": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "TRINO_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### TRINO_SUBSELECT {#entity-TRINO_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `TRINO_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "TRINO_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_USAGE_TRACKING_TABLE {#entity-CH_USAGE_TRACKING_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_USAGE_TRACKING_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_USAGE_TRACKING_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### CH_USAGE_TRACKING_AGG_TABLE {#entity-CH_USAGE_TRACKING_AGG_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `CH_USAGE_TRACKING_AGG_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "CH_USAGE_TRACKING_AGG_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YDB_TABLE {#entity-YDB_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YDB_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YDB_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YDB_SUBSELECT {#entity-YDB_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YDB_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YDB_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YQ_TABLE {#entity-YQ_TABLE1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SQLParameters](#entity-SQLParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name": "example",
  "db_version": "example",
  "table_name": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YQ_TABLE`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YQ_TABLE",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### YQ_SUBSELECT {#entity-YQ_SUBSELECT1}

#|
|| **Name** | **Description** ||
||

_id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_title_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_connection_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_index_info_set_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "columns": [
      "example"
    ],
    "kind": "table_sorting"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_managed_by_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Enum:_{.json-schema-reset .json-schema-value} `user`, `feature`, `compiler_runtime`, `null`

_Example:_{.json-schema-reset .json-schema-example} `user`
{.table-cell}
||
||

_parameter_hash_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_parameters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SubselectParameters](#entity-SubselectParameters)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "subsql": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_raw_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: array &#124; null

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "description": "example",
    "has_auto_aggregation": true,
    "lock_aggregation": true,
    "name": "example",
    "native_type": {
      "name": "example"
    },
    "nullable": true,
    "title": "example",
    "user_type": "string"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_source_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `YQ_SUBSELECT`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_valid_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_virtual_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "subsql": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "YQ_SUBSELECT",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DataSourceStrict {#entity-DataSourceStrict1}

#|
|| **Name** | **Description** ||
|#{.json-schema-properties}

{% cut "**One of 42 types**" %}{.json-schema-combinators data-marker=or}

- **APPMETRICA_API**

  **Type**: [APPMETRICA_API](#entity-APPMETRICA_API1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "APPMETRICA_API",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **BIGQUERY_TABLE**

  **Type**: [BIGQUERY_TABLE](#entity-BIGQUERY_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "dataset_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "BIGQUERY_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **BIGQUERY_SUBSELECT**

  **Type**: [BIGQUERY_SUBSELECT](#entity-BIGQUERY_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "BIGQUERY_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **BITRIX_GDS**

  **Type**: [BITRIX_GDS](#entity-BITRIX_GDS1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "BITRIX_GDS",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_BILLING_ANALYTICS_TABLE**

  **Type**: [CH_BILLING_ANALYTICS_TABLE](#entity-CH_BILLING_ANALYTICS_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_BILLING_ANALYTICS_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_YA_MUSIC_PODCAST_STATS_TABLE**

  **Type**: [CH_YA_MUSIC_PODCAST_STATS_TABLE](#entity-CH_YA_MUSIC_PODCAST_STATS_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_YA_MUSIC_PODCAST_STATS_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_TABLE**

  **Type**: [CHYT_YTSAURUS_TABLE](#entity-CHYT_YTSAURUS_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_TABLE_LIST**

  **Type**: [CHYT_YTSAURUS_TABLE_LIST](#entity-CHYT_YTSAURUS_TABLE_LIST1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "table_names": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_TABLE_LIST",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_TABLE_RANGE**

  **Type**: [CHYT_YTSAURUS_TABLE_RANGE](#entity-CHYT_YTSAURUS_TABLE_RANGE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "directory_path": "example",
      "range_from": "example",
      "range_to": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_TABLE_RANGE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CHYT_YTSAURUS_SUBSELECT**

  **Type**: [CHYT_YTSAURUS_SUBSELECT](#entity-CHYT_YTSAURUS_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CHYT_YTSAURUS_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_TABLE**

  **Type**: [CH_TABLE](#entity-CH_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_SUBSELECT**

  **Type**: [CH_SUBSELECT](#entity-CH_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **EQUEO_CH_TABLE**

  **Type**: [EQUEO_CH_TABLE](#entity-EQUEO_CH_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "EQUEO_CH_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **EXTRACTOR_1C_CH_TABLE**

  **Type**: [EXTRACTOR_1C_CH_TABLE](#entity-EXTRACTOR_1C_CH_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "EXTRACTOR_1C_CH_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **GP_TABLE**

  **Type**: [GP_TABLE](#entity-GP_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "GP_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **GP_SUBSELECT**

  **Type**: [GP_SUBSELECT](#entity-GP_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "GP_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **GSHEETS**

  **Type**: [GSHEETS](#entity-GSHEETS1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "GSHEETS",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **JSON_API**

  **Type**: [JSON_API](#entity-JSON_API1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "JSON_API",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **KONTUR_MARKET_CH_TABLE**

  **Type**: [KONTUR_MARKET_CH_TABLE](#entity-KONTUR_MARKET_CH_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "KONTUR_MARKET_CH_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **METRIKA_API**

  **Type**: [METRIKA_API](#entity-METRIKA_API1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "METRIKA_API",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **MONITORING**

  **Type**: [MONITORING](#entity-MONITORING1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MONITORING",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **MOYSKLAD_CH_TABLE**

  **Type**: [MOYSKLAD_CH_TABLE](#entity-MOYSKLAD_CH_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MOYSKLAD_CH_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **MSSQL_TABLE**

  **Type**: [MSSQL_TABLE](#entity-MSSQL_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MSSQL_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **MSSQL_SUBSELECT**

  **Type**: [MSSQL_SUBSELECT](#entity-MSSQL_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MSSQL_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **MYSQL_TABLE**

  **Type**: [MYSQL_TABLE](#entity-MYSQL_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MYSQL_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **MYSQL_SUBSELECT**

  **Type**: [MYSQL_SUBSELECT](#entity-MYSQL_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "MYSQL_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **ORACLE_TABLE**

  **Type**: [ORACLE_TABLE](#entity-ORACLE_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "ORACLE_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **ORACLE_SUBSELECT**

  **Type**: [ORACLE_SUBSELECT](#entity-ORACLE_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "ORACLE_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **PG_TABLE**

  **Type**: [PG_TABLE](#entity-PG_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "PG_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **PG_SUBSELECT**

  **Type**: [PG_SUBSELECT](#entity-PG_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "PG_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **PROMQL**

  **Type**: [PROMQL](#entity-PROMQL1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {},
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "PROMQL",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_SMB_HEATMAPS_TABLE**

  **Type**: [CH_SMB_HEATMAPS_TABLE](#entity-CH_SMB_HEATMAPS_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_SMB_HEATMAPS_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **SNOWFLAKE_TABLE**

  **Type**: [SNOWFLAKE_TABLE](#entity-SNOWFLAKE_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "schema": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "SNOWFLAKE_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **SPEECHSENSE_TABLE**

  **Type**: [SPEECHSENSE_TABLE](#entity-SPEECHSENSE_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "SPEECHSENSE_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **TRINO_TABLE**

  **Type**: [TRINO_TABLE](#entity-TRINO_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "schema_name": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "TRINO_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **TRINO_SUBSELECT**

  **Type**: [TRINO_SUBSELECT](#entity-TRINO_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "TRINO_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_USAGE_TRACKING_TABLE**

  **Type**: [CH_USAGE_TRACKING_TABLE](#entity-CH_USAGE_TRACKING_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_USAGE_TRACKING_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **CH_USAGE_TRACKING_AGG_TABLE**

  **Type**: [CH_USAGE_TRACKING_AGG_TABLE](#entity-CH_USAGE_TRACKING_AGG_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "CH_USAGE_TRACKING_AGG_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **YDB_TABLE**

  **Type**: [YDB_TABLE](#entity-YDB_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YDB_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **YDB_SUBSELECT**

  **Type**: [YDB_SUBSELECT](#entity-YDB_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YDB_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **YQ_TABLE**

  **Type**: [YQ_TABLE](#entity-YQ_TABLE1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YQ_TABLE",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

- **YQ_SUBSELECT**

  **Type**: [YQ_SUBSELECT](#entity-YQ_SUBSELECT1)

  {% cut "**Example**" %}{.json-schema-example}

  ```json translate=no
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "subsql": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": {},
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "YQ_SUBSELECT",
    "title": "example",
    "valid": true,
    "virtual": null
  }
  ```

  {% endcut %}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connection_id": "example",
  "id": "example",
  "index_info_set": null,
  "managed_by": "user",
  "parameter_hash": "example",
  "parameters": {
    "db_name": "example",
    "db_version": "example",
    "table_name": "example"
  },
  "raw_schema": [
    {
      "description": "example",
      "has_auto_aggregation": true,
      "lock_aggregation": true,
      "name": "example",
      "native_type": {},
      "nullable": true,
      "title": "example",
      "user_type": "string"
    }
  ],
  "source_type": "APPMETRICA_API",
  "title": "example",
  "valid": true,
  "virtual": null
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DatasetContentInternal {#entity-DatasetContentInternal1}

#|
|| **Name** | **Description** ||
||

_avatar_relations_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [AvatarRelation](#entity-AvatarRelation1)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "conditions": [
      {
        "left": {},
        "operator": "gt",
        "right": null,
        "type": "binary"
      }
    ],
    "id": "example",
    "join_type": "inner",
    "left_avatar_id": "example",
    "managed_by": "user",
    "required": false,
    "right_avatar_id": "example",
    "virtual": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_cache_invalidation_source_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CacheInvalidationSource](#entity-CacheInvalidationSource1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "cache_invalidation_error": null,
  "field": null,
  "filters": [
    {
      "default_filters": [],
      "field_guid": "example",
      "id": "example",
      "managed_by": "user",
      "valid": true
    }
  ],
  "mode": "off",
  "sql": "null"
}
```

{% endcut %}
{.table-cell}
||
||

_component_errors_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ComponentErrorList](#entity-ComponentErrorList)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "errors": [
        {
          "code": null,
          "details": {},
          "level": "error",
          "message": "example"
        }
      ],
      "id": "example",
      "type": "data_source"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_data_export_forbidden_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_description_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} ``
{.table-cell}
||
||

_load_preview_by_default_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `true`
{.table-cell}
||
||

_obligatory_filters_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ObligatoryFilter](#entity-ObligatoryFilter)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "default_filters": [],
    "field_guid": "example",
    "id": "example",
    "managed_by": "user",
    "valid": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_preview_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
||

_result_schema_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ResultSchemaSchemaGeneric](#entity-ResultSchemaSchemaGeneric1)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "aggregation": "none",
    "aggregation_locked": false,
    "autoaggregated": true,
    "avatar_id": "example",
    "cast": "string",
    "data_type": "string",
    "description": "example",
    "guid": "example",
    "has_auto_aggregation": true,
    "hidden": false,
    "initial_data_type": "string",
    "lock_aggregation": true,
    "managed_by": "user",
    "source": "example",
    "title": "example",
    "type": "DIMENSION",
    "ui_settings": "",
    "valid": true,
    "virtual": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_result_schema_aux_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [ResultSchemaAux](#entity-ResultSchemaAux)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "inter_dependencies": {
    "deps": [
      {
        "dep_field_id": "example",
        "ref_field_ids": [
          "example"
        ]
      }
    ]
  }
}
```

{% endcut %}
{.table-cell}
||
||

_revision_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

_Default:_{.json-schema-reset .json-schema-value} `null`
{.table-cell}
||
||

_rls_{.json-schema-reset .json-schema-property}
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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_rls2_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: [RLS2ConfigEntry](#entity-RLS2ConfigEntry)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "allowed_value": "null",
    "field_guid": "null",
    "pattern_type": "value",
    "subject": {
      "subject_id": "example",
      "subject_name": "null",
      "subject_type": "user"
    }
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_source_avatars_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceAvatarStrict](#entity-SourceAvatarStrict1)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "is_root": true,
    "managed_by": "user",
    "source_id": "example",
    "title": "example",
    "valid": true,
    "virtual": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataSourceStrict](#entity-DataSourceStrict1)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "connection_id": "example",
    "id": "example",
    "index_info_set": null,
    "managed_by": "user",
    "parameter_hash": "example",
    "parameters": {
      "db_name": "example",
      "db_version": "example",
      "table_name": "example"
    },
    "raw_schema": [
      {
        "description": "example",
        "has_auto_aggregation": true,
        "lock_aggregation": true,
        "name": "example",
        "native_type": null,
        "nullable": true,
        "title": "example",
        "user_type": "string"
      }
    ],
    "source_type": "APPMETRICA_API",
    "title": "example",
    "valid": true,
    "virtual": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_template_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

_Default:_{.json-schema-reset .json-schema-value} `false`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "avatar_relations": [
    {
      "conditions": [
        {
          "left": {},
          "operator": "gt",
          "right": null,
          "type": "binary"
        }
      ],
      "id": "example",
      "join_type": "inner",
      "left_avatar_id": "example",
      "managed_by": "user",
      "required": false,
      "right_avatar_id": "example",
      "virtual": null
    }
  ],
  "cache_invalidation_source": {
    "cache_invalidation_error": null,
    "field": null,
    "filters": [
      {
        "default_filters": [],
        "field_guid": "example",
        "id": "example",
        "managed_by": "user",
        "valid": true
      }
    ],
    "mode": "off",
    "sql": "null"
  },
  "component_errors": {
    "items": [
      {
        "errors": [
          {}
        ],
        "id": "example",
        "type": "data_source"
      }
    ]
  },
  "data_export_forbidden": false,
  "description": "",
  "load_preview_by_default": true,
  "obligatory_filters": [
    null
  ],
  "preview_enabled": false,
  "result_schema": [
    {
      "aggregation": "none",
      "aggregation_locked": false,
      "autoaggregated": true,
      "avatar_id": "example",
      "cast": "string",
      "data_type": "string",
      "description": "example",
      "guid": "example",
      "has_auto_aggregation": true,
      "hidden": false,
      "initial_data_type": "string",
      "lock_aggregation": true,
      "managed_by": "user",
      "source": "example",
      "title": "example",
      "type": "DIMENSION",
      "ui_settings": "",
      "valid": true,
      "virtual": null
    }
  ],
  "result_schema_aux": {
    "inter_dependencies": {
      "deps": [
        {
          "dep_field_id": "example",
          "ref_field_ids": [
            null
          ]
        }
      ]
    }
  },
  "revision_id": "null",
  "rls": {},
  "rls2": {},
  "source_avatars": [
    {
      "id": "example",
      "is_root": true,
      "managed_by": "user",
      "source_id": "example",
      "title": "example",
      "valid": true,
      "virtual": null
    }
  ],
  "sources": [
    {
      "connection_id": "example",
      "id": "example",
      "index_info_set": null,
      "managed_by": "user",
      "parameter_hash": "example",
      "parameters": {
        "db_name": "example",
        "db_version": "example",
        "table_name": "example"
      },
      "raw_schema": [
        {}
      ],
      "source_type": "APPMETRICA_API",
      "title": "example",
      "valid": true,
      "virtual": null
    }
  ],
  "template_enabled": false
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Sources {#entity-Sources1}

#|
|| **Name** | **Description** ||
||

_compatible_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [CompatSourceTypeListItem](#entity-CompatSourceTypeListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "source_type": null
  }
]
```

{% endcut %}
{.table-cell}
||
||

_items_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceListItem1](#entity-SourceListItem)[]

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "schema_update_enabled": true
  }
]
```

{% endcut %}
{.table-cell}
||
||

_max_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "source_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### Options {#entity-Options1}

#|
|| **Name** | **Description** ||
||

_connections_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Connections](#entity-Connections)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "conn_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "replacement_types": [
        null
      ]
    }
  ],
  "max": 0
}
```

{% endcut %}
{.table-cell}
||
||

_data_types_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [DataTypes](#entity-DataTypes)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "aggregations": [
        "none"
      ],
      "casts": [
        "string"
      ],
      "filter_operations": [
        "ISNULL"
      ],
      "type": "string"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_fields_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Fields](#entity-Fields)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "aggregations": [
        "none"
      ],
      "casts": [
        "string"
      ],
      "guid": "example"
    }
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_is_cache_invalidation_enabled_in_conn_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_join_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Join](#entity-Join)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "operators": [
    "gt"
  ],
  "types": [
    "inner"
  ]
}
```

{% endcut %}
{.table-cell}
||
||

_preview_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Preview](#entity-Preview)

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

_schema_update_enabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
||

_source_avatars_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Avatars](#entity-Avatars)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}
{.table-cell}
||
||

_source_listing_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SourceListing](#entity-SourceListing)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "db_name_label": "example",
  "db_name_required_for_search": true,
  "supports_db_name_listing": true,
  "supports_source_pagination": true,
  "supports_source_search": true
}
```

{% endcut %}
{.table-cell}
||
||

_sources_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Sources](#entity-Sources1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "compatible_types": [
    {
      "source_type": null
    }
  ],
  "items": [
    {
      "id": "example",
      "schema_update_enabled": true
    }
  ],
  "max": 0
}
```

{% endcut %}
{.table-cell}
||
||

_supported_functions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

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

_supports_offset_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connections": {
    "compatible_types": [
      {
        "conn_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "replacement_types": [
          null
        ]
      }
    ],
    "max": 0
  },
  "data_types": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "filter_operations": [
          "ISNULL"
        ],
        "type": "string"
      }
    ]
  },
  "fields": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "guid": "example"
      }
    ]
  },
  "is_cache_invalidation_enabled_in_conn": true,
  "join": {
    "operators": [
      "gt"
    ],
    "types": [
      "inner"
    ]
  },
  "preview": {
    "enabled": true
  },
  "schema_update_enabled": true,
  "source_avatars": {
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "source_listing": {
    "db_name_label": "example",
    "db_name_required_for_search": true,
    "supports_db_name_listing": true,
    "supports_source_pagination": true,
    "supports_source_search": true
  },
  "sources": {
    "compatible_types": [
      {
        "source_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "supported_functions": [
    "example"
  ],
  "supports_offset": true
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### DatasetUpdate {#entity-DatasetUpdate1}

#|
|| **Name** | **Description** ||
||

_dataset_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [DatasetContentInternal](#entity-DatasetContentInternal1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "avatar_relations": [
    {
      "conditions": [
        {
          "left": {},
          "operator": "gt",
          "right": null,
          "type": "binary"
        }
      ],
      "id": "example",
      "join_type": "inner",
      "left_avatar_id": "example",
      "managed_by": "user",
      "required": false,
      "right_avatar_id": "example",
      "virtual": null
    }
  ],
  "cache_invalidation_source": {
    "cache_invalidation_error": null,
    "field": null,
    "filters": [
      {
        "default_filters": [],
        "field_guid": "example",
        "id": "example",
        "managed_by": "user",
        "valid": true
      }
    ],
    "mode": "off",
    "sql": "null"
  },
  "component_errors": {
    "items": [
      {
        "errors": [
          {}
        ],
        "id": "example",
        "type": "data_source"
      }
    ]
  },
  "data_export_forbidden": false,
  "description": "",
  "load_preview_by_default": true,
  "obligatory_filters": [
    null
  ],
  "preview_enabled": false,
  "result_schema": [
    {
      "aggregation": "none",
      "aggregation_locked": false,
      "autoaggregated": true,
      "avatar_id": "example",
      "cast": "string",
      "data_type": "string",
      "description": "example",
      "guid": "example",
      "has_auto_aggregation": true,
      "hidden": false,
      "initial_data_type": "string",
      "lock_aggregation": true,
      "managed_by": "user",
      "source": "example",
      "title": "example",
      "type": "DIMENSION",
      "ui_settings": "",
      "valid": true,
      "virtual": null
    }
  ],
  "result_schema_aux": {
    "inter_dependencies": {
      "deps": [
        {
          "dep_field_id": "example",
          "ref_field_ids": [
            null
          ]
        }
      ]
    }
  },
  "revision_id": "null",
  "rls": {},
  "rls2": {},
  "source_avatars": [
    {
      "id": "example",
      "is_root": true,
      "managed_by": "user",
      "source_id": "example",
      "title": "example",
      "valid": true,
      "virtual": null
    }
  ],
  "sources": [
    {
      "connection_id": "example",
      "id": "example",
      "index_info_set": null,
      "managed_by": "user",
      "parameter_hash": "example",
      "parameters": {
        "db_name": "example",
        "db_version": "example",
        "table_name": "example"
      },
      "raw_schema": [
        {}
      ],
      "source_type": "APPMETRICA_API",
      "title": "example",
      "valid": true,
      "virtual": null
    }
  ],
  "template_enabled": false
}
```

{% endcut %}
{.table-cell}
||
||

_options_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [Options](#entity-Options1)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "connections": {
    "compatible_types": [
      {
        "conn_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "replacement_types": [
          null
        ]
      }
    ],
    "max": 0
  },
  "data_types": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "filter_operations": [
          "ISNULL"
        ],
        "type": "string"
      }
    ]
  },
  "fields": {
    "items": [
      {
        "aggregations": [
          "none"
        ],
        "casts": [
          "string"
        ],
        "guid": "example"
      }
    ]
  },
  "is_cache_invalidation_enabled_in_conn": true,
  "join": {
    "operators": [
      "gt"
    ],
    "types": [
      "inner"
    ]
  },
  "preview": {
    "enabled": true
  },
  "schema_update_enabled": true,
  "source_avatars": {
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "source_listing": {
    "db_name_label": "example",
    "db_name_required_for_search": true,
    "supports_db_name_listing": true,
    "supports_source_pagination": true,
    "supports_source_search": true
  },
  "sources": {
    "compatible_types": [
      {
        "source_type": null
      }
    ],
    "items": [
      {
        "id": "example",
        "schema_update_enabled": true
      }
    ],
    "max": 0
  },
  "supported_functions": [
    "example"
  ],
  "supports_offset": true
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataset": {
    "avatar_relations": [
      {
        "conditions": [
          {}
        ],
        "id": "example",
        "join_type": "inner",
        "left_avatar_id": "example",
        "managed_by": "user",
        "required": false,
        "right_avatar_id": "example",
        "virtual": null
      }
    ],
    "cache_invalidation_source": {
      "cache_invalidation_error": null,
      "field": null,
      "filters": [
        {
          "default_filters": [],
          "field_guid": "example",
          "id": "example",
          "managed_by": "user",
          "valid": true
        }
      ],
      "mode": "off",
      "sql": "null"
    },
    "component_errors": {
      "items": [
        {
          "errors": [
            null
          ],
          "id": "example",
          "type": "data_source"
        }
      ]
    },
    "data_export_forbidden": false,
    "description": "",
    "load_preview_by_default": true,
    "obligatory_filters": [
      null
    ],
    "preview_enabled": false,
    "result_schema": [
      {
        "aggregation": "none",
        "aggregation_locked": false,
        "autoaggregated": true,
        "avatar_id": "example",
        "cast": "string",
        "data_type": "string",
        "description": "example",
        "guid": "example",
        "has_auto_aggregation": true,
        "hidden": false,
        "initial_data_type": "string",
        "lock_aggregation": true,
        "managed_by": "user",
        "source": "example",
        "title": "example",
        "type": "DIMENSION",
        "ui_settings": "",
        "valid": true,
        "virtual": null
      }
    ],
    "result_schema_aux": {
      "inter_dependencies": {
        "deps": [
          {}
        ]
      }
    },
    "revision_id": "null",
    "rls": {},
    "rls2": {},
    "source_avatars": [
      {
        "id": "example",
        "is_root": true,
        "managed_by": "user",
        "source_id": "example",
        "title": "example",
        "valid": true,
        "virtual": null
      }
    ],
    "sources": [
      {
        "connection_id": "example",
        "id": "example",
        "index_info_set": null,
        "managed_by": "user",
        "parameter_hash": "example",
        "parameters": {},
        "raw_schema": [
          null
        ],
        "source_type": "APPMETRICA_API",
        "title": "example",
        "valid": true,
        "virtual": null
      }
    ],
    "template_enabled": false
  },
  "options": {
    "connections": {
      "compatible_types": [
        {
          "conn_type": null
        }
      ],
      "items": [
        {
          "id": "example",
          "replacement_types": [
            null
          ]
        }
      ],
      "max": 0
    },
    "data_types": {
      "items": [
        {
          "aggregations": [
            null
          ],
          "casts": [
            null
          ],
          "filter_operations": [
            null
          ],
          "type": "string"
        }
      ]
    },
    "fields": {
      "items": [
        {
          "aggregations": [
            null
          ],
          "casts": [
            null
          ],
          "guid": "example"
        }
      ]
    },
    "is_cache_invalidation_enabled_in_conn": true,
    "join": {
      "operators": [
        "gt"
      ],
      "types": [
        "inner"
      ]
    },
    "preview": {
      "enabled": true
    },
    "schema_update_enabled": true,
    "source_avatars": {
      "items": [
        {
          "id": "example",
          "schema_update_enabled": true
        }
      ],
      "max": 0
    },
    "source_listing": {
      "db_name_label": "example",
      "db_name_required_for_search": true,
      "supports_db_name_listing": true,
      "supports_source_pagination": true,
      "supports_source_search": true
    },
    "sources": {
      "compatible_types": [
        {
          "source_type": null
        }
      ],
      "items": [
        {
          "id": "example",
          "schema_update_enabled": true
        }
      ],
      "max": 0
    },
    "supported_functions": [
      "example"
    ],
    "supports_offset": true
  }
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.