---
editable: false
noIndex: true
---

# yc beta datatransfer endpoint create

Creates an endpoint in the specified folder.

#### Command Usage

Syntax:

`yc beta datatransfer endpoint create <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--description` | `string`

Description of the endpoint. ||
|| `--folder-id` | `string`

ID of the folder to create the endpoint in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--labels` | `map<string><string>`

Endpoint labels as 'key:value' pairs. For details about the concept, see [documentation]({{ api-url-prefix }}/resource-manager/concepts/labels). ||
|| `--name` | `string`

Name of the endpoint. The name must be unique within the folder. ||
|| `--settings` | `shorthand/json`

Shorthand Syntax:

```hcl
{
  settings = clickhouse-source={
    clickhouse-cluster-name = string,
    connection = {
      connection = connection-options={
        address = connection-manager-connection={
          connection-id = string,
          subnet-id = string
        } | mdb-cluster-id=string | on-premise={
          http-port = integer,
          native-port = integer,
          shards = [
            {
              hosts = string,...,
              name = string
            }, ...
          ],
          tls-mode = {
            tls-mode = disabled={} | enabled={
              ca-certificate = string
            }
          }
        },
        database = string,
        password = {
          value = raw=string
        },
        user = string
      }
    },
    exclude-tables = string,...,
    include-tables = string,...,
    security-groups = string,...,
    subnet-id = string
  } | clickhouse-target={
    alt-names = [
      {
        from-name = string,
        to-name = string
      }, ...
    ],
    cleanup-policy = CLICKHOUSE_CLEANUP_POLICY_DISABLED|CLICKHOUSE_CLEANUP_POLICY_DROP|CLICKHOUSE_CLEANUP_POLICY_TRUNCATE,
    clickhouse-cluster-name = string,
    connection = {
      connection = connection-options={
        address = connection-manager-connection={
          connection-id = string,
          subnet-id = string
        } | mdb-cluster-id=string | on-premise={
          http-port = integer,
          native-port = integer,
          shards = [
            {
              hosts = string,...,
              name = string
            }, ...
          ],
          tls-mode = {
            tls-mode = disabled={} | enabled={
              ca-certificate = string
            }
          }
        },
        database = string,
        password = {
          value = raw=string
        },
        user = string
      }
    },
    is-schema-migration-disabled = boolean,
    security-groups = string,...,
    sharding = {
      sharding = column-value-hash={
        column-name = string
      } | custom-mapping={
        column-name = string,
        mapping = [
          {
            column-value = {
              value = string-value=string
            },
            shard-name = string
          }, ...
        ]
      } | round-robin={} | transfer-id={}
    },
    subnet-id = string
  } | kafka-source={
    auth = {
      security = no-auth={} | sasl={
        mechanism = KAFKA_MECHANISM_SHA256|KAFKA_MECHANISM_SHA512,
        password = {
          value = raw=string
        },
        user = string
      }
    },
    connection = {
      connection = cluster-id=string | connection-manager-connection={
        connection-id = string,
        subnet-id = string
      } | on-premise={
        broker-urls = string,...,
        subnet-id = string,
        tls-mode = {
          tls-mode = disabled={} | enabled={
            ca-certificate = string
          }
        }
      }
    },
    parser = {
      parser = audit-trails-v1-parser={} | cloud-logging-parser={} | json-parser={
        add-rest-column = boolean,
        data-schema = {
          schema = fields={
            fields = [
              {
                key = boolean,
                name = string,
                path = string,
                required = boolean,
                type = INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64
              }, ...
            ]
          } | json-fields=string
        },
        null-keys-allowed = boolean,
        unescape-string-values = boolean
      } | tskv-parser={
        add-rest-column = boolean,
        data-schema = {
          schema = fields={
            fields = [
              {
                key = boolean,
                name = string,
                path = string,
                required = boolean,
                type = INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64
              }, ...
            ]
          } | json-fields=string
        },
        null-keys-allowed = boolean,
        unescape-string-values = boolean
      }
    },
    security-groups = string,...,
    topic-name = string,
    topic-names = string,...,
    transformer = {
      buffer-flush-interval = string,
      buffer-size = string,
      cloud-function = string,
      invocation-timeout = string,
      number-of-retries = integer,
      service-account-id = string
    }
  } | kafka-target={
    auth = {
      security = no-auth={} | sasl={
        mechanism = KAFKA_MECHANISM_SHA256|KAFKA_MECHANISM_SHA512,
        password = {
          value = raw=string
        },
        user = string
      }
    },
    connection = {
      connection = cluster-id=string | connection-manager-connection={
        connection-id = string,
        subnet-id = string
      } | on-premise={
        broker-urls = string,...,
        subnet-id = string,
        tls-mode = {
          tls-mode = disabled={} | enabled={
            ca-certificate = string
          }
        }
      }
    },
    security-groups = string,...,
    serializer = {
      serializer = serializer-auto={} | serializer-debezium={
        serializer-parameters = [
          {
            key = string,
            value = string
          }, ...
        ]
      } | serializer-json={}
    },
    topic-settings = {
      topic-settings = topic={
        save-tx-order = boolean,
        topic-name = string
      } | topic-prefix=string
    }
  } | metrika-source={
    counter-ids = integer,...,
    streams = [
      {
        columns = string,...,
        type = METRIKA_STREAM_TYPE_HITS|METRIKA_STREAM_TYPE_VISITS|METRIKA_STREAM_TYPE_HITS_V2
      }, ...
    ],
    token = {
      value = raw=string
    }
  } | mongo-source={
    collections = [
      {
        collection-name = string,
        database-name = string
      }, ...
    ],
    connection = {
      connection = connection-options={
        address = connection-manager-connection={
          connection-id = string,
          replica-set = string
        } | mdb-cluster-id=string | on-premise={
          hosts = string,...,
          port = integer,
          replica-set = string,
          tls-mode = {
            tls-mode = disabled={} | enabled={
              ca-certificate = string
            }
          }
        },
        auth-source = string,
        password = {
          value = raw=string
        },
        user = string
      }
    },
    excluded-collections = [
      {
        collection-name = string,
        database-name = string
      }, ...
    ],
    secondary-preferred-mode = boolean,
    security-groups = string,...,
    subnet-id = string
  } | mongo-target={
    cleanup-policy = DISABLED|DROP|TRUNCATE,
    connection = {
      connection = connection-options={
        address = connection-manager-connection={
          connection-id = string,
          replica-set = string
        } | mdb-cluster-id=string | on-premise={
          hosts = string,...,
          port = integer,
          replica-set = string,
          tls-mode = {
            tls-mode = disabled={} | enabled={
              ca-certificate = string
            }
          }
        },
        auth-source = string,
        password = {
          value = raw=string
        },
        user = string
      }
    },
    database = string,
    security-groups = string,...,
    subnet-id = string
  } | mysql-source={
    connection = {
      connection = connection-manager-connection={
        connection-id = string,
        subnet-id = string
      } | mdb-cluster-id=string | on-premise={
        hosts = string,...,
        port = integer,
        subnet-id = string,
        tls-mode = {
          tls-mode = disabled={} | enabled={
            ca-certificate = string
          }
        }
      }
    },
    database = string,
    exclude-tables-regex = string,...,
    include-tables-regex = string,...,
    object-transfer-settings = {
      routine = BEFORE_DATA|AFTER_DATA|NEVER,
      tables = BEFORE_DATA|AFTER_DATA|NEVER,
      trigger = BEFORE_DATA|AFTER_DATA|NEVER,
      view = BEFORE_DATA|AFTER_DATA|NEVER
    },
    password = {
      value = raw=string
    },
    security-groups = string,...,
    service-database = string,
    timezone = string,
    user = string
  } | mysql-target={
    cleanup-policy = DISABLED|DROP|TRUNCATE,
    connection = {
      connection = connection-manager-connection={
        connection-id = string,
        subnet-id = string
      } | mdb-cluster-id=string | on-premise={
        hosts = string,...,
        port = integer,
        subnet-id = string,
        tls-mode = {
          tls-mode = disabled={} | enabled={
            ca-certificate = string
          }
        }
      }
    },
    database = string,
    is-schema-migration-disabled = boolean,
    password = {
      value = raw=string
    },
    security-groups = string,...,
    service-database = string,
    skip-constraint-checks = boolean,
    sql-mode = string,
    timezone = string,
    user = string
  } | postgres-source={
    connection = {
      connection = connection-manager-connection={
        connection-id = string,
        subnet-id = string
      } | mdb-cluster-id=string | on-premise={
        hosts = string,...,
        port = integer,
        subnet-id = string,
        tls-mode = {
          tls-mode = disabled={} | enabled={
            ca-certificate = string
          }
        }
      }
    },
    database = string,
    exclude-tables = string,...,
    include-tables = string,...,
    object-transfer-settings = {
      cast = BEFORE_DATA|AFTER_DATA|NEVER,
      collation = BEFORE_DATA|AFTER_DATA|NEVER,
      constraint = BEFORE_DATA|AFTER_DATA|NEVER,
      default-values = BEFORE_DATA|AFTER_DATA|NEVER,
      fk-constraint = BEFORE_DATA|AFTER_DATA|NEVER,
      function = BEFORE_DATA|AFTER_DATA|NEVER,
      index = BEFORE_DATA|AFTER_DATA|NEVER,
      materialized-view = BEFORE_DATA|AFTER_DATA|NEVER,
      policy = BEFORE_DATA|AFTER_DATA|NEVER,
      primary-key = BEFORE_DATA|AFTER_DATA|NEVER,
      rule = BEFORE_DATA|AFTER_DATA|NEVER,
      sequence = BEFORE_DATA|AFTER_DATA|NEVER,
      sequence-owned-by = BEFORE_DATA|AFTER_DATA|NEVER,
      sequence-set = BEFORE_DATA|AFTER_DATA|NEVER,
      table = BEFORE_DATA|AFTER_DATA|NEVER,
      trigger = BEFORE_DATA|AFTER_DATA|NEVER,
      type = BEFORE_DATA|AFTER_DATA|NEVER,
      view = BEFORE_DATA|AFTER_DATA|NEVER
    },
    password = {
      value = raw=string
    },
    security-groups = string,...,
    service-schema = string,
    slot-byte-lag-limit = integer,
    user = string
  } | postgres-target={
    cleanup-policy = DISABLED|DROP|TRUNCATE,
    connection = {
      connection = connection-manager-connection={
        connection-id = string,
        subnet-id = string
      } | mdb-cluster-id=string | on-premise={
        hosts = string,...,
        port = integer,
        subnet-id = string,
        tls-mode = {
          tls-mode = disabled={} | enabled={
            ca-certificate = string
          }
        }
      }
    },
    database = string,
    is-schema-migration-disabled = boolean,
    password = {
      value = raw=string
    },
    security-groups = string,...,
    user = string
  } | ydb-source={
    changefeed-custom-consumer-name = string,
    changefeed-custom-name = string,
    database = string,
    instance = string,
    paths = string,...,
    sa-key-content = string,
    security-groups = string,...,
    service-account-id = string,
    subnet-id = string
  } | ydb-target={
    cleanup-policy = YDB_CLEANUP_POLICY_DISABLED|YDB_CLEANUP_POLICY_DROP,
    database = string,
    default-compression = YDB_DEFAULT_COMPRESSION_DISABLED|YDB_DEFAULT_COMPRESSION_LZ4,
    instance = string,
    is-schema-migration-disabled = boolean,
    is-table-column-oriented = boolean,
    path = string,
    sa-key-content = string,
    security-groups = string,...,
    service-account-id = string,
    subnet-id = string
  } | yds-source={
    allow-ttl-rewind = boolean,
    consumer = string,
    database = string,
    endpoint = string,
    parser = {
      parser = audit-trails-v1-parser={} | cloud-logging-parser={} | json-parser={
        add-rest-column = boolean,
        data-schema = {
          schema = fields={
            fields = [
              {
                key = boolean,
                name = string,
                path = string,
                required = boolean,
                type = INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64
              }, ...
            ]
          } | json-fields=string
        },
        null-keys-allowed = boolean,
        unescape-string-values = boolean
      } | tskv-parser={
        add-rest-column = boolean,
        data-schema = {
          schema = fields={
            fields = [
              {
                key = boolean,
                name = string,
                path = string,
                required = boolean,
                type = INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64
              }, ...
            ]
          } | json-fields=string
        },
        null-keys-allowed = boolean,
        unescape-string-values = boolean
      }
    },
    security-groups = string,...,
    service-account-id = string,
    stream = string,
    subnet-id = string,
    supported-codecs = [
      YDS_COMPRESSION_CODEC_RAW|YDS_COMPRESSION_CODEC_GZIP|YDS_COMPRESSION_CODEC_ZSTD, ...
    ]
  } | yds-target={
    compression-codec = YDS_COMPRESSION_CODEC_RAW|YDS_COMPRESSION_CODEC_GZIP|YDS_COMPRESSION_CODEC_ZSTD,
    database = string,
    endpoint = string,
    save-tx-order = boolean,
    security-groups = string,...,
    serializer = {
      serializer = serializer-auto={} | serializer-debezium={
        serializer-parameters = [
          {
            key = string,
            value = string
          }, ...
        ]
      } | serializer-json={}
    },
    service-account-id = string,
    stream = string,
    subnet-id = string
  }
}
```

JSON Syntax:

```json
{
  "settings": {
    "clickhouse-source": {
      "clickhouse-cluster-name": "string",
      "connection": {
        "connection": {
          "connection-options": {
            "address": {
              "connection-manager-connection": {
                "connection-id": "string",
                "subnet-id": "string"
              },
              "mdb-cluster-id": "string",
              "on-premise": {
                "http-port": "integer",
                "native-port": "integer",
                "shards": [
                  {
                    "hosts": [
                      "string", ...
                    ],
                    "name": "string"
                  }, ...
                ],
                "tls-mode": {
                  "tls-mode": {
                    "disabled": {},
                    "enabled": {
                      "ca-certificate": "string"
                    }
                  }
                }
              }
            },
            "database": "string",
            "password": {
              "value": {
                "raw": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "exclude-tables": [
        "string", ...
      ],
      "include-tables": [
        "string", ...
      ],
      "security-groups": [
        "string", ...
      ],
      "subnet-id": "string"
    },
    "clickhouse-target": {
      "alt-names": [
        {
          "from-name": "string",
          "to-name": "string"
        }, ...
      ],
      "cleanup-policy": "CLICKHOUSE_CLEANUP_POLICY_DISABLED|CLICKHOUSE_CLEANUP_POLICY_DROP|CLICKHOUSE_CLEANUP_POLICY_TRUNCATE",
      "clickhouse-cluster-name": "string",
      "connection": {
        "connection": {
          "connection-options": {
            "address": {
              "connection-manager-connection": {
                "connection-id": "string",
                "subnet-id": "string"
              },
              "mdb-cluster-id": "string",
              "on-premise": {
                "http-port": "integer",
                "native-port": "integer",
                "shards": [
                  {
                    "hosts": [
                      "string", ...
                    ],
                    "name": "string"
                  }, ...
                ],
                "tls-mode": {
                  "tls-mode": {
                    "disabled": {},
                    "enabled": {
                      "ca-certificate": "string"
                    }
                  }
                }
              }
            },
            "database": "string",
            "password": {
              "value": {
                "raw": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "is-schema-migration-disabled": "boolean",
      "security-groups": [
        "string", ...
      ],
      "sharding": {
        "sharding": {
          "column-value-hash": {
            "column-name": "string"
          },
          "custom-mapping": {
            "column-name": "string",
            "mapping": [
              {
                "column-value": {
                  "value": {
                    "string-value": "string"
                  }
                },
                "shard-name": "string"
              }, ...
            ]
          },
          "round-robin": {},
          "transfer-id": {}
        }
      },
      "subnet-id": "string"
    },
    "kafka-source": {
      "auth": {
        "security": {
          "no-auth": {},
          "sasl": {
            "mechanism": "KAFKA_MECHANISM_SHA256|KAFKA_MECHANISM_SHA512",
            "password": {
              "value": {
                "raw": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "connection": {
        "connection": {
          "cluster-id": "string",
          "connection-manager-connection": {
            "connection-id": "string",
            "subnet-id": "string"
          },
          "on-premise": {
            "broker-urls": [
              "string", ...
            ],
            "subnet-id": "string",
            "tls-mode": {
              "tls-mode": {
                "disabled": {},
                "enabled": {
                  "ca-certificate": "string"
                }
              }
            }
          }
        }
      },
      "parser": {
        "parser": {
          "audit-trails-v1-parser": {},
          "cloud-logging-parser": {},
          "json-parser": {
            "add-rest-column": "boolean",
            "data-schema": {
              "schema": {
                "fields": {
                  "fields": [
                    {
                      "key": "boolean",
                      "name": "string",
                      "path": "string",
                      "required": "boolean",
                      "type": "INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64"
                    }, ...
                  ]
                },
                "json-fields": "string"
              }
            },
            "null-keys-allowed": "boolean",
            "unescape-string-values": "boolean"
          },
          "tskv-parser": {
            "add-rest-column": "boolean",
            "data-schema": {
              "schema": {
                "fields": {
                  "fields": [
                    {
                      "key": "boolean",
                      "name": "string",
                      "path": "string",
                      "required": "boolean",
                      "type": "INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64"
                    }, ...
                  ]
                },
                "json-fields": "string"
              }
            },
            "null-keys-allowed": "boolean",
            "unescape-string-values": "boolean"
          }
        }
      },
      "security-groups": [
        "string", ...
      ],
      "topic-name": "string",
      "topic-names": [
        "string", ...
      ],
      "transformer": {
        "buffer-flush-interval": "string",
        "buffer-size": "string",
        "cloud-function": "string",
        "invocation-timeout": "string",
        "number-of-retries": "integer",
        "service-account-id": "string"
      }
    },
    "kafka-target": {
      "auth": {
        "security": {
          "no-auth": {},
          "sasl": {
            "mechanism": "KAFKA_MECHANISM_SHA256|KAFKA_MECHANISM_SHA512",
            "password": {
              "value": {
                "raw": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "connection": {
        "connection": {
          "cluster-id": "string",
          "connection-manager-connection": {
            "connection-id": "string",
            "subnet-id": "string"
          },
          "on-premise": {
            "broker-urls": [
              "string", ...
            ],
            "subnet-id": "string",
            "tls-mode": {
              "tls-mode": {
                "disabled": {},
                "enabled": {
                  "ca-certificate": "string"
                }
              }
            }
          }
        }
      },
      "security-groups": [
        "string", ...
      ],
      "serializer": {
        "serializer": {
          "serializer-auto": {},
          "serializer-debezium": {
            "serializer-parameters": [
              {
                "key": "string",
                "value": "string"
              }, ...
            ]
          },
          "serializer-json": {}
        }
      },
      "topic-settings": {
        "topic-settings": {
          "topic": {
            "save-tx-order": "boolean",
            "topic-name": "string"
          },
          "topic-prefix": "string"
        }
      }
    },
    "metrika-source": {
      "counter-ids": [
        "integer", ...
      ],
      "streams": [
        {
          "columns": [
            "string", ...
          ],
          "type": "METRIKA_STREAM_TYPE_HITS|METRIKA_STREAM_TYPE_VISITS|METRIKA_STREAM_TYPE_HITS_V2"
        }, ...
      ],
      "token": {
        "value": {
          "raw": "string"
        }
      }
    },
    "mongo-source": {
      "collections": [
        {
          "collection-name": "string",
          "database-name": "string"
        }, ...
      ],
      "connection": {
        "connection": {
          "connection-options": {
            "address": {
              "connection-manager-connection": {
                "connection-id": "string",
                "replica-set": "string"
              },
              "mdb-cluster-id": "string",
              "on-premise": {
                "hosts": [
                  "string", ...
                ],
                "port": "integer",
                "replica-set": "string",
                "tls-mode": {
                  "tls-mode": {
                    "disabled": {},
                    "enabled": {
                      "ca-certificate": "string"
                    }
                  }
                }
              }
            },
            "auth-source": "string",
            "password": {
              "value": {
                "raw": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "excluded-collections": [
        {
          "collection-name": "string",
          "database-name": "string"
        }, ...
      ],
      "secondary-preferred-mode": "boolean",
      "security-groups": [
        "string", ...
      ],
      "subnet-id": "string"
    },
    "mongo-target": {
      "cleanup-policy": "DISABLED|DROP|TRUNCATE",
      "connection": {
        "connection": {
          "connection-options": {
            "address": {
              "connection-manager-connection": {
                "connection-id": "string",
                "replica-set": "string"
              },
              "mdb-cluster-id": "string",
              "on-premise": {
                "hosts": [
                  "string", ...
                ],
                "port": "integer",
                "replica-set": "string",
                "tls-mode": {
                  "tls-mode": {
                    "disabled": {},
                    "enabled": {
                      "ca-certificate": "string"
                    }
                  }
                }
              }
            },
            "auth-source": "string",
            "password": {
              "value": {
                "raw": "string"
              }
            },
            "user": "string"
          }
        }
      },
      "database": "string",
      "security-groups": [
        "string", ...
      ],
      "subnet-id": "string"
    },
    "mysql-source": {
      "connection": {
        "connection": {
          "connection-manager-connection": {
            "connection-id": "string",
            "subnet-id": "string"
          },
          "mdb-cluster-id": "string",
          "on-premise": {
            "hosts": [
              "string", ...
            ],
            "port": "integer",
            "subnet-id": "string",
            "tls-mode": {
              "tls-mode": {
                "disabled": {},
                "enabled": {
                  "ca-certificate": "string"
                }
              }
            }
          }
        }
      },
      "database": "string",
      "exclude-tables-regex": [
        "string", ...
      ],
      "include-tables-regex": [
        "string", ...
      ],
      "object-transfer-settings": {
        "routine": "BEFORE_DATA|AFTER_DATA|NEVER",
        "tables": "BEFORE_DATA|AFTER_DATA|NEVER",
        "trigger": "BEFORE_DATA|AFTER_DATA|NEVER",
        "view": "BEFORE_DATA|AFTER_DATA|NEVER"
      },
      "password": {
        "value": {
          "raw": "string"
        }
      },
      "security-groups": [
        "string", ...
      ],
      "service-database": "string",
      "timezone": "string",
      "user": "string"
    },
    "mysql-target": {
      "cleanup-policy": "DISABLED|DROP|TRUNCATE",
      "connection": {
        "connection": {
          "connection-manager-connection": {
            "connection-id": "string",
            "subnet-id": "string"
          },
          "mdb-cluster-id": "string",
          "on-premise": {
            "hosts": [
              "string", ...
            ],
            "port": "integer",
            "subnet-id": "string",
            "tls-mode": {
              "tls-mode": {
                "disabled": {},
                "enabled": {
                  "ca-certificate": "string"
                }
              }
            }
          }
        }
      },
      "database": "string",
      "is-schema-migration-disabled": "boolean",
      "password": {
        "value": {
          "raw": "string"
        }
      },
      "security-groups": [
        "string", ...
      ],
      "service-database": "string",
      "skip-constraint-checks": "boolean",
      "sql-mode": "string",
      "timezone": "string",
      "user": "string"
    },
    "postgres-source": {
      "connection": {
        "connection": {
          "connection-manager-connection": {
            "connection-id": "string",
            "subnet-id": "string"
          },
          "mdb-cluster-id": "string",
          "on-premise": {
            "hosts": [
              "string", ...
            ],
            "port": "integer",
            "subnet-id": "string",
            "tls-mode": {
              "tls-mode": {
                "disabled": {},
                "enabled": {
                  "ca-certificate": "string"
                }
              }
            }
          }
        }
      },
      "database": "string",
      "exclude-tables": [
        "string", ...
      ],
      "include-tables": [
        "string", ...
      ],
      "object-transfer-settings": {
        "cast": "BEFORE_DATA|AFTER_DATA|NEVER",
        "collation": "BEFORE_DATA|AFTER_DATA|NEVER",
        "constraint": "BEFORE_DATA|AFTER_DATA|NEVER",
        "default-values": "BEFORE_DATA|AFTER_DATA|NEVER",
        "fk-constraint": "BEFORE_DATA|AFTER_DATA|NEVER",
        "function": "BEFORE_DATA|AFTER_DATA|NEVER",
        "index": "BEFORE_DATA|AFTER_DATA|NEVER",
        "materialized-view": "BEFORE_DATA|AFTER_DATA|NEVER",
        "policy": "BEFORE_DATA|AFTER_DATA|NEVER",
        "primary-key": "BEFORE_DATA|AFTER_DATA|NEVER",
        "rule": "BEFORE_DATA|AFTER_DATA|NEVER",
        "sequence": "BEFORE_DATA|AFTER_DATA|NEVER",
        "sequence-owned-by": "BEFORE_DATA|AFTER_DATA|NEVER",
        "sequence-set": "BEFORE_DATA|AFTER_DATA|NEVER",
        "table": "BEFORE_DATA|AFTER_DATA|NEVER",
        "trigger": "BEFORE_DATA|AFTER_DATA|NEVER",
        "type": "BEFORE_DATA|AFTER_DATA|NEVER",
        "view": "BEFORE_DATA|AFTER_DATA|NEVER"
      },
      "password": {
        "value": {
          "raw": "string"
        }
      },
      "security-groups": [
        "string", ...
      ],
      "service-schema": "string",
      "slot-byte-lag-limit": "integer",
      "user": "string"
    },
    "postgres-target": {
      "cleanup-policy": "DISABLED|DROP|TRUNCATE",
      "connection": {
        "connection": {
          "connection-manager-connection": {
            "connection-id": "string",
            "subnet-id": "string"
          },
          "mdb-cluster-id": "string",
          "on-premise": {
            "hosts": [
              "string", ...
            ],
            "port": "integer",
            "subnet-id": "string",
            "tls-mode": {
              "tls-mode": {
                "disabled": {},
                "enabled": {
                  "ca-certificate": "string"
                }
              }
            }
          }
        }
      },
      "database": "string",
      "is-schema-migration-disabled": "boolean",
      "password": {
        "value": {
          "raw": "string"
        }
      },
      "security-groups": [
        "string", ...
      ],
      "user": "string"
    },
    "ydb-source": {
      "changefeed-custom-consumer-name": "string",
      "changefeed-custom-name": "string",
      "database": "string",
      "instance": "string",
      "paths": [
        "string", ...
      ],
      "sa-key-content": "string",
      "security-groups": [
        "string", ...
      ],
      "service-account-id": "string",
      "subnet-id": "string"
    },
    "ydb-target": {
      "cleanup-policy": "YDB_CLEANUP_POLICY_DISABLED|YDB_CLEANUP_POLICY_DROP",
      "database": "string",
      "default-compression": "YDB_DEFAULT_COMPRESSION_DISABLED|YDB_DEFAULT_COMPRESSION_LZ4",
      "instance": "string",
      "is-schema-migration-disabled": "boolean",
      "is-table-column-oriented": "boolean",
      "path": "string",
      "sa-key-content": "string",
      "security-groups": [
        "string", ...
      ],
      "service-account-id": "string",
      "subnet-id": "string"
    },
    "yds-source": {
      "allow-ttl-rewind": "boolean",
      "consumer": "string",
      "database": "string",
      "endpoint": "string",
      "parser": {
        "parser": {
          "audit-trails-v1-parser": {},
          "cloud-logging-parser": {},
          "json-parser": {
            "add-rest-column": "boolean",
            "data-schema": {
              "schema": {
                "fields": {
                  "fields": [
                    {
                      "key": "boolean",
                      "name": "string",
                      "path": "string",
                      "required": "boolean",
                      "type": "INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64"
                    }, ...
                  ]
                },
                "json-fields": "string"
              }
            },
            "null-keys-allowed": "boolean",
            "unescape-string-values": "boolean"
          },
          "tskv-parser": {
            "add-rest-column": "boolean",
            "data-schema": {
              "schema": {
                "fields": {
                  "fields": [
                    {
                      "key": "boolean",
                      "name": "string",
                      "path": "string",
                      "required": "boolean",
                      "type": "INT32|INT16|INT8|UINT64|UINT32|UINT16|UINT8|DOUBLE|BOOLEAN|STRING|UTF8|ANY|DATETIME|INT64"
                    }, ...
                  ]
                },
                "json-fields": "string"
              }
            },
            "null-keys-allowed": "boolean",
            "unescape-string-values": "boolean"
          }
        }
      },
      "security-groups": [
        "string", ...
      ],
      "service-account-id": "string",
      "stream": "string",
      "subnet-id": "string",
      "supported-codecs": [
        "YDS_COMPRESSION_CODEC_RAW|YDS_COMPRESSION_CODEC_GZIP|YDS_COMPRESSION_CODEC_ZSTD", ...
      ]
    },
    "yds-target": {
      "compression-codec": "YDS_COMPRESSION_CODEC_RAW|YDS_COMPRESSION_CODEC_GZIP|YDS_COMPRESSION_CODEC_ZSTD",
      "database": "string",
      "endpoint": "string",
      "save-tx-order": "boolean",
      "security-groups": [
        "string", ...
      ],
      "serializer": {
        "serializer": {
          "serializer-auto": {},
          "serializer-debezium": {
            "serializer-parameters": [
              {
                "key": "string",
                "value": "string"
              }, ...
            ]
          },
          "serializer-json": {}
        }
      },
      "service-account-id": "string",
      "stream": "string",
      "subnet-id": "string"
    }
  }
}
```

Fields:

```
settings -> (oneof<clickhouse-source|clickhouse-target|kafka-source|kafka-target|metrika-source|mongo-source|mongo-target|mysql-source|mysql-target|postgres-source|postgres-target|ydb-source|ydb-target|yds-source|yds-target>)
  Oneof settings field
  mysql-source -> (struct)
    connection -> (struct)
      Database connection settings
      connection -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
        Oneof connection field
        mdb-cluster-id -> (string)
          Managed Service for MySQL cluster ID
        on-premise -> (struct)
          Connection options for on-premise MySQL
          hosts -> ([]string)
            List of host names of the MySQL server. Exactly one host is expected
          port -> (integer)
            Port for the database connection
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
          tls-mode -> (struct)
            TLS settings for server connection. Disabled by default.
            tls-mode -> (oneof<disabled|enabled>)
              Oneof tls-mode field
              disabled -> (struct)
                Empty block designating that the connection is not secured, i.e. plaintext connection
              enabled -> (struct)
                TLS is used for the server connection
                ca-certificate -> (string)
                  CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
        connection-manager-connection -> (struct)
          Get Mysql installation params and credentials from Connection Manager
          connection-id -> (string)
            ID of connection in Connection Manager with installation params and credetials
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    database -> (string)
      Name of the database to transfer You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.
    exclude-tables-regex -> ([]string)
      Opposite of 'include_table_regex'. The tables matching the specified regular expressions will not be transferred
    include-tables-regex -> ([]string)
      List of regular expressions of table names which should be transferred. A table name is formatted as schemaname.tablename. For example, a single regular expression may look like '^mydb.employees$'
    object-transfer-settings -> (struct)
      Schema migration Defines which database schema objects should be transferred, e.g. views, routines, etc. All of the attrubutes in the block are optional and should be either 'BEFORE_DATA', 'AFTER_DATA' or 'NEVER'."
      routine -> (struct)
        Routines CREATE PROCEDURE ... ; CREATE FUNCTION ... ;
      tables -> (struct)
      trigger -> (struct)
        Triggers CREATE TRIGGER ...
      view -> (struct)
        Views CREATE VIEW ...
    password -> (struct)
      Password for database access.
      value -> (oneof<raw>)
        Oneof value field
        raw -> (string)
          Raw secret value
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    service-database -> (string)
      Database for service tables Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).
    timezone -> (string)
      Database timezone Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.
    user -> (string)
      User for database access. Required unless connection manager connection is used
  postgres-source -> (struct)
    connection -> (struct)
      Database connection settings
      connection -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
        Oneof connection field
        mdb-cluster-id -> (string)
          Managed Service for PostgreSQL cluster ID
        on-premise -> (struct)
          Connection options for on-premise PostgreSQL
          hosts -> ([]string)
            PG installation hosts
          port -> (integer)
            PG port. Will be used if the cluster ID is not specified.
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
          tls-mode -> (struct)
            TLS settings for server connection. Disabled by default.
            tls-mode -> (oneof<disabled|enabled>)
              Oneof tls-mode field
              disabled -> (struct)
                Empty block designating that the connection is not secured, i.e. plaintext connection
              enabled -> (struct)
                TLS is used for the server connection
                ca-certificate -> (string)
                  CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
        connection-manager-connection -> (struct)
          Get Postgres installation params and credentials from Connection Manager
          connection-id -> (string)
            ID of connection in Connection Manager with installation params and credetials
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    database -> (string)
      Name of the database to transfer
    exclude-tables -> ([]string)
      List of tables which will not be transfered, formatted as 'schemaname.tablename' If omitted or empty list is specified, all tables are replicated. Can contain schema_name.* patterns.
    include-tables -> ([]string)
      List of tables to transfer, formatted as 'schemaname.tablename'. If omitted or an empty list is specified, all tables will be transferred. Can contain schema_name.* patterns.
    object-transfer-settings -> (struct)
      Defines which database schema objects should be transferred, e.g. views, functions, etc. All of the attributes in this block are optional and should be either 'BEFORE_DATA', 'AFTER_DATA' or 'NEVER'
      cast -> (struct)
        Casts CREATE CAST ...
      collation -> (struct)
        Collations CREATE COLLATION ...
      constraint -> (struct)
        Constraints ALTER TABLE ... ADD CONSTRAINT ...
      default-values -> (struct)
        Default values ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...
      fk-constraint -> (struct)
        Foreign keys ALTER TABLE ... ADD FOREIGN KEY ...
      function -> (struct)
        Functions CREATE FUNCTION ...
      index -> (struct)
        Indexes CREATE INDEX ...
      materialized-view -> (struct)
        Materialized views CREATE MATERIALIZED VIEW ...
      policy -> (struct)
        Policies CREATE POLICY ...
      primary-key -> (struct)
        Primary keys ALTER TABLE ... ADD PRIMARY KEY ...
      rule -> (struct)
        Rules CREATE RULE ...
      sequence -> (struct)
        Sequences CREATE SEQUENCE ...
      sequence-owned-by -> (struct)
        Owned sequences CREATE SEQUENCE ... OWNED BY ...
      sequence-set -> (struct)
      table -> (struct)
        Tables CREATE TABLE ...
      trigger -> (struct)
        Triggers CREATE TRIGGER ...
      type -> (struct)
        Types CREATE TYPE ...
      view -> (struct)
        Views CREATE VIEW ...
    password -> (struct)
      Password for database access.
      value -> (oneof<raw>)
        Oneof value field
        raw -> (string)
          Raw secret value
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    service-schema -> (string)
      Name of the database schema in which auxiliary tables needed for the transfer will be created (__consumer_keeper, __data_transfer_mole_finder). Empty 'service_schema' implies schema 'public'
    slot-byte-lag-limit -> (integer)
      Maximum WAL size held by the replication slot (API - in bytes, terraform - in gigabytes); Exceeding this limit will result in a replication failure and deletion of the replication slot. Default is 50 gigabytes
    user -> (string)
      User for database access. Required unless Connection Manager connection is used.
  ydb-source -> (struct)
    changefeed-custom-consumer-name -> (string)
      Consumer for pre-created change feed if any
    changefeed-custom-name -> (string)
      Pre-created change feed if any
    database -> (string)
      Database path in YDB where tables are stored. Example: '/ru/transfer_manager/prod/data-transfer-yt'
    instance -> (string)
      Instance of YDB. example: ydb-ru-prestable.yandex.net:2135. If not specified, will be determined by database
    paths -> ([]string)
      A list of paths which should be uploaded. When not specified, all available tables are uploaded
    sa-key-content -> (string)
      Authorization Key
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    service-account-id -> (string)
      Service account ID for interaction with database
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
  yds-source -> (struct)
    allow-ttl-rewind -> (boolean)
      Should continue working, if consumer read lag exceed TTL of topic False: stop the transfer in error state, if detected lost data. True: continue working with losing part of data
    consumer -> (string)
      Custom consumer - for important streams
    database -> (string)
      Database path in YDB for streams Example: '/ru/transfer_manager/prod/data-transfer'
    endpoint -> (string)
      YDS Endpoint for dedicated db
    parser -> (struct)
      Data parsing rules
      parser -> (oneof<audit-trails-v1-parser|cloud-logging-parser|json-parser|tskv-parser>)
        Oneof parser field
        json-parser -> (struct)
          Parse data in json format
          add-rest-column -> (boolean)
            Will add _rest column for all unknown fields
          data-schema -> (struct)
            Data parsing scheme
            schema -> (oneof<fields|json-fields>)
              Oneof schema field
              json-fields -> (string)
                Description of the data schema as JSON specification
              fields -> (struct)
                Description of the data schema in the array of 'fields' structure
                fields -> ([]struct)
                  Description of the column schema in the array of 'fields' structure
                  key -> (boolean)
                    Mark field as Primary Key
                  name -> (string)
                    Field name
                  path -> (string)
                    Path to the field
                  required -> (boolean)
                    Mark field as required
                  type -> (struct)
                    Field type, one of: 'INT64', 'INT32', 'INT16', 'INT8', 'UINT64', 'UINT32', 'UINT16', 'UINT8', 'DOUBLE', 'BOOLEAN', 'STRING', 'UTF8', 'ANY', 'DATETIME'.
          null-keys-allowed -> (boolean)
            Allow null keys, if no - null keys will be putted to unparsed data
          unescape-string-values -> (boolean)
            Unescape string values
        audit-trails-v1-parser -> (struct)
          Parse Audit Trails data. Empty struct
        cloud-logging-parser -> (struct)
          Parse Cloud Logging data. Empty struct
        tskv-parser -> (struct)
          Parse data in tskv format
          add-rest-column -> (boolean)
            Will add _rest column for all unknown fields
          data-schema -> (struct)
            Data parsing scheme
            schema -> (oneof<fields|json-fields>)
              Oneof schema field
              json-fields -> (string)
                Description of the data schema as JSON specification
              fields -> (struct)
                Description of the data schema in the array of 'fields' structure
                fields -> ([]struct)
                  Description of the column schema in the array of 'fields' structure
                  key -> (boolean)
                    Mark field as Primary Key
                  name -> (string)
                    Field name
                  path -> (string)
                    Path to the field
                  required -> (boolean)
                    Mark field as required
                  type -> (struct)
                    Field type, one of: 'INT64', 'INT32', 'INT16', 'INT8', 'UINT64', 'UINT32', 'UINT16', 'UINT8', 'DOUBLE', 'BOOLEAN', 'STRING', 'UTF8', 'ANY', 'DATETIME'.
          null-keys-allowed -> (boolean)
            Allow null keys, if no - null keys will be putted to unparsed data
          unescape-string-values -> (boolean)
            Unescape string values
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    service-account-id -> (string)
      Service account ID which has read access to the stream.
    stream -> (string)
      Stream to read
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    supported-codecs -> ([]struct)
      List of supported compression codecs Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD, YDS_COMPRESSION_CODEC_GZIP
  kafka-source -> (struct)
    auth -> (struct)
      Authentication settings
      security -> (oneof<no-auth|sasl>)
        Oneof security field
        sasl -> (struct)
          Authentication with SASL
          mechanism -> (struct)
            SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256, KAFKA_MECHANISM_SHA512
          password -> (struct)
            Password for user
            value -> (oneof<raw>)
              Oneof value field
              raw -> (string)
                Raw secret value
          user -> (string)
            User name
        no-auth -> (struct)
          No authentication
    connection -> (struct)
      Connection settings
      connection -> (oneof<cluster-id|connection-manager-connection|on-premise>)
        Oneof connection field
        cluster-id -> (string)
          Managed Service for Kafka cluster ID. Set only one of: cluster_id/on_premise/connection_manager_connection
        on-premise -> (struct)
          Connection options for on-premise Kafka Set only one of: cluster_id/on_premise/connection_manager_connection
          broker-urls -> ([]string)
            Kafka broker URLs
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
          tls-mode -> (struct)
            TLS settings for broker connection. Disabled by default.
            tls-mode -> (oneof<disabled|enabled>)
              Oneof tls-mode field
              disabled -> (struct)
                Empty block designating that the connection is not secured, i.e. plaintext connection
              enabled -> (struct)
                TLS is used for the server connection
                ca-certificate -> (string)
                  CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
        connection-manager-connection -> (struct)
          Get Kafka installation params and credentials from Connection Manager Set only one of: cluster_id/on_premise/connection_manager_connection
          connection-id -> (string)
            ID of connection in Connection Manager with installation params and credetials
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    parser -> (struct)
      Data parsing parameters. If not set, the source messages are read in raw
      parser -> (oneof<audit-trails-v1-parser|cloud-logging-parser|json-parser|tskv-parser>)
        Oneof parser field
        json-parser -> (struct)
          Parse data in json format
          add-rest-column -> (boolean)
            Will add _rest column for all unknown fields
          data-schema -> (struct)
            Data parsing scheme
            schema -> (oneof<fields|json-fields>)
              Oneof schema field
              json-fields -> (string)
                Description of the data schema as JSON specification
              fields -> (struct)
                Description of the data schema in the array of 'fields' structure
                fields -> ([]struct)
                  Description of the column schema in the array of 'fields' structure
                  key -> (boolean)
                    Mark field as Primary Key
                  name -> (string)
                    Field name
                  path -> (string)
                    Path to the field
                  required -> (boolean)
                    Mark field as required
                  type -> (struct)
                    Field type, one of: 'INT64', 'INT32', 'INT16', 'INT8', 'UINT64', 'UINT32', 'UINT16', 'UINT8', 'DOUBLE', 'BOOLEAN', 'STRING', 'UTF8', 'ANY', 'DATETIME'.
          null-keys-allowed -> (boolean)
            Allow null keys, if no - null keys will be putted to unparsed data
          unescape-string-values -> (boolean)
            Unescape string values
        audit-trails-v1-parser -> (struct)
          Parse Audit Trails data. Empty struct
        cloud-logging-parser -> (struct)
          Parse Cloud Logging data. Empty struct
        tskv-parser -> (struct)
          Parse data in tskv format
          add-rest-column -> (boolean)
            Will add _rest column for all unknown fields
          data-schema -> (struct)
            Data parsing scheme
            schema -> (oneof<fields|json-fields>)
              Oneof schema field
              json-fields -> (string)
                Description of the data schema as JSON specification
              fields -> (struct)
                Description of the data schema in the array of 'fields' structure
                fields -> ([]struct)
                  Description of the column schema in the array of 'fields' structure
                  key -> (boolean)
                    Mark field as Primary Key
                  name -> (string)
                    Field name
                  path -> (string)
                    Path to the field
                  required -> (boolean)
                    Mark field as required
                  type -> (struct)
                    Field type, one of: 'INT64', 'INT32', 'INT16', 'INT8', 'UINT64', 'UINT32', 'UINT16', 'UINT8', 'DOUBLE', 'BOOLEAN', 'STRING', 'UTF8', 'ANY', 'DATETIME'.
          null-keys-allowed -> (boolean)
            Allow null keys, if no - null keys will be putted to unparsed data
          unescape-string-values -> (boolean)
            Unescape string values
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    topic-name -> (string)
      **Deprecated**. Please use 'topic_names' instead Full source topic name
    topic-names -> ([]string)
      List of full source topic names to read
    transformer -> (struct)
      Transform data with a custom Cloud Function
      buffer-flush-interval -> (string)
        Flush interval
      buffer-size -> (string)
        Buffer size for function. Maximum 4 GB. Use value with units, i.e. 10 B, 20 kB, 2.0 MB, 30 MB, 1.0 GB
      cloud-function -> (string)
        Cloud function
      invocation-timeout -> (string)
        Invocation timeout
      number-of-retries -> (integer)
        Number of retries
      service-account-id -> (string)
        Service account
  mongo-source -> (struct)
    collections -> ([]struct)
      List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name.
      collection-name -> (string)
      database-name -> (string)
    connection -> (struct)
      Connection settings
      connection -> (oneof<connection-options>)
        Oneof connection field
        connection-options -> (struct)
          auth-source -> (string)
            Database name associated with the credentials
          password -> (struct)
            Password for user
            value -> (oneof<raw>)
              Oneof value field
              raw -> (string)
                Raw secret value
          user -> (string)
            User name, required unless connection_manager_connection is used
          address -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
            Oneof address field
            mdb-cluster-id -> (string)
              Identifier of the Yandex StoreDoc cluster Use one of: mdb_cluster_id/on_premise/connection_manager_connection
            on-premise -> (struct)
              Connection settings of the on-premise MongoDB server Use one of: mdb_cluster_id/on_premise/connection_manager_connection
              hosts -> ([]string)
                Host names of the replica set
              port -> (integer)
                TCP Port number
              replica-set -> (string)
                Replica set name
              tls-mode -> (struct)
                TLS settings for the server connection. Empty implies plaintext connection
                tls-mode -> (oneof<disabled|enabled>)
                  Oneof tls-mode field
                  disabled -> (struct)
                    Empty block designating that the connection is not secured, i.e. plaintext connection
                  enabled -> (struct)
                    TLS is used for the server connection
                    ca-certificate -> (string)
                      CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
            connection-manager-connection -> (struct)
              Get StoreDoc/MongoDB installation params and credentials from Connection Manager Use one of: mdb_cluster_id/on_premise/connection_manager_connection
              connection-id -> (string)
                ID of connectionmanager connection with mongodb/Yandex Storedoc installation parameters and credentials
              replica-set -> (string)
                Replica set name, used only for on-premise mongodb installations
    excluded-collections -> ([]struct)
      List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema.
      collection-name -> (string)
      database-name -> (string)
    secondary-preferred-mode -> (boolean)
      Read mode for mongo client: whether the secondary server should be preferred to the primary when copying data
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
  clickhouse-source -> (struct)
    clickhouse-cluster-name -> (string)
      Name of the ClickHouse cluster. For Managed ClickHouse that is name of ShardGroup or managed cluster ID by default
    connection -> (struct)
      Connection settings
      connection -> (oneof<connection-options>)
        Oneof connection field
        connection-options -> (struct)
          database -> (string)
            Database name
          password -> (struct)
            Password for the database access
            value -> (oneof<raw>)
              Oneof value field
              raw -> (string)
                Raw secret value
          user -> (string)
            User for database access. Required unless connection_manager_connection is used
          address -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
            Oneof address field
            on-premise -> (struct)
              Connection settings of the on-premise ClickHouse server
              http-port -> (integer)
              native-port -> (integer)
              shards -> ([]struct)
                hosts -> ([]string)
                name -> (string)
              tls-mode -> (struct)
                TLS settings for server connection. Disabled by default
                tls-mode -> (oneof<disabled|enabled>)
                  Oneof tls-mode field
                  disabled -> (struct)
                    Empty block designating that the connection is not secured, i.e. plaintext connection
                  enabled -> (struct)
                    TLS is used for the server connection
                    ca-certificate -> (string)
                      CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
            connection-manager-connection -> (struct)
              Get ClickHouse installation params and credentials from Connection Manager
              connection-id -> (string)
                ID of connection in Connection Manager with installation params and credetials
              subnet-id -> (string)
                Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
            mdb-cluster-id -> (string)
              Identifier of the Managed ClickHouse cluster
    exclude-tables -> ([]string)
      Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.
    include-tables -> ([]string)
      White list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
  mysql-target -> (struct)
    cleanup-policy -> (struct)
      Cleanup policy for activate, reactivate and reupload processes. One of 'DISABLED', 'DROP' or 'TRUNCATE' Default is 'DISABLED'.
    connection -> (struct)
      Database connection settings
      connection -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
        Oneof connection field
        mdb-cluster-id -> (string)
          Managed Service for MySQL cluster ID
        on-premise -> (struct)
          Connection options for on-premise MySQL
          hosts -> ([]string)
            List of host names of the MySQL server. Exactly one host is expected
          port -> (integer)
            Port for the database connection
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
          tls-mode -> (struct)
            TLS settings for server connection. Disabled by default.
            tls-mode -> (oneof<disabled|enabled>)
              Oneof tls-mode field
              disabled -> (struct)
                Empty block designating that the connection is not secured, i.e. plaintext connection
              enabled -> (struct)
                TLS is used for the server connection
                ca-certificate -> (string)
                  CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
        connection-manager-connection -> (struct)
          Get Mysql installation params and credentials from Connection Manager
          connection-id -> (string)
            ID of connection in Connection Manager with installation params and credetials
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    database -> (string)
      Database name Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.
    is-schema-migration-disabled -> (boolean)
      Whether can change table schema if schema changed on source
    password -> (struct)
      Password for database access.
      value -> (oneof<raw>)
        Oneof value field
        raw -> (string)
          Raw secret value
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    service-database -> (string)
      Database schema for service table Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).
    skip-constraint-checks -> (boolean)
      Disable constraints checks When 'true', disables foreign key checks and unique checks. 'False' by default. See foreign_key_checks. Recommend to disable for increase replication speed unless schema contains cascading operations
    sql-mode -> (string)
      sql_mode to use when interacting with the server. Defaults to 'NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION'
    timezone -> (string)
      Database timezone Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.
    user -> (string)
      User for database access. Required unless connection manager connection is used
  postgres-target -> (struct)
    cleanup-policy -> (struct)
      Cleanup policy for activate, reactivate and reupload processes. One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE
    connection -> (struct)
      Database connection settings
      connection -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
        Oneof connection field
        mdb-cluster-id -> (string)
          Managed Service for PostgreSQL cluster ID
        on-premise -> (struct)
          Connection options for on-premise PostgreSQL
          hosts -> ([]string)
            PG installation hosts
          port -> (integer)
            PG port. Will be used if the cluster ID is not specified.
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
          tls-mode -> (struct)
            TLS settings for server connection. Disabled by default.
            tls-mode -> (oneof<disabled|enabled>)
              Oneof tls-mode field
              disabled -> (struct)
                Empty block designating that the connection is not secured, i.e. plaintext connection
              enabled -> (struct)
                TLS is used for the server connection
                ca-certificate -> (string)
                  CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
        connection-manager-connection -> (struct)
          Get Postgres installation params and credentials from Connection Manager
          connection-id -> (string)
            ID of connection in Connection Manager with installation params and credetials
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    database -> (string)
      Target database name
    is-schema-migration-disabled -> (boolean)
      Whether can change table schema if schema changed on source
    password -> (struct)
      Password for database access.
      value -> (oneof<raw>)
        Oneof value field
        raw -> (string)
          Raw secret value
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    user -> (string)
      User for database access. Required unless Connection Manager connection is used
  clickhouse-target -> (struct)
    alt-names -> ([]struct)
      Table renaming rules in target
      from-name -> (string)
        Source table name
      to-name -> (string)
        Target table name
    cleanup-policy -> (struct)
      How to clean collections when activating the transfer. One of 'CLICKHOUSE_CLEANUP_POLICY_DISABLED' or 'CLICKHOUSE_CLEANUP_POLICY_DROP'
    clickhouse-cluster-name -> (string)
      Name of the ClickHouse cluster. For Managed ClickHouse that is name of ShardGroup or managed cluster ID by default.
    connection -> (struct)
      Connection settings
      connection -> (oneof<connection-options>)
        Oneof connection field
        connection-options -> (struct)
          database -> (string)
            Database name
          password -> (struct)
            Password for the database access
            value -> (oneof<raw>)
              Oneof value field
              raw -> (string)
                Raw secret value
          user -> (string)
            User for database access. Required unless connection_manager_connection is used
          address -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
            Oneof address field
            on-premise -> (struct)
              Connection settings of the on-premise ClickHouse server
              http-port -> (integer)
              native-port -> (integer)
              shards -> ([]struct)
                hosts -> ([]string)
                name -> (string)
              tls-mode -> (struct)
                TLS settings for server connection. Disabled by default
                tls-mode -> (oneof<disabled|enabled>)
                  Oneof tls-mode field
                  disabled -> (struct)
                    Empty block designating that the connection is not secured, i.e. plaintext connection
                  enabled -> (struct)
                    TLS is used for the server connection
                    ca-certificate -> (string)
                      CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
            connection-manager-connection -> (struct)
              Get ClickHouse installation params and credentials from Connection Manager
              connection-id -> (string)
                ID of connection in Connection Manager with installation params and credetials
              subnet-id -> (string)
                Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
            mdb-cluster-id -> (string)
              Identifier of the Managed ClickHouse cluster
    is-schema-migration-disabled -> (boolean)
      Whether can change table schema if schema changed on source
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    sharding -> (struct)
      Shard selection rules for the data being transferred
      sharding -> (oneof<column-value-hash|custom-mapping|round-robin|transfer-id>)
        Oneof sharding field
        column-value-hash -> (struct)
          Shard data by the hash value of the specified column
          column-name -> (string)
            The name of the column to calculate hash from
        custom-mapping -> (struct)
          A custom shard mapping by the value of the specified column
          column-name -> (string)
            The name of the column to inspect when deciding the shard to chose for an incoming row
          mapping -> ([]struct)
            The mapping of the specified column values to the shard names
            column-value -> (struct)
              The value of the column. Currently only the string columns are supported
              value -> (oneof<string-value>)
                Oneof value field
                string-value -> (string)
            shard-name -> (string)
              The name of the shard into which all the rows with the specified 'column_value' will be written
        transfer-id -> (struct)
          Shard data by ID of the transfer
        round-robin -> (struct)
          Distribute incoming rows between ClickHouse shards in a round-robin manner. Specify as an empty block to enable
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
  ydb-target -> (struct)
    cleanup-policy -> (struct)
      Cleanup policy determine how to clean collections when activating the transfer. One of 'YDB_CLEANUP_POLICY_DISABLED' or 'YDB_CLEANUP_POLICY_DROP'
    database -> (string)
      Database path in YDB where tables are stored. Example: '/ru/transfer_manager/prod/data-transfer'
    default-compression -> (struct)
      Compression that will be used for default columns family on YDB table creation. One of 'YDB_DEFAULT_COMPRESSION_UNSPECIFIED', 'YDB_DEFAULT_COMPRESSION_DISABLED', 'YDB_DEFAULT_COMPRESSION_LZ4'
    instance -> (string)
      Instance of YDB. example: ydb-ru-prestable.yandex.net:2135. If not specified, will be determined by database
    is-schema-migration-disabled -> (boolean)
      Whether can change table schema if schema changed on source
    is-table-column-oriented -> (boolean)
      Whether a column-oriented (i.e. OLAP) tables should be created. Default is 'false' (create row-oriented OLTP tables)
    path -> (string)
      Path extension for database, each table will be layouted into this path
    sa-key-content -> (string)
      Authentication key
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    service-account-id -> (string)
      Service account ID for interaction with database
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
  kafka-target -> (struct)
    auth -> (struct)
      Authentication settings
      security -> (oneof<no-auth|sasl>)
        Oneof security field
        sasl -> (struct)
          Authentication with SASL
          mechanism -> (struct)
            SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256, KAFKA_MECHANISM_SHA512
          password -> (struct)
            Password for user
            value -> (oneof<raw>)
              Oneof value field
              raw -> (string)
                Raw secret value
          user -> (string)
            User name
        no-auth -> (struct)
          No authentication
    connection -> (struct)
      Connection settings
      connection -> (oneof<cluster-id|connection-manager-connection|on-premise>)
        Oneof connection field
        cluster-id -> (string)
          Managed Service for Kafka cluster ID. Set only one of: cluster_id/on_premise/connection_manager_connection
        on-premise -> (struct)
          Connection options for on-premise Kafka Set only one of: cluster_id/on_premise/connection_manager_connection
          broker-urls -> ([]string)
            Kafka broker URLs
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
          tls-mode -> (struct)
            TLS settings for broker connection. Disabled by default.
            tls-mode -> (oneof<disabled|enabled>)
              Oneof tls-mode field
              disabled -> (struct)
                Empty block designating that the connection is not secured, i.e. plaintext connection
              enabled -> (struct)
                TLS is used for the server connection
                ca-certificate -> (string)
                  CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
        connection-manager-connection -> (struct)
          Get Kafka installation params and credentials from Connection Manager Set only one of: cluster_id/on_premise/connection_manager_connection
          connection-id -> (string)
            ID of connection in Connection Manager with installation params and credetials
          subnet-id -> (string)
            Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    serializer -> (struct)
      Data serialization format settings
      serializer -> (oneof<serializer-auto|serializer-debezium|serializer-json>)
        Oneof serializer field
        serializer-auto -> (struct)
          Empty block. Select the serialization format automatically
        serializer-json -> (struct)
          Empty block. Serialize data in json format
        serializer-debezium -> (struct)
          Serialize data in debezium json format
          serializer-parameters -> ([]struct)
            A list of Debezium parameters set by the structure of the 'key' and 'value' string fields
            key -> (string)
              Name of the serializer parameter
            value -> (string)
              Value of the serializer parameter
    topic-settings -> (struct)
      Target topic settings
      topic-settings -> (oneof<topic|topic-prefix>)
        Oneof topic-settings field
        topic -> (struct)
          All messages will be sent to one topic
          save-tx-order -> (boolean)
            Save transactions order Not to split events queue into separate per-table queues.
          topic-name -> (string)
            Full topic name
        topic-prefix -> (string)
          Topic prefix Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>. Analogue of the Debezium setting database.server.name.
  mongo-target -> (struct)
    cleanup-policy -> (struct)
      How to clean collections when activating the transfer. One of 'DISABLED', 'DROP' or 'TRUNCATE'
    connection -> (struct)
      Connection settings
      connection -> (oneof<connection-options>)
        Oneof connection field
        connection-options -> (struct)
          auth-source -> (string)
            Database name associated with the credentials
          password -> (struct)
            Password for user
            value -> (oneof<raw>)
              Oneof value field
              raw -> (string)
                Raw secret value
          user -> (string)
            User name, required unless connection_manager_connection is used
          address -> (oneof<connection-manager-connection|mdb-cluster-id|on-premise>)
            Oneof address field
            mdb-cluster-id -> (string)
              Identifier of the Yandex StoreDoc cluster Use one of: mdb_cluster_id/on_premise/connection_manager_connection
            on-premise -> (struct)
              Connection settings of the on-premise MongoDB server Use one of: mdb_cluster_id/on_premise/connection_manager_connection
              hosts -> ([]string)
                Host names of the replica set
              port -> (integer)
                TCP Port number
              replica-set -> (string)
                Replica set name
              tls-mode -> (struct)
                TLS settings for the server connection. Empty implies plaintext connection
                tls-mode -> (oneof<disabled|enabled>)
                  Oneof tls-mode field
                  disabled -> (struct)
                    Empty block designating that the connection is not secured, i.e. plaintext connection
                  enabled -> (struct)
                    TLS is used for the server connection
                    ca-certificate -> (string)
                      CA certificate X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified, TLS is used to connect to the server. If CA certificate is empty, the server's certificate must be signed by a well-known CA
            connection-manager-connection -> (struct)
              Get StoreDoc/MongoDB installation params and credentials from Connection Manager Use one of: mdb_cluster_id/on_premise/connection_manager_connection
              connection-id -> (string)
                ID of connectionmanager connection with mongodb/Yandex Storedoc installation parameters and credentials
              replica-set -> (string)
                Replica set name, used only for on-premise mongodb installations
    database -> (string)
      Database name. If not empty, then all the data will be written to the database with the specified name; otherwise the database name is the same as in the source endpoint
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
  metrika-source -> (struct)
    counter-ids -> ([]integer)
      Counter IDs
    streams -> ([]struct)
      Streams
      columns -> ([]string)
        Column names
      type -> (struct)
        Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS, METRIKA_STREAM_TYPE_HITS_V2
    token -> (struct)
      Authentication token
      value -> (oneof<raw>)
        Oneof value field
        raw -> (string)
          Raw secret value
  yds-target -> (struct)
    compression-codec -> (struct)
      Codec to use for output data compression. If not specified, no compression will be done Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD, YDS_COMPRESSION_CODEC_GZIP
    database -> (string)
      Database path in YDB for streams Example: '/ru/transfer_manager/prod/data-transfer'
    endpoint -> (string)
      YDS Endpoint for dedicated db
    save-tx-order -> (boolean)
      Save transaction order Not to split events queue into separate per-table queues. Incompatible with setting Topic prefix, only with Topic full name.
    security-groups -> ([]string)
      List of security groups that the transfer associated with this endpoint should use
    serializer -> (struct)
      Data serialization format
      serializer -> (oneof<serializer-auto|serializer-debezium|serializer-json>)
        Oneof serializer field
        serializer-auto -> (struct)
          Empty block. Select the serialization format automatically
        serializer-json -> (struct)
          Empty block. Serialize data in json format
        serializer-debezium -> (struct)
          Serialize data in debezium json format
          serializer-parameters -> ([]struct)
            A list of Debezium parameters set by the structure of the 'key' and 'value' string fields
            key -> (string)
              Name of the serializer parameter
            value -> (string)
              Value of the serializer parameter
    service-account-id -> (string)
      Service account ID which has read access to the stream
    stream -> (string)
      Stream to write to
    subnet-id -> (string)
      Identifier of the Yandex Cloud VPC subnetwork to user for accessing the database. If omitted, the server has to be accessible via Internet
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#