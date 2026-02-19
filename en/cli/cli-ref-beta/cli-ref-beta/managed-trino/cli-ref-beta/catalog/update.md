---
editable: false
noIndex: true
---

# yc beta managed-trino catalog update

Updates the specified Trino Catalog.

#### Command Usage

Syntax:

`yc beta managed-trino catalog update <CATALOG-ID>`

#### Flags

#|
||Flag | Description ||
|| `--catalog` | `shorthand/json`

New values for the specified fields.

Shorthand Syntax:

```hcl
{
  connector = {
    type = clickhouse={
      additional-properties = {key=string, key=...},
      connection = {
        type = connection-manager={
          connection-id = string,
          connection-properties = {key=string, key=...},
          database = string
        } | on-premise={
          connection-url = string,
          password = string,
          user-name = string
        }
      }
    } | delta-lake={
      additional-properties = {key=string, key=...},
      filesystem = {
        type = external-s3={
          aws-access-key = string,
          aws-endpoint = string,
          aws-region = string,
          aws-secret-key = string
        } | s3={}
      },
      metastore = {
        type = hive={
          connection = uri=string
        }
      }
    } | greenplum={
      additional-properties = {key=string, key=...},
      connection = {
        type = connection-manager={
          connection-id = string,
          connection-properties = {key=string, key=...},
          database = string
        } | on-premise={
          connection-url = string,
          password = string,
          user-name = string
        }
      }
    } | hive={
      additional-properties = {key=string, key=...},
      filesystem = {
        type = external-s3={
          aws-access-key = string,
          aws-endpoint = string,
          aws-region = string,
          aws-secret-key = string
        } | s3={}
      },
      metastore = {
        type = hive={
          connection = uri=string
        }
      }
    } | hudi={
      additional-properties = {key=string, key=...},
      filesystem = {
        type = external-s3={
          aws-access-key = string,
          aws-endpoint = string,
          aws-region = string,
          aws-secret-key = string
        } | s3={}
      },
      metastore = {
        type = hive={
          connection = uri=string
        }
      }
    } | iceberg={
      additional-properties = {key=string, key=...},
      filesystem = {
        type = external-s3={
          aws-access-key = string,
          aws-endpoint = string,
          aws-region = string,
          aws-secret-key = string
        } | s3={}
      },
      metastore = {
        type = hive={
          connection = uri=string
        }
      }
    } | mysql={
      additional-properties = {key=string, key=...},
      connection = {
        type = connection-manager={
          connection-id = string,
          connection-properties = {key=string, key=...}
        } | on-premise={
          connection-url = string,
          password = string,
          user-name = string
        }
      }
    } | oracle={
      additional-properties = {key=string, key=...},
      connection = {
        type = on-premise={
          connection-url = string,
          password = string,
          user-name = string
        }
      }
    } | postgresql={
      additional-properties = {key=string, key=...},
      connection = {
        type = connection-manager={
          connection-id = string,
          connection-properties = {key=string, key=...},
          database = string
        } | on-premise={
          connection-url = string,
          password = string,
          user-name = string
        }
      }
    } | sqlserver={
      additional-properties = {key=string, key=...},
      connection = {
        type = on-premise={
          connection-url = string,
          password = string,
          user-name = string
        }
      }
    } | tpcds={
      additional-properties = {key=string, key=...}
    } | tpch={
      additional-properties = {key=string, key=...}
    }
  },
  description = string,
  labels = {key=string, key=...},
  name = string
}
```

JSON Syntax:

```json
{
  "connector": {
    "type": {
      "clickhouse": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "connection": {
          "type": {
            "connection-manager": {
              "connection-id": "string",
              "connection-properties": {
                "<key>": "string", ...
              },
              "database": "string"
            },
            "on-premise": {
              "connection-url": "string",
              "password": "string",
              "user-name": "string"
            }
          }
        }
      },
      "delta-lake": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "filesystem": {
          "type": {
            "external-s3": {
              "aws-access-key": "string",
              "aws-endpoint": "string",
              "aws-region": "string",
              "aws-secret-key": "string"
            },
            "s3": {}
          }
        },
        "metastore": {
          "type": {
            "hive": {
              "connection": {
                "uri": "string"
              }
            }
          }
        }
      },
      "greenplum": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "connection": {
          "type": {
            "connection-manager": {
              "connection-id": "string",
              "connection-properties": {
                "<key>": "string", ...
              },
              "database": "string"
            },
            "on-premise": {
              "connection-url": "string",
              "password": "string",
              "user-name": "string"
            }
          }
        }
      },
      "hive": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "filesystem": {
          "type": {
            "external-s3": {
              "aws-access-key": "string",
              "aws-endpoint": "string",
              "aws-region": "string",
              "aws-secret-key": "string"
            },
            "s3": {}
          }
        },
        "metastore": {
          "type": {
            "hive": {
              "connection": {
                "uri": "string"
              }
            }
          }
        }
      },
      "hudi": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "filesystem": {
          "type": {
            "external-s3": {
              "aws-access-key": "string",
              "aws-endpoint": "string",
              "aws-region": "string",
              "aws-secret-key": "string"
            },
            "s3": {}
          }
        },
        "metastore": {
          "type": {
            "hive": {
              "connection": {
                "uri": "string"
              }
            }
          }
        }
      },
      "iceberg": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "filesystem": {
          "type": {
            "external-s3": {
              "aws-access-key": "string",
              "aws-endpoint": "string",
              "aws-region": "string",
              "aws-secret-key": "string"
            },
            "s3": {}
          }
        },
        "metastore": {
          "type": {
            "hive": {
              "connection": {
                "uri": "string"
              }
            }
          }
        }
      },
      "mysql": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "connection": {
          "type": {
            "connection-manager": {
              "connection-id": "string",
              "connection-properties": {
                "<key>": "string", ...
              }
            },
            "on-premise": {
              "connection-url": "string",
              "password": "string",
              "user-name": "string"
            }
          }
        }
      },
      "oracle": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "connection": {
          "type": {
            "on-premise": {
              "connection-url": "string",
              "password": "string",
              "user-name": "string"
            }
          }
        }
      },
      "postgresql": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "connection": {
          "type": {
            "connection-manager": {
              "connection-id": "string",
              "connection-properties": {
                "<key>": "string", ...
              },
              "database": "string"
            },
            "on-premise": {
              "connection-url": "string",
              "password": "string",
              "user-name": "string"
            }
          }
        }
      },
      "sqlserver": {
        "additional-properties": {
          "<key>": "string", ...
        },
        "connection": {
          "type": {
            "on-premise": {
              "connection-url": "string",
              "password": "string",
              "user-name": "string"
            }
          }
        }
      },
      "tpcds": {
        "additional-properties": {
          "<key>": "string", ...
        }
      },
      "tpch": {
        "additional-properties": {
          "<key>": "string", ...
        }
      }
    }
  },
  "description": "string",
  "labels": {
    "<key>": "string", ...
  },
  "name": "string"
}
```

Fields:

```
connector -> (struct)
  Updated connector configuration. If specified, replaces the existing connector.
  type -> (oneof<clickhouse|delta-lake|greenplum|hive|hudi|iceberg|mysql|oracle|postgresql|sqlserver|tpcds|tpch>)
    Oneof type field
    hive -> (struct)
      Hive connector configuration.
      additional-properties -> (map[string,string])
        Additional properties.
      filesystem -> (struct)
        File system configuration.
        type -> (oneof<external-s3|s3>)
          Oneof type field
          s3 -> (struct)
            Yandex Cloud S3 filesystem.
          external-s3 -> (struct)
            External S3 filesystem.
            aws-access-key -> (string)
              AWS access key.
            aws-endpoint -> (string)
              AWS endpoint.
            aws-region -> (string)
              AWS region.
            aws-secret-key -> (string)
              AWS secret key.
      metastore -> (struct)
        Metastore configuration.
        type -> (oneof<hive>)
          Oneof type field
          hive -> (struct)
            Apache Hive Metastore.
            connection -> (oneof<uri>)
              Oneof connection field
              uri -> (string)
                URI or cluster ID of the Hive Metastore.
    iceberg -> (struct)
      Iceberg connector configuration.
      additional-properties -> (map[string,string])
        Additional properties.
      filesystem -> (struct)
        File system configuration.
        type -> (oneof<external-s3|s3>)
          Oneof type field
          s3 -> (struct)
            Yandex Cloud S3 filesystem.
          external-s3 -> (struct)
            External S3 filesystem.
            aws-access-key -> (string)
              AWS access key.
            aws-endpoint -> (string)
              AWS endpoint.
            aws-region -> (string)
              AWS region.
            aws-secret-key -> (string)
              AWS secret key.
      metastore -> (struct)
        Metastore configuration.
        type -> (oneof<hive>)
          Oneof type field
          hive -> (struct)
            Apache Hive Metastore.
            connection -> (oneof<uri>)
              Oneof connection field
              uri -> (string)
                URI or cluster ID of the Hive Metastore.
    delta-lake -> (struct)
      Delta Lake connector configuration.
      additional-properties -> (map[string,string])
        Additional properties.
      filesystem -> (struct)
        File system configuration.
        type -> (oneof<external-s3|s3>)
          Oneof type field
          s3 -> (struct)
            Yandex Cloud S3 filesystem.
          external-s3 -> (struct)
            External S3 filesystem.
            aws-access-key -> (string)
              AWS access key.
            aws-endpoint -> (string)
              AWS endpoint.
            aws-region -> (string)
              AWS region.
            aws-secret-key -> (string)
              AWS secret key.
      metastore -> (struct)
        Metastore configuration.
        type -> (oneof<hive>)
          Oneof type field
          hive -> (struct)
            Apache Hive Metastore.
            connection -> (oneof<uri>)
              Oneof connection field
              uri -> (string)
                URI or cluster ID of the Hive Metastore.
    postgresql -> (struct)
      PostgreSQL connector configuration.
      additional-properties -> (map[string,string])
        Additional properties.
      connection -> (struct)
        Connection configuration.
        type -> (oneof<connection-manager|on-premise>)
          Oneof type field
          on-premise -> (struct)
            Connection configured manually.
            connection-url -> (string)
              Connection to the Postgresql.
            password -> (string)
              Password of the Postgresql user.
            user-name -> (string)
              Name of the Postgresql user.
          connection-manager -> (struct)
            Connection configured using Yandex Cloud Connection Manager.
            connection-id -> (string)
              Connection ID.
            connection-properties -> (map[string,string])
              Additional connection properties.
            database -> (string)
              Database.
    clickhouse -> (struct)
      ClickHouse connector configuration.
      additional-properties -> (map[string,string])
        Additional properties.
      connection -> (struct)
        Connection configuration.
        type -> (oneof<connection-manager|on-premise>)
          Oneof type field
          on-premise -> (struct)
            Connection configured manually.
            connection-url -> (string)
              Connection to the Clickhouse.
            password -> (string)
              Password of the Clickhouse user.
            user-name -> (string)
              Name of the Clickhouse user.
          connection-manager -> (struct)
            Connection configured using Yandex Cloud Connection Manager.
            connection-id -> (string)
              Connection ID.
            connection-properties -> (map[string,string])
              Additional connection properties.
            database -> (string)
              Database.
    tpch -> (struct)
      TPC-H connector for synthetic benchmarking.
      additional-properties -> (map[string,string])
        Additional properties.
    tpcds -> (struct)
      TPC-DS connector for synthetic benchmarking.
      additional-properties -> (map[string,string])
        Additional properties.
    oracle -> (struct)
      Oracle connector configuration for connecting to Oracle Database instances.
      additional-properties -> (map[string,string])
        Additional properties.
      connection -> (struct)
        Connection configuration.
        type -> (oneof<on-premise>)
          Oneof type field
          on-premise -> (struct)
            Connection configured manually.
            connection-url -> (string)
              Connection to the Oracle.
            password -> (string)
              Password of the Oracle user.
            user-name -> (string)
              Name of the Oracle user.
    sqlserver -> (struct)
      SQLServer connector configuration for connecting to SQLServer Database instances.
      additional-properties -> (map[string,string])
        Additional properties.
      connection -> (struct)
        Connection configuration.
        type -> (oneof<on-premise>)
          Oneof type field
          on-premise -> (struct)
            Connection configured manually.
            connection-url -> (string)
              Connection to the SQLServer.
            password -> (string)
              Password of the SQLServer user.
            user-name -> (string)
              Name of the SQLServer user.
    hudi -> (struct)
      Hudi connector configuration.
      additional-properties -> (map[string,string])
        Additional properties.
      filesystem -> (struct)
        File system configuration.
        type -> (oneof<external-s3|s3>)
          Oneof type field
          s3 -> (struct)
            Yandex Cloud S3 filesystem.
          external-s3 -> (struct)
            External S3 filesystem.
            aws-access-key -> (string)
              AWS access key.
            aws-endpoint -> (string)
              AWS endpoint.
            aws-region -> (string)
              AWS region.
            aws-secret-key -> (string)
              AWS secret key.
      metastore -> (struct)
        Metastore configuration.
        type -> (oneof<hive>)
          Oneof type field
          hive -> (struct)
            Apache Hive Metastore.
            connection -> (oneof<uri>)
              Oneof connection field
              uri -> (string)
                URI or cluster ID of the Hive Metastore.
    mysql -> (struct)
      MySQL connector configuration for connecting to MySQL Database instances.
      additional-properties -> (map[string,string])
        Additional properties.
      connection -> (struct)
        Connection configuration.
        type -> (oneof<connection-manager|on-premise>)
          Oneof type field
          on-premise -> (struct)
            Connection configured manually.
            connection-url -> (string)
              Connection to the MySQL.
            password -> (string)
              Password of the MySQL user.
            user-name -> (string)
              Name of the MySQL user.
          connection-manager -> (struct)
            Connection configured using Yandex Cloud Connection Manager.
            connection-id -> (string)
              Connection ID.
            connection-properties -> (map[string,string])
              Additional connection properties.
    greenplum -> (struct)
      Greenplum connector configuration for connecting to Greenplum or Cloudberry Database instances.
      additional-properties -> (map[string,string])
        Additional properties.
      connection -> (struct)
        Connection configuration
        type -> (oneof<connection-manager|on-premise>)
          Oneof type field
          on-premise -> (struct)
            Connection configured manually.
            connection-url -> (string)
              Connection to the Greenplum/Cloudberry.
            password -> (string)
              Password of the Greenplum/Cloudberry user.
            user-name -> (string)
              Name of the Greenplum/Cloudberry user.
          connection-manager -> (struct)
            Connection configured using Yandex Cloud Connection Manager.
            connection-id -> (string)
              Connection ID.
            connection-properties -> (map[string,string])
              Additional connection properties.
            database -> (string)
              Database.
description -> (string)
  Description of the catalog.
labels -> (map[string,string])
  Labels associated with the catalog.
name -> (string)
  New name of the catalog.
``` ||
|| `--catalog-id` | `string`

ID of the catalog to update. ||
|| `--cluster-id` | `string`

ID of the Trino Cluster that contains the catalog to update. ||
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