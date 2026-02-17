---
editable: false
---

# DataLens API: Validate dataset

## HTTP request

```
POST https://api.datalens.yandex.net/rpc/validateDataset
```

## Body parameters

**Request schema: application/json**

```json
{
  "datasetId": "string",
  "workbookId": "string | null",
  "data": {
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
      "rls2": {
        "string": "array"
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
    "updates": [
      {
        "<oneOf>": [
          {
            "action": "add_field",
            "field": {
              "aggregation": "string",
              "avatar_id": "string | null",
              "calc_mode": "string",
              "cast": "string | null",
              "default_value": "unknown",
              "description": "string",
              "formula": "string",
              "guid": "string",
              "guid_formula": "string",
              "hidden": "boolean",
              "new_id": "string | null",
              "source": "string",
              "strict": "boolean",
              "template_enabled": "boolean | null",
              "title": "string",
              "ui_settings": "string",
              "value_constraint": "unknown"
            },
            "order_index": "integer"
          },
          {
            "action": "update_field",
            "field": {
              "aggregation": "string",
              "avatar_id": "string | null",
              "calc_mode": "string",
              "cast": "string | null",
              "default_value": "unknown",
              "description": "string",
              "formula": "string",
              "guid": "string",
              "guid_formula": "string",
              "hidden": "boolean",
              "new_id": "string | null",
              "source": "string",
              "strict": "boolean",
              "template_enabled": "boolean | null",
              "title": "string",
              "ui_settings": "string",
              "value_constraint": "unknown"
            },
            "order_index": "integer"
          },
          {
            "action": "delete_field",
            "field": {
              "guid": "string",
              "strict": "boolean"
            },
            "order_index": "integer"
          },
          {
            "action": "clone_field",
            "field": {
              "aggregation": "string | null",
              "cast": "string | null",
              "from_guid": "string",
              "guid": "string",
              "strict": "boolean",
              "title": "string"
            },
            "order_index": "integer"
          },
          {
            "action": "add_source",
            "order_index": "integer",
            "source": {
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
          },
          {
            "action": "add_source",
            "order_index": "integer",
            "source": {
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
          },
          {
            "action": "delete_source",
            "order_index": "integer",
            "source": {
              "id": "string"
            }
          },
          {
            "action": "refresh_source",
            "order_index": "integer",
            "source": {
              "force_update_fields": "boolean",
              "id": "string"
            }
          },
          {
            "action": "add_source_avatar",
            "disable_fields_update": "boolean",
            "order_index": "integer",
            "source_avatar": {
              "id": "string",
              "is_root": "boolean",
              "managed_by": "string | null",
              "source_id": "string",
              "title": "string",
              "valid": "boolean",
              "virtual": "unknown"
            }
          },
          {
            "action": "add_source_avatar",
            "disable_fields_update": "boolean",
            "order_index": "integer",
            "source_avatar": {
              "id": "string",
              "is_root": "boolean",
              "managed_by": "string | null",
              "source_id": "string",
              "title": "string",
              "valid": "boolean",
              "virtual": "unknown"
            }
          },
          {
            "action": "delete_source_avatar",
            "disable_fields_update": "boolean",
            "order_index": "integer",
            "source_avatar": {
              "id": "string"
            }
          },
          {
            "action": "add_avatar_relation",
            "avatar_relation": {
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
            },
            "order_index": "integer"
          },
          {
            "action": "add_avatar_relation",
            "avatar_relation": {
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
            },
            "order_index": "integer"
          },
          {
            "action": "delete_avatar_relation",
            "avatar_relation": {
              "id": "string"
            },
            "order_index": "integer"
          },
          {
            "action": "replace_connection",
            "connection": {
              "id": "string",
              "new_id": "string"
            },
            "order_index": "integer"
          },
          {
            "action": "add_obligatory_filter",
            "obligatory_filter": {
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
            },
            "order_index": "integer"
          },
          {
            "action": "add_obligatory_filter",
            "obligatory_filter": {
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
            },
            "order_index": "integer"
          },
          {
            "action": "delete_obligatory_filter",
            "obligatory_filter": {
              "id": "string"
            },
            "order_index": "integer"
          },
          {
            "action": "update_setting",
            "order_index": "integer",
            "setting": {
              "name": "string",
              "value": "boolean"
            }
          },
          {
            "action": "update_description",
            "description": "string",
            "order_index": "integer"
          }
        ]
      }
    ]
  }
}
```

