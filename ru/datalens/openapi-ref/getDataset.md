---
editable: false
---

# DataLens API: Get dataset

## HTTP request

Returns the specified dataset.

```
POST https://api.datalens.yandex.net/rpc/getDataset
```

## Body parameters

**Request schema: application/json**

```json
{
  "datasetId": "string",
  "workbookId": "string | null",
  "rev_id": "string"
}
```

#|
||Field | Description ||
|| datasetId | **string**

Required field. ID of the dataset to retrieve. You can find it in the dataset settings in DataLens interface. ||
|| workbookId | **string \| null**

ID of the workbook the dataset belongs to. If navigation across folders is enabled and the dataset belongs to a folder, the value must be `null`. ||
|| rev_id | **string** 

Version ID for the dataset. For details, see [documentation](https://docs.yandex-team.ru/cloud/datalens/dataset/versioning). ||
|#

## Response {#200}

**HTTP Code: 200**

**Response schema: application/json**

```json
{
  "dataset": {
    "avatar_relations": [
      {
        "conditions": [
          {
            "left": {
              "<oneOf>": [
                {
                  "calc_mode": "string",
                  "source": "string"
                },
                {
                  "calc_mode": "string",
                  "formula": "string"
                },
                {
                  "calc_mode": "string",
                  "field_id": "string"
                }
              ]
            },
            "operator": "string",
            "right": {
              "<oneOf>": [
                {
                  "calc_mode": "string",
                  "source": "string"
                },
                {
                  "calc_mode": "string",
                  "formula": "string"
                },
                {
                  "calc_mode": "string",
                  "field_id": "string"
                }
              ]
            },
            "type": "string"
          }
        ],
        "id": "string",
        "join_type": "string",
        "left_avatar_id": "string",
        "managed_by": "string | null",
        "required": "boolean",
        "right_avatar_id": "string",
        "virtual": "unknown"
      }
    ],
    "component_errors": {
      "items": [
        {
          "errors": [
            {
              "code": "unknown",
              "details": {
                "string": "unknown"
              },
              "level": "string",
              "message": "string"
            }
          ],
          "id": "string",
          "type": "string"
        }
      ]
    },
    "data_export_forbidden": "boolean",
    "description": "string | null",
    "load_preview_by_default": "boolean",
    "obligatory_filters": [
      {
        "default_filters": [
          {
            "column": "string",
            "operation": "string",
            "values": "array | null"
          }
        ],
        "field_guid": "string",
        "id": "string",
        "managed_by": "string | null",
        "valid": "boolean"
      }
    ],
    "preview_enabled": "boolean",
    "result_schema": [
      {
        "<oneOf>": [
          {
            "aggregation": "string",
            "aggregation_locked": "boolean | null",
            "autoaggregated": "boolean | null",
            "avatar_id": "string | null",
            "cast": "string",
            "data_type": "string | null",
            "description": "string",
            "guid": "string",
            "has_auto_aggregation": "boolean | null",
            "hidden": "boolean",
            "initial_data_type": "string | null",
            "lock_aggregation": "boolean | null",
            "managed_by": "string | null",
            "source": "string",
            "title": "string",
            "type": "string",
            "ui_settings": "string",
            "valid": "boolean | null",
            "virtual": "unknown"
          },
          {
            "aggregation": "string",
            "aggregation_locked": "boolean | null",
            "autoaggregated": "boolean | null",
            "cast": "string",
            "data_type": "string | null",
            "description": "string",
            "formula": "string",
            "guid": "string",
            "guid_formula": "string",
            "has_auto_aggregation": "boolean | null",
            "hidden": "boolean",
            "initial_data_type": "string | null",
            "lock_aggregation": "boolean | null",
            "managed_by": "string | null",
            "title": "string",
            "type": "string",
            "ui_settings": "string",
            "valid": "boolean | null",
            "virtual": "unknown"
          },
          {
            "aggregation": "string",
            "aggregation_locked": "boolean | null",
            "autoaggregated": "boolean | null",
            "cast": "string",
            "data_type": "string | null",
            "default_value": "string | null",
            "description": "string",
            "guid": "string",
            "has_auto_aggregation": "boolean | null",
            "hidden": "boolean",
            "initial_data_type": "string | null",
            "lock_aggregation": "boolean | null",
            "managed_by": "string | null",
            "template_enabled": "boolean",
            "title": "string",
            "type": "string",
            "ui_settings": "string",
            "valid": "boolean | null",
            "value_constraint": "unknown",
            "virtual": "unknown"
          }
        ]
      }
    ],
    "result_schema_aux": {
      "inter_dependencies": {
        "deps": [
          {
            "dep_field_id": "string",
            "ref_field_ids": [
              "string"
            ]
          }
        ]
      }
    },
    "revision_id": "string | null",
    "rls": {
      "string": "unknown"
    },
    "source_avatars": [
      {
        "id": "string",
        "is_root": "boolean",
        "managed_by": "string | null",
        "source_id": "string",
        "title": "string",
        "valid": "boolean",
        "virtual": "unknown"
      }
    ],
    "sources": [
      {
        "<oneOf>": [
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "APPMETRICA_API",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "table_names": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_TABLE_LIST",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "directory_path": "string",
              "range_from": "string",
              "range_to": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_TABLE_RANGE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_USER_AUTH_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "table_names": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_USER_AUTH_TABLE_LIST",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "directory_path": "string",
              "range_from": "string",
              "range_to": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_USER_AUTH_TABLE_RANGE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CHYT_USER_AUTH_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "CH_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "CH_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "schema_name": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "GP_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "GP_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {},
            "raw_schema": "array | null",
            "source_type": "GSHEETS",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {},
            "raw_schema": "array | null",
            "source_type": "JSON_API",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "METRIKA_API",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "schema_name": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "MSSQL_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "MSSQL_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "MYSQL_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "MYSQL_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "schema_name": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "ORACLE_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "ORACLE_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "schema_name": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "PG_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "PG_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {},
            "raw_schema": "array | null",
            "source_type": "PROMQL",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {},
            "raw_schema": "array | null",
            "source_type": "SOLOMON",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "CH_USAGE_TRACKING_YA_TEAM_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "db_name": "string | null",
              "db_version": "string | null",
              "table_name": "string | null"
            },
            "raw_schema": "array | null",
            "source_type": "YDB_TABLE",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          },
          {
            "connection_id": "string | null",
            "id": "string",
            "index_info_set": "array | null",
            "managed_by": "string | null",
            "parameter_hash": "string",
            "parameters": {
              "subsql": "string"
            },
            "raw_schema": "array | null",
            "source_type": "YDB_SUBSELECT",
            "title": "string",
            "valid": "boolean",
            "virtual": "unknown"
          }
        ]
      }
    ],
    "template_enabled": "boolean"
  },
  "id": "string",
  "is_favorite": "boolean",
  "key": "string",
  "options": {
    "connections": {
      "compatible_types": [
        {
          "conn_type": "unknown"
        }
      ],
      "items": [
        {
          "id": "string",
          "replacement_types": [
            {
              "conn_type": "unknown"
            }
          ]
        }
      ],
      "max": "integer"
    },
    "data_types": {
      "items": [
        {
          "aggregations": [
            "string"
          ],
          "casts": [
            "string"
          ],
          "filter_operations": [
            "string"
          ],
          "type": "string"
        }
      ]
    },
    "fields": {
      "items": [
        {
          "aggregations": [
            "string"
          ],
          "casts": [
            "string"
          ],
          "guid": "string"
        }
      ]
    },
    "join": {
      "operators": [
        "string"
      ],
      "types": [
        "string"
      ]
    },
    "preview": {
      "enabled": "boolean"
    },
    "schema_update_enabled": "boolean",
    "source_avatars": {
      "items": [
        {
          "id": "string",
          "schema_update_enabled": "boolean"
        }
      ],
      "max": "integer"
    },
    "source_listing": {
      "db_name_label": "string",
      "db_name_required_for_search": "boolean",
      "supports_db_name_listing": "boolean",
      "supports_source_pagination": "boolean",
      "supports_source_search": "boolean"
    },
    "sources": {
      "compatible_types": [
        {
          "source_type": "unknown"
        }
      ],
      "items": [
        {
          "id": "string",
          "schema_update_enabled": "boolean"
        }
      ],
      "max": "integer"
    },
    "supported_functions": [
      "string"
    ],
    "supports_offset": "boolean"
  },
  "permissions": {
    "string": "boolean"
  }
}
```

#|
||Field | Description ||
|| dataset | **[DatasetContentInternal](#DatasetContentInternal)**

Required field. Dataset object containing all dataset properties. ||
|| id | **string** 

ID of the dataset. ||
|| is_favorite | **boolean** 

Indicates if the dataset is marked as favorite. ||
|| key | **string** 

Key of the dataset entry. Indicates the path and name of the dataset. ||
|| options | **[Options](#Options)** 

Dataset options configuration. ||
|| permissions | **object** (map<**string**, **boolean**>) 

Permissions for the dataset. ||
|#

## DatasetContentInternal {#DatasetContentInternal}

#|
||Field | Description ||
|| avatar_relations[] | **[AvatarRelation](#AvatarRelation)**

Required field. Avatar relations (JOIN conditions) in the dataset. ||
|| component_errors | **[ComponentErrorList](#ComponentErrorList)** 

A list of dataset validation errors including IDs of affected components (data sources, fields, etc.) ||
|| data_export_forbidden | **boolean** 

Indicates if data export is forbidden. ||
|| description | **string \| null** 

Description of the dataset. ||
|| load_preview_by_default | **boolean** 

Indicates whether to load preview by default. ||
|| obligatory_filters[] | **[ObligatoryFilter](#ObligatoryFilter)**

Required field. Filters for the dataset. ||
|| preview_enabled | **boolean** 

Indicates whether preview is enabled. ||
|| result_schema[] | **[ResultSchemaSchemaGeneric](#ResultSchemaSchemaGeneric)** 

Result schema of the dataset. ||
|| result_schema_aux | **[ResultSchemaAux](#ResultSchemaAux)** 

Auxiliary result schema information. ||
|| revision_id | **string \| null** 

Revision ID of the dataset. ||
|| rls | **object** (map<**string**, **unknown**>)

Row-level security configuration. ||
|| source_avatars[] | **[SourceAvatarStrict](#SourceAvatarStrict)**

Required field. Source avatars in the dataset. ||
|| sources[] | **[DataSourceStrict](#DataSourceStrict)** 

Data sources in the dataset. ||
|| template_enabled | **boolean** 

Indicates whether template is enabled. ||
|#

## AvatarRelation {#AvatarRelation}

#|
||Field | Description ||
|| conditions[] | **[JoinCondition](#JoinCondition)**

Required field. JOIN conditions. ||
|| id | **string**

Required field. ID of the relation. ||
|| join_type | **enum**

Type of JOIN condition:

- `inner`
- `left`
- `right`
- `full` ||
|| left_avatar_id | **string** 

ID of the left table. ||
|| managed_by | **enum**

Reserved for future extensions. Indicates the entity that is allowed to manage the component. When creating or editing datasets, always use value `user`, using other values may lead to unexpected results.

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| required | **boolean** 

Indicates if table relation is required. ||
|| right_avatar_id | **string** 

ID of the right table. ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

## JoinCondition {#JoinCondition}

#|
||Field | Description ||
|| left | One of **[direct1](#direct1)** \| **[formula2](#formula2)** \| **[result_field](#result_field)** ||
|| operator | **enum**

Required field. Relational operator.

- `gt` — greater than;
- `lt` — less than;
- `gte`— greater than or equal to;
- `lte` — less than or equal to;
- `eq` — equal to;
- `ne` — not equal to. ||
|| right | One of **[direct1](#direct1)** \| **[formula2](#formula2)** \| **[result_field](#result_field)** ||
|| type | **enum**

Required field. Type of the operator, equals to:

- `binary` ||
|#

## direct1 {#direct1}

#|
||Field | Description ||
|| calc_mode | **enum**

Required field. 

- `direct` — field from the source;
- `formula` — calculated field;
- `result_field` — result field. ||
|| source | **string**

Required field.  ||
|#

## formula2 {#formula2}

#|
||Field | Description ||
|| calc_mode | **enum**

Required field. 

- `direct`
- `formula`
- `result_field` ||
|| formula | **string**

Required field.  ||
|#

## result_field {#result_field}

#|
||Field | Description ||
|| calc_mode | **enum**

Required field. 

- `direct`
- `formula`
- `result_field` ||
|| field_id | **string**

Required field.  ||
|#

## ComponentErrorList {#ComponentErrorList}

#|
||Field | Description ||
|| items[] | **[ComponentErrorPack](#ComponentErrorPack)** ||
|#

## ComponentErrorPack {#ComponentErrorPack}

#|
||Field | Description ||
|| errors[] | **[ComponentError](#ComponentError)** ||
|| id | **string** ||
|| type | **enum**

- `data_source`
- `source_avatar`
- `avatar_relation`
- `field`
- `obligatory_filter`
- `result_schema` ||
|#

## ComponentError {#ComponentError}

#|
||Field | Description ||
|| code | **unknown** ||
|| details | **object** (map<**string**, **unknown**>) ||
|| level | **enum**

- `error`
- `warning` ||
|| message | **string** ||
|#

## ObligatoryFilter {#ObligatoryFilter}

#|
||Field | Description ||
|| default_filters[] | **[Where](#Where)**

Required field.  ||
|| field_guid | **string** ||
|| id | **string**

Required field.  ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| valid | **boolean** ||
|#

## Where {#Where}

#|
||Field | Description ||
|| column | **string**

Required field.  ||
|| operation | **enum**

Required field. 

- `ISNULL`
- `ISNOTNULL`
- `GT`
- `LT`
- `GTE`
- `LTE`
- `EQ`
- `NE`
- `STARTSWITH`
- `ISTARTSWITH`
- `ENDSWITH`
- `IENDSWITH`
- `CONTAINS`
- `ICONTAINS`
- `NOTCONTAINS`
- `NOTICONTAINS`
- `LENEQ`
- `LENNE`
- `LENGT`
- `LENGTE`
- `LENLT`
- `LENLTE`
- `IN`
- `NIN`
- `BETWEEN` ||
|| values | **array \| null**

Required field.  ||
|#

## ResultSchemaSchemaGeneric {#ResultSchemaSchemaGeneric}

One of:

#|
||Field | Description ||
|| aggregation | **enum**

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| aggregation_locked | **boolean \| null** ||
|| autoaggregated | **boolean \| null** ||
|| avatar_id | **string \| null** ||
|| cast | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime` ||
|| data_type | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime`
- `null` ||
|| description | **string** ||
|| guid | **string** ||
|| has_auto_aggregation | **boolean \| null** ||
|| hidden | **boolean** ||
|| initial_data_type | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime`
- `null` ||
|| lock_aggregation | **boolean \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| source | **string** ||
|| title | **string**

Required field.  ||
|| type | **enum**

- `DIMENSION`
- `MEASURE` ||
|| ui_settings | **string** ||
|| valid | **boolean \| null** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| aggregation | **enum**

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| aggregation_locked | **boolean \| null** ||
|| autoaggregated | **boolean \| null** ||
|| cast | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime` ||
|| data_type | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime`
- `null` ||
|| description | **string** ||
|| formula | **string** ||
|| guid | **string** ||
|| guid_formula | **string** ||
|| has_auto_aggregation | **boolean \| null** ||
|| hidden | **boolean** ||
|| initial_data_type | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime`
- `null` ||
|| lock_aggregation | **boolean \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| title | **string**

Required field.  ||
|| type | **enum**

- `DIMENSION`
- `MEASURE` ||
|| ui_settings | **string** ||
|| valid | **boolean \| null** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| aggregation | **enum**

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| aggregation_locked | **boolean \| null** ||
|| autoaggregated | **boolean \| null** ||
|| cast | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime` ||
|| data_type | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime`
- `null` ||
|| default_value | **string \| null** ||
|| description | **string** ||
|| guid | **string** ||
|| has_auto_aggregation | **boolean \| null** ||
|| hidden | **boolean** ||
|| initial_data_type | **enum**

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime`
- `null` ||
|| lock_aggregation | **boolean \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| template_enabled | **boolean** ||
|| title | **string**

Required field.  ||
|| type | **enum**

- `DIMENSION`
- `MEASURE` ||
|| ui_settings | **string** ||
|| valid | **boolean \| null** ||
|| value_constraint | Any of **[ParameterValueConstraint](#ParameterValueConstraint)** \| **null** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## ParameterValueConstraint {#ParameterValueConstraint}

One of:

#|
||Field | Description ||
|| pattern | **string** ||
|| type | **regex** (const) ||
|#

>

#|
||Field | Description ||
|| type | **default** (const) ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## ResultSchemaAux {#ResultSchemaAux}

#|
||Field | Description ||
|| inter_dependencies | **[FieldInterDependencyInfo](#FieldInterDependencyInfo)** ||
|#

## FieldInterDependencyInfo {#FieldInterDependencyInfo}

#|
||Field | Description ||
|| deps[] | **[FieldInterDependencyItem](#FieldInterDependencyItem)** ||
|#

## FieldInterDependencyItem {#FieldInterDependencyItem}

#|
||Field | Description ||
|| dep_field_id | **string** ||
|| ref_field_ids[] | **string** ||
|#

## RLSSubject {#RLSSubject}

#|
||Field | Description ||
|| subject_id | **string**

Required field.  ||
|| subject_name | **string \| null** ||
|| subject_type | **enum**

- `user`
- `group`
- `all`
- `userid`
- `unknown`
- `notfound` ||
|#

## SourceAvatarStrict {#SourceAvatarStrict}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| is_root | **boolean** ||
|| managed_by | **enum**

Required field. 

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| source_id | **string** ||
|| title | **string** ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

## DataSourceStrict {#DataSourceStrict}

One of:

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **APPMETRICA_API** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[CHYTTableListParameters](#CHYTTableListParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_TABLE_LIST** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[CHYTTableRangeParameters](#CHYTTableRangeParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_TABLE_RANGE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[CHYTTableListParameters](#CHYTTableListParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_TABLE_LIST** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[CHYTTableRangeParameters](#CHYTTableRangeParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_TABLE_RANGE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CH_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CH_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SchematizedParameters](#SchematizedParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **GP_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **GP_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SimpleParameters](#SimpleParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **GSHEETS** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SimpleParameters](#SimpleParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **JSON_API** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **METRIKA_API** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SchematizedParameters](#SchematizedParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MSSQL_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MSSQL_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MYSQL_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MYSQL_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SchematizedParameters](#SchematizedParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **ORACLE_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **ORACLE_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SchematizedParameters](#SchematizedParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **PG_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **PG_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SimpleParameters](#SimpleParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **PROMQL** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SimpleParameters](#SimpleParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **SOLOMON** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CH_USAGE_TRACKING_YA_TEAM_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SQLParameters](#SQLParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **YDB_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| connection_id | **string \| null** ||
|| id | **string**

Required field.  ||
|| index_info_set | **array \| null** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| parameter_hash | **string** ||
|| parameters | **[SubselectParameters](#SubselectParameters)** ||
|| raw_schema | **array \| null** ||
|| source_type | **YDB_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** 

Indicates whether a certain component is managed by the service. Service components are not fully controlled by the user. ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## SQLParameters {#SQLParameters}

#|
||Field | Description ||
|| db_name | **string \| null** 

Database name. ||
|| db_version | **string \| null** 

Database version. ||
|| table_name | **string \| null** 

Table name. ||
|#

## CHYTTableListParameters {#CHYTTableListParameters}

#|
||Field | Description ||
|| table_names | **string** ||
|#

## CHYTTableRangeParameters {#CHYTTableRangeParameters}

#|
||Field | Description ||
|| directory_path | **string** 

Directory path. ||
|| range_from | **string** 

Range start. ||
|| range_to | **string** 

Range end. ||
|#

## SubselectParameters {#SubselectParameters}

#|
||Field | Description ||
|| subsql | **string** 

Subquery SQL. ||
|#

## SchematizedParameters {#SchematizedParameters}

#|
||Field | Description ||
|| db_name | **string \| null** 

Database name (nullable). ||
|| db_version | **string \| null** 

Database version (nullable).||
|| schema_name | **string \| null** 

Schema name (nullable). ||
|| table_name | **string \| null** 

Table names. ||
|#

## SimpleParameters {#SimpleParameters}

#|
||Field | Description ||
|| Empty | > ||
|#

## Options {#Options}

#|
||Field | Description ||
|| connections | **[Connections](#Connections)** 

Connection options. ||
|| data_types | **[DataTypes](#DataTypes)** 

Data type options. ||
|| fields | **[Fields](#Fields)** 

Field options. ||
|| join | **[Join](#Join)** 

Join options. ||
|| preview | **[Preview](#Preview)** 

Preview options. ||
|| schema_update_enabled | **boolean** 

Whether schema update is enabled. ||
|| source_avatars | **[Avatars](#Avatars)** 

Source avatar options. ||
|| source_listing | **[SourceListing](#SourceListing)** 

Source listing options. ||
|| sources | **[Sources](#Sources)** 

Source options. ||
|| supported_functions[] | **string** 

Supported functions. ||
|| supports_offset | **boolean** 

Whether offset is supported. ||
|#

## Connections {#Connections}

#|
||Field | Description ||
|| compatible_types[] | **[CompatConnectionTypeListItem](#CompatConnectionTypeListItem)** 

Compatible connection types. ||
|| items[] | **[ConnectionListItem](#ConnectionListItem)** 

Connection items. ||
|| max | **integer** 

Maximum number of connections. ||
|#

## CompatConnectionTypeListItem {#CompatConnectionTypeListItem}

#|
||Field | Description ||
|| conn_type | **unknown** 

Connection type. ||
|#

## ConnectionListItem {#ConnectionListItem}

#|
||Field | Description ||
|| id | **string** 

ID of the connection. ||
|| replacement_types[] | **[CompatConnectionTypeListItem](#CompatConnectionTypeListItem)** 

Replacement types. ||
|#

## DataTypes {#DataTypes}

#|
||Field | Description ||
|| items[] | **[DataTypeListItem](#DataTypeListItem)** 

Data type items. ||
|#

## DataTypeListItem {#DataTypeListItem}

#|
||Field | Description ||
|| aggregations[] | **enum**

Supported aggregations.

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| casts[] | **enum**

Supported casts.

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime` ||
|| filter_operations[] | **enum**

Supported filter operations.

- `ISNULL`
- `ISNOTNULL`
- `GT`
- `LT`
- `GTE`
- `LTE`
- `EQ`
- `NE`
- `STARTSWITH`
- `ISTARTSWITH`
- `ENDSWITH`
- `IENDSWITH`
- `CONTAINS`
- `ICONTAINS`
- `NOTCONTAINS`
- `NOTICONTAINS`
- `LENEQ`
- `LENNE`
- `LENGT`
- `LENGTE`
- `LENLT`
- `LENLTE`
- `IN`
- `NIN`
- `BETWEEN` ||
|| type | **enum**

Data type.

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime` ||
|#

## Fields {#Fields}

#|
||Field | Description ||
|| items[] | **[FieldListItem](#FieldListItem)** 

Field items. ||
|#

## FieldListItem {#FieldListItem}

#|
||Field | Description ||
|| aggregations[] | **enum**

Supported aggregations.

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| casts[] | **enum**

Supported casts.

- `string`
- `integer`
- `float`
- `date`
- `datetime`
- `boolean`
- `geopoint`
- `geopolygon`
- `uuid`
- `markup`
- `datetimetz`
- `unsupported`
- `array_str`
- `array_int`
- `array_float`
- `tree_str`
- `genericdatetime` ||
|| guid | **string** 

GUID of the field. ||
|#

## Join {#Join}

#|
||Field | Description ||
|| operators[] | **enum**

Supported join operators.

- `gt` — greater than;
- `lt` — less than;
- `gte`— greater than or equal to;
- `lte` — less than or equal to;
- `eq` — equal to;
- `ne` — not equal to. ||
|| types[] | **enum**

Type of JOIN:

- `inner`
- `left`
- `right`
- `full` ||
|#

## Preview {#Preview}

#|
||Field | Description ||
|| enabled | **boolean** 

Whether preview is enabled. ||
|#

## Avatars {#Avatars}

#|
||Field | Description ||
|| items[] | **[SourceListItem](#SourceListItem)** 

Source items. ||
|| max | **integer** 

Maximum number of source avatars. ||
|#

## SourceListItem {#SourceListItem}

#|
||Field | Description ||
|| id | **string** 
ID of the source. ||
|| schema_update_enabled | **boolean** 

Whether schema update is enabled. ||
|#

## SourceListing {#SourceListing}

#|
||Field | Description ||
|| db_name_label | **string** 

Label for database name. ||
|| db_name_required_for_search | **boolean** 

Whether database name is required for search. ||
|| supports_db_name_listing | **boolean** 

Whether database name listing is supported. ||
|| supports_source_pagination | **boolean** 

Whether source pagination is supported. ||
|| supports_source_search | **boolean** 

Whether source search is supported. ||
|#

## Sources {#Sources}

#|
||Field | Description ||
|| compatible_types[] | **[CompatSourceTypeListItem](#CompatSourceTypeListItem)** 

Compatible source types. ||
|| items[] | **[SourceListItem1](#SourceListItem1)** 

Source items. ||
|| max | **integer** 

Maximum number of sources. ||
|#

## CompatSourceTypeListItem {#CompatSourceTypeListItem}

#|
||Field | Description ||
|| source_type | **unknown** 

Source type. ||
|#

## SourceListItem1 {#SourceListItem1}

#|
||Field | Description ||
|| id | **string** 

ID of the source. ||
|| schema_update_enabled | **boolean** 

Whether schema update is enabled. ||
|#