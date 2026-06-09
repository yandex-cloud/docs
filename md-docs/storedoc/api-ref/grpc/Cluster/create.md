# Managed Service for MongoDB API, gRPC: ClusterService.Create

Creates a MongoDB cluster in the specified folder.

## gRPC request

**rpc Create ([CreateClusterRequest](#yandex.cloud.mdb.mongodb.v1.CreateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateClusterRequest {#yandex.cloud.mdb.mongodb.v1.CreateClusterRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "environment": "Environment",
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
                "cache_size_gb": "google.protobuf.DoubleValue",
                "cache_size": "google.protobuf.DoubleValue"
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
            "min_snapshot_history_window_in_seconds": "google.protobuf.Int64Value",
            "flow_control_target_lag_seconds": "google.protobuf.Int64Value",
            "flow_control_warn_threshold_seconds": "google.protobuf.Int64Value",
            "migrate_clone_insertion_batch_delay_ms": "google.protobuf.Int64Value",
            "migrate_clone_insertion_batch_size": "google.protobuf.Int64Value",
            "orphan_cleanup_delay_secs": "google.protobuf.Int64Value",
            "persisted_chunk_cache_update_max_batch_size": "google.protobuf.Int64Value",
            "range_deleter_batch_delay_ms": "google.protobuf.Int64Value",
            "range_deleter_batch_size": "google.protobuf.Int64Value",
            "mirror_reads": {
              "sampling_rate": "google.protobuf.DoubleValue",
              "max_time_ms": "google.protobuf.Int64Value"
            },
            "redact_client_log_data": "google.protobuf.BoolValue"
          },
          "oplog": {
            "max_size_percent": "google.protobuf.Int64Value",
            "min_retention_hours": "google.protobuf.DoubleValue"
          },
          "chaining_allowed": "google.protobuf.BoolValue"
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
                "cache_size_gb": "google.protobuf.DoubleValue",
                "cache_size": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          },
          "set_parameter": {
            "enable_flow_control": "google.protobuf.BoolValue",
            "audit_authorization_success": "google.protobuf.BoolValue",
            "redact_client_log_data": "google.protobuf.BoolValue"
          },
          "audit_log": {
            "filter": "string"
          },
          "oplog": {
            "max_size_percent": "google.protobuf.Int64Value",
            "min_retention_hours": "google.protobuf.DoubleValue"
          },
          "chaining_allowed": "google.protobuf.BoolValue"
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
          },
          "set_parameter": {
            "audit_authorization_success": "google.protobuf.BoolValue",
            "read_hedging_mode": "google.protobuf.StringValue",
            "sharding_task_executor_pool_max_size": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_max_connecting": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_min_size": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_replica_set_matching": "google.protobuf.StringValue",
            "sharding_task_executor_pool_host_timeout_ms": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_refresh_requirement_ms": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_refresh_timeout_ms": "google.protobuf.Int64Value",
            "warm_min_connections_in_sharding_task_executor_pool_on_startup": "google.protobuf.BoolValue",
            "warm_min_connections_in_sharding_task_executor_pool_on_startup_wait_ms": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_max_size_for_config_servers": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_min_size_for_config_servers": "google.protobuf.Int64Value",
            "redact_client_log_data": "google.protobuf.BoolValue"
          },
          "audit_log": {
            "filter": "string"
          },
          "chunk_size": "google.protobuf.Int64Value"
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
          },
          "set_parameter": {
            "audit_authorization_success": "google.protobuf.BoolValue",
            "read_hedging_mode": "google.protobuf.StringValue",
            "sharding_task_executor_pool_max_size": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_max_connecting": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_min_size": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_replica_set_matching": "google.protobuf.StringValue",
            "sharding_task_executor_pool_host_timeout_ms": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_refresh_requirement_ms": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_refresh_timeout_ms": "google.protobuf.Int64Value",
            "warm_min_connections_in_sharding_task_executor_pool_on_startup": "google.protobuf.BoolValue",
            "warm_min_connections_in_sharding_task_executor_pool_on_startup_wait_ms": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_max_size_for_config_servers": "google.protobuf.Int64Value",
            "sharding_task_executor_pool_min_size_for_config_servers": "google.protobuf.Int64Value",
            "redact_client_log_data": "google.protobuf.BoolValue"
          },
          "audit_log": {
            "filter": "string"
          },
          "chunk_size": "google.protobuf.Int64Value"
        },
        "config_mongocfg": {
          "storage": {
            "wired_tiger": {
              "engine_config": {
                "cache_size_gb": "google.protobuf.DoubleValue",
                "cache_size": "google.protobuf.DoubleValue"
              }
            }
          },
          "operation_profiling": {
            "mode": "Mode",
            "slow_op_threshold": "google.protobuf.Int64Value"
          },
          "net": {
            "max_incoming_connections": "google.protobuf.Int64Value"
          },
          "set_parameter": {
            "enable_flow_control": "google.protobuf.BoolValue",
            "audit_authorization_success": "google.protobuf.BoolValue",
            "redact_client_log_data": "google.protobuf.BoolValue"
          },
          "audit_log": {
            "filter": "string"
          },
          "oplog": {
            "max_size_percent": "google.protobuf.Int64Value",
            "min_retention_hours": "google.protobuf.DoubleValue"
          },
          "chaining_allowed": "google.protobuf.BoolValue"
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
    "autocompact_config": {
      "enabled": "bool",
      "target_free_space": "google.protobuf.Int64Value",
      "bloat_percent": "google.protobuf.DoubleValue",
      "compaction_type": "CompactionType"
    }
  },
  "database_specs": [
    {
      "name": "string"
    }
  ],
  "user_specs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "database_name": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "host_specs": [
    {
      "zone_id": "string",
      "subnet_id": "string",
      "assign_public_ip": "bool",
      "type": "Type",
      "shard_name": "string",
      "hidden": "google.protobuf.BoolValue",
      "secondary_delay_secs": "google.protobuf.Int64Value",
      "priority": "google.protobuf.DoubleValue",
      "tags": "map<string, string>"
    }
  ],
  "network_id": "string",
  "security_group_ids": [
    "string"
  ],
  "deletion_protection": "bool",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "disk_encryption_key_id": "google.protobuf.StringValue",
  "retention_policies": [
    {
      "policy_name": "string",
      "cron": {
        "day_of_month": "string",
        "month": "string",
        "day_of_week": "string"
      },
      "retain_for_days": "int64",
      "description": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create MongoDB cluster in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the MongoDB cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the MongoDB cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".

The maximum string length in characters for each value is 63. The maximum string length in characters for each key is 63. Each key must match the regular expression ` ^[a-z][-_./\@0-9a-z]*$ `. Each value must match the regular expression ` ^[-_./\@0-9a-z]*$ `. No more than 64 per resource. ||
|| environment | enum **Environment**

Required field. Deployment environment of the MongoDB cluster.

- `PRODUCTION`: Stable environment with a conservative update policy: only hotfixes
are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| config_spec | **[ConfigSpec](#yandex.cloud.mdb.mongodb.v1.ConfigSpec)**

Required field. Configuration and resources for hosts that should be created for the MongoDB cluster. ||
|| database_specs[] | **[DatabaseSpec](#yandex.cloud.mdb.mongodb.v1.DatabaseSpec)**

Descriptions of databases to be created in the MongoDB cluster. ||
|| user_specs[] | **[UserSpec](#yandex.cloud.mdb.mongodb.v1.UserSpec)**

Descriptions of database users to be created in the MongoDB cluster. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.mongodb.v1.HostSpec)**

Individual configurations for hosts that should be created for the MongoDB cluster.

The number of elements must be greater than 0. ||
|| network_id | **string**

ID of the network to create the cluster in.

The maximum string length in characters is 150. ||
|| security_group_ids[] | **string**

User security groups ||
|| deletion_protection | **bool**

Deletion Protection inhibits deletion of the cluster ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow)**

Maintenance window settings for the cluster. ||
|| disk_encryption_key_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

ID of the key to encrypt cluster disks. ||
|| retention_policies[] | **[BackupRetentionPolicySpec](#yandex.cloud.mdb.v1.BackupRetentionPolicySpec)**

Backup long-term retention policies setting. ||
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

Retain period of automatically created backup in days

Acceptable values are 7 to 35, inclusive. ||
|| performance_diagnostics | **[PerformanceDiagnosticsConfig](#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig)**

Performance Diagnosics configuration ||
|| access | **[Access](#yandex.cloud.mdb.mongodb.v1.Access)**

Access policy to DB ||
|| mongodb | **[MongodbSpec](#yandex.cloud.mdb.mongodb.v1.MongodbSpec)**

Configuration and resource allocation for a MongoDB 7.0 Enterprise cluster. ||
|| autocompact_config | **[AutoCompactConfig](#yandex.cloud.mdb.mongodb.v1.AutoCompactConfig)**

AutoCompact config ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](../../../../managed-mongodb/concepts/instance-types). ||
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

- `OFF`: The profiler is off and does not collect any data. This is the default
profiler level.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of incoming connections.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of incoming connections.

Acceptable values are 10 to 32768, inclusive. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec3_6.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)**

Configuration for mongos of mongoinfra 3.6 hosts. ||
|| config_mongocfg | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)**

Configuration for mongocfg of mongoinfra 3.6 hosts. ||
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

- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal}

#|
||Field | Description ||
|| commit_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Commit interval between journal operations, in milliseconds.
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)**

Configuration for mongos of mongoinfra 4.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)**

Configuration for mongocfg of mongoinfra 4.0 hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_2.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)**

Configuration for mongos of mongoinfra 4.2 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)**

