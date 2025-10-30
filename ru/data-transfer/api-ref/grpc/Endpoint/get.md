---
editable: false
sourcePath: en/_api-ref-grpc/datatransfer/v1/api-ref/grpc/Endpoint/get.md
---

# Data Transfer API, gRPC: EndpointService.Get

Returns the specified endpoint.

To get the list of all available endpoints, make a [List](/docs/data-transfer/api-ref/grpc/Endpoint/list#List) request.

## gRPC request

**rpc Get ([GetEndpointRequest](#yandex.cloud.datatransfer.v1.GetEndpointRequest)) returns ([Endpoint](#yandex.cloud.datatransfer.v1.Endpoint))**

## GetEndpointRequest {#yandex.cloud.datatransfer.v1.GetEndpointRequest}

```json
{
  "endpoint_id": "string"
}
```

#|
||Field | Description ||
|| endpoint_id | **string**

Identifier of the endpoint to return.

To get the endpoint ID, make an [EndpointService.List](/docs/data-transfer/api-ref/grpc/Endpoint/list#List) request. ||
|#

## Endpoint {#yandex.cloud.datatransfer.v1.Endpoint}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "settings": {
    // Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`
    "mysql_source": {
      "connection": {
        // Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`
        "mdb_cluster_id": "string",
        "on_premise": {
          "port": "int64",
          "subnet_id": "string",
          "hosts": [
            "string"
          ],
          "tls_mode": {
            // Includes only one of the fields `disabled`, `enabled`
            "disabled": "google.protobuf.Empty",
            "enabled": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connection_manager_connection": {
          "connection_id": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "timezone": "string",
      "object_transfer_settings": {
        "view": "ObjectTransferStage",
        "routine": "ObjectTransferStage",
        "trigger": "ObjectTransferStage",
        "tables": "ObjectTransferStage"
      },
      "include_tables_regex": [
        "string"
      ],
      "exclude_tables_regex": [
        "string"
      ],
      "security_groups": [
        "string"
      ],
      "service_database": "string"
    },
    "postgres_source": {
      "connection": {
        // Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`
        "mdb_cluster_id": "string",
        "on_premise": {
          "port": "int64",
          "subnet_id": "string",
          "hosts": [
            "string"
          ],
          "tls_mode": {
            // Includes only one of the fields `disabled`, `enabled`
            "disabled": "google.protobuf.Empty",
            "enabled": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connection_manager_connection": {
          "connection_id": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "include_tables": [
        "string"
      ],
      "exclude_tables": [
        "string"
      ],
      "slot_byte_lag_limit": "int64",
      "service_schema": "string",
      "object_transfer_settings": {
        "sequence": "ObjectTransferStage",
        "sequence_owned_by": "ObjectTransferStage",
        "table": "ObjectTransferStage",
        "primary_key": "ObjectTransferStage",
        "fk_constraint": "ObjectTransferStage",
        "default_values": "ObjectTransferStage",
        "constraint": "ObjectTransferStage",
        "index": "ObjectTransferStage",
        "view": "ObjectTransferStage",
        "function": "ObjectTransferStage",
        "trigger": "ObjectTransferStage",
        "type": "ObjectTransferStage",
        "rule": "ObjectTransferStage",
        "collation": "ObjectTransferStage",
        "policy": "ObjectTransferStage",
        "cast": "ObjectTransferStage",
        "materialized_view": "ObjectTransferStage",
        "sequence_set": "ObjectTransferStage"
      },
      "security_groups": [
        "string"
      ]
    },
    "ydb_source": {
      "database": "string",
      "instance": "string",
      "paths": [
        "string"
      ],
      "service_account_id": "string",
      "subnet_id": "string",
      "sa_key_content": "string",
      "security_groups": [
        "string"
      ],
      "changefeed_custom_name": "string",
      "changefeed_custom_consumer_name": "string"
    },
    "yds_source": {
      "database": "string",
      "stream": "string",
      "service_account_id": "string",
      "supported_codecs": [
        "YdsCompressionCodec"
      ],
      "parser": {
        // Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`
        "json_parser": {
          "data_schema": {
            // Includes only one of the fields `json_fields`, `fields`
            "json_fields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "ColumnType",
                  "key": "bool",
                  "required": "bool",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "null_keys_allowed": "bool",
          "add_rest_column": "bool",
          "unescape_string_values": "bool"
        },
        "audit_trails_v1_parser": "AuditTrailsV1Parser",
        "cloud_logging_parser": "CloudLoggingParser",
        "tskv_parser": {
          "data_schema": {
            // Includes only one of the fields `json_fields`, `fields`
            "json_fields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "ColumnType",
                  "key": "bool",
                  "required": "bool",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "null_keys_allowed": "bool",
          "add_rest_column": "bool",
          "unescape_string_values": "bool"
        }
        // end of the list of possible fields
      },
      "allow_ttl_rewind": "bool",
      "endpoint": "string",
      "subnet_id": "string",
      "security_groups": [
        "string"
      ],
      "consumer": "string"
    },
    "kafka_source": {
      "connection": {
        // Includes only one of the fields `cluster_id`, `on_premise`
        "cluster_id": "string",
        "on_premise": {
          "broker_urls": [
            "string"
          ],
          "subnet_id": "string",
          "tls_mode": {
            // Includes only one of the fields `disabled`, `enabled`
            "disabled": "google.protobuf.Empty",
            "enabled": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "auth": {
        // Includes only one of the fields `sasl`, `no_auth`
        "sasl": {
          "user": "string",
          "mechanism": "KafkaMechanism",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          }
        },
        "no_auth": "NoAuth"
        // end of the list of possible fields
      },
      "security_groups": [
        "string"
      ],
      "topic_name": "string",
      "transformer": {
        "cloud_function": "string",
        "number_of_retries": "int64",
        "buffer_size": "string",
        "buffer_flush_interval": "string",
        "invocation_timeout": "string",
        "service_account_id": "string"
      },
      "parser": {
        // Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`
        "json_parser": {
          "data_schema": {
            // Includes only one of the fields `json_fields`, `fields`
            "json_fields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "ColumnType",
                  "key": "bool",
                  "required": "bool",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "null_keys_allowed": "bool",
          "add_rest_column": "bool",
          "unescape_string_values": "bool"
        },
        "audit_trails_v1_parser": "AuditTrailsV1Parser",
        "cloud_logging_parser": "CloudLoggingParser",
        "tskv_parser": {
          "data_schema": {
            // Includes only one of the fields `json_fields`, `fields`
            "json_fields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "ColumnType",
                  "key": "bool",
                  "required": "bool",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "null_keys_allowed": "bool",
          "add_rest_column": "bool",
          "unescape_string_values": "bool"
        }
        // end of the list of possible fields
      },
      "topic_names": [
        "string"
      ]
    },
    "mongo_source": {
      "connection": {
        // Includes only one of the fields `connection_options`
        "connection_options": {
          // Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`
          "mdb_cluster_id": "string",
          "on_premise": {
            "hosts": [
              "string"
            ],
            "port": "int64",
            "replica_set": "string",
            "tls_mode": {
              // Includes only one of the fields `disabled`, `enabled`
              "disabled": "google.protobuf.Empty",
              "enabled": {
                "ca_certificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connection_manager_connection": {
            "connection_id": "string",
            "replica_set": "string"
          },
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "auth_source": "string"
        }
        // end of the list of possible fields
      },
      "subnet_id": "string",
      "collections": [
        {
          "database_name": "string",
          "collection_name": "string"
        }
      ],
      "excluded_collections": [
        {
          "database_name": "string",
          "collection_name": "string"
        }
      ],
      "secondary_preferred_mode": "bool",
      "security_groups": [
        "string"
      ]
    },
    "clickhouse_source": {
      "connection": {
        // Includes only one of the fields `connection_options`
        "connection_options": {
          // Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`
          "on_premise": {
            "shards": [
              {
                "name": "string",
                "hosts": [
                  "string"
                ]
              }
            ],
            "http_port": "int64",
            "native_port": "int64",
            "tls_mode": {
              // Includes only one of the fields `disabled`, `enabled`
              "disabled": "google.protobuf.Empty",
              "enabled": {
                "ca_certificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connection_manager_connection": {
            "connection_id": "string"
          },
          "mdb_cluster_id": "string",
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "database": "string"
        }
        // end of the list of possible fields
      },
      "include_tables": [
        "string"
      ],
      "exclude_tables": [
        "string"
      ],
      "subnet_id": "string",
      "security_groups": [
        "string"
      ],
      "clickhouse_cluster_name": "string"
    },
    "mysql_target": {
      "connection": {
        // Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`
        "mdb_cluster_id": "string",
        "on_premise": {
          "port": "int64",
          "subnet_id": "string",
          "hosts": [
            "string"
          ],
          "tls_mode": {
            // Includes only one of the fields `disabled`, `enabled`
            "disabled": "google.protobuf.Empty",
            "enabled": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connection_manager_connection": {
          "connection_id": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "sql_mode": "string",
      "skip_constraint_checks": "bool",
      "timezone": "string",
      "cleanup_policy": "CleanupPolicy",
      "service_database": "string",
      "security_groups": [
        "string"
      ],
      "is_schema_migration_disabled": "bool"
    },
    "postgres_target": {
      "connection": {
        // Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`
        "mdb_cluster_id": "string",
        "on_premise": {
          "port": "int64",
          "subnet_id": "string",
          "hosts": [
            "string"
          ],
          "tls_mode": {
            // Includes only one of the fields `disabled`, `enabled`
            "disabled": "google.protobuf.Empty",
            "enabled": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connection_manager_connection": {
          "connection_id": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "cleanup_policy": "CleanupPolicy",
      "security_groups": [
        "string"
      ],
      "is_schema_migration_disabled": "bool"
    },
    "clickhouse_target": {
      "connection": {
        // Includes only one of the fields `connection_options`
        "connection_options": {
          // Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`
          "on_premise": {
            "shards": [
              {
                "name": "string",
                "hosts": [
                  "string"
                ]
              }
            ],
            "http_port": "int64",
            "native_port": "int64",
            "tls_mode": {
              // Includes only one of the fields `disabled`, `enabled`
              "disabled": "google.protobuf.Empty",
              "enabled": {
                "ca_certificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connection_manager_connection": {
            "connection_id": "string"
          },
          "mdb_cluster_id": "string",
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "database": "string"
        }
        // end of the list of possible fields
      },
      "subnet_id": "string",
      "alt_names": [
        {
          "from_name": "string",
          "to_name": "string"
        }
      ],
      "cleanup_policy": "ClickhouseCleanupPolicy",
      "sharding": {
        // Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`
        "column_value_hash": {
          "column_name": "string"
        },
        "custom_mapping": {
          "column_name": "string",
          "mapping": [
            {
              "column_value": {
                // Includes only one of the fields `string_value`
                "string_value": "string"
                // end of the list of possible fields
              },
              "shard_name": "string"
            }
          ]
        },
        "transfer_id": "google.protobuf.Empty",
        "round_robin": "google.protobuf.Empty"
        // end of the list of possible fields
      },
      "is_schema_migration_disabled": "bool",
      "clickhouse_cluster_name": "string",
      "security_groups": [
        "string"
      ]
    },
    "ydb_target": {
      "database": "string",
      "instance": "string",
      "path": "string",
      "service_account_id": "string",
      "cleanup_policy": "YdbCleanupPolicy",
      "subnet_id": "string",
      "sa_key_content": "string",
      "security_groups": [
        "string"
      ],
      "is_table_column_oriented": "bool",
      "default_compression": "YdbDefaultCompression",
      "is_schema_migration_disabled": "bool"
    },
    "kafka_target": {
      "connection": {
        // Includes only one of the fields `cluster_id`, `on_premise`
        "cluster_id": "string",
        "on_premise": {
          "broker_urls": [
            "string"
          ],
          "subnet_id": "string",
          "tls_mode": {
            // Includes only one of the fields `disabled`, `enabled`
            "disabled": "google.protobuf.Empty",
            "enabled": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "auth": {
        // Includes only one of the fields `sasl`, `no_auth`
        "sasl": {
          "user": "string",
          "mechanism": "KafkaMechanism",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          }
        },
        "no_auth": "NoAuth"
        // end of the list of possible fields
      },
      "security_groups": [
        "string"
      ],
      "topic_settings": {
        // Includes only one of the fields `topic`, `topic_prefix`
        "topic": {
          "topic_name": "string",
          "save_tx_order": "bool"
        },
        "topic_prefix": "string"
        // end of the list of possible fields
      },
      "serializer": {
        // Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`
        "serializer_auto": "SerializerAuto",
        "serializer_json": "SerializerJSON",
        "serializer_debezium": {
          "serializer_parameters": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "mongo_target": {
      "connection": {
        // Includes only one of the fields `connection_options`
        "connection_options": {
          // Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`
          "mdb_cluster_id": "string",
          "on_premise": {
            "hosts": [
              "string"
            ],
            "port": "int64",
            "replica_set": "string",
            "tls_mode": {
              // Includes only one of the fields `disabled`, `enabled`
              "disabled": "google.protobuf.Empty",
              "enabled": {
                "ca_certificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connection_manager_connection": {
            "connection_id": "string",
            "replica_set": "string"
          },
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "auth_source": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "cleanup_policy": "CleanupPolicy",
      "subnet_id": "string",
      "security_groups": [
        "string"
      ]
    },
    "metrika_source": {
      "counter_ids": [
        "int64"
      ],
      "token": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "streams": [
        {
          "type": "MetrikaStreamType",
          "columns": [
            "string"
          ]
        }
      ]
    },
    "yds_target": {
      "database": "string",
      "stream": "string",
      "service_account_id": "string",
      "save_tx_order": "bool",
      "compression_codec": "YdsCompressionCodec",
      "serializer": {
        // Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`
        "serializer_auto": "SerializerAuto",
        "serializer_json": "SerializerJSON",
        "serializer_debezium": {
          "serializer_parameters": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
        // end of the list of possible fields
      },
      "endpoint": "string",
      "subnet_id": "string",
      "security_groups": [
        "string"
      ]
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| id | **string** ||
|| folder_id | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| settings | **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)** ||
|#

## EndpointSettings {#yandex.cloud.datatransfer.v1.EndpointSettings}

#|
||Field | Description ||
|| mysql_source | **[MysqlSource](#yandex.cloud.datatransfer.v1.endpoint.MysqlSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| postgres_source | **[PostgresSource](#yandex.cloud.datatransfer.v1.endpoint.PostgresSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| ydb_source | **[YdbSource](#yandex.cloud.datatransfer.v1.endpoint.YdbSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| yds_source | **[YDSSource](#yandex.cloud.datatransfer.v1.endpoint.YDSSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| kafka_source | **[KafkaSource](#yandex.cloud.datatransfer.v1.endpoint.KafkaSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| mongo_source | **[MongoSource](#yandex.cloud.datatransfer.v1.endpoint.MongoSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| clickhouse_source | **[ClickhouseSource](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| mysql_target | **[MysqlTarget](#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| postgres_target | **[PostgresTarget](#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| clickhouse_target | **[ClickhouseTarget](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| ydb_target | **[YdbTarget](#yandex.cloud.datatransfer.v1.endpoint.YdbTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| kafka_target | **[KafkaTarget](#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| mongo_target | **[MongoTarget](#yandex.cloud.datatransfer.v1.endpoint.MongoTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| metrika_source | **[MetrikaSource](#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|| yds_target | **[YDSTarget](#yandex.cloud.datatransfer.v1.endpoint.YDSTarget)**

Includes only one of the fields `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source`, `yds_target`. ||
|#

## MysqlSource {#yandex.cloud.datatransfer.v1.endpoint.MysqlSource}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Database name

You can leave it empty, then it will be possible to transfer tables from several
databases at the same time from this source. ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| object_transfer_settings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**

Schema migration

Select database objects to be transferred during activation or deactivation. ||
|| include_tables_regex[] | **string** ||
|| exclude_tables_regex[] | **string** ||
|| security_groups[] | **string**

Security groups ||
|| service_database | **string**

Database for service tables

Default: data source database. Here created technical tables (__tm_keeper,
__tm_gtid_keeper). ||
|#

## MysqlConnection {#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection}

#|
||Field | Description ||
|| mdb_cluster_id | **string**

Managed Service for MySQL cluster ID

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| on_premise | **[OnPremiseMysql](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql)**

Connection options for on-premise MySQL

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| connection_manager_connection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **int64**

Database port ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| hosts[] | **string** ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## TLSMode {#yandex.cloud.datatransfer.v1.endpoint.TLSMode}

#|
||Field | Description ||
|| disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `disabled`, `enabled`. ||
|| enabled | **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**

Includes only one of the fields `disabled`, `enabled`. ||
|#

## TLSConfig {#yandex.cloud.datatransfer.v1.endpoint.TLSConfig}

#|
||Field | Description ||
|| ca_certificate | **string**

CA certificate

X.509 certificate of the certificate authority which issued the server's
certificate, in PEM format. When CA certificate is specified TLS is used to
connect to the server. ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

#|
||Field | Description ||
|| connection_id | **string** ||
|#

## Secret {#yandex.cloud.datatransfer.v1.endpoint.Secret}

#|
||Field | Description ||
|| raw | **string**

Raw secret value

Includes only one of the fields `raw`. ||
|#

## MysqlObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings}

#|
||Field | Description ||
|| view | enum **ObjectTransferStage**

Views

CREATE VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| routine | enum **ObjectTransferStage**

Routines

CREATE PROCEDURE ... ; CREATE FUNCTION ... ;

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | enum **ObjectTransferStage**

Triggers

CREATE TRIGGER ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| tables | enum **ObjectTransferStage**

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Database name ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| include_tables[] | **string**

Included tables

If none or empty list is presented, all tables are replicated. Full table name
with schema. Can contain schema_name.* patterns. ||
|| exclude_tables[] | **string**

Excluded tables

If none or empty list is presented, all tables are replicated. Full table name
with schema. Can contain schema_name.* patterns. ||
|| slot_byte_lag_limit | **int64**

Maximum lag of replication slot (in bytes); after exceeding this limit
replication will be aborted. ||
|| service_schema | **string**

Database schema for service tables (__consumer_keeper,
__data_transfer_mole_finder). Default is public ||
|| object_transfer_settings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**

Select database objects to be transferred during activation or deactivation. ||
|| security_groups[] | **string**

Security groups ||
|#

## PostgresConnection {#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection}

#|
||Field | Description ||
|| mdb_cluster_id | **string**

Managed Service for PostgreSQL cluster ID

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| on_premise | **[OnPremisePostgres](#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres)**

Connection options for on-premise PostgreSQL

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| connection_manager_connection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **int64**

Will be used if the cluster ID is not specified. ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| hosts[] | **string** ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | enum **ObjectTransferStage**

Sequences

CREATE SEQUENCE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequence_owned_by | enum **ObjectTransferStage**

Owned sequences

CREATE SEQUENCE ... OWNED BY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| table | enum **ObjectTransferStage**

Tables

CREATE TABLE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| primary_key | enum **ObjectTransferStage**

Primary keys

ALTER TABLE ... ADD PRIMARY KEY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| fk_constraint | enum **ObjectTransferStage**

Foreign keys

ALTER TABLE ... ADD FOREIGN KEY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| default_values | enum **ObjectTransferStage**

Default values

ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| constraint | enum **ObjectTransferStage**

Constraints

ALTER TABLE ... ADD CONSTRAINT ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| index | enum **ObjectTransferStage**

Indexes

CREATE INDEX ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| view | enum **ObjectTransferStage**

Views

CREATE VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| function | enum **ObjectTransferStage**

Functions

CREATE FUNCTION ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | enum **ObjectTransferStage**

Triggers

CREATE TRIGGER ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| type | enum **ObjectTransferStage**

Types

CREATE TYPE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| rule | enum **ObjectTransferStage**

Rules

CREATE RULE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| collation | enum **ObjectTransferStage**

Collations

CREATE COLLATION ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| policy | enum **ObjectTransferStage**

Policies

CREATE POLICY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| cast | enum **ObjectTransferStage**

Casts

CREATE CAST ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| materialized_view | enum **ObjectTransferStage**

Materialized views

CREATE MATERIALIZED VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequence_set | enum **ObjectTransferStage**

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

#|
||Field | Description ||
|| database | **string**

Path in YDB where to store tables ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 ||
|| paths[] | **string** ||
|| service_account_id | **string** ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| sa_key_content | **string**

Authorization Key ||
|| security_groups[] | **string**

Security groups ||
|| changefeed_custom_name | **string**

Pre-created change feed ||
|| changefeed_custom_consumer_name | **string** ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

#|
||Field | Description ||
|| database | **string**

Database ||
|| stream | **string**

Stream ||
|| service_account_id | **string**

SA which has read access to the stream. ||
|| supported_codecs[] | enum **YdsCompressionCodec**

Compression codec

- `YDS_COMPRESSION_CODEC_UNSPECIFIED`
- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing rules ||
|| allow_ttl_rewind | **bool**

Should continue working, if consumer read lag exceed TTL of topic
False: stop the transfer in error state, if detected lost data. True: continue
working with losing part of data ||
|| endpoint | **string**

for dedicated db ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| security_groups[] | **string**

Security groups ||
|| consumer | **string**

for important streams ||
|#

## Parser {#yandex.cloud.datatransfer.v1.endpoint.Parser}

#|
||Field | Description ||
|| json_parser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|| audit_trails_v1_parser | **[AuditTrailsV1Parser](#yandex.cloud.datatransfer.v1.endpoint.AuditTrailsV1Parser)**

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|| cloud_logging_parser | **[CloudLoggingParser](#yandex.cloud.datatransfer.v1.endpoint.CloudLoggingParser)**

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|| tskv_parser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|#

## GenericParserCommon {#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon}

#|
||Field | Description ||
|| data_schema | **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)** ||
|| null_keys_allowed | **bool**

Allow null keys, if no - null keys will be putted to unparsed data ||
|| add_rest_column | **bool**

Will add _rest column for all unknown fields ||
|| unescape_string_values | **bool**

Unescape string values ||
|#

## DataSchema {#yandex.cloud.datatransfer.v1.endpoint.DataSchema}

#|
||Field | Description ||
|| json_fields | **string**

Includes only one of the fields `json_fields`, `fields`. ||
|| fields | **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**

Includes only one of the fields `json_fields`, `fields`. ||
|#

## FieldList {#yandex.cloud.datatransfer.v1.endpoint.FieldList}

#|
||Field | Description ||
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**

Column schema ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string** ||
|| type | enum **ColumnType**

- `COLUMN_TYPE_UNSPECIFIED`
- `INT32`
- `INT16`
- `INT8`
- `UINT64`
- `UINT32`
- `UINT16`
- `UINT8`
- `DOUBLE`
- `BOOLEAN`
- `STRING`
- `UTF8`
- `ANY`
- `DATETIME`
- `INT64` ||
|| key | **bool** ||
|| required | **bool** ||
|| path | **string** ||
|#

## AuditTrailsV1Parser {#yandex.cloud.datatransfer.v1.endpoint.AuditTrailsV1Parser}

#|
||Field | Description ||
|| Empty | > ||
|#

## CloudLoggingParser {#yandex.cloud.datatransfer.v1.endpoint.CloudLoggingParser}

#|
||Field | Description ||
|| Empty | > ||
|#

## KafkaSource {#yandex.cloud.datatransfer.v1.endpoint.KafkaSource}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| security_groups[] | **string**

Security groups ||
|| topic_name | **string**

Full source topic name
Deprecated in favor of topic names ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**

Data transformation rules ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing rules ||
|| topic_names[] | **string**

List of topic names to read ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| cluster_id | **string**

Managed Service for Kafka cluster ID

Includes only one of the fields `cluster_id`, `on_premise`. ||
|| on_premise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Connection options for on-premise Kafka

Includes only one of the fields `cluster_id`, `on_premise`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

#|
||Field | Description ||
|| broker_urls[] | **string**

Kafka broker URLs ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for broker connection. Disabled by default. ||
|#

## KafkaAuth {#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity)**

Authentication with SASL

Includes only one of the fields `sasl`, `no_auth`. ||
|| no_auth | **[NoAuth](#yandex.cloud.datatransfer.v1.endpoint.NoAuth)**

No authentication

Includes only one of the fields `sasl`, `no_auth`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity}

#|
||Field | Description ||
|| user | **string**

User name ||
|| mechanism | enum **KafkaMechanism**

SASL mechanism for authentication

- `KAFKA_MECHANISM_UNSPECIFIED`
- `KAFKA_MECHANISM_SHA256`
- `KAFKA_MECHANISM_SHA512` ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|#

## NoAuth {#yandex.cloud.datatransfer.v1.endpoint.NoAuth}

No authentication

#|
||Field | Description ||
|| Empty | > ||
|#

## DataTransformationOptions {#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions}

#|
||Field | Description ||
|| cloud_function | **string**

Cloud function ||
|| number_of_retries | **int64**

Number of retries ||
|| buffer_size | **string**

Buffer size for function ||
|| buffer_flush_interval | **string**

Flush interval ||
|| invocation_timeout | **string**

Invocation timeout ||
|| service_account_id | **string**

Service account ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| subnet_id | **string** ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of collections for replication. Empty list implies replication of all
tables on the deployment. Allowed to use * as collection name. ||
|| excluded_collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of forbidden collections for replication. Allowed to use * as collection
name for forbid all collections of concrete schema. ||
|| secondary_preferred_mode | **bool**

Read mode for mongo client ||
|| security_groups[] | **string**

Security groups ||
|#

## MongoConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnection}

#|
||Field | Description ||
|| connection_options | **[MongoConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions)**

Includes only one of the fields `connection_options`. ||
|#

## MongoConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions}

#|
||Field | Description ||
|| mdb_cluster_id | **string**

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| on_premise | **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| connection_manager_connection | **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| user | **string**

User name ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|| auth_source | **string**

Database name associated with the credentials ||
|#

## OnPremiseMongo {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo}

#|
||Field | Description ||
|| hosts[] | **string** ||
|| port | **int64** ||
|| replica_set | **string** ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## MongoConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection}

#|
||Field | Description ||
|| connection_id | **string** ||
|| replica_set | **string**

Used only for on-premise connections ||
|#

## MongoCollection {#yandex.cloud.datatransfer.v1.endpoint.MongoCollection}

#|
||Field | Description ||
|| database_name | **string** ||
|| collection_name | **string** ||
|#

## ClickhouseSource {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| include_tables[] | **string**

White list of tables for replication. If none or empty list is presented - will
replicate all tables. Can contain * patterns. ||
|| exclude_tables[] | **string**

Exclude list of tables for replication. If none or empty list is presented -
will replicate all tables. Can contain * patterns. ||
|| subnet_id | **string** ||
|| security_groups[] | **string** ||
|| clickhouse_cluster_name | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup. ||
|#

## ClickhouseConnection {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection}

#|
||Field | Description ||
|| connection_options | **[ClickhouseConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions)**

Includes only one of the fields `connection_options`. ||
|#

## ClickhouseConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions}

#|
||Field | Description ||
|| on_premise | **[OnPremiseClickhouse](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse)**

Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`. ||
|| connection_manager_connection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`. ||
|| mdb_cluster_id | **string**

Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`. ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| database | **string**

Database ||
|#

## OnPremiseClickhouse {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse}

#|
||Field | Description ||
|| shards[] | **[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)** ||
|| http_port | **int64** ||
|| native_port | **int64** ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## ClickhouseShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard}

#|
||Field | Description ||
|| name | **string** ||
|| hosts[] | **string** ||
|#

## MysqlTarget {#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Database name

Allowed to leave it empty, then the tables will be created in databases with the
same names as on the source. If this field is empty, then you must fill below db
schema for service table. ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| sql_mode | **string**

Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. ||
|| skip_constraint_checks | **bool**

Disable constraints checks

Recommend to disable for increase replication speed, but if schema contain
cascading operations we don't recommend to disable. This option set
FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| cleanup_policy | enum **CleanupPolicy**

Cleanup policy

Cleanup policy for activate, reactivate and reupload processes. Default is
DISABLED.

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| service_database | **string**

Database schema for service table

Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). ||
|| security_groups[] | **string**

Security groups ||
|| is_schema_migration_disabled | **bool** ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Database name ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| cleanup_policy | enum **CleanupPolicy**

Cleanup policy for activate, reactivate and reupload processes. Default is
truncate.

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| security_groups[] | **string**

Security groups ||
|| is_schema_migration_disabled | **bool** ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| subnet_id | **string** ||
|| alt_names[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**

Alternative table names in target ||
|| cleanup_policy | enum **ClickhouseCleanupPolicy**

- `CLICKHOUSE_CLEANUP_POLICY_UNSPECIFIED`
- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)** ||
|| is_schema_migration_disabled | **bool** ||
|| clickhouse_cluster_name | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup. ||
|| security_groups[] | **string** ||
|#

## AltName {#yandex.cloud.datatransfer.v1.endpoint.AltName}

#|
||Field | Description ||
|| from_name | **string**

Source table name ||
|| to_name | **string**

Target table name ||
|#

## ClickhouseSharding {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding}

#|
||Field | Description ||
|| column_value_hash | **[ColumnValueHash](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash)**

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|| custom_mapping | **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|| transfer_id | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|| round_robin | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|#

## ColumnValueHash {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash}

#|
||Field | Description ||
|| column_name | **string** ||
|#

## ColumnValueMapping {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping}

#|
||Field | Description ||
|| column_name | **string** ||
|| mapping[] | **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)** ||
|#

## ValueToShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard}

#|
||Field | Description ||
|| column_value | **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)** ||
|| shard_name | **string** ||
|#

## ColumnValue {#yandex.cloud.datatransfer.v1.endpoint.ColumnValue}

#|
||Field | Description ||
|| string_value | **string**

Includes only one of the fields `string_value`. ||
|#

## YdbTarget {#yandex.cloud.datatransfer.v1.endpoint.YdbTarget}

#|
||Field | Description ||
|| database | **string**

Path in YDB where to store tables ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 ||
|| path | **string**

Path extension for database, each table will be layouted into this path ||
|| service_account_id | **string** ||
|| cleanup_policy | enum **YdbCleanupPolicy**

Cleanup policy

- `YDB_CLEANUP_POLICY_UNSPECIFIED`
- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| sa_key_content | **string**

SA content ||
|| security_groups[] | **string**

Security groups ||
|| is_table_column_oriented | **bool**

Should create column-oriented table (OLAP). By default it creates row-oriented
(OLTP) ||
|| default_compression | enum **YdbDefaultCompression**

Compression that will be used for default columns family on YDB table creation

- `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`
- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| is_schema_migration_disabled | **bool** ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| security_groups[] | **string**

Security groups ||
|| topic_settings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**

Target topic settings ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format settings ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

Full topic name

Includes only one of the fields `topic`, `topic_prefix`. ||
|| topic_prefix | **string**

Topic prefix

Analogue of the Debezium setting database.server.name.
Messages will be sent to topic with name &lt;topic_prefix&gt;.&lt;schema&gt;.&lt;table_name&gt;.

Includes only one of the fields `topic`, `topic_prefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topic_name | **string**

Topic name ||
|| save_tx_order | **bool**

Save transactions order
Not to split events queue into separate per-table queues. ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

Data serialization format

#|
||Field | Description ||
|| serializer_auto | **[SerializerAuto](#yandex.cloud.datatransfer.v1.endpoint.SerializerAuto)**

Select the serialization format automatically

Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`. ||
|| serializer_json | **[SerializerJSON](#yandex.cloud.datatransfer.v1.endpoint.SerializerJSON)**

Serialize data in json format

Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`. ||
|| serializer_debezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Serialize data in debezium format

Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`. ||
|#

## SerializerAuto {#yandex.cloud.datatransfer.v1.endpoint.SerializerAuto}

#|
||Field | Description ||
|| Empty | > ||
|#

## SerializerJSON {#yandex.cloud.datatransfer.v1.endpoint.SerializerJSON}

#|
||Field | Description ||
|| Empty | > ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

#|
||Field | Description ||
|| serializer_parameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**

Settings of sterilization parameters as key-value pairs ||
|#

## DebeziumSerializerParameter {#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter}

#|
||Field | Description ||
|| key | **string**

Name of the serializer parameter ||
|| value | **string**

Value of the serializer parameter ||
|#

## MongoTarget {#yandex.cloud.datatransfer.v1.endpoint.MongoTarget}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| database | **string**

Database name ||
|| cleanup_policy | enum **CleanupPolicy**

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| subnet_id | **string** ||
|| security_groups[] | **string**

Security groups ||
|#

## MetrikaSource {#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource}

#|
||Field | Description ||
|| counter_ids[] | **int64** ||
|| token | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| streams[] | **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)** ||
|#

## MetrikaStream {#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream}

#|
||Field | Description ||
|| type | enum **MetrikaStreamType**

- `METRIKA_STREAM_TYPE_UNSPECIFIED`
- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string** ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

#|
||Field | Description ||
|| database | **string**

Database ||
|| stream | **string**

Stream ||
|| service_account_id | **string**

SA which has read access to the stream. ||
|| save_tx_order | **bool**

Save transaction order
Not to split events queue into separate per-table queues.
Incompatible with setting Topic prefix, only with Topic full name. ||
|| compression_codec | enum **YdsCompressionCodec**

- `YDS_COMPRESSION_CODEC_UNSPECIFIED`
- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format ||
|| endpoint | **string**

for dedicated db ||
|| subnet_id | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| security_groups[] | **string**

Security groups ||
|#