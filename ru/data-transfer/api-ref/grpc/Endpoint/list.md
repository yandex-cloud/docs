---
editable: false
---

# Data Transfer API, gRPC: EndpointService.List

Lists endpoints in the specified folder.

## gRPC request

**rpc List ([ListEndpointsRequest](#yandex.cloud.datatransfer.v1.ListEndpointsRequest)) returns ([ListEndpointsResponse](#yandex.cloud.datatransfer.v1.ListEndpointsResponse))**

## ListEndpointsRequest {#yandex.cloud.datatransfer.v1.ListEndpointsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Identifier of the folder containing the endpoints to be listed. ||
|| page_size | **int64**

The maximum number of endpoints to be sent in the response message. If the
folder contains more endpoints than `page_size`, `next_page_token` will be
included
in the response message. Include it into the subsequent `ListEndpointRequest` to
fetch the next page. Defaults to `100` if not specified. The maximum allowed
value
for this field is `1000`. ||
|| page_token | **string**

Opaque value identifying the endpoints page to be fetched. Should be empty in
the first `ListEndpointsRequest`. Subsequent requests should have this field
filled
with the `next_page_token` from the previous `ListEndpointsResponse`. ||
|#

## ListEndpointsResponse {#yandex.cloud.datatransfer.v1.ListEndpointsResponse}

```json
{
  "endpoints": [
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
              "connection_id": "string",
              "subnet_id": "string"
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
              "connection_id": "string",
              "subnet_id": "string"
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
            // Includes only one of the fields `cluster_id`, `on_premise`, `connection_manager_connection`
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
            },
            "connection_manager_connection": {
              "connection_id": "string",
              "subnet_id": "string"
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
                "connection_id": "string",
                "subnet_id": "string"
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
              "connection_id": "string",
              "subnet_id": "string"
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
              "connection_id": "string",
              "subnet_id": "string"
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
                "connection_id": "string",
                "subnet_id": "string"
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
            // Includes only one of the fields `cluster_id`, `on_premise`, `connection_manager_connection`
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
            },
            "connection_manager_connection": {
              "connection_id": "string",
              "subnet_id": "string"
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| endpoints[] | **[Endpoint](#yandex.cloud.datatransfer.v1.Endpoint)**

The list of endpoints. If there are more endpoints in the folder, then
`next_page_token` is a non-empty string to be included into the subsequent
`ListEndpointsRequest` to fetch the next endpoints page. ||
|| next_page_token | **string**

Opaque value identifying the next endpoints page. This field is empty if there
are no more endpoints in the folder. Otherwise, it is non-empty and should be
included in the subsequent `ListEndpointsRequest` to fetch the next endpoints
page. ||
|#

## Endpoint {#yandex.cloud.datatransfer.v1.Endpoint}

Data Transfer endpoint. For more information, see [the official
documentation](https://yandex.cloud/docs/data-transfer/)

#|
||Field | Description ||
|| id | **string** ||
|| folder_id | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| settings | **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)**

DataTransfer Endpoint Settings block ||
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

Settings specific to the MySQL source endpoint

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Name of the database to transfer

You can leave it empty, then it will be possible to transfer tables from several
databases at the same time from this source. ||
|| user | **string**

User for database access. Required unless connection manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| object_transfer_settings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**

Schema migration
Defines which database schema objects should be transferred, e.g. views,
routines, etc.
All of the attrubutes in the block are optional and should be either
`BEFORE_DATA`, `AFTER_DATA` or `NEVER`." ||
|| include_tables_regex[] | **string**

List of regular expressions of table names which should be transferred. A table
name is formatted as schemaname.tablename. For example, a single regular
expression may look like `^mydb.employees$` ||
|| exclude_tables_regex[] | **string**

Opposite of `include_table_regex`. The tables matching the specified regular
expressions will not be transferred ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Get Mysql installation params and credentials from Connection Manager

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **int64**

Port for the database connection ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| hosts[] | **string**

List of host names of the MySQL server. Exactly one host is expected ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## TLSMode {#yandex.cloud.datatransfer.v1.endpoint.TLSMode}

TLS configuration

#|
||Field | Description ||
|| disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Empty block designating that the connection is not secured, i.e. plaintext
connection

Includes only one of the fields `disabled`, `enabled`. ||
|| enabled | **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**

TLS is used for the server connection

Includes only one of the fields `disabled`, `enabled`. ||
|#

## TLSConfig {#yandex.cloud.datatransfer.v1.endpoint.TLSConfig}

#|
||Field | Description ||
|| ca_certificate | **string**

CA certificate

X.509 certificate of the certificate authority which issued the server's
certificate, in PEM format. When CA certificate is specified, TLS is used to
connect to the server. If CA certificate is empty, the server's certificate must
be signed by a well-known CA ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

Use Connection Manager connection

#|
||Field | Description ||
|| connection_id | **string**

ID of connection in Connection Manager with installation params and credetials ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
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

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| routine | enum **ObjectTransferStage**

Routines

CREATE PROCEDURE ... ; CREATE FUNCTION ... ;

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | enum **ObjectTransferStage**

Triggers

CREATE TRIGGER ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| tables | enum **ObjectTransferStage**

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

Settings specific to the PostgreSQL source endpoint.

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Name of the database to transfer ||
|| user | **string**

User for database access. Required unless Connection Manager connection is used. ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| include_tables[] | **string**

List of tables to transfer, formatted as `schemaname.tablename`.
If omitted or an empty list is specified, all tables will be transferred.
Can contain schema_name.* patterns. ||
|| exclude_tables[] | **string**

List of tables which will not be transfered, formatted as `schemaname.tablename`
If omitted or empty list is specified, all tables are replicated.
Can contain schema_name.* patterns. ||
|| slot_byte_lag_limit | **int64**

Maximum WAL size held by the replication slot (API - in bytes, terraform - in
gigabytes);
Exceeding this limit will result in a replication failure and deletion of the
replication slot.
Default is 50 gigabytes ||
|| service_schema | **string**

Name of the database schema in which auxiliary tables needed for the transfer
will be created (__consumer_keeper, __data_transfer_mole_finder).
Empty `service_schema` implies schema `public` ||
|| object_transfer_settings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**

Defines which database schema objects should be transferred, e.g. views,
functions, etc.
All of the attributes in this block are optional and should be either
`BEFORE_DATA`, `AFTER_DATA` or `NEVER` ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Get Postgres installation params and credentials from Connection Manager

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **int64**

PG port. Will be used if the cluster ID is not specified. ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| hosts[] | **string**

PG installation hosts ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | enum **ObjectTransferStage**

Sequences

CREATE SEQUENCE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequence_owned_by | enum **ObjectTransferStage**

Owned sequences

CREATE SEQUENCE ... OWNED BY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| table | enum **ObjectTransferStage**

Tables

CREATE TABLE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| primary_key | enum **ObjectTransferStage**

Primary keys

ALTER TABLE ... ADD PRIMARY KEY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| fk_constraint | enum **ObjectTransferStage**

Foreign keys

ALTER TABLE ... ADD FOREIGN KEY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| default_values | enum **ObjectTransferStage**

Default values

ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| constraint | enum **ObjectTransferStage**

Constraints

ALTER TABLE ... ADD CONSTRAINT ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| index | enum **ObjectTransferStage**

Indexes

CREATE INDEX ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| view | enum **ObjectTransferStage**

Views

CREATE VIEW ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| function | enum **ObjectTransferStage**

Functions

CREATE FUNCTION ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | enum **ObjectTransferStage**

Triggers

CREATE TRIGGER ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| type | enum **ObjectTransferStage**

Types

CREATE TYPE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| rule | enum **ObjectTransferStage**

Rules

CREATE RULE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| collation | enum **ObjectTransferStage**

Collations

CREATE COLLATION ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| policy | enum **ObjectTransferStage**

Policies

CREATE POLICY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| cast | enum **ObjectTransferStage**

Casts

CREATE CAST ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| materialized_view | enum **ObjectTransferStage**

Materialized views

CREATE MATERIALIZED VIEW ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequence_set | enum **ObjectTransferStage**

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

Settings specific to the YDB source endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB where tables are stored.
Example: `/ru/transfer_manager/prod/data-transfer-yt` ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
If not specified, will be determined by database ||
|| paths[] | **string**

A list of paths which should be uploaded. When not specified, all available
tables are uploaded ||
|| service_account_id | **string**

Service account ID for interaction with database ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| sa_key_content | **string**

Authorization Key ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| changefeed_custom_name | **string**

Pre-created change feed if any ||
|| changefeed_custom_consumer_name | **string**

Consumer for pre-created change feed if any ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

Settings specific to the YDS source endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB for streams
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| stream | **string**

Stream to read ||
|| service_account_id | **string**

Service account ID which has read access to the stream. ||
|| supported_codecs[] | enum **YdsCompressionCodec**

List of supported compression codecs
Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
YDS_COMPRESSION_CODEC_GZIP

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

YDS Endpoint for dedicated db ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| consumer | **string**

Custom consumer - for important streams ||
|#

## Parser {#yandex.cloud.datatransfer.v1.endpoint.Parser}

#|
||Field | Description ||
|| json_parser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Parse data in json format

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|| audit_trails_v1_parser | **[AuditTrailsV1Parser](#yandex.cloud.datatransfer.v1.endpoint.AuditTrailsV1Parser)**

Parse Audit Trails data. Empty struct

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|| cloud_logging_parser | **[CloudLoggingParser](#yandex.cloud.datatransfer.v1.endpoint.CloudLoggingParser)**

Parse Cloud Logging data. Empty struct

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|| tskv_parser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Parse data in tskv format

Includes only one of the fields `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser`, `tskv_parser`. ||
|#

## GenericParserCommon {#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon}

#|
||Field | Description ||
|| data_schema | **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)**

Data parsing scheme ||
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

Description of the data schema as JSON specification

Includes only one of the fields `json_fields`, `fields`. ||
|| fields | **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**

Description of the data schema in the array of `fields` structure

Includes only one of the fields `json_fields`, `fields`. ||
|#

## FieldList {#yandex.cloud.datatransfer.v1.endpoint.FieldList}

#|
||Field | Description ||
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**

Description of the column schema in the array of `fields` structure ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string**

Field name ||
|| type | enum **ColumnType**

Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
`UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.

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
|| key | **bool**

Mark field as Primary Key ||
|| required | **bool**

Mark field as required ||
|| path | **string**

Path to the field ||
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

Settings specific to the Kafka source endpoint

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| topic_name | **string**

*Deprecated**. Please use `topic_names` instead
Full source topic name ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**

Transform data with a custom Cloud Function ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing parameters. If not set, the source messages are read in raw ||
|| topic_names[] | **string**

List of full source topic names to read ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| cluster_id | **string**

Managed Service for Kafka cluster ID.
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| on_premise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Connection options for on-premise Kafka
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| connection_manager_connection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Get Kafka installation params and credentials from Connection Manager
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `cluster_id`, `on_premise`, `connection_manager_connection`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

On-premise Kafka installation options

#|
||Field | Description ||
|| broker_urls[] | **string**

Kafka broker URLs ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
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

SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
KAFKA_MECHANISM_SHA512

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

Buffer size for function. Maximum 4 GB.  Use value with units, i.e. 10 B, 20 kB,
2.0 MB, 30 MB, 1.0 GB ||
|| buffer_flush_interval | **string**

Flush interval ||
|| invocation_timeout | **string**

Invocation timeout ||
|| service_account_id | **string**

Service account ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

Settings specific to the MongoDB source endpoint

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**

Connection settings ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of collections for replication. Empty list implies replication of all
tables on the deployment. Allowed to use * as collection name. ||
|| excluded_collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of forbidden collections for replication. Allowed to use * as collection
name for forbid all collections of concrete schema. ||
|| secondary_preferred_mode | **bool**

Read mode for mongo client: whether the secondary server should be preferred to
the primary when copying data ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Identifier of the Yandex StoreDoc cluster
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| on_premise | **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**

Connection settings of the on-premise MongoDB server
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| connection_manager_connection | **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**

Get StoreDoc/MongoDB installation params and credentials from Connection Manager
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdb_cluster_id`, `on_premise`, `connection_manager_connection`. ||
|| user | **string**

User name, required unless connection_manager_connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|| auth_source | **string**

Database name associated with the credentials ||
|#

## OnPremiseMongo {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo}

#|
||Field | Description ||
|| hosts[] | **string**

Host names of the replica set ||
|| port | **int64**

TCP Port number ||
|| replica_set | **string**

Replica set name ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for the server connection. Empty implies plaintext connection ||
|#

## MongoConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection}

#|
||Field | Description ||
|| connection_id | **string**

ID of connectionmanager connection with mongodb/Yandex Storedoc installation
parameters and credentials ||
|| replica_set | **string**

Replica set name, used only for on-premise mongodb installations ||
|#

## MongoCollection {#yandex.cloud.datatransfer.v1.endpoint.MongoCollection}

#|
||Field | Description ||
|| database_name | **string** ||
|| collection_name | **string** ||
|#

## ClickhouseSource {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource}

Settings specific to the ClickHouse source endpoint

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**

Connection settings ||
|| include_tables[] | **string**

White list of tables for replication. If none or empty list is presented - will
replicate all tables. Can contain * patterns. ||
|| exclude_tables[] | **string**

Exclude list of tables for replication. If none or empty list is presented -
will replicate all tables. Can contain * patterns. ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| clickhouse_cluster_name | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup or managed cluster ID by default ||
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

Connection settings of the on-premise ClickHouse server

Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`. ||
|| connection_manager_connection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Get ClickHouse installation params and credentials from Connection Manager

Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`. ||
|| mdb_cluster_id | **string**

Identifier of the Managed ClickHouse cluster

Includes only one of the fields `on_premise`, `connection_manager_connection`, `mdb_cluster_id`. ||
|| user | **string**

User for database access. Required unless connection_manager_connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for the database access ||
|| database | **string**

Database name ||
|#

## OnPremiseClickhouse {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse}

#|
||Field | Description ||
|| shards[] | **[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)** ||
|| http_port | **int64** ||
|| native_port | **int64** ||
|| tls_mode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default ||
|#

## ClickhouseShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard}

#|
||Field | Description ||
|| name | **string** ||
|| hosts[] | **string** ||
|#

## MysqlTarget {#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget}

Settings specific to the MySQL target endpoint

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

User for database access. Required unless connection manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| sql_mode | **string**

[sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) to use when
interacting with the server.
Defaults to `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION` ||
|| skip_constraint_checks | **bool**

Disable constraints checks
When `true`, disables foreign key checks and unique checks. `False` by default.
See
[foreign_key_checks](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_foreign_key_checks).
Recommend to disable for increase replication speed unless schema contains
cascading operations ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| cleanup_policy | enum **CleanupPolicy**

Cleanup policy for activate, reactivate and reupload processes.
One of `DISABLED`, `DROP` or `TRUNCATE` Default is `DISABLED`.

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| service_database | **string**

Database schema for service table
Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| is_schema_migration_disabled | **bool**

Whether can change table schema if schema changed on source ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

Settings specific to the PostgreSQL target endpoint

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Target database name ||
|| user | **string**

User for database access. Required unless Connection Manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| cleanup_policy | enum **CleanupPolicy**

Cleanup policy for activate, reactivate and reupload processes.
One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| is_schema_migration_disabled | **bool**

Whether can change table schema if schema changed on source ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

Settings specific to the ClickHouse target endpoint

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**

Connection settings ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| alt_names[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**

Table renaming rules in target ||
|| cleanup_policy | enum **ClickhouseCleanupPolicy**

How to clean collections when activating the transfer. One of
`CLICKHOUSE_CLEANUP_POLICY_DISABLED` or `CLICKHOUSE_CLEANUP_POLICY_DROP`

- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)**

Shard selection rules for the data being transferred ||
|| is_schema_migration_disabled | **bool**

Whether can change table schema if schema changed on source ||
|| clickhouse_cluster_name | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup or managed cluster ID by default. ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Shard data by the hash value of the specified column

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|| custom_mapping | **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**

A custom shard mapping by the value of the specified column

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|| transfer_id | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Shard data by ID of the transfer

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|| round_robin | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Distribute incoming rows between ClickHouse shards in a round-robin manner.
Specify as an empty block to enable

Includes only one of the fields `column_value_hash`, `custom_mapping`, `transfer_id`, `round_robin`. ||
|#

## ColumnValueHash {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash}

#|
||Field | Description ||
|| column_name | **string**

The name of the column to calculate hash from ||
|#

## ColumnValueMapping {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping}

#|
||Field | Description ||
|| column_name | **string**

The name of the column to inspect when deciding the shard to chose for an
incoming row ||
|| mapping[] | **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)**

The mapping of the specified column values to the shard names ||
|#

## ValueToShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard}

#|
||Field | Description ||
|| column_value | **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)**

The value of the column. Currently only the string columns are supported ||
|| shard_name | **string**

The name of the shard into which all the rows with the specified `column_value`
will be written ||
|#

## ColumnValue {#yandex.cloud.datatransfer.v1.endpoint.ColumnValue}

#|
||Field | Description ||
|| string_value | **string**

Includes only one of the fields `string_value`. ||
|#

## YdbTarget {#yandex.cloud.datatransfer.v1.endpoint.YdbTarget}

Settings specific to the YDB target endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB where tables are stored.
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
If not specified, will be determined by database ||
|| path | **string**

Path extension for database, each table will be layouted into this path ||
|| service_account_id | **string**

Service account ID for interaction with database ||
|| cleanup_policy | enum **YdbCleanupPolicy**

Cleanup policy determine how to clean collections when activating the transfer.
One of `YDB_CLEANUP_POLICY_DISABLED` or `YDB_CLEANUP_POLICY_DROP`

- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| sa_key_content | **string**

Authentication key ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| is_table_column_oriented | **bool**

Whether a column-oriented (i.e. OLAP) tables should be created.
Default is `false` (create row-oriented OLTP tables) ||
|| default_compression | enum **YdbDefaultCompression**

Compression that will be used for default columns family on YDB table creation.
One of `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`,
`YDB_DEFAULT_COMPRESSION_DISABLED`, `YDB_DEFAULT_COMPRESSION_LZ4`

- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| is_schema_migration_disabled | **bool**

Whether can change table schema if schema changed on source ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

Settings specific to the Kafka target endpoint

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| topic_settings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**

Target topic settings ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format settings ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

All messages will be sent to one topic

Includes only one of the fields `topic`, `topic_prefix`. ||
|| topic_prefix | **string**

Topic prefix
Messages will be sent to topic with name &lt;topic_prefix&gt;.&lt;schema&gt;.&lt;table_name&gt;.
Analogue of the Debezium setting database.server.name.

Includes only one of the fields `topic`, `topic_prefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topic_name | **string**

Full topic name ||
|| save_tx_order | **bool**

Save transactions order
Not to split events queue into separate per-table queues. ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

Data serialization format

#|
||Field | Description ||
|| serializer_auto | **[SerializerAuto](#yandex.cloud.datatransfer.v1.endpoint.SerializerAuto)**

Empty block. Select the serialization format automatically

Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`. ||
|| serializer_json | **[SerializerJSON](#yandex.cloud.datatransfer.v1.endpoint.SerializerJSON)**

Empty block. Serialize data in json format

Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`. ||
|| serializer_debezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Serialize data in debezium json format

Includes only one of the fields `serializer_auto`, `serializer_json`, `serializer_debezium`. ||
|#

## SerializerAuto {#yandex.cloud.datatransfer.v1.endpoint.SerializerAuto}

Empty block. Select data serialization format automatically

#|
||Field | Description ||
|| Empty | > ||
|#

## SerializerJSON {#yandex.cloud.datatransfer.v1.endpoint.SerializerJSON}

Empty block. Serialize data in json format

#|
||Field | Description ||
|| Empty | > ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

Serialize data in json format

#|
||Field | Description ||
|| serializer_parameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**

A list of Debezium parameters set by the structure of the `key` and `value`
string fields ||
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

Settings specific to the MongoDB target endpoint

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**

Connection settings ||
|| database | **string**

Database name. If not empty, then all the data will be written to the database
with the specified name; otherwise the database name is the same as in the
source endpoint ||
|| cleanup_policy | enum **CleanupPolicy**

How to clean collections when activating the transfer. One of `DISABLED`, `DROP`
or `TRUNCATE`

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|#

## MetrikaSource {#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource}

Settings specific to the Yandex Metrika source endpoint

#|
||Field | Description ||
|| counter_ids[] | **int64**

Counter IDs ||
|| token | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Authentication token ||
|| streams[] | **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)**

Streams ||
|#

## MetrikaStream {#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream}

#|
||Field | Description ||
|| type | enum **MetrikaStreamType**

Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS,
METRIKA_STREAM_TYPE_HITS_V2

- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string**

Column names ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

Settings specific to the YDS target endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB for streams
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| stream | **string**

Stream to write to ||
|| service_account_id | **string**

Service account ID which has read access to the stream ||
|| save_tx_order | **bool**

Save transaction order
Not to split events queue into separate per-table queues.
Incompatible with setting Topic prefix, only with Topic full name. ||
|| compression_codec | enum **YdsCompressionCodec**

Codec to use for output data compression. If not specified, no compression will
be done
Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
YDS_COMPRESSION_CODEC_GZIP

- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format ||
|| endpoint | **string**

YDS Endpoint for dedicated db ||
|| subnet_id | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| security_groups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|#