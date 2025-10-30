---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/update.md
---

# Managed Service for MongoDB API, gRPC: ClusterService.Update

Updates the specified MongoDB cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.mdb.mongodb.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.mdb.mongodb.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "description": "string",
  "labels": "map<string, string>",
  "config_spec": {
    "version": "string",
    "feature_compatibility_version": "string",
    // Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`
    "mongodb_spec_3_6": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              }
            },
            "journal": {
              "enabled": "google.protobuf.BoolValue",
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_4_0": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_4_2": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "set_parameter": {
            "enable_flow_control": "google.protobuf.BoolValue"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_4_4": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "set_parameter": {
            "enable_flow_control": "google.protobuf.BoolValue"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_5_0": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "set_parameter": {
            "enable_flow_control": "google.protobuf.BoolValue",
            "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_6_0": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "set_parameter": {
            "enable_flow_control": "google.protobuf.BoolValue",
            "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_4_4_enterprise": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "security": {
            "enable_encryption": "google.protobuf.BoolValue",
            "kmip": {
              "server_name": "string",
              "port": "google.protobuf.Int64Value",
              "server_ca": "string",
              "client_certificate": "string",
              "key_identifier": "string"
            }
          },
          "audit_log": {
            "filter": "string"
          },
          "set_parameter": {
            "audit_authorization_success": "google.protobuf.BoolValue",
            "enable_flow_control": "google.protobuf.BoolValue"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_5_0_enterprise": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "security": {
            "enable_encryption": "google.protobuf.BoolValue",
            "kmip": {
              "server_name": "string",
              "port": "google.protobuf.Int64Value",
              "server_ca": "string",
              "client_certificate": "string",
              "key_identifier": "string"
            }
          },
          "audit_log": {
            "filter": "string",
            "runtime_configuration": "google.protobuf.BoolValue"
          },
          "set_parameter": {
            "audit_authorization_success": "google.protobuf.BoolValue",
            "enable_flow_control": "google.protobuf.BoolValue",
            "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    "mongodb_spec_6_0_enterprise": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "security": {
            "enable_encryption": "google.protobuf.BoolValue",
            "kmip": {
              "server_name": "string",
              "port": "google.protobuf.Int64Value",
              "server_ca": "string",
              "client_certificate": "string",
              "key_identifier": "string"
            }
          },
          "audit_log": {
            "filter": "string",
            "runtime_configuration": "google.protobuf.BoolValue"
          },
          "set_parameter": {
            "audit_authorization_success": "google.protobuf.BoolValue",
            "enable_flow_control": "google.protobuf.BoolValue",
            "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    },
    // end of the list of possible fields
    "backup_window_start": "google.type.TimeOfDay",
    "backup_retain_period_days": "google.protobuf.Int64Value",
    "performance_diagnostics": {
      "profiling_enabled": "bool"
    },
    "access": {
      "data_lens": "bool",
      "web_sql": "bool",
      "data_transfer": "bool"
    },
    "mongodb": {
      "mongod": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              },
              "collection_config": {
                "block_compressor": "Compressor"
              },
              "index_config": {
                "prefix_compression": "google.protobuf.BoolValue"
              }
            },
            "journal": {
              "commit_interval": "google.protobuf.Int64Value"
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value",
            "slow_op_sample_rate": "google.protobuf.DoubleValue"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          },
          "security": {
            "enable_encryption": "google.protobuf.BoolValue",
            "kmip": {
              "server_name": "string",
              "port": "google.protobuf.Int64Value",
              "server_ca": "string",
              "client_certificate": "string",
              "key_identifier": "string"
            }
          },
          "audit_log": {
            "filter": "string",
            "runtime_configuration": "google.protobuf.BoolValue"
          },
          "set_parameter": {
            "audit_authorization_success": "google.protobuf.BoolValue",
            "enable_flow_control": "google.protobuf.BoolValue",
            "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongocfg": {
        "config": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      },
      "mongoinfra": {
        "config_mongos": {
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value",
            "compression": {
              "compressors": [
                "Compressor"
              ]
            }
          }
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          }
        },
        "resources": {
          "resource_preset_id": "string",
          "disk_size": "int64",
          "disk_type_id": "string"
        },
        "disk_size_autoscaling": {
          "planned_usage_threshold": "google.protobuf.Int64Value",
          "emergency_usage_threshold": "google.protobuf.Int64Value",
          "disk_size_limit": "google.protobuf.Int64Value"
        }
      }
    }
  },
  "name": "string",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "network_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the MongoDB Cluster resource to update.
To get the MongoDB cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the MongoDB Cluster resource should be updated. ||
|| description | **string**

New description of the MongoDB cluster. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".

The new set of labels will completely replace the old ones. To add a label, request the current
set with the [ClusterService.Get](/docs/managed-mongodb/api-ref/grpc/Cluster/get#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.mongodb.v1.ConfigSpec)**

New configuration and resources for hosts in the cluster. ||
|| name | **string**

New name for the cluster. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow)**

New maintenance window settings for the cluster. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| network_id | **string**

ID of the network to move the cluster to. ||
|#

## ConfigSpec {#yandex.cloud.mdb.mongodb.v1.ConfigSpec}

#|
||Field | Description ||
|| version | **string**

Version of MongoDB used in the cluster. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`. ||
|| feature_compatibility_version | **string**

MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

Possible values:
* `3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older.
* `4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older.
* `4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older.
* `4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or older.
* `5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 4.4 or older.
* `6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 5.0 or older. ||
|| mongodb_spec_3_6 | **[MongodbSpec3_6](#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6)**

Configuration and resource allocation for a MongoDB 3.6 cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_4_0 | **[MongodbSpec4_0](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0)**

Configuration and resource allocation for a MongoDB 4.0 cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_4_2 | **[MongodbSpec4_2](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2)**

Configuration and resource allocation for a MongoDB 4.2 cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_4_4 | **[MongodbSpec4_4](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4)**

Configuration and resource allocation for a MongoDB 4.4 cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_5_0 | **[MongodbSpec5_0](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0)**

Configuration and resource allocation for a MongoDB 5.0 cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_6_0 | **[MongodbSpec6_0](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0)**

Configuration and resource allocation for a MongoDB 6.0 cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_4_4_enterprise | **[MongodbSpec4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise)**

Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_5_0_enterprise | **[MongodbSpec5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise)**

Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| mongodb_spec_6_0_enterprise | **[MongodbSpec6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise)**

Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster.

Includes only one of the fields `mongodb_spec_3_6`, `mongodb_spec_4_0`, `mongodb_spec_4_2`, `mongodb_spec_4_4`, `mongodb_spec_5_0`, `mongodb_spec_6_0`, `mongodb_spec_4_4_enterprise`, `mongodb_spec_5_0_enterprise`, `mongodb_spec_6_0_enterprise`. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|| performance_diagnostics | **[PerformanceDiagnosticsConfig](#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig)**

Performance Diagnosics configuration ||
|| access | **[Access](#yandex.cloud.mdb.mongodb.v1.Access)**

Access policy to DB ||
|| mongodb | **[MongodbSpec](#yandex.cloud.mdb.mongodb.v1.MongodbSpec)**

Configuration and resource allocation for a MongoDB 7.0 Enterprise cluster. ||
|#

## MongodbSpec3_6 {#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.Mongod)**

Configuration and resource allocation for mongod 3.6 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.MongoCfg)**

Configuration and resource allocation for mongocfg 3.6 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.Mongos)**

Configuration and resource allocation for mongos 3.6 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 3.6 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)**

Configuration for mongod 3.6 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network)**

`net` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal}

#|
||Field | Description ||
|| enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the journal is enabled or disabled.
Possible values:
* true (default) - the journal is enabled.
* false - the journal is disabled. ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| planned_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)**

Configuration for mongocfg 3.6 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Operation profiling level. For details, see [MongoDB documentation](https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/).

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data. This is the default
profiler level.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of incoming connections. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)**

Configuration for mongos 3.6 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of incoming connections. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)**

Configuration for mongoinfra 3.6 hosts. ||
|| config_mongocfg | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec4_0 {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.Mongod)**

Configuration and resource allocation for mongod 4.0 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.MongoCfg)**

Configuration and resource allocation for mongocfg 4.0 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.Mongos)**

Configuration and resource allocation for mongos 4.0 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.0 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)**

Configuration for mongod 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network)**

`net` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)**

Configuration for mongocfg 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)**

Configuration for mongos 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)**

Configuration for mongoinfra 4.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec4_2 {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.Mongod)**

Configuration and resource allocation for mongod 4.2 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.MongoCfg)**

Configuration and resource allocation for mongocfg 4.2 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.Mongos)**

Configuration and resource allocation for mongos 4.2 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.2 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)**

Configuration for mongod 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter)**

`replication` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.2/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)**

Configuration for mongocfg 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)**

Configuration for mongos 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)**

Configuration for mongoinfra 4.2 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec4_4 {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.Mongod)**

Configuration and resource allocation for mongod 4.4 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.MongoCfg)**

Configuration and resource allocation for mongocfg 4.4 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.Mongos)**

Configuration and resource allocation for mongos 4.4 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)**

Configuration for mongod 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter)**

`replication` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.4/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)**

Configuration for mongocfg 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)**

Configuration for mongos 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)**

Configuration for mongoinfra 4.4 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec5_0 {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.Mongod)**

Configuration and resource allocation for mongod 5.0 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.MongoCfg)**

Configuration and resource allocation for mongocfg 5.0 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.Mongos)**

Configuration and resource allocation for mongos 5.0 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)**

Configuration for mongod 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v5.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)**

Configuration for mongocfg 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)**

Configuration for mongos 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)**

Configuration for mongoinfra 5.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec6_0 {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.Mongod)**

Configuration and resource allocation for mongod 6.0 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.MongoCfg)**

Configuration and resource allocation for mongocfg 6.0 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.Mongos)**

Configuration and resource allocation for mongos 6.0 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)**

Configuration for mongod 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v6.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)**

Configuration for mongocfg 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)**

Configuration for mongos 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)**

Configuration for mongoinfra 6.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.Mongod)**

Configuration and resource allocation for mongod 4.4 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.MongoCfg)**

Configuration and resource allocation for mongocfg 4.4 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.Mongos)**

Configuration and resource allocation for mongos 4.4 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)**

Configuration for mongod 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.4/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)**

Configuration for mongocfg 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)**

Configuration for mongos 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)**

Configuration for mongoinfra 4.4 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.Mongod)**

Configuration and resource allocation for mongod 5.0 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.MongoCfg)**

Configuration and resource allocation for mongocfg 5.0 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.Mongos)**

Configuration and resource allocation for mongos 5.0 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)**

Configuration for mongod 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v5.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtime_configuration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)**

Configuration for mongocfg 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)**

Configuration for mongos 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)**

Configuration for mongoinfra 5.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodbSpec6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.Mongod)**

Configuration and resource allocation for mongod 6.0 hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.MongoCfg)**

Configuration and resource allocation for mongocfg 6.0 hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.Mongos)**

Configuration and resource allocation for mongos 6.0 hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)**

Configuration for mongod 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v6.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtime_configuration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)**

Configuration for mongocfg 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)**

Configuration for mongos 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)**

Configuration for mongoinfra 6.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## PerformanceDiagnosticsConfig {#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig}

#|
||Field | Description ||
|| profiling_enabled | **bool** ||
|#

## Access {#yandex.cloud.mdb.mongodb.v1.Access}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens. ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|#

## MongodbSpec {#yandex.cloud.mdb.mongodb.v1.MongodbSpec}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.MongodbSpec.Mongod)**

Configuration and resource allocation for mongod hosts. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.MongodbSpec.MongoCfg)**

Configuration and resource allocation for mongocfg hosts. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.MongodbSpec.Mongos)**

Configuration and resource allocation for mongos hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.MongodbSpec.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) hosts. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.MongodbSpec.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongod host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v7.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtime_configuration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v7.0/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.MongodbSpec.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)**

Configuration for mongocfg hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongocfg host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://www.mongodb.com/docs/v7.0/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.MongodbSpec.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)**

Configuration for mongos hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongos host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfig {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)**

Configuration for mongoinfra hosts. ||
|| config_mongocfg | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.AnytimeMaintenanceWindow)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "operation_log": {
      "entities": [
        {
          "cluster_id": "string",
          "action": "string",
          "started_at": "google.protobuf.Timestamp",
          "hosts": [
            {
              "fqdn": "string",
              "action": "string",
              "started_at": "google.protobuf.Timestamp"
            }
          ]
        }
      ]
    }
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "environment": "Environment",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      "feature_compatibility_version": "string",
      // Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`
      "mongodb_3_6": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  }
                },
                "journal": {
                  "enabled": "google.protobuf.BoolValue",
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  }
                },
                "journal": {
                  "enabled": "google.protobuf.BoolValue",
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  }
                },
                "journal": {
                  "enabled": "google.protobuf.BoolValue",
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_4_0": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_4_2": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_4_4": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_5_0": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_6_0": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "set_parameter": {
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_4_4_enterprise": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_5_0_enterprise": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      "mongodb_6_0_enterprise": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      },
      // end of the list of possible fields
      "backup_window_start": "google.type.TimeOfDay",
      "backup_retain_period_days": "google.protobuf.Int64Value",
      "performance_diagnostics": {
        "profiling_enabled": "bool"
      },
      "access": {
        "data_lens": "bool",
        "web_sql": "bool",
        "data_transfer": "bool"
      },
      "mongodb_config": {
        "mongod": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  },
                  "collection_config": {
                    "block_compressor": "Compressor"
                  },
                  "index_config": {
                    "prefix_compression": "google.protobuf.BoolValue"
                  }
                },
                "journal": {
                  "commit_interval": "google.protobuf.Int64Value"
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value",
                "slow_op_sample_rate": "google.protobuf.DoubleValue"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              },
              "security": {
                "enable_encryption": "google.protobuf.BoolValue",
                "kmip": {
                  "server_name": "string",
                  "port": "google.protobuf.Int64Value",
                  "server_ca": "string",
                  "client_certificate": "string",
                  "key_identifier": "string"
                }
              },
              "audit_log": {
                "filter": "string",
                "runtime_configuration": "google.protobuf.BoolValue"
              },
              "set_parameter": {
                "audit_authorization_success": "google.protobuf.BoolValue",
                "enable_flow_control": "google.protobuf.BoolValue",
                "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongocfg": {
          "config": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongos": {
          "config": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        },
        "mongoinfra": {
          "config_mongos": {
            "effective_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "user_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            },
            "default_config": {
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value",
                "compression": {
                  "compressors": [
                    "Compressor"
                  ]
                }
              }
            }
          },
          "config_mongocfg": {
            "effective_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "user_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            },
            "default_config": {
              "storage": {
                "wired_tiger": {
                  "engine_config": {
                    "cache_size_gb": "google.protobuf.DoubleValue"
                  }
                }
              },
              "operation_profiling": {
                "mode": "Mode",
                "slow_op_threshold": "google.protobuf.Int64Value"
              },
              "net": {
                "max_incoming_connections": "google.protobuf.Int64Value"
              }
            }
          },
          "resources": {
            "resource_preset_id": "string",
            "disk_size": "int64",
            "disk_type_id": "string"
          },
          "disk_size_autoscaling": {
            "planned_usage_threshold": "google.protobuf.Int64Value",
            "emergency_usage_threshold": "google.protobuf.Int64Value",
            "disk_size_limit": "google.protobuf.Int64Value"
          }
        }
      }
    },
    "network_id": "string",
    "health": "Health",
    "status": "Status",
    "sharded": "bool",
    "maintenance_window": {
      // Includes only one of the fields `anytime`, `weekly_maintenance_window`
      "anytime": "AnytimeMaintenanceWindow",
      "weekly_maintenance_window": {
        "day": "WeekDay",
        "hour": "int64"
      }
      // end of the list of possible fields
    },
    "planned_operation": {
      "info": "string",
      "delayed_until": "google.protobuf.Timestamp"
    },
    "security_group_ids": [
      "string"
    ],
    "deletion_protection": "bool",
    "disk_encryption_key_id": "google.protobuf.StringValue"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateClusterMetadata](#yandex.cloud.mdb.mongodb.v1.UpdateClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Cluster](#yandex.cloud.mdb.mongodb.v1.Cluster)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateClusterMetadata {#yandex.cloud.mdb.mongodb.v1.UpdateClusterMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the MongoDB Cluster resource that is being updated. ||
|| operation_log | **[OperationLog](#yandex.cloud.mdb.operationlog.v1.OperationLog)**

Log of actions during operation ||
|#

## OperationLog {#yandex.cloud.mdb.operationlog.v1.OperationLog}

#|
||Field | Description ||
|| entities[] | **[ClusterEntity](#yandex.cloud.mdb.operationlog.v1.ClusterEntity)** ||
|#

## ClusterEntity {#yandex.cloud.mdb.operationlog.v1.ClusterEntity}

#|
||Field | Description ||
|| cluster_id | **string** ||
|| action | **string** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| hosts[] | **[HostEntity](#yandex.cloud.mdb.operationlog.v1.HostEntity)** ||
|#

## HostEntity {#yandex.cloud.mdb.operationlog.v1.HostEntity}

#|
||Field | Description ||
|| fqdn | **string** ||
|| action | **string** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#

## Cluster {#yandex.cloud.mdb.mongodb.v1.Cluster}

A managed MongoDB cluster. For more information, see the [documentation](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the MongoDB cluster.
This ID is assigned by MDB at creation time. ||
|| folder_id | **string**

ID of the folder that the MongoDB cluster belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the MongoDB cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the MongoDB cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. ||
|| environment | enum **Environment**

Deployment environment of the MongoDB cluster.

- `ENVIRONMENT_UNSPECIFIED`
- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.mongodb.v1.Monitoring)**

Description of monitoring systems relevant to the MongoDB cluster. ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.mongodb.v1.ClusterConfig)**

Configuration of the MongoDB cluster. ||
|| network_id | **string**

ID of the network that the cluster belongs to. ||
|| health | enum **Health**

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-mongodb/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-mongodb/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-mongodb/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-mongodb/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | enum **Status**

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| sharded | **bool**

Indicates current sharding status of the cluster. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow2)**

Maintenance window for the cluster. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.mdb.mongodb.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenance_window`. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| disk_encryption_key_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the key to encrypt cluster disks. ||
|#

## Monitoring {#yandex.cloud.mdb.mongodb.v1.Monitoring}

Monitoring system.

#|
||Field | Description ||
|| name | **string**

Name of the monitoring system. ||
|| description | **string**

Description of the monitoring system. ||
|| link | **string**

Link to the monitoring system charts for the MongoDB cluster. ||
|#

## ClusterConfig {#yandex.cloud.mdb.mongodb.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string**

Version of MongoDB server software. Possible values: `3.6`, `4.0`, `4.2`, `4.4`, `4.4-enterprise`, `5.0`, `5.0-enterprise`, `6.0`, `6.0-enterprise`, `7.0`, `7.0-enterprise`. ||
|| feature_compatibility_version | **string**

MongoDB feature compatibility version. See usage details in [MongoDB documentation](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

Possible values:
* `3.6` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower.
* `4.0` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower.
* `4.2` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower.
* `4.4` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower.
* `5.0` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower.
* `6.0` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower. ||
|| mongodb_3_6 | **[Mongodb3_6](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6)**

Configuration and resource allocation for a MongoDB 3.6 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_0 | **[Mongodb4_0](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0)**

Configuration and resource allocation for a MongoDB 4.0 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_2 | **[Mongodb4_2](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2)**

Configuration and resource allocation for a MongoDB 4.2 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_4 | **[Mongodb4_4](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4)**

Configuration and resource allocation for a MongoDB 4.4 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_5_0 | **[Mongodb5_0](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0)**

Configuration and resource allocation for a MongoDB 5.0 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_6_0 | **[Mongodb6_0](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0)**

Configuration and resource allocation for a MongoDB 6.0 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_4_enterprise | **[Mongodb4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise)**

Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_5_0_enterprise | **[Mongodb5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise)**

Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_6_0_enterprise | **[Mongodb6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise)**

Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4_enterprise`, `mongodb_5_0_enterprise`, `mongodb_6_0_enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Time to start the daily backup, in the UTC timezone. ||
|| backup_retain_period_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Retain period of automatically created backup in days ||
|| performance_diagnostics | **[PerformanceDiagnosticsConfig](#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig2)**

Performance Diagnostic ||
|| access | **[Access](#yandex.cloud.mdb.mongodb.v1.Access2)**

Access policy to DB ||
|| mongodb_config | **[Mongodb](#yandex.cloud.mdb.mongodb.v1.Mongodb)**

Configuration and resource allocation for a MongoDB Enterprise cluster. ||
|#

## Mongodb3_6 {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 3.6 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 3.6 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet3_6)**

Configuration for a mongod 3.6 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to MongoDB hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet3_6}

#|
||Field | Description ||
|| effective_config | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_62)**

Effective mongod settings for a MongoDB 3.6 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_62)**

User-defined mongod settings for a MongoDB 3.6 cluster. ||
|| default_config | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_62)**

Default mongod configuration for a MongoDB 3.6 cluster. ||
|#

## MongodConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_62}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network2)**

`net` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal2}

#|
||Field | Description ||
|| enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the journal is enabled or disabled.
Possible values:
* true (default) - the journal is enabled.
* false - the journal is disabled. ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources2}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2}

#|
||Field | Description ||
|| planned_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergency_usage_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| disk_size_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_62)**

Effective mongocfg settings for a MongoDB 3.6 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_62)**

User-defined mongocfg settings for a MongoDB 3.6 cluster. ||
|| default_config | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_62)**

Default mongocfg configuration for a MongoDB 3.6 cluster. ||
|#

## MongoCfgConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_62}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Operation profiling level. For details, see [MongoDB documentation](https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/).

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data. This is the default
profiler level.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of incoming connections. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6}

#|
||Field | Description ||
|| effective_config | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_62)**

Effective settings for a MongoDB 3.6 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_62)**

User-defined settings for a MongoDB 3.6 cluster. ||
|| default_config | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_62)**

Default configuration for a MongoDB 3.6 cluster. ||
|#

## MongosConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_62}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of incoming connections. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6)** ||
|| config_mongocfg | **[MongoCfgConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb4_0 {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 4.0 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 4.0 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_0)**

Configuration for mongod 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_0}

#|
||Field | Description ||
|| effective_config | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_02)**

Effective mongod settings for a MongoDB 4.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_02)**

User-defined mongod settings for a MongoDB 4.0 cluster. ||
|| default_config | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_02)**

Default mongod configuration for a MongoDB 4.0 cluster. ||
|#

## MongodConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_02}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network2)**

`net` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0)**

Configuration for mongocfg 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_02)**

Effective mongocfg settings for a MongoDB 4.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_02)**

User-defined mongocfg settings for a MongoDB 4.0 cluster. ||
|| default_config | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_02)**

Default mongocfg configuration for a MongoDB 4.0 cluster. ||
|#

## MongoCfgConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_02}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0)**

Configuration for mongos 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0}

#|
||Field | Description ||
|| effective_config | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_02)**

Effective mongos settings for a MongoDB 4.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_02)**

User-defined mongos settings for a MongoDB 4.0 cluster. ||
|| default_config | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_02)**

Default mongos configuration for a MongoDB 4.0 cluster. ||
|#

## MongosConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_02}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0)** ||
|| config_mongocfg | **[MongoCfgConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb4_2 {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 4.2 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 4.2 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_2)**

Configuration for mongod 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_2}

#|
||Field | Description ||
|| effective_config | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_22)**

Effective mongod settings for a MongoDB 4.2 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_22)**

User-defined mongod settings for a MongoDB 4.2 cluster. ||
|| default_config | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_22)**

Default mongod configuration for a MongoDB 4.2 cluster. ||
|#

## MongodConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_22}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network2)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter2)**

`replication` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.2/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter2}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2)**

Configuration for mongocfg 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_22)**

Effective mongocfg settings for a MongoDB 4.2 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_22)**

User-defined mongocfg settings for a MongoDB 4.2 cluster. ||
|| default_config | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_22)**

Default mongocfg configuration for a MongoDB 4.2 cluster. ||
|#

## MongoCfgConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_22}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2)**

Configuration for mongos 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2}

#|
||Field | Description ||
|| effective_config | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_22)**

Effective mongos settings for a MongoDB 4.2 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_22)**

User-defined mongos settings for a MongoDB 4.2 cluster. ||
|| default_config | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_22)**

Default mongos configuration for a MongoDB 4.2 cluster. ||
|#

## MongosConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_22}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2)** ||
|| config_mongocfg | **[MongoCfgConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb4_4 {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4)**

Configuration for mongod 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4}

#|
||Field | Description ||
|| effective_config | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_42)**

Effective mongod settings for a MongoDB 4.4 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_42)**

User-defined mongod settings for a MongoDB 4.4 cluster. ||
|| default_config | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_42)**

Default mongod configuration for a MongoDB 4.4 cluster. ||
|#

## MongodConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_42}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network2)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter2)**

`replication` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.4/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter2}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4)**

Configuration for mongocfg 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_42)**

Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_42)**

User-defined mongocfg settings for a MongoDB 4.4 cluster. ||
|| default_config | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_42)**

Default mongocfg configuration for a MongoDB 4.4 cluster. ||
|#

## MongoCfgConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_42}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4)**

Configuration for mongos 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4}

#|
||Field | Description ||
|| effective_config | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_42)**

Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_42)**

User-defined mongos settings for a MongoDB 4.4 cluster. ||
|| default_config | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_42)**

Default mongos configuration for a MongoDB 4.4 cluster. ||
|#

## MongosConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_42}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4)** ||
|| config_mongocfg | **[MongoCfgConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb5_0 {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0)**

Configuration for mongod 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0}

#|
||Field | Description ||
|| effective_config | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_02)**

Effective mongod settings for a MongoDB 5.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_02)**

User-defined mongod settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_02)**

Default mongod configuration for a MongoDB 5.0 cluster. ||
|#

## MongodConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_02}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network2)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter2)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v5.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter2}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0)**

Configuration for mongocfg 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_02)**

Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_02)**

User-defined mongocfg settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_02)**

Default mongocfg configuration for a MongoDB 5.0 cluster. ||
|#

## MongoCfgConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_02}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0)**

Configuration for mongos 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0}

#|
||Field | Description ||
|| effective_config | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_02)**

Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_02)**

User-defined mongos settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_02)**

Default mongos configuration for a MongoDB 5.0 cluster. ||
|#

## MongosConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_02}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0)** ||
|| config_mongocfg | **[MongoCfgConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb6_0 {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0)**

Configuration for mongod 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0}

#|
||Field | Description ||
|| effective_config | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_02)**

Effective mongod settings for a MongoDB 6.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_02)**

User-defined mongod settings for a MongoDB 6.0 cluster. ||
|| default_config | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_02)**

Default mongod configuration for a MongoDB 6.0 cluster. ||
|#

## MongodConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_02}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network2)**

`net` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter2)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v6.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter2}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0)**

Configuration for mongocfg 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_02)**

Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_02)**

User-defined mongocfg settings for a MongoDB 6.0 cluster. ||
|| default_config | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_02)**

Default mongocfg configuration for a MongoDB 6.0 cluster. ||
|#

## MongoCfgConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_02}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0)**

Configuration for mongos 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0}

#|
||Field | Description ||
|| effective_config | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_02)**

Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_02)**

User-defined mongos settings for a MongoDB 6.0 cluster. ||
|| default_config | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_02)**

Default mongos configuration for a MongoDB 6.0 cluster. ||
|#

## MongosConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_02}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0)** ||
|| config_mongocfg | **[MongoCfgConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 4.4 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 4.4 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4_enterprise)**

Configuration for mongod 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongodConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise2)**

Effective mongod settings for a MongoDB 4.4 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise2)**

User-defined mongod settings for a MongoDB 4.4 cluster. ||
|| default_config | **[MongodConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise2)**

Default mongod configuration for a MongoDB 4.4 cluster. ||
|#

## MongodConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise2}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network2)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security2)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog2)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter2)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.4/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security2}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP2)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP2}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog2}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter2}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise)**

Configuration for mongocfg 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise2)**

Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise2)**

User-defined mongocfg settings for a MongoDB 4.4 cluster. ||
|| default_config | **[MongoCfgConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise2)**

Default mongocfg configuration for a MongoDB 4.4 cluster. ||
|#

## MongoCfgConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise)**

Configuration for mongos 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongosConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise2)**

Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise2)**

User-defined mongos settings for a MongoDB 4.4 cluster. ||
|| default_config | **[MongosConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise2)**

Default mongos configuration for a MongoDB 4.4 cluster. ||
|#

## MongosConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise2}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise)** ||
|| config_mongocfg | **[MongoCfgConfigSet4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 5.0 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 5.0 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0_enterprise)**

Configuration for mongod 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongodConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise2)**

Effective mongod settings for a MongoDB 5.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise2)**

User-defined mongod settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongodConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise2)**

Default mongod configuration for a MongoDB 5.0 cluster. ||
|#

## MongodConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise2}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network2)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security2)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog2)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter2)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v5.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security2}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP2)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP2}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog2}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtime_configuration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter2}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise)**

Configuration for mongocfg 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise2)**

Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise2)**

User-defined mongocfg settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongoCfgConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise2)**

Default mongocfg configuration for a MongoDB 5.0 cluster. ||
|#

## MongoCfgConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise)**

Configuration for mongos 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongosConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise2)**

Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise2)**

User-defined mongos settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongosConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise2)**

Default mongos configuration for a MongoDB 5.0 cluster. ||
|#

## MongosConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise2}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise)** ||
|| config_mongocfg | **[MongoCfgConfigSet5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## Mongodb6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongod)**

Configuration and resource allocation for mongod in a MongoDB 6.0 cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongos)**

Configuration and resource allocation for mongos in a MongoDB 6.0 cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0_enterprise)**

Configuration for mongod 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongodConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise2)**

Effective mongod settings for a MongoDB 6.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise2)**

User-defined mongod settings for a MongoDB 6.0 cluster. ||
|| default_config | **[MongodConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise2)**

Default mongod configuration for a MongoDB 6.0 cluster. ||
|#

## MongodConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise2}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network2)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security2)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog2)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter2)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v6.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security2}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP2)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP2}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog2}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtime_configuration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter2}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise)**

Configuration for mongocfg 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise2)**

Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise2)**

User-defined mongocfg settings for a MongoDB 6.0 cluster. ||
|| default_config | **[MongoCfgConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise2)**

Default mongocfg configuration for a MongoDB 6.0 cluster. ||
|#

## MongoCfgConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise)**

Configuration for mongos 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effective_config | **[MongosConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise2)**

Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise2)**

User-defined mongos settings for a MongoDB 5.0 cluster. ||
|| default_config | **[MongosConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise2)**

Default mongos configuration for a MongoDB 5.0 cluster. ||
|#

## MongosConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise2}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise)** ||
|| config_mongocfg | **[MongoCfgConfigSet6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## PerformanceDiagnosticsConfig {#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig2}

#|
||Field | Description ||
|| profiling_enabled | **bool** ||
|#

## Access {#yandex.cloud.mdb.mongodb.v1.Access2}

#|
||Field | Description ||
|| data_lens | **bool**

Allow access for DataLens. ||
|| web_sql | **bool**

Allow access for Web SQL. ||
|| data_transfer | **bool**

Allow access for DataTransfer. ||
|#

## Mongodb {#yandex.cloud.mdb.mongodb.v1.Mongodb}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongod)**

Configuration and resource allocation for mongod in a MongoDB cluster. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoCfg)**

Configuration and resource allocation for mongocfg in a MongoDB cluster. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongos)**

Configuration and resource allocation for mongos in a MongoDB cluster. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoInfra)**

Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB cluster. ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet)**

Configuration for mongod hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongod hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongodConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet}

#|
||Field | Description ||
|| effective_config | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig2)**

Effective mongod settings for a MongoDB cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig2)**

User-defined mongod settings for a MongoDB cluster. ||
|| default_config | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig2)**

Default mongod configuration for a MongoDB cluster. ||
|#

## MongodConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig2}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v7.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage2)**

`storage` section of mongod configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling2)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network2)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security2)**

`security` section of mongod configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog2)**

`AuditLog` section of mongod configuration. ||
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter2)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal2)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|| collection_config | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig2)**

Collection configuration for WiredTiger. ||
|| index_config | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig2)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig2}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-zstd) compression. ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig2}

#|
||Field | Description ||
|| prefix_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal2}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security2}

#|
||Field | Description ||
|| enable_encryption | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP2)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP2}

#|
||Field | Description ||
|| server_name | **string**

KMIP server name ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

KMIP server port ||
|| server_ca | **string**

KMIP Server CA ||
|| client_certificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| key_identifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog2}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtime_configuration | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter2}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v7.0/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| min_snapshot_history_window_in_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet)**

Configuration for mongocfg hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongocfg hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet}

#|
||Field | Description ||
|| effective_config | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig2)**

Effective mongocfg settings for a MongoDB cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig2)**

User-defined mongocfg settings for a MongoDB cluster. ||
|| default_config | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig2)**

Default mongocfg configuration for a MongoDB cluster. ||
|#

## MongoCfgConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage2)**

`storage` section of mongocfg configuration. ||
|| operation_profiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling2)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network2)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage2}

#|
||Field | Description ||
|| wired_tiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger2)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger2}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engine_config | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig2)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig2}

#|
||Field | Description ||
|| cache_size_gb | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling2}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://www.mongodb.com/docs/v7.0/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet)**

Configuration for mongos hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongos hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MongosConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet}

#|
||Field | Description ||
|| effective_config | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig2)**

Effective mongos settings for a MongoDB cluster (a combination of settings defined
in `user_config` and `default_config`). ||
|| user_config | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig2)**

User-defined mongos settings for a MongoDB cluster. ||
|| default_config | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig2)**

Default mongos configuration for a MongoDB cluster. ||
|#

## MongosConfig {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig2}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network2)**

Network settings for mongos. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network2}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression2)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression2}

#|
||Field | Description ||
|| compressors[] | enum **Compressor**

Specifies the default compressor(s) to use for communication between this mongod or mongos instance and:
- other members of the deployment if the instance is part of a replica set or a sharded cluster
- mongosh
- drivers that support the OP_COMPRESSED message format.
MongoDB supports the following compressors:

- `COMPRESSOR_UNSPECIFIED`
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet)** ||
|| config_mongocfg | **[MongoCfgConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources2)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling2)**

Disk size autoscaling settings ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow2}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.AnytimeMaintenanceWindow2)**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow2)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weekly_maintenance_window`.

The maintenance policy in effect. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.AnytimeMaintenanceWindow2}

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow2}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.mongodb.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time until which this maintenance operation is delayed. ||
|#