#|
||Field | Description ||
|| datasetId | **string**

Required field.  ||
|| workbookId | **string \| null** ||
|| data | **[DatasetValidate](#DatasetValidate)** ||
|#

## DatasetValidate {#DatasetValidate}

#|
||Field | Description ||
|| dataset | **[DatasetContentInternal](#DatasetContentInternal)** ||
|| updates[] | **[Action](#Action)** ||
|#

## DatasetContentInternal {#DatasetContentInternal}

#|
||Field | Description ||
|| avatar_relations[] | **[AvatarRelation](#AvatarRelation)**

Required field.  ||
|| component_errors | **[ComponentErrorList](#ComponentErrorList)** ||
|| data_export_forbidden | **boolean** ||
|| description | **string \| null** ||
|| load_preview_by_default | **boolean** ||
|| obligatory_filters[] | **[ObligatoryFilter](#ObligatoryFilter)**

Required field.  ||
|| preview_enabled | **boolean** ||
|| result_schema[] | **[ResultSchemaSchemaGeneric](#ResultSchemaSchemaGeneric)** ||
|| result_schema_aux | **[ResultSchemaAux](#ResultSchemaAux)** ||
|| revision_id | **string \| null** ||
|| rls | **object** (map<**string**, **unknown**>) ||
|| rls2 | **[RLS2ConfigEntry](#RLS2ConfigEntry)**

Required field.  ||
|| source_avatars[] | **[SourceAvatarStrict](#SourceAvatarStrict)**

Required field.  ||
|| sources[] | **[DataSourceStrict](#DataSourceStrict)** ||
|| template_enabled | **boolean** ||
|#

## AvatarRelation {#AvatarRelation}

#|
||Field | Description ||
|| conditions[] | **[JoinCondition](#JoinCondition)**

Required field.  ||
|| id | **string**

Required field.  ||
|| join_type | **enum**

- `inner`
- `left`
- `right`
- `full` ||
|| left_avatar_id | **string** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| required | **boolean** ||
|| right_avatar_id | **string** ||
|| virtual | **unknown** ||
|#

## JoinCondition {#JoinCondition}

#|
||Field | Description ||
|| left | One of **[direct1](#direct1)** \| **[formula2](#formula2)** \| **[result_field](#result_field)** ||
|| operator | **enum**

Required field. 

- `gt`
- `lt`
- `gte`
- `lte`
- `eq`
- `ne` ||
|| right | One of **[direct1](#direct1)** \| **[formula2](#formula2)** \| **[result_field](#result_field)** ||
|| type | **enum**

Required field. 

- `binary` ||
|#

## direct1 {#direct1}

#|
||Field | Description ||
|| calc_mode | **enum**

Required field. 

- `direct`
- `formula`
- `result_field` ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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

## RLS2ConfigEntry {#RLS2ConfigEntry}

#|
||Field | Description ||
|| allowed_value | **string \| null** ||
|| field_guid | **string \| null** ||
|| pattern_type | **enum**

- `value`
- `all`
- `userid` ||
|| subject | **[RLSSubject](#RLSSubject)**

Required field.  ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## SQLParameters {#SQLParameters}

#|
||Field | Description ||
|| db_name | **string \| null** ||
|| db_version | **string \| null** ||
|| table_name | **string \| null** ||
|#

## CHYTTableListParameters {#CHYTTableListParameters}

#|
||Field | Description ||
|| table_names | **string** ||
|#

## CHYTTableRangeParameters {#CHYTTableRangeParameters}

#|
||Field | Description ||
|| directory_path | **string** ||
|| range_from | **string** ||
|| range_to | **string** ||
|#

## SubselectParameters {#SubselectParameters}

#|
||Field | Description ||
|| subsql | **string** ||
|#

## SchematizedParameters {#SchematizedParameters}

#|
||Field | Description ||
|| db_name | **string \| null** ||
|| db_version | **string \| null** ||
|| schema_name | **string \| null** ||
|| table_name | **string \| null** ||
|#

## SimpleParameters {#SimpleParameters}

#|
||Field | Description ||
|| Empty | > ||
|#

## Action {#Action}

One of:

#|
||Field | Description ||
|| action | **add_field** (const)

Required field.  ||
|| field | **[AddField](#AddField)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **update_field** (const)

Required field.  ||
|| field | **[UpdateField](#UpdateField)** ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **delete_field** (const)

Required field.  ||
|| field | **[DeleteField](#DeleteField)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **clone_field** (const)

Required field.  ||
|| field | **[CloneField](#CloneField)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **add_source** (const)

Required field.  ||
|| order_index | **integer** ||
|| source | One of **[APPMETRICA_API1](#APPMETRICA_API1)** \| **[CHYT_TABLE1](#CHYT_TABLE1)** \| **[CHYT_TABLE_LIST1](#CHYT_TABLE_LIST1)** \| **[CHYT_TABLE_RANGE1](#CHYT_TABLE_RANGE1)** \| **[CHYT_SUBSELECT1](#CHYT_SUBSELECT1)** \| **[CHYT_USER_AUTH_TABLE1](#CHYT_USER_AUTH_TABLE1)** \| **[CHYT_USER_AUTH_TABLE_LIST1](#CHYT_USER_AUTH_TABLE_LIST1)** \| **[CHYT_USER_AUTH_TABLE_RANGE1](#CHYT_USER_AUTH_TABLE_RANGE1)** \| **[CHYT_USER_AUTH_SUBSELECT1](#CHYT_USER_AUTH_SUBSELECT1)** \| **[CH_TABLE1](#CH_TABLE1)** \| **[CH_SUBSELECT1](#CH_SUBSELECT1)** \| **[GP_TABLE1](#GP_TABLE1)** \| **[GP_SUBSELECT1](#GP_SUBSELECT1)** \| **[GSHEETS1](#GSHEETS1)** \| **[JSON_API1](#JSON_API1)** \| **[METRIKA_API1](#METRIKA_API1)** \| **[MSSQL_TABLE1](#MSSQL_TABLE1)** \| **[MSSQL_SUBSELECT1](#MSSQL_SUBSELECT1)** \| **[MYSQL_TABLE1](#MYSQL_TABLE1)** \| **[MYSQL_SUBSELECT1](#MYSQL_SUBSELECT1)** \| **[ORACLE_TABLE1](#ORACLE_TABLE1)** \| **[ORACLE_SUBSELECT1](#ORACLE_SUBSELECT1)** \| **[PG_TABLE1](#PG_TABLE1)** \| **[PG_SUBSELECT1](#PG_SUBSELECT1)** \| **[PROMQL1](#PROMQL1)** \| **[SOLOMON1](#SOLOMON1)** \| **[CH_USAGE_TRACKING_YA_TEAM_TABLE1](#CH_USAGE_TRACKING_YA_TEAM_TABLE1)** \| **[YDB_TABLE1](#YDB_TABLE1)** \| **[YDB_SUBSELECT1](#YDB_SUBSELECT1)** ||
|#

>

#|
||Field | Description ||
|| action | **add_source** (const)

Required field.  ||
|| order_index | **integer** ||
|| source | One of **[APPMETRICA_API1](#APPMETRICA_API1)** \| **[CHYT_TABLE1](#CHYT_TABLE1)** \| **[CHYT_TABLE_LIST1](#CHYT_TABLE_LIST1)** \| **[CHYT_TABLE_RANGE1](#CHYT_TABLE_RANGE1)** \| **[CHYT_SUBSELECT1](#CHYT_SUBSELECT1)** \| **[CHYT_USER_AUTH_TABLE1](#CHYT_USER_AUTH_TABLE1)** \| **[CHYT_USER_AUTH_TABLE_LIST1](#CHYT_USER_AUTH_TABLE_LIST1)** \| **[CHYT_USER_AUTH_TABLE_RANGE1](#CHYT_USER_AUTH_TABLE_RANGE1)** \| **[CHYT_USER_AUTH_SUBSELECT1](#CHYT_USER_AUTH_SUBSELECT1)** \| **[CH_TABLE1](#CH_TABLE1)** \| **[CH_SUBSELECT1](#CH_SUBSELECT1)** \| **[GP_TABLE1](#GP_TABLE1)** \| **[GP_SUBSELECT1](#GP_SUBSELECT1)** \| **[GSHEETS1](#GSHEETS1)** \| **[JSON_API1](#JSON_API1)** \| **[METRIKA_API1](#METRIKA_API1)** \| **[MSSQL_TABLE1](#MSSQL_TABLE1)** \| **[MSSQL_SUBSELECT1](#MSSQL_SUBSELECT1)** \| **[MYSQL_TABLE1](#MYSQL_TABLE1)** \| **[MYSQL_SUBSELECT1](#MYSQL_SUBSELECT1)** \| **[ORACLE_TABLE1](#ORACLE_TABLE1)** \| **[ORACLE_SUBSELECT1](#ORACLE_SUBSELECT1)** \| **[PG_TABLE1](#PG_TABLE1)** \| **[PG_SUBSELECT1](#PG_SUBSELECT1)** \| **[PROMQL1](#PROMQL1)** \| **[SOLOMON1](#SOLOMON1)** \| **[CH_USAGE_TRACKING_YA_TEAM_TABLE1](#CH_USAGE_TRACKING_YA_TEAM_TABLE1)** \| **[YDB_TABLE1](#YDB_TABLE1)** \| **[YDB_SUBSELECT1](#YDB_SUBSELECT1)** ||
|#

>

#|
||Field | Description ||
|| action | **delete_source** (const)

Required field.  ||
|| order_index | **integer** ||
|| source | **[SourceBase](#SourceBase)**

Required field.  ||
|#

>

#|
||Field | Description ||
|| action | **refresh_source** (const)

Required field.  ||
|| order_index | **integer** ||
|| source | **[RefreshSource](#RefreshSource)**

Required field.  ||
|#

>

#|
||Field | Description ||
|| action | **add_source_avatar** (const)

Required field.  ||
|| disable_fields_update | **boolean** ||
|| order_index | **integer** ||
|| source_avatar | **[SourceAvatar](#SourceAvatar)**

Required field.  ||
|#

>

#|
||Field | Description ||
|| action | **add_source_avatar** (const)

Required field.  ||
|| disable_fields_update | **boolean** ||
|| order_index | **integer** ||
|| source_avatar | **[SourceAvatar](#SourceAvatar)**

Required field.  ||
|#

>

#|
||Field | Description ||
|| action | **delete_source_avatar** (const)

Required field.  ||
|| disable_fields_update | **boolean** ||
|| order_index | **integer** ||
|| source_avatar | **[AvatarBase](#AvatarBase)**

Required field.  ||
|#

>

#|
||Field | Description ||
|| action | **add_avatar_relation** (const)

Required field.  ||
|| avatar_relation | **[AvatarRelation](#AvatarRelation)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **add_avatar_relation** (const)

Required field.  ||
|| avatar_relation | **[AvatarRelation](#AvatarRelation)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **delete_avatar_relation** (const)

Required field.  ||
|| avatar_relation | **[RelationBase](#RelationBase)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **replace_connection** (const)

Required field.  ||
|| connection | **[ReplaceConnection](#ReplaceConnection)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **add_obligatory_filter** (const)

Required field.  ||
|| obligatory_filter | **[ObligatoryFilter](#ObligatoryFilter)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **add_obligatory_filter** (const)

Required field.  ||
|| obligatory_filter | **[ObligatoryFilter](#ObligatoryFilter)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **delete_obligatory_filter** (const)

Required field.  ||
|| obligatory_filter | **[DeleteObligatoryFilter](#DeleteObligatoryFilter)**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| action | **update_setting** (const)

Required field.  ||
|| order_index | **integer** ||
|| setting | **[Setting](#Setting)**

Required field.  ||
|#

>

#|
||Field | Description ||
|| action | **update_description** (const)

Required field.  ||
|| description | **string**

Required field.  ||
|| order_index | **integer** ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## AddField {#AddField}

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
|| avatar_id | **string \| null** ||
|| calc_mode | **enum**

- `direct`
- `formula`
- `parameter` ||
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
- `genericdatetime`
- `null` ||
|| default_value | Any of **[Value](#Value)** \| **null** ||
|| description | **string** ||
|| formula | **string** ||
|| guid | **string** ||
|| guid_formula | **string** ||
|| hidden | **boolean** ||
|| new_id | **string \| null** ||
|| source | **string** ||
|| strict | **boolean** ||
|| template_enabled | **boolean \| null** ||
|| title | **string**

Required field.  ||
|| ui_settings | **string** ||
|| value_constraint | Any of **[ParameterValueConstraint](#ParameterValueConstraint)** \| **null** ||
|#

## Value {#Value}

One of:

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **integer** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **number** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** (date) ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** (date-time) ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** (date-time) ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** (date-time) ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **boolean** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value[] | **number** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value[] | **number** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value | **string** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value[] | **string** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value[] | **integer** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value[] | **number** ||
|#

>

#|
||Field | Description ||
|| type | **enum**

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
|| value[] | **string** ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## UpdateField {#UpdateField}

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
|| avatar_id | **string \| null** ||
|| calc_mode | **enum**

- `direct`
- `formula`
- `parameter` ||
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
- `genericdatetime`
- `null` ||
|| default_value | Any of **[Value](#Value)** \| **null** ||
|| description | **string** ||
|| formula | **string** ||
|| guid | **string** ||
|| guid_formula | **string** ||
|| hidden | **boolean** ||
|| new_id | **string \| null** ||
|| source | **string** ||
|| strict | **boolean** ||
|| template_enabled | **boolean \| null** ||
|| title | **string** ||
|| ui_settings | **string** ||
|| value_constraint | Any of **[ParameterValueConstraint](#ParameterValueConstraint)** \| **null** ||
|#

## DeleteField {#DeleteField}

#|
||Field | Description ||
|| guid | **string** ||
|| strict | **boolean** ||
|#

## CloneField {#CloneField}

#|
||Field | Description ||
|| aggregation | **enum**

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique`
- `null` ||
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
- `genericdatetime`
- `null` ||
|| from_guid | **string** ||
|| guid | **string** ||
|| strict | **boolean** ||
|| title | **string** ||
|#

## APPMETRICA_API1 {#APPMETRICA_API1}

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
|| virtual | **unknown** ||
|#

## CHYT_TABLE1 {#CHYT_TABLE1}

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
|| virtual | **unknown** ||
|#

## CHYT_TABLE_LIST1 {#CHYT_TABLE_LIST1}

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
|| virtual | **unknown** ||
|#

## CHYT_TABLE_RANGE1 {#CHYT_TABLE_RANGE1}

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
|| virtual | **unknown** ||
|#

## CHYT_SUBSELECT1 {#CHYT_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## CHYT_USER_AUTH_TABLE1 {#CHYT_USER_AUTH_TABLE1}

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
|| virtual | **unknown** ||
|#

## CHYT_USER_AUTH_TABLE_LIST1 {#CHYT_USER_AUTH_TABLE_LIST1}

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
|| virtual | **unknown** ||
|#

## CHYT_USER_AUTH_TABLE_RANGE1 {#CHYT_USER_AUTH_TABLE_RANGE1}

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
|| virtual | **unknown** ||
|#

## CHYT_USER_AUTH_SUBSELECT1 {#CHYT_USER_AUTH_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## CH_TABLE1 {#CH_TABLE1}

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
|| virtual | **unknown** ||
|#

## CH_SUBSELECT1 {#CH_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## GP_TABLE1 {#GP_TABLE1}

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
|| virtual | **unknown** ||
|#

## GP_SUBSELECT1 {#GP_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## GSHEETS1 {#GSHEETS1}

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
|| virtual | **unknown** ||
|#

## JSON_API1 {#JSON_API1}

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
|| virtual | **unknown** ||
|#

## METRIKA_API1 {#METRIKA_API1}

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
|| virtual | **unknown** ||
|#

## MSSQL_TABLE1 {#MSSQL_TABLE1}

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
|| virtual | **unknown** ||
|#

## MSSQL_SUBSELECT1 {#MSSQL_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## MYSQL_TABLE1 {#MYSQL_TABLE1}

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
|| virtual | **unknown** ||
|#

## MYSQL_SUBSELECT1 {#MYSQL_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## ORACLE_TABLE1 {#ORACLE_TABLE1}

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
|| virtual | **unknown** ||
|#

## ORACLE_SUBSELECT1 {#ORACLE_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## PG_TABLE1 {#PG_TABLE1}

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
|| virtual | **unknown** ||
|#

## PG_SUBSELECT1 {#PG_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## PROMQL1 {#PROMQL1}

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
|| virtual | **unknown** ||
|#

## SOLOMON1 {#SOLOMON1}

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
|| virtual | **unknown** ||
|#

## CH_USAGE_TRACKING_YA_TEAM_TABLE1 {#CH_USAGE_TRACKING_YA_TEAM_TABLE1}

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
|| virtual | **unknown** ||
|#

## YDB_TABLE1 {#YDB_TABLE1}

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
|| virtual | **unknown** ||
|#

## YDB_SUBSELECT1 {#YDB_SUBSELECT1}

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
|| virtual | **unknown** ||
|#

## SourceBase {#SourceBase}

#|
||Field | Description ||
|| id | **string** ||
|#

## RefreshSource {#RefreshSource}

#|
||Field | Description ||
|| force_update_fields | **boolean** ||
|| id | **string** ||
|#

## SourceAvatar {#SourceAvatar}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| is_root | **boolean** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| source_id | **string** ||
|| title | **string** ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
|#

## AvatarBase {#AvatarBase}

#|
||Field | Description ||
|| id | **string** ||
|#

## RelationBase {#RelationBase}

#|
||Field | Description ||
|| id | **string** ||
|#

## ReplaceConnection {#ReplaceConnection}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|| new_id | **string**

Required field.  ||
|#

## DeleteObligatoryFilter {#DeleteObligatoryFilter}

#|
||Field | Description ||
|| id | **string**

Required field.  ||
|#

## Setting {#Setting}

#|
||Field | Description ||
|| name | **enum**

Required field. 

- `load_preview_by_default`
- `template_enabled`
- `data_export_forbidden` ||
|| value | **boolean**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

Response

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
    "rls2": {
      "string": "array"
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
|| dataset | **[DatasetContentInternal](#DatasetContentInternal2)**

Required field.  ||
|| id | **string** ||
|| is_favorite | **boolean** ||
|| key | **string** ||
|| options | **[Options](#Options)** ||
|| permissions | **object** (map<**string**, **boolean**>) ||
|#

## DatasetContentInternal {#DatasetContentInternal2}

#|
||Field | Description ||
|| avatar_relations[] | **[AvatarRelation](#AvatarRelation2)**

Required field.  ||
|| component_errors | **[ComponentErrorList](#ComponentErrorList2)** ||
|| data_export_forbidden | **boolean** ||
|| description | **string \| null** ||
|| load_preview_by_default | **boolean** ||
|| obligatory_filters[] | **[ObligatoryFilter](#ObligatoryFilter2)**

Required field.  ||
|| preview_enabled | **boolean** ||
|| result_schema[] | **[ResultSchemaSchemaGeneric](#ResultSchemaSchemaGeneric2)** ||
|| result_schema_aux | **[ResultSchemaAux](#ResultSchemaAux2)** ||
|| revision_id | **string \| null** ||
|| rls | **object** (map<**string**, **unknown**>) ||
|| rls2 | **[RLS2ConfigEntry](#RLS2ConfigEntry2)**

Required field.  ||
|| source_avatars[] | **[SourceAvatarStrict](#SourceAvatarStrict2)**

Required field.  ||
|| sources[] | **[DataSourceStrict](#DataSourceStrict2)** ||
|| template_enabled | **boolean** ||
|#

## AvatarRelation {#AvatarRelation2}

#|
||Field | Description ||
|| conditions[] | **[JoinCondition](#JoinCondition2)**

Required field.  ||
|| id | **string**

Required field.  ||
|| join_type | **enum**

- `inner`
- `left`
- `right`
- `full` ||
|| left_avatar_id | **string** ||
|| managed_by | **enum**

- `user`
- `feature`
- `compiler_runtime`
- `null` ||
|| required | **boolean** ||
|| right_avatar_id | **string** ||
|| virtual | **unknown** ||
|#

## JoinCondition {#JoinCondition2}

#|
||Field | Description ||
|| left | One of **[direct1](#direct12)** \| **[formula2](#formula22)** \| **[result_field](#result_field2)** ||
|| operator | **enum**

Required field. 

- `gt`
- `lt`
- `gte`
- `lte`
- `eq`
- `ne` ||
|| right | One of **[direct1](#direct12)** \| **[formula2](#formula22)** \| **[result_field](#result_field2)** ||
|| type | **enum**

Required field. 

- `binary` ||
|#

## direct1 {#direct12}

#|
||Field | Description ||
|| calc_mode | **enum**

Required field. 

- `direct`
- `formula`
- `result_field` ||
|| source | **string**

Required field.  ||
|#

## formula2 {#formula22}

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

## result_field {#result_field2}

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

## ComponentErrorList {#ComponentErrorList2}

#|
||Field | Description ||
|| items[] | **[ComponentErrorPack](#ComponentErrorPack2)** ||
|#

## ComponentErrorPack {#ComponentErrorPack2}

#|
||Field | Description ||
|| errors[] | **[ComponentError](#ComponentError2)** ||
|| id | **string** ||
|| type | **enum**

- `data_source`
- `source_avatar`
- `avatar_relation`
- `field`
- `obligatory_filter`
- `result_schema` ||
|#

## ComponentError {#ComponentError2}

#|
||Field | Description ||
|| code | **unknown** ||
|| details | **object** (map<**string**, **unknown**>) ||
|| level | **enum**

- `error`
- `warning` ||
|| message | **string** ||
|#

## ObligatoryFilter {#ObligatoryFilter2}

#|
||Field | Description ||
|| default_filters[] | **[Where](#Where2)**

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

## Where {#Where2}

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

## ResultSchemaSchemaGeneric {#ResultSchemaSchemaGeneric2}

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
|| virtual | **unknown** ||
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
|| virtual | **unknown** ||
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
|| value_constraint | Any of **[ParameterValueConstraint](#ParameterValueConstraint2)** \| **null** ||
|| virtual | **unknown** ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## ParameterValueConstraint {#ParameterValueConstraint2}

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

## ResultSchemaAux {#ResultSchemaAux2}

#|
||Field | Description ||
|| inter_dependencies | **[FieldInterDependencyInfo](#FieldInterDependencyInfo2)** ||
|#

## FieldInterDependencyInfo {#FieldInterDependencyInfo2}

#|
||Field | Description ||
|| deps[] | **[FieldInterDependencyItem](#FieldInterDependencyItem2)** ||
|#

## FieldInterDependencyItem {#FieldInterDependencyItem2}

#|
||Field | Description ||
|| dep_field_id | **string** ||
|| ref_field_ids[] | **string** ||
|#

## RLS2ConfigEntry {#RLS2ConfigEntry2}

#|
||Field | Description ||
|| allowed_value | **string \| null** ||
|| field_guid | **string \| null** ||
|| pattern_type | **enum**

- `value`
- `all`
- `userid` ||
|| subject | **[RLSSubject](#RLSSubject2)**

Required field.  ||
|#

## RLSSubject {#RLSSubject2}

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

## SourceAvatarStrict {#SourceAvatarStrict2}

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
|| virtual | **unknown** ||
|#

## DataSourceStrict {#DataSourceStrict2}

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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **APPMETRICA_API** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[CHYTTableListParameters](#CHYTTableListParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_TABLE_LIST** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[CHYTTableRangeParameters](#CHYTTableRangeParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_TABLE_RANGE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[CHYTTableListParameters](#CHYTTableListParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_TABLE_LIST** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[CHYTTableRangeParameters](#CHYTTableRangeParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_TABLE_RANGE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CHYT_USER_AUTH_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CH_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CH_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SchematizedParameters](#SchematizedParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **GP_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **GP_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SimpleParameters](#SimpleParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **GSHEETS** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SimpleParameters](#SimpleParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **JSON_API** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **METRIKA_API** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SchematizedParameters](#SchematizedParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MSSQL_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MSSQL_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MYSQL_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **MYSQL_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SchematizedParameters](#SchematizedParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **ORACLE_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **ORACLE_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SchematizedParameters](#SchematizedParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **PG_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **PG_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SimpleParameters](#SimpleParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **PROMQL** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SimpleParameters](#SimpleParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **SOLOMON** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **CH_USAGE_TRACKING_YA_TEAM_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SQLParameters](#SQLParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **YDB_TABLE** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
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
|| parameters | **[SubselectParameters](#SubselectParameters2)** ||
|| raw_schema | **array \| null** ||
|| source_type | **YDB_SUBSELECT** (const) ||
|| title | **string**

Required field.  ||
|| valid | **boolean** ||
|| virtual | **unknown** ||
|#

>

#|
||Field | Description ||
|| Empty | > ||
|#

## SQLParameters {#SQLParameters2}

#|
||Field | Description ||
|| db_name | **string \| null** ||
|| db_version | **string \| null** ||
|| table_name | **string \| null** ||
|#

## CHYTTableListParameters {#CHYTTableListParameters2}

#|
||Field | Description ||
|| table_names | **string** ||
|#

## CHYTTableRangeParameters {#CHYTTableRangeParameters2}

#|
||Field | Description ||
|| directory_path | **string** ||
|| range_from | **string** ||
|| range_to | **string** ||
|#

## SubselectParameters {#SubselectParameters2}

#|
||Field | Description ||
|| subsql | **string** ||
|#

## SchematizedParameters {#SchematizedParameters2}

#|
||Field | Description ||
|| db_name | **string \| null** ||
|| db_version | **string \| null** ||
|| schema_name | **string \| null** ||
|| table_name | **string \| null** ||
|#

## SimpleParameters {#SimpleParameters2}

#|
||Field | Description ||
|| Empty | > ||
|#

## Options {#Options}

#|
||Field | Description ||
|| connections | **[Connections](#Connections)** ||
|| data_types | **[DataTypes](#DataTypes)** ||
|| fields | **[Fields](#Fields)** ||
|| join | **[Join](#Join)** ||
|| preview | **[Preview](#Preview)** ||
|| schema_update_enabled | **boolean** ||
|| source_avatars | **[Avatars](#Avatars)** ||
|| source_listing | **[SourceListing](#SourceListing)** ||
|| sources | **[Sources](#Sources)** ||
|| supported_functions[] | **string** ||
|| supports_offset | **boolean** ||
|#

## Connections {#Connections}

#|
||Field | Description ||
|| compatible_types[] | **[CompatConnectionTypeListItem](#CompatConnectionTypeListItem)** ||
|| items[] | **[ConnectionListItem](#ConnectionListItem)** ||
|| max | **integer** ||
|#

## CompatConnectionTypeListItem {#CompatConnectionTypeListItem}

#|
||Field | Description ||
|| conn_type | **unknown** ||
|#

## ConnectionListItem {#ConnectionListItem}

#|
||Field | Description ||
|| id | **string** ||
|| replacement_types[] | **[CompatConnectionTypeListItem](#CompatConnectionTypeListItem)** ||
|#

## DataTypes {#DataTypes}

#|
||Field | Description ||
|| items[] | **[DataTypeListItem](#DataTypeListItem)** ||
|#

## DataTypeListItem {#DataTypeListItem}

#|
||Field | Description ||
|| aggregations[] | **enum**

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| casts[] | **enum**

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
|| items[] | **[FieldListItem](#FieldListItem)** ||
|#

## FieldListItem {#FieldListItem}

#|
||Field | Description ||
|| aggregations[] | **enum**

- `none`
- `sum`
- `avg`
- `min`
- `max`
- `count`
- `countunique` ||
|| casts[] | **enum**

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
|| guid | **string** ||
|#

## Join {#Join}

#|
||Field | Description ||
|| operators[] | **enum**

- `gt`
- `lt`
- `gte`
- `lte`
- `eq`
- `ne` ||
|| types[] | **enum**

- `inner`
- `left`
- `right`
- `full` ||
|#

## Preview {#Preview}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## Avatars {#Avatars}

#|
||Field | Description ||
|| items[] | **[SourceListItem](#SourceListItem)** ||
|| max | **integer** ||
|#

## SourceListItem {#SourceListItem}

#|
||Field | Description ||
|| id | **string** ||
|| schema_update_enabled | **boolean** ||
|#

## SourceListing {#SourceListing}

#|
||Field | Description ||
|| db_name_label | **string** ||
|| db_name_required_for_search | **boolean** ||
|| supports_db_name_listing | **boolean** ||
|| supports_source_pagination | **boolean** ||
|| supports_source_search | **boolean** ||
|#

## Sources {#Sources}

#|
||Field | Description ||
|| compatible_types[] | **[CompatSourceTypeListItem](#CompatSourceTypeListItem)** ||
|| items[] | **[SourceListItem1](#SourceListItem1)** ||
|| max | **integer** ||
|#

## CompatSourceTypeListItem {#CompatSourceTypeListItem}

#|
||Field | Description ||
|| source_type | **unknown** ||
|#

## SourceListItem1 {#SourceListItem1}

#|
||Field | Description ||
|| id | **string** ||
|| schema_update_enabled | **boolean** ||
|#