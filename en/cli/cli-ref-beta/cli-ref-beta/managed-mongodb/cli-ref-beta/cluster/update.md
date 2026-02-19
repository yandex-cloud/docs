---
editable: false
noIndex: true
---

# yc beta managed-mongodb cluster update

Updates the specified MongoDB cluster.

#### Command Usage

Syntax:

`yc beta managed-mongodb cluster update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the MongoDB Cluster resource to update. To get the MongoDB cluster ID use a [ClusterService.List] request. ||
|| `--config-spec` | `shorthand/json`

New configuration and resources for hosts in the cluster.

Shorthand Syntax:

```hcl
{
  access = {
    data-lens = boolean,
    data-transfer = boolean,
    web-sql = boolean
  },
  backup-retain-period-days = integer,
  backup-window-start = timeofday,
  feature-compatibility-version = string,
  mongodb = {
    mongocfg = {
      config = {
        audit-log = {
          filter = string
        },
        chaining-allowed = boolean,
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        oplog = {
          max-size-percent = integer,
          min-retention-hours = float64
        },
        set-parameter = {
          audit-authorization-success = boolean,
          enable-flow-control = boolean
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size = float64,
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = string,
          runtime-configuration = boolean
        },
        chaining-allowed = boolean,
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        oplog = {
          max-size-percent = integer,
          min-retention-hours = float64
        },
        security = {
          enable-encryption = boolean,
          kmip = {
            client-certificate = string,
            key-identifier = string,
            port = integer,
            server-ca = string,
            server-name = string
          }
        },
        set-parameter = {
          audit-authorization-success = boolean,
          enable-flow-control = boolean,
          flow-control-target-lag-seconds = integer,
          flow-control-warn-threshold-seconds = integer,
          migrate-clone-insertion-batch-delay-ms = integer,
          migrate-clone-insertion-batch-size = integer,
          min-snapshot-history-window-in-seconds = integer,
          mirror-reads = {
            max-time-ms = integer,
            sampling-rate = float64
          },
          orphan-cleanup-delay-secs = integer,
          persisted-chunk-cache-update-max-batch-size = integer,
          range-deleter-batch-delay-ms = integer,
          range-deleter-batch-size = integer
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size = float64,
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        audit-log = {
          filter = string
        },
        chaining-allowed = boolean,
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        oplog = {
          max-size-percent = integer,
          min-retention-hours = float64
        },
        set-parameter = {
          audit-authorization-success = boolean,
          enable-flow-control = boolean
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size = float64,
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        audit-log = {
          filter = string
        },
        chunk-size = integer,
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        set-parameter = {
          audit-authorization-success = boolean,
          read-hedging-mode = string,
          sharding-task-executor-pool-host-timeout-ms = integer,
          sharding-task-executor-pool-max-connecting = integer,
          sharding-task-executor-pool-max-size = integer,
          sharding-task-executor-pool-max-size-for-config-servers = integer,
          sharding-task-executor-pool-min-size = integer,
          sharding-task-executor-pool-min-size-for-config-servers = integer,
          sharding-task-executor-pool-refresh-requirement-ms = integer,
          sharding-task-executor-pool-refresh-timeout-ms = integer,
          sharding-task-executor-pool-replica-set-matching = string,
          warm-min-connections-in-sharding-task-executor-pool-on-startup = boolean,
          warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        audit-log = {
          filter = string
        },
        chunk-size = integer,
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        set-parameter = {
          audit-authorization-success = boolean,
          read-hedging-mode = string,
          sharding-task-executor-pool-host-timeout-ms = integer,
          sharding-task-executor-pool-max-connecting = integer,
          sharding-task-executor-pool-max-size = integer,
          sharding-task-executor-pool-max-size-for-config-servers = integer,
          sharding-task-executor-pool-min-size = integer,
          sharding-task-executor-pool-min-size-for-config-servers = integer,
          sharding-task-executor-pool-refresh-requirement-ms = integer,
          sharding-task-executor-pool-refresh-timeout-ms = integer,
          sharding-task-executor-pool-replica-set-matching = string,
          warm-min-connections-in-sharding-task-executor-pool-on-startup = boolean,
          warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  },
  mongodb-spec = mongodb-spec-3-6={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          journal = {
            commit-interval = integer,
            enabled = boolean
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB
            },
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-4-0={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB
            },
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-4-2={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        set-parameter = {
          enable-flow-control = boolean
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-4-4={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        set-parameter = {
          enable-flow-control = boolean
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-4-4-enterprise={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = string
        },
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        security = {
          enable-encryption = boolean,
          kmip = {
            client-certificate = string,
            key-identifier = string,
            port = integer,
            server-ca = string,
            server-name = string
          }
        },
        set-parameter = {
          audit-authorization-success = boolean,
          enable-flow-control = boolean
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-5-0={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        set-parameter = {
          enable-flow-control = boolean,
          min-snapshot-history-window-in-seconds = integer
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-5-0-enterprise={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = string,
          runtime-configuration = boolean
        },
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        security = {
          enable-encryption = boolean,
          kmip = {
            client-certificate = string,
            key-identifier = string,
            port = integer,
            server-ca = string,
            server-name = string
          }
        },
        set-parameter = {
          audit-authorization-success = boolean,
          enable-flow-control = boolean,
          min-snapshot-history-window-in-seconds = integer
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-6-0={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        set-parameter = {
          enable-flow-control = boolean,
          min-snapshot-history-window-in-seconds = integer
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  } | mongodb-spec-6-0-enterprise={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = string,
          runtime-configuration = boolean
        },
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = float64,
          slow-op-threshold = integer
        },
        security = {
          enable-encryption = boolean,
          kmip = {
            client-certificate = string,
            key-identifier = string,
            port = integer,
            server-ca = string,
            server-name = string
          }
        },
        set-parameter = {
          audit-authorization-success = boolean,
          enable-flow-control = boolean,
          min-snapshot-history-window-in-seconds = integer
        },
        storage = {
          journal = {
            commit-interval = integer
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = float64
            },
            index-config = {
              prefix-compression = boolean
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = integer
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = integer
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = float64
            }
          }
        }
      },
      config-mongos = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    },
    mongos = {
      config = {
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = integer
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = integer,
        emergency-usage-threshold = integer,
        planned-usage-threshold = integer
      },
      resources = {
        disk-size = integer,
        disk-type-id = string,
        resource-preset-id = string
      }
    }
  },
  performance-diagnostics = {
    profiling-enabled = boolean
  },
  version = string
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "boolean",
    "data-transfer": "boolean",
    "web-sql": "boolean"
  },
  "backup-retain-period-days": "integer",
  "backup-window-start": "timeofday",
  "feature-compatibility-version": "string",
  "mongodb": {
    "mongocfg": {
      "config": {
        "audit-log": {
          "filter": "string"
        },
        "chaining-allowed": "boolean",
        "net": {
          "max-incoming-connections": "integer"
        },
        "operation-profiling": {
          "mode": "OFF|SLOW_OP|ALL",
          "slow-op-threshold": "integer"
        },
        "oplog": {
          "max-size-percent": "integer",
          "min-retention-hours": "float64"
        },
        "set-parameter": {
          "audit-authorization-success": "boolean",
          "enable-flow-control": "boolean"
        },
        "storage": {
          "wired-tiger": {
            "engine-config": {
              "cache-size": "float64",
              "cache-size-gb": "float64"
            }
          }
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "integer",
        "emergency-usage-threshold": "integer",
        "planned-usage-threshold": "integer"
      },
      "resources": {
        "disk-size": "integer",
        "disk-type-id": "string",
        "resource-preset-id": "string"
      }
    },
    "mongod": {
      "config": {
        "audit-log": {
          "filter": "string",
          "runtime-configuration": "boolean"
        },
        "chaining-allowed": "boolean",
        "net": {
          "compression": {
            "compressors": [
              "SNAPPY|ZLIB|ZSTD|DISABLED", ...
            ]
          },
          "max-incoming-connections": "integer"
        },
        "operation-profiling": {
          "mode": "OFF|SLOW_OP|ALL",
          "slow-op-sample-rate": "float64",
          "slow-op-threshold": "integer"
        },
        "oplog": {
          "max-size-percent": "integer",
          "min-retention-hours": "float64"
        },
        "security": {
          "enable-encryption": "boolean",
          "kmip": {
            "client-certificate": "string",
            "key-identifier": "string",
            "port": "integer",
            "server-ca": "string",
            "server-name": "string"
          }
        },
        "set-parameter": {
          "audit-authorization-success": "boolean",
          "enable-flow-control": "boolean",
          "flow-control-target-lag-seconds": "integer",
          "flow-control-warn-threshold-seconds": "integer",
          "migrate-clone-insertion-batch-delay-ms": "integer",
          "migrate-clone-insertion-batch-size": "integer",
          "min-snapshot-history-window-in-seconds": "integer",
          "mirror-reads": {
            "max-time-ms": "integer",
            "sampling-rate": "float64"
          },
          "orphan-cleanup-delay-secs": "integer",
          "persisted-chunk-cache-update-max-batch-size": "integer",
          "range-deleter-batch-delay-ms": "integer",
          "range-deleter-batch-size": "integer"
        },
        "storage": {
          "journal": {
            "commit-interval": "integer"
          },
          "wired-tiger": {
            "collection-config": {
              "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
            },
            "engine-config": {
              "cache-size": "float64",
              "cache-size-gb": "float64"
            },
            "index-config": {
              "prefix-compression": "boolean"
            }
          }
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "integer",
        "emergency-usage-threshold": "integer",
        "planned-usage-threshold": "integer"
      },
      "resources": {
        "disk-size": "integer",
        "disk-type-id": "string",
        "resource-preset-id": "string"
      }
    },
    "mongoinfra": {
      "config-mongocfg": {
        "audit-log": {
          "filter": "string"
        },
        "chaining-allowed": "boolean",
        "net": {
          "max-incoming-connections": "integer"
        },
        "operation-profiling": {
          "mode": "OFF|SLOW_OP|ALL",
          "slow-op-threshold": "integer"
        },
        "oplog": {
          "max-size-percent": "integer",
          "min-retention-hours": "float64"
        },
        "set-parameter": {
          "audit-authorization-success": "boolean",
          "enable-flow-control": "boolean"
        },
        "storage": {
          "wired-tiger": {
            "engine-config": {
              "cache-size": "float64",
              "cache-size-gb": "float64"
            }
          }
        }
      },
      "config-mongos": {
        "audit-log": {
          "filter": "string"
        },
        "chunk-size": "integer",
        "net": {
          "compression": {
            "compressors": [
              "SNAPPY|ZLIB|ZSTD|DISABLED", ...
            ]
          },
          "max-incoming-connections": "integer"
        },
        "set-parameter": {
          "audit-authorization-success": "boolean",
          "read-hedging-mode": "string",
          "sharding-task-executor-pool-host-timeout-ms": "integer",
          "sharding-task-executor-pool-max-connecting": "integer",
          "sharding-task-executor-pool-max-size": "integer",
          "sharding-task-executor-pool-max-size-for-config-servers": "integer",
          "sharding-task-executor-pool-min-size": "integer",
          "sharding-task-executor-pool-min-size-for-config-servers": "integer",
          "sharding-task-executor-pool-refresh-requirement-ms": "integer",
          "sharding-task-executor-pool-refresh-timeout-ms": "integer",
          "sharding-task-executor-pool-replica-set-matching": "string",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup": "boolean",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms": "integer"
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "integer",
        "emergency-usage-threshold": "integer",
        "planned-usage-threshold": "integer"
      },
      "resources": {
        "disk-size": "integer",
        "disk-type-id": "string",
        "resource-preset-id": "string"
      }
    },
    "mongos": {
      "config": {
        "audit-log": {
          "filter": "string"
        },
        "chunk-size": "integer",
        "net": {
          "compression": {
            "compressors": [
              "SNAPPY|ZLIB|ZSTD|DISABLED", ...
            ]
          },
          "max-incoming-connections": "integer"
        },
        "set-parameter": {
          "audit-authorization-success": "boolean",
          "read-hedging-mode": "string",
          "sharding-task-executor-pool-host-timeout-ms": "integer",
          "sharding-task-executor-pool-max-connecting": "integer",
          "sharding-task-executor-pool-max-size": "integer",
          "sharding-task-executor-pool-max-size-for-config-servers": "integer",
          "sharding-task-executor-pool-min-size": "integer",
          "sharding-task-executor-pool-min-size-for-config-servers": "integer",
          "sharding-task-executor-pool-refresh-requirement-ms": "integer",
          "sharding-task-executor-pool-refresh-timeout-ms": "integer",
          "sharding-task-executor-pool-replica-set-matching": "string",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup": "boolean",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms": "integer"
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "integer",
        "emergency-usage-threshold": "integer",
        "planned-usage-threshold": "integer"
      },
      "resources": {
        "disk-size": "integer",
        "disk-type-id": "string",
        "resource-preset-id": "string"
      }
    }
  },
  "mongodb-spec": {
    "mongodb-spec-3-6": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer",
              "enabled": "boolean"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-4-0": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-4-2": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "set-parameter": {
            "enable-flow-control": "boolean"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-4-4": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "set-parameter": {
            "enable-flow-control": "boolean"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-4-4-enterprise": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "audit-log": {
            "filter": "string"
          },
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "security": {
            "enable-encryption": "boolean",
            "kmip": {
              "client-certificate": "string",
              "key-identifier": "string",
              "port": "integer",
              "server-ca": "string",
              "server-name": "string"
            }
          },
          "set-parameter": {
            "audit-authorization-success": "boolean",
            "enable-flow-control": "boolean"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-5-0": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "set-parameter": {
            "enable-flow-control": "boolean",
            "min-snapshot-history-window-in-seconds": "integer"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-5-0-enterprise": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "audit-log": {
            "filter": "string",
            "runtime-configuration": "boolean"
          },
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "security": {
            "enable-encryption": "boolean",
            "kmip": {
              "client-certificate": "string",
              "key-identifier": "string",
              "port": "integer",
              "server-ca": "string",
              "server-name": "string"
            }
          },
          "set-parameter": {
            "audit-authorization-success": "boolean",
            "enable-flow-control": "boolean",
            "min-snapshot-history-window-in-seconds": "integer"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-6-0": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "set-parameter": {
            "enable-flow-control": "boolean",
            "min-snapshot-history-window-in-seconds": "integer"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    },
    "mongodb-spec-6-0-enterprise": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongod": {
        "config": {
          "audit-log": {
            "filter": "string",
            "runtime-configuration": "boolean"
          },
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "float64",
            "slow-op-threshold": "integer"
          },
          "security": {
            "enable-encryption": "boolean",
            "kmip": {
              "client-certificate": "string",
              "key-identifier": "string",
              "port": "integer",
              "server-ca": "string",
              "server-name": "string"
            }
          },
          "set-parameter": {
            "audit-authorization-success": "boolean",
            "enable-flow-control": "boolean",
            "min-snapshot-history-window-in-seconds": "integer"
          },
          "storage": {
            "journal": {
              "commit-interval": "integer"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "float64"
              },
              "index-config": {
                "prefix-compression": "boolean"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "integer"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "integer"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "float64"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "integer"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "integer",
          "emergency-usage-threshold": "integer",
          "planned-usage-threshold": "integer"
        },
        "resources": {
          "disk-size": "integer",
          "disk-type-id": "string",
          "resource-preset-id": "string"
        }
      }
    }
  },
  "performance-diagnostics": {
    "profiling-enabled": "boolean"
  },
  "version": "string"
}
```

Fields:

```
access -> (struct)
  Access policy to DB
  data-lens -> (boolean)
    Allow access for DataLens.
  data-transfer -> (boolean)
    Allow access for DataTransfer.
  web-sql -> (boolean)
    Allow access for Web SQL.
backup-retain-period-days -> (integer)
  Retain period of automatically created backup in days
backup-window-start -> (timeofday)
  Time to start the daily backup, in the UTC timezone.
feature-compatibility-version -> (string)
  MongoDB feature compatibility version. See usage details in MongoDB documentation. Possible values: * '3.6' - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older. * '4.0' - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older. * '4.2' - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older. * '4.4' - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or older. * '5.0' - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 4.4 or older. * '6.0' - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 5.0 or older.
mongodb -> (struct)
  Configuration and resource allocation for a MongoDB 7.0 Enterprise cluster.
  mongocfg -> (struct)
    Configuration and resource allocation for mongocfg hosts.
    config -> (struct)
      Configuration for mongocfg hosts.
      audit-log -> (struct)
        'AuditLog' section of mongocfg configuration.
        filter -> (string)
          Audit filter, should be valid JSON object string
      chaining-allowed -> (boolean)
        Chained replication setting
      net -> (struct)
        'net' section of mongocfg configuration.
        max-incoming-connections -> (integer)
          The maximum number of simultaneous connections that mongocfg will accept.
      operation-profiling -> (struct)
        'operationProfiling' section of mongocfg configuration.
        mode -> (struct)
          Mode which specifies operations that should be profiled.
        slow-op-threshold -> (integer)
          The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
      oplog -> (struct)
        'Oplog' section of mongod configuration.
        max-size-percent -> (integer)
          Oplog maxsize in percents.
        min-retention-hours -> (float64)
          The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour.
      set-parameter -> (struct)
        'setParameter' section of mongocfg configuration.
        audit-authorization-success -> (boolean)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        enable-flow-control -> (boolean)
          Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
      storage -> (struct)
        'storage' section of mongocfg configuration.
        wired-tiger -> (struct)
          Configuration of the WiredTiger storage engine.
          engine-config -> (struct)
            Engine configuration for WiredTiger.
            cache-size -> (float64)
              The maximum size of the internal cache that WiredTiger will use for all data in percents.
            cache-size-gb -> (float64)
              The maximum size of the internal cache that WiredTiger will use for all data.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongocfg host.
      disk-size -> (integer)
        Volume of the storage available to a host, in bytes.
      disk-type-id -> (string)
        Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
      resource-preset-id -> (string)
        ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongod -> (struct)
    Configuration and resource allocation for mongod hosts.
    config -> (struct)
      audit-log -> (struct)
        'AuditLog' section of mongod configuration.
        filter -> (string)
          Audit filter
        runtime-configuration -> (boolean)
          Allows runtime configuration of audit filter and auditAuthorizationSuccess
      chaining-allowed -> (boolean)
        Chained replication setting
      net -> (struct)
        'net' section of mongod configuration.
        compression -> (struct)
          Compression settings
          compressors -> ([]struct)
            Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
        max-incoming-connections -> (integer)
          The maximum number of simultaneous connections that mongod will accept.
      operation-profiling -> (struct)
        'operationProfiling' section of mongod configuration.
        mode -> (struct)
          Mode which specifies operations that should be profiled.
        slow-op-sample-rate -> (float64)
          The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
        slow-op-threshold -> (integer)
          The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
      oplog -> (struct)
        'Oplog' section of mongod configuration.
        max-size-percent -> (integer)
          Oplog maxsize in percents.
        min-retention-hours -> (float64)
          The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour.
      security -> (struct)
        'security' section of mongod configuration.
        enable-encryption -> (boolean)
          If encryption at rest should be enabled or not
        kmip -> (struct)
          'kmip' section of mongod security config
          client-certificate -> (string)
            KMIP client certificate + private key (unencrypted)
          key-identifier -> (string)
            KMIP Key identifier (if any)
          port -> (integer)
            KMIP server port
          server-ca -> (string)
            KMIP Server CA
          server-name -> (string)
            KMIP server name
      set-parameter -> (struct)
        'SetParameter' section of mongod configuration.
        audit-authorization-success -> (boolean)
          Enables the auditing of authorization successes
        enable-flow-control -> (boolean)
          Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        flow-control-target-lag-seconds -> (integer)
          The target maximum majority committed lag when running with flow control
        flow-control-warn-threshold-seconds -> (integer)
          The amount of time to wait to log a warning once the flow control mechanism detects the majority commit point has not moved.
        migrate-clone-insertion-batch-delay-ms -> (integer)
          Time in milliseconds to wait between batches of insertions during cloning step of the migration process.
        migrate-clone-insertion-batch-size -> (integer)
          The maximum number of documents to insert in a single batch during the cloning step of the migration process.
        min-snapshot-history-window-in-seconds -> (integer)
          The minimum time window in seconds for which the storage engine keeps the snapshot history.
        mirror-reads -> (struct)
          Specifies the settings for mirrored reads for the mongod instance
          max-time-ms -> (integer)
            The maximum time in milliseconds for the mirrored reads.
          sampling-rate -> (float64)
            The sampling rate used to mirror a subset of operations that support mirroring.
        orphan-cleanup-delay-secs -> (integer)
          Minimum delay before a migrated chunk is deleted from the source shard.
        persisted-chunk-cache-update-max-batch-size -> (integer)
          Specifies the maximum batch size used for updating the persisted chunk cache.
        range-deleter-batch-delay-ms -> (integer)
          The amount of time in milliseconds to wait before the next batch of deletion during the cleanup stage of chunk migration (or the cleanupOrphaned command).
        range-deleter-batch-size -> (integer)
          The maximum number of documents in each batch to delete during the cleanup stage of chunk migration (or the cleanupOrphaned command).
      storage -> (struct)
        'storage' section of mongod configuration.
        journal -> (struct)
          Configuration of the MongoDB journal.
          commit-interval -> (integer)
            Commit interval between journal operations, in milliseconds. Default: 100.
        wired-tiger -> (struct)
          Configuration of the WiredTiger storage engine.
          collection-config -> (struct)
            Collection configuration for WiredTiger.
            block-compressor -> (struct)
              Default type of compression to use for collection data.
          engine-config -> (struct)
            Engine configuration for WiredTiger.
            cache-size -> (float64)
              The maximum size of the internal cache that WiredTiger will use for all data in percents.
            cache-size-gb -> (float64)
              The maximum size of the internal cache that WiredTiger will use for all data.
          index-config -> (struct)
            Index configuration for WiredTiger
            prefix-compression -> (boolean)
              Enables or disables prefix compression
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongod host.
      disk-size -> (integer)
        Volume of the storage available to a host, in bytes.
      disk-type-id -> (string)
        Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
      resource-preset-id -> (string)
        ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongoinfra -> (struct)
    Configuration and resource allocation for mongoinfra (mongos+mongocfg) hosts.
    config-mongocfg -> (struct)
      audit-log -> (struct)
        'AuditLog' section of mongocfg configuration.
        filter -> (string)
          Audit filter, should be valid JSON object string
      chaining-allowed -> (boolean)
        Chained replication setting
      net -> (struct)
        'net' section of mongocfg configuration.
        max-incoming-connections -> (integer)
          The maximum number of simultaneous connections that mongocfg will accept.
      operation-profiling -> (struct)
        'operationProfiling' section of mongocfg configuration.
        mode -> (struct)
          Mode which specifies operations that should be profiled.
        slow-op-threshold -> (integer)
          The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
      oplog -> (struct)
        'Oplog' section of mongod configuration.
        max-size-percent -> (integer)
          Oplog maxsize in percents.
        min-retention-hours -> (float64)
          The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour.
      set-parameter -> (struct)
        'setParameter' section of mongocfg configuration.
        audit-authorization-success -> (boolean)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        enable-flow-control -> (boolean)
          Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
      storage -> (struct)
        'storage' section of mongocfg configuration.
        wired-tiger -> (struct)
          Configuration of the WiredTiger storage engine.
          engine-config -> (struct)
            Engine configuration for WiredTiger.
            cache-size -> (float64)
              The maximum size of the internal cache that WiredTiger will use for all data in percents.
            cache-size-gb -> (float64)
              The maximum size of the internal cache that WiredTiger will use for all data.
    config-mongos -> (struct)
      Configuration for mongoinfra hosts.
      audit-log -> (struct)
        'AuditLog' section of mongos configuration.
        filter -> (string)
          Audit filter, should be valid JSON object string
      chunk-size -> (integer)
        'ChunkSize' parameter of mongos configuration.
      net -> (struct)
        Network settings for mongos.
        compression -> (struct)
          Compression settings
          compressors -> ([]struct)
            Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
        max-incoming-connections -> (integer)
          The maximum number of simultaneous connections that mongos will accept.
      set-parameter -> (struct)
        'setParameter' section of mongos configuration.
        audit-authorization-success -> (boolean)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        read-hedging-mode -> (string)
          Specifies whether mongos supports hedged reads for those read operations whose read preference have enabled the hedged read option.
        sharding-task-executor-pool-host-timeout-ms -> (integer)
          Maximum time that mongos goes without communication to a host before mongos drops all connections to the host.
        sharding-task-executor-pool-max-connecting -> (integer)
          Maximum number of simultaneous initiating connections (including pending connections in setup/refresh state) each TaskExecutor connection pool can have to a mongod instance.
        sharding-task-executor-pool-max-size -> (integer)
          Maximum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-max-size-for-config-servers -> (integer)
          Optional override for ShardingTaskExecutorPoolMaxSize to set the maximum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-min-size -> (integer)
          Minimum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-min-size-for-config-servers -> (integer)
          Optional override for ShardingTaskExecutorPoolMinSize to set the minimum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-refresh-requirement-ms -> (integer)
          Maximum time the mongos waits before attempting to heartbeat an idle connection in the pool.
        sharding-task-executor-pool-refresh-timeout-ms -> (integer)
          Maximum time the mongos waits for a heartbeat before timing out the heartbeat.
        sharding-task-executor-pool-replica-set-matching -> (string)
          On a mongos instance, this parameter sets the policy that determines the minimum size limit of its connection pools to nodes within replica sets.
        warm-min-connections-in-sharding-task-executor-pool-on-startup -> (boolean)
          Configures a mongos instance to prewarm its connection pool on startup.
        warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms -> (integer)
          Sets the timeout threshold in milliseconds for a mongos to wait for ShardingTaskExecutorPoolMinSize connections to be established per shard host when using the warmMinConnectionsInShardingTaskExecutorPoolOnStartup parameter.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongoinfra (mongos+mongocfg) host.
      disk-size -> (integer)
        Volume of the storage available to a host, in bytes.
      disk-type-id -> (string)
        Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
      resource-preset-id -> (string)
        ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongos -> (struct)
    Configuration and resource allocation for mongos hosts.
    config -> (struct)
      Configuration for mongos hosts.
      audit-log -> (struct)
        'AuditLog' section of mongos configuration.
        filter -> (string)
          Audit filter, should be valid JSON object string
      chunk-size -> (integer)
        'ChunkSize' parameter of mongos configuration.
      net -> (struct)
        Network settings for mongos.
        compression -> (struct)
          Compression settings
          compressors -> ([]struct)
            Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
        max-incoming-connections -> (integer)
          The maximum number of simultaneous connections that mongos will accept.
      set-parameter -> (struct)
        'setParameter' section of mongos configuration.
        audit-authorization-success -> (boolean)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        read-hedging-mode -> (string)
          Specifies whether mongos supports hedged reads for those read operations whose read preference have enabled the hedged read option.
        sharding-task-executor-pool-host-timeout-ms -> (integer)
          Maximum time that mongos goes without communication to a host before mongos drops all connections to the host.
        sharding-task-executor-pool-max-connecting -> (integer)
          Maximum number of simultaneous initiating connections (including pending connections in setup/refresh state) each TaskExecutor connection pool can have to a mongod instance.
        sharding-task-executor-pool-max-size -> (integer)
          Maximum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-max-size-for-config-servers -> (integer)
          Optional override for ShardingTaskExecutorPoolMaxSize to set the maximum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-min-size -> (integer)
          Minimum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-min-size-for-config-servers -> (integer)
          Optional override for ShardingTaskExecutorPoolMinSize to set the minimum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-refresh-requirement-ms -> (integer)
          Maximum time the mongos waits before attempting to heartbeat an idle connection in the pool.
        sharding-task-executor-pool-refresh-timeout-ms -> (integer)
          Maximum time the mongos waits for a heartbeat before timing out the heartbeat.
        sharding-task-executor-pool-replica-set-matching -> (string)
          On a mongos instance, this parameter sets the policy that determines the minimum size limit of its connection pools to nodes within replica sets.
        warm-min-connections-in-sharding-task-executor-pool-on-startup -> (boolean)
          Configures a mongos instance to prewarm its connection pool on startup.
        warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms -> (integer)
          Sets the timeout threshold in milliseconds for a mongos to wait for ShardingTaskExecutorPoolMinSize connections to be established per shard host when using the warmMinConnectionsInShardingTaskExecutorPoolOnStartup parameter.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (integer)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (integer)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (integer)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongos host.
      disk-size -> (integer)
        Volume of the storage available to a host, in bytes.
      disk-type-id -> (string)
        Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
      resource-preset-id -> (string)
        ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
performance-diagnostics -> (struct)
  Performance Diagnosics configuration
  profiling-enabled -> (boolean)
version -> (string)
  Version of MongoDB used in the cluster. Possible values: '3.6', '4.0', '4.2', '4.4', '4.4-enterprise', '5.0', '5.0-enterprise', '6.0', '6.0-enterprise'.
mongodb-spec -> (oneof<mongodb-spec-3-6|mongodb-spec-4-0|mongodb-spec-4-2|mongodb-spec-4-4|mongodb-spec-4-4-enterprise|mongodb-spec-5-0|mongodb-spec-5-0-enterprise|mongodb-spec-6-0|mongodb-spec-6-0-enterprise>)
  Oneof mongodb-spec field
  mongodb-spec-3-6 -> (struct)
    Configuration and resource allocation for a MongoDB 3.6 cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 3.6 hosts.
      config -> (struct)
        Configuration for mongocfg 3.6 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of incoming connections.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Operation profiling level. For details, see MongoDB documentation.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 3.6 hosts.
      config -> (struct)
        Configuration for mongod 3.6 hosts.
        net -> (struct)
          'net' section of mongod configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
            enabled -> (boolean)
              Whether the journal is enabled or disabled. Possible values: * true (default) - the journal is enabled. * false - the journal is disabled.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 3.6 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of incoming connections.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Operation profiling level. For details, see MongoDB documentation.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 3.6 hosts.
        net -> (struct)
          Network settings for mongos.
          max-incoming-connections -> (integer)
            The maximum number of incoming connections.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 3.6 hosts.
      config -> (struct)
        Configuration for mongos 3.6 hosts.
        net -> (struct)
          Network settings for mongos.
          max-incoming-connections -> (integer)
            The maximum number of incoming connections.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-4-0 -> (struct)
    Configuration and resource allocation for a MongoDB 4.0 cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 4.0 hosts.
      config -> (struct)
        Configuration for mongocfg 4.0 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 4.0 hosts.
      config -> (struct)
        Configuration for mongod 4.0 hosts.
        net -> (struct)
          'net' section of mongod configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.0 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.0 hosts.
        net -> (struct)
          Network settings for mongos.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 4.0 hosts.
      config -> (struct)
        Configuration for mongos 4.0 hosts.
        net -> (struct)
          Network settings for mongos.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-4-2 -> (struct)
    Configuration and resource allocation for a MongoDB 4.2 cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 4.2 hosts.
      config -> (struct)
        Configuration for mongocfg 4.2 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 4.2 hosts.
      config -> (struct)
        Configuration for mongod 4.2 hosts.
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'replication' section of mongod configuration.
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.2 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.2 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 4.2 hosts.
      config -> (struct)
        Configuration for mongos 4.2 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-4-4 -> (struct)
    Configuration and resource allocation for a MongoDB 4.4 cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 4.4 hosts.
      config -> (struct)
        Configuration for mongocfg 4.4 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 4.4 hosts.
      config -> (struct)
        Configuration for mongod 4.4 hosts.
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'replication' section of mongod configuration.
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.4 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 4.4 hosts.
      config -> (struct)
        Configuration for mongos 4.4 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-5-0 -> (struct)
    Configuration and resource allocation for a MongoDB 5.0 cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 5.0 hosts.
      config -> (struct)
        Configuration for mongocfg 5.0 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 5.0 hosts.
      config -> (struct)
        Configuration for mongod 5.0 hosts.
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (integer)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 5.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 5.0 hosts.
      config -> (struct)
        Configuration for mongos 5.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-6-0 -> (struct)
    Configuration and resource allocation for a MongoDB 6.0 cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 6.0 hosts.
      config -> (struct)
        Configuration for mongocfg 6.0 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 6.0 hosts.
      config -> (struct)
        Configuration for mongod 6.0 hosts.
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (integer)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 6.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 6.0 hosts.
      config -> (struct)
        Configuration for mongos 6.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-4-4-enterprise -> (struct)
    Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 4.4 hosts.
      config -> (struct)
        Configuration for mongocfg 4.4 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 4.4 hosts.
      config -> (struct)
        Configuration for mongod 4.4 hosts.
        audit-log -> (struct)
          'AuditLog' section of mongod configuration.
          filter -> (string)
            Audit filter
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        security -> (struct)
          'security' section of mongod configuration.
          enable-encryption -> (boolean)
            If encryption at rest should be enabled or not
          kmip -> (struct)
            'kmip' section of mongod security config
            client-certificate -> (string)
              KMIP client certificate + private key (unencrypted)
            key-identifier -> (string)
              KMIP Key identifier (if any)
            port -> (integer)
              KMIP server port
            server-ca -> (string)
              KMIP Server CA
            server-name -> (string)
              KMIP server name
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          audit-authorization-success -> (boolean)
            Enables the auditing of authorization successes
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.4 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 4.4 hosts.
      config -> (struct)
        Configuration for mongos 4.4 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-5-0-enterprise -> (struct)
    Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 5.0 hosts.
      config -> (struct)
        Configuration for mongocfg 5.0 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 5.0 hosts.
      config -> (struct)
        Configuration for mongod 5.0 hosts.
        audit-log -> (struct)
          'AuditLog' section of mongod configuration.
          filter -> (string)
            Audit filter
          runtime-configuration -> (boolean)
            Allows runtime configuration of audit filter and auditAuthorizationSuccess
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        security -> (struct)
          'security' section of mongod configuration.
          enable-encryption -> (boolean)
            If encryption at rest should be enabled or not
          kmip -> (struct)
            'kmip' section of mongod security config
            client-certificate -> (string)
              KMIP client certificate + private key (unencrypted)
            key-identifier -> (string)
              KMIP Key identifier (if any)
            port -> (integer)
              KMIP server port
            server-ca -> (string)
              KMIP Server CA
            server-name -> (string)
              KMIP server name
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          audit-authorization-success -> (boolean)
            Enables the auditing of authorization successes
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (integer)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 5.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 5.0 hosts.
      config -> (struct)
        Configuration for mongos 5.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
  mongodb-spec-6-0-enterprise -> (struct)
    Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster.
    mongocfg -> (struct)
      Configuration and resource allocation for mongocfg 6.0 hosts.
      config -> (struct)
        Configuration for mongocfg 6.0 hosts.
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongod -> (struct)
      Configuration and resource allocation for mongod 6.0 hosts.
      config -> (struct)
        Configuration for mongod 6.0 hosts.
        audit-log -> (struct)
          'AuditLog' section of mongod configuration.
          filter -> (string)
            Audit filter
          runtime-configuration -> (boolean)
            Allows runtime configuration of audit filter and auditAuthorizationSuccess
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (float64)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        security -> (struct)
          'security' section of mongod configuration.
          enable-encryption -> (boolean)
            If encryption at rest should be enabled or not
          kmip -> (struct)
            'kmip' section of mongod security config
            client-certificate -> (string)
              KMIP client certificate + private key (unencrypted)
            key-identifier -> (string)
              KMIP Key identifier (if any)
            port -> (integer)
              KMIP server port
            server-ca -> (string)
              KMIP Server CA
            server-name -> (string)
              KMIP server name
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          audit-authorization-success -> (boolean)
            Enables the auditing of authorization successes
          enable-flow-control -> (boolean)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (integer)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (integer)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (boolean)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongoinfra -> (struct)
      Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts.
      config-mongocfg -> (struct)
        net -> (struct)
          'net' section of mongocfg configuration.
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (integer)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (float64)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 6.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
    mongos -> (struct)
      Configuration and resource allocation for mongos 6.0 hosts.
      config -> (struct)
        Configuration for mongos 6.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (integer)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (integer)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (integer)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (integer)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (integer)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description of the MongoDB cluster. ||
|| `--labels` | `map<string><string>`

Custom labels for the MongoDB cluster as '' key:value '' pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--maintenance-window` | `shorthand/json`

New maintenance window settings for the cluster.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = integer
  }
}
```

JSON Syntax:

```json
{
  "policy": {
    "anytime": {},
    "weekly-maintenance-window": {
      "day": "MON|TUE|WED|THU|FRI|SAT|SUN",
      "hour": "integer"
    }
  }
}
```

Fields:

```
policy -> (oneof<anytime|weekly-maintenance-window>)
  Oneof policy field
  anytime -> (struct)
    Maintenance operation can be scheduled anytime.
  weekly-maintenance-window -> (struct)
    Maintenance operation can be scheduled on a weekly basis.
    day -> (struct)
      Day of the week (in 'DDD' format).
    hour -> (integer)
      Hour of the day in UTC (in 'HH' format).
``` ||
|| `--name` | `string`

New name for the cluster. ||
|| `--network-id` | `string`

ID of the network to move the cluster to. ||
|| `--security-group-ids` | `[]string`

User security groups ||
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