Configuration for mongocfg of mongoinfra 4.2 hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)**

Configuration for mongos of mongoinfra 4.4 hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)**

Configuration for mongocfg of mongoinfra 4.4 hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

The minimum time window in seconds for which the storage engine keeps the snapshot history.

The minimum value is 0. ||
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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)**

Configuration for mongos of mongoinfra 5.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)**

Configuration for mongocfg of mongoinfra 5.0 hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

The minimum time window in seconds for which the storage engine keeps the snapshot history.

The minimum value is 0. ||
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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)**

Configuration for mongos of mongoinfra 6.0 hosts. ||
|| config_mongocfg | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)**

Configuration for mongocfg of mongoinfra 6.0 hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec4_4_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)**

Configuration for mongos of mongoinfra 4.4 enterprise hosts. ||
|| config_mongocfg | **[MongoCfgConfig4_4_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)**

Configuration for mongocfg of mongoinfra 4.4 enterprise hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

The minimum time window in seconds for which the storage engine keeps the snapshot history.

The minimum value is 0. ||
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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec5_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)**

Configuration for mongos of mongoinfra 5.0 enterprise hosts. ||
|| config_mongocfg | **[MongoCfgConfig5_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)**

Configuration for mongocfg of mongoinfra 5.0 enterprise hosts. ||
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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

The minimum time window in seconds for which the storage engine keeps the snapshot history.

The minimum value is 0. ||
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

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec6_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)**

Configuration for mongos of mongoinfra 6.0 enterprise hosts. ||
|| config_mongocfg | **[MongoCfgConfig6_0_enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)**

Configuration for mongocfg of mongoinfra 6.0 enterprise hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## PerformanceDiagnosticsConfig {#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig}

#|
||Field | Description ||
|| profiling_enabled | **bool**

Whether profiling is enabled for the cluster. ||
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
|| config | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)**

Configuration for mongod hosts. ||
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
|| oplog | **[Oplog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Oplog)**

`Oplog` section of mongod configuration. ||
|| chaining_allowed | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Chained replication setting ||
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
|| cache_size | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data in percents. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| block_compressor | enum **Compressor**

Default type of compression to use for collection data.

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
Default: 100.

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode.

Value must be greater than 0. ||
|| slow_op_sample_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongod will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

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

The minimum time window in seconds for which the storage engine keeps the snapshot history.

The minimum value is 0. ||
|| flow_control_target_lag_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The target maximum majority committed lag when running with flow control

Value must be greater than 0. ||
|| flow_control_warn_threshold_seconds | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of time to wait to log a warning once the flow control mechanism detects the majority commit point has not moved.

The minimum value is 0. ||
|| migrate_clone_insertion_batch_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Time in milliseconds to wait between batches of insertions during cloning step of the migration process.

The minimum value is 0. ||
|| migrate_clone_insertion_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of documents to insert in a single batch during the cloning step of the migration process.

The minimum value is 0. ||
|| orphan_cleanup_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum delay before a migrated chunk is deleted from the source shard. ||
|| persisted_chunk_cache_update_max_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Specifies the maximum batch size used for updating the persisted chunk cache. ||
|| range_deleter_batch_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The amount of time in milliseconds to wait before the next batch of deletion during the cleanup stage of chunk migration (or the cleanupOrphaned command).

The minimum value is 0. ||
|| range_deleter_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of documents in each batch to delete during the cleanup stage of chunk migration (or the cleanupOrphaned command).

The minimum value is 0. ||
|| mirror_reads | **[MirrorReads](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter.MirrorReads)**

Specifies the settings for mirrored reads for the mongod instance ||
|| redact_client_log_data | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables redacting any message accompanying a given log event before logging.
This prevents the mongod or mongos from writing potentially sensitive data
stored on the database to the diagnostic log.
https://mongo-db.ru/reference/configuration-options/index.html#mongodb-setting-security.redactClientLogData ||
|#

## MirrorReads {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter.MirrorReads}

#|
||Field | Description ||
|| sampling_rate | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The sampling rate used to mirror a subset of operations that support mirroring. ||
|| max_time_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum time in milliseconds for the mirrored reads. ||
|#

## Oplog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Oplog}

#|
||Field | Description ||
|| max_size_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Oplog maxsize in percents. ||
|| min_retention_hours | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour. ||
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
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.SetParameter)**

`setParameter` section of mongocfg configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.AuditLog)**

`AuditLog` section of mongocfg configuration. ||
|| oplog | **[Oplog](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Oplog)**

`Oplog` section of mongod configuration. ||
|| chaining_allowed | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Chained replication setting ||
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
|| cache_size | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The maximum size of the internal cache that WiredTiger will use for all data in percents. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode which specifies operations that should be profiled.

- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slow_op_threshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slow_op_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://www.mongodb.com/docs/v7.0/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpThresholdMs).

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongocfg will accept.

Acceptable values are 10 to 32768, inclusive. ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.SetParameter}

#|
||Field | Description ||
|| enable_flow_control | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes
https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess ||
|| redact_client_log_data | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables redacting any message accompanying a given log event before logging.
This prevents the mongod or mongos from writing potentially sensitive data
stored on the database to the diagnostic log.
https://mongo-db.ru/reference/configuration-options/index.html#mongodb-setting-security.redactClientLogData ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter, should be valid JSON object string ||
|#

## Oplog {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Oplog}

#|
||Field | Description ||
|| max_size_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Oplog maxsize in percents. ||
|| min_retention_hours | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour. ||
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
|| set_parameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.SetParameter)**

`setParameter` section of mongos configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.AuditLog)**

`AuditLog` section of mongos configuration. ||
|| chunk_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

`ChunkSize` parameter of mongos configuration. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network}

#|
||Field | Description ||
|| max_incoming_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections that mongos will accept.

Acceptable values are 10 to 32768, inclusive. ||
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

The number of elements must be in the range 1-3.

- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib) compression.
- `ZSTD`: The [zstd](https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd) compression.
- `DISABLED`: No compression ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.SetParameter}

#|
||Field | Description ||
|| audit_authorization_success | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables the auditing of authorization successes
https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess ||
|| read_hedging_mode | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Specifies whether mongos supports hedged reads for those read operations whose read preference have enabled the hedged read option. ||
|| sharding_task_executor_pool_max_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance. ||
|| sharding_task_executor_pool_max_connecting | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum number of simultaneous initiating connections (including pending connections in setup/refresh state) each TaskExecutor connection pool can have to a mongod instance. ||
|| sharding_task_executor_pool_min_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance. ||
|| sharding_task_executor_pool_replica_set_matching | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

On a mongos instance, this parameter sets the policy that determines the minimum size limit of its connection pools to nodes within replica sets. ||
|| sharding_task_executor_pool_host_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time that mongos goes without communication to a host before mongos drops all connections to the host. ||
|| sharding_task_executor_pool_refresh_requirement_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time the mongos waits before attempting to heartbeat an idle connection in the pool. ||
|| sharding_task_executor_pool_refresh_timeout_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Maximum time the mongos waits for a heartbeat before timing out the heartbeat. ||
|| warm_min_connections_in_sharding_task_executor_pool_on_startup | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Configures a mongos instance to prewarm its connection pool on startup. ||
|| warm_min_connections_in_sharding_task_executor_pool_on_startup_wait_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the timeout threshold in milliseconds for a mongos to wait for ShardingTaskExecutorPoolMinSize connections to be established per shard host when using the warmMinConnectionsInShardingTaskExecutorPoolOnStartup parameter. ||
|| sharding_task_executor_pool_max_size_for_config_servers | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Optional override for ShardingTaskExecutorPoolMaxSize to set the maximum number of outbound connections each TaskExecutor connection pool can open to a configuration server. ||
|| sharding_task_executor_pool_min_size_for_config_servers | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Optional override for ShardingTaskExecutorPoolMinSize to set the minimum number of outbound connections each TaskExecutor connection pool can open to a configuration server. ||
|| redact_client_log_data | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables redacting any message accompanying a given log event before logging.
This prevents the mongod or mongos from writing potentially sensitive data
stored on the database to the diagnostic log.
https://mongo-db.ru/reference/configuration-options/index.html#mongodb-setting-security.redactClientLogData ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter, should be valid JSON object string ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.MongodbSpec.MongoInfra}

#|
||Field | Description ||
|| config_mongos | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)**

Configuration for mongos of mongoinfra hosts. ||
|| config_mongocfg | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)**

Configuration for mongocfg of mongoinfra hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to each mongoinfra (mongos+mongocfg) host. ||
|| disk_size_autoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## AutoCompactConfig {#yandex.cloud.mdb.mongodb.v1.AutoCompactConfig}

#|
||Field | Description ||
|| enabled | **bool**

Enable autocompact. ||
|| target_free_space | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Minimum estimated amount of space to be freed by compact operation to run. ||
|| bloat_percent | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Minimum percentage of bloat of collection to be compacted. ||
|| compaction_type | enum **CompactionType**

Type of compaction. Either switch primary to run compaction on all hosts or ignore primary host.

- `COMPACTION_TYPE_IGNORE_PRIMARY`
- `COMPACTION_TYPE_SWITCH_PRIMARY` ||
|#

## DatabaseSpec {#yandex.cloud.mdb.mongodb.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the MongoDB database. 1-63 characters long.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## UserSpec {#yandex.cloud.mdb.mongodb.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the MongoDB user.

The maximum string length in characters is 63. Value must match the regular expression ` ^[a-zA-Z0-9_][a-zA-Z0-9_@.-]*$ `. ||
|| password | **string**

Password of the MongoDB user.

The maximum string length in characters is 128. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mongodb.v1.Permission)**

Set of permissions to grant to the user. ||
|#

## Permission {#yandex.cloud.mdb.mongodb.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **string**

MongoDB roles for the `database_name` database that the permission grants. ||
|#

## HostSpec {#yandex.cloud.mdb.mongodb.v1.HostSpec}

#|
||Field | Description ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](../../../../compute/api-ref/grpc/Zone/list.md#List) request.

The maximum string length in characters is 50. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The network ID is set in the [Cluster.network_id](../../../../managed-mongodb/api-ref/grpc/Cluster/get#yandex.cloud.mdb.mongodb.v1.Cluster) field.

The maximum string length in characters is 50. ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.
After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.
Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| type | enum **Type**

Type of the host to be deployed.

- `MONGOD`: A mongod host.
- `MONGOS`: A mongos host.
- `MONGOCFG`: A mongocfg host.
- `MONGOINFRA`: A mongoinfra (mongos+mongocfg) host. ||
|| shard_name | **string**

Name of the shard that the host belongs to.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Is host hidden in replSet ||
|| secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds "behind" the primary that this replica set member should "lag" ||
|| priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Priority of host for the election in replSet ||
|| tags | **object** (map<**string**, **string**>)

Host tags ||
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

- `MON`: Monday.
- `TUE`: Tuesday.
- `WED`: Wednesday.
- `THU`: Thursday.
- `FRI`: Friday.
- `SAT`: Saturday.
- `SUN`: Sunday. ||
|| hour | **int64**

Hour of the day in UTC (in `HH` format).

Acceptable values are 1 to 24, inclusive. ||
|#

## BackupRetentionPolicySpec {#yandex.cloud.mdb.v1.BackupRetentionPolicySpec}

Message to describe a new retention policy for cluster backups.

#|
||Field | Description ||
|| policy_name | **string**

Required field. Required. Policy name. ||
|| cron | **[CronTab](#yandex.cloud.mdb.v1.CronTab)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Human-readable description. ||
|#

## CronTab {#yandex.cloud.mdb.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| day_of_month | **string**

Day of month in cron format. Valid values: 1-31, *, ranges (1-15), steps (*/2, 1-15/3), lists (1,15,28).
Defaults to "*". ||
|| month | **string**

Month in cron format. Valid values: 1-12, *, ranges (1-6), steps (*/3), lists (1,6,12).
Defaults to "*". ||
|| day_of_week | **string**

Day of week in cron format. Valid values: 0-7 (0 and 7 both mean Sunday), *, ranges (1-5), steps (0-6/2), lists (1,3,5).
Defaults to "*". ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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