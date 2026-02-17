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
    data-lens = bool,
    data-transfer = bool,
    web-sql = bool
  },
  backup-retain-period-days = int,
  backup-window-start = timeofday,
  feature-compatibility-version = str,
  mongodb = {
    mongocfg = {
      config = {
        audit-log = {
          filter = str
        },
        chaining-allowed = bool,
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        oplog = {
          max-size-percent = int,
          min-retention-hours = double
        },
        set-parameter = {
          audit-authorization-success = bool,
          enable-flow-control = bool
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size = double,
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = str,
          runtime-configuration = bool
        },
        chaining-allowed = bool,
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        oplog = {
          max-size-percent = int,
          min-retention-hours = double
        },
        security = {
          enable-encryption = bool,
          kmip = {
            client-certificate = str,
            key-identifier = str,
            port = int,
            server-ca = str,
            server-name = str
          }
        },
        set-parameter = {
          audit-authorization-success = bool,
          enable-flow-control = bool,
          flow-control-target-lag-seconds = int,
          flow-control-warn-threshold-seconds = int,
          migrate-clone-insertion-batch-delay-ms = int,
          migrate-clone-insertion-batch-size = int,
          min-snapshot-history-window-in-seconds = int,
          mirror-reads = {
            max-time-ms = int,
            sampling-rate = double
          },
          orphan-cleanup-delay-secs = int,
          persisted-chunk-cache-update-max-batch-size = int,
          range-deleter-batch-delay-ms = int,
          range-deleter-batch-size = int
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size = double,
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        audit-log = {
          filter = str
        },
        chaining-allowed = bool,
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        oplog = {
          max-size-percent = int,
          min-retention-hours = double
        },
        set-parameter = {
          audit-authorization-success = bool,
          enable-flow-control = bool
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size = double,
              cache-size-gb = double
            }
          }
        }
      },
      config-mongos = {
        audit-log = {
          filter = str
        },
        chunk-size = int,
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = int
        },
        set-parameter = {
          audit-authorization-success = bool,
          read-hedging-mode = str,
          sharding-task-executor-pool-host-timeout-ms = int,
          sharding-task-executor-pool-max-connecting = int,
          sharding-task-executor-pool-max-size = int,
          sharding-task-executor-pool-max-size-for-config-servers = int,
          sharding-task-executor-pool-min-size = int,
          sharding-task-executor-pool-min-size-for-config-servers = int,
          sharding-task-executor-pool-refresh-requirement-ms = int,
          sharding-task-executor-pool-refresh-timeout-ms = int,
          sharding-task-executor-pool-replica-set-matching = str,
          warm-min-connections-in-sharding-task-executor-pool-on-startup = bool,
          warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongos = {
      config = {
        audit-log = {
          filter = str
        },
        chunk-size = int,
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = int
        },
        set-parameter = {
          audit-authorization-success = bool,
          read-hedging-mode = str,
          sharding-task-executor-pool-host-timeout-ms = int,
          sharding-task-executor-pool-max-connecting = int,
          sharding-task-executor-pool-max-size = int,
          sharding-task-executor-pool-max-size-for-config-servers = int,
          sharding-task-executor-pool-min-size = int,
          sharding-task-executor-pool-min-size-for-config-servers = int,
          sharding-task-executor-pool-refresh-requirement-ms = int,
          sharding-task-executor-pool-refresh-timeout-ms = int,
          sharding-task-executor-pool-replica-set-matching = str,
          warm-min-connections-in-sharding-task-executor-pool-on-startup = bool,
          warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  },
  mongodb-spec = mongodb-spec-3-6={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongod = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          journal = {
            commit-interval = int,
            enabled = bool
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB
            },
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      config-mongos = {
        net = {
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongos = {
      config = {
        net = {
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-4-0={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongod = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB
            },
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      config-mongos = {
        net = {
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongos = {
      config = {
        net = {
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-4-2={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        set-parameter = {
          enable-flow-control = bool
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-4-4={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        set-parameter = {
          enable-flow-control = bool
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-4-4-enterprise={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = str
        },
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        security = {
          enable-encryption = bool,
          kmip = {
            client-certificate = str,
            key-identifier = str,
            port = int,
            server-ca = str,
            server-name = str
          }
        },
        set-parameter = {
          audit-authorization-success = bool,
          enable-flow-control = bool
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-5-0={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        set-parameter = {
          enable-flow-control = bool,
          min-snapshot-history-window-in-seconds = int
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-5-0-enterprise={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = str,
          runtime-configuration = bool
        },
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        security = {
          enable-encryption = bool,
          kmip = {
            client-certificate = str,
            key-identifier = str,
            port = int,
            server-ca = str,
            server-name = str
          }
        },
        set-parameter = {
          audit-authorization-success = bool,
          enable-flow-control = bool,
          min-snapshot-history-window-in-seconds = int
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-6-0={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        set-parameter = {
          enable-flow-control = bool,
          min-snapshot-history-window-in-seconds = int
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  } | mongodb-spec-6-0-enterprise={
    mongocfg = {
      config = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongod = {
      config = {
        audit-log = {
          filter = str,
          runtime-configuration = bool
        },
        net = {
          compression = {
            compressors = [
              SNAPPY|ZLIB|ZSTD|DISABLED, ...
            ]
          },
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-sample-rate = double,
          slow-op-threshold = int
        },
        security = {
          enable-encryption = bool,
          kmip = {
            client-certificate = str,
            key-identifier = str,
            port = int,
            server-ca = str,
            server-name = str
          }
        },
        set-parameter = {
          audit-authorization-success = bool,
          enable-flow-control = bool,
          min-snapshot-history-window-in-seconds = int
        },
        storage = {
          journal = {
            commit-interval = int
          },
          wired-tiger = {
            collection-config = {
              block-compressor = NONE|SNAPPY|ZLIB|ZSTD
            },
            engine-config = {
              cache-size-gb = double
            },
            index-config = {
              prefix-compression = bool
            }
          }
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    },
    mongoinfra = {
      config-mongocfg = {
        net = {
          max-incoming-connections = int
        },
        operation-profiling = {
          mode = OFF|SLOW_OP|ALL,
          slow-op-threshold = int
        },
        storage = {
          wired-tiger = {
            engine-config = {
              cache-size-gb = double
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
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
          max-incoming-connections = int
        }
      },
      disk-size-autoscaling = {
        disk-size-limit = int,
        emergency-usage-threshold = int,
        planned-usage-threshold = int
      },
      resources = {
        disk-size = int,
        disk-type-id = str,
        resource-preset-id = str
      }
    }
  },
  performance-diagnostics = {
    profiling-enabled = bool
  },
  version = str
}
```

JSON Syntax:

```json
{
  "access": {
    "data-lens": "bool",
    "data-transfer": "bool",
    "web-sql": "bool"
  },
  "backup-retain-period-days": "int",
  "backup-window-start": "timeofday",
  "feature-compatibility-version": "str",
  "mongodb": {
    "mongocfg": {
      "config": {
        "audit-log": {
          "filter": "str"
        },
        "chaining-allowed": "bool",
        "net": {
          "max-incoming-connections": "int"
        },
        "operation-profiling": {
          "mode": "OFF|SLOW_OP|ALL",
          "slow-op-threshold": "int"
        },
        "oplog": {
          "max-size-percent": "int",
          "min-retention-hours": "double"
        },
        "set-parameter": {
          "audit-authorization-success": "bool",
          "enable-flow-control": "bool"
        },
        "storage": {
          "wired-tiger": {
            "engine-config": {
              "cache-size": "double",
              "cache-size-gb": "double"
            }
          }
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "int",
        "emergency-usage-threshold": "int",
        "planned-usage-threshold": "int"
      },
      "resources": {
        "disk-size": "int",
        "disk-type-id": "str",
        "resource-preset-id": "str"
      }
    },
    "mongod": {
      "config": {
        "audit-log": {
          "filter": "str",
          "runtime-configuration": "bool"
        },
        "chaining-allowed": "bool",
        "net": {
          "compression": {
            "compressors": [
              "SNAPPY|ZLIB|ZSTD|DISABLED", ...
            ]
          },
          "max-incoming-connections": "int"
        },
        "operation-profiling": {
          "mode": "OFF|SLOW_OP|ALL",
          "slow-op-sample-rate": "double",
          "slow-op-threshold": "int"
        },
        "oplog": {
          "max-size-percent": "int",
          "min-retention-hours": "double"
        },
        "security": {
          "enable-encryption": "bool",
          "kmip": {
            "client-certificate": "str",
            "key-identifier": "str",
            "port": "int",
            "server-ca": "str",
            "server-name": "str"
          }
        },
        "set-parameter": {
          "audit-authorization-success": "bool",
          "enable-flow-control": "bool",
          "flow-control-target-lag-seconds": "int",
          "flow-control-warn-threshold-seconds": "int",
          "migrate-clone-insertion-batch-delay-ms": "int",
          "migrate-clone-insertion-batch-size": "int",
          "min-snapshot-history-window-in-seconds": "int",
          "mirror-reads": {
            "max-time-ms": "int",
            "sampling-rate": "double"
          },
          "orphan-cleanup-delay-secs": "int",
          "persisted-chunk-cache-update-max-batch-size": "int",
          "range-deleter-batch-delay-ms": "int",
          "range-deleter-batch-size": "int"
        },
        "storage": {
          "journal": {
            "commit-interval": "int"
          },
          "wired-tiger": {
            "collection-config": {
              "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
            },
            "engine-config": {
              "cache-size": "double",
              "cache-size-gb": "double"
            },
            "index-config": {
              "prefix-compression": "bool"
            }
          }
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "int",
        "emergency-usage-threshold": "int",
        "planned-usage-threshold": "int"
      },
      "resources": {
        "disk-size": "int",
        "disk-type-id": "str",
        "resource-preset-id": "str"
      }
    },
    "mongoinfra": {
      "config-mongocfg": {
        "audit-log": {
          "filter": "str"
        },
        "chaining-allowed": "bool",
        "net": {
          "max-incoming-connections": "int"
        },
        "operation-profiling": {
          "mode": "OFF|SLOW_OP|ALL",
          "slow-op-threshold": "int"
        },
        "oplog": {
          "max-size-percent": "int",
          "min-retention-hours": "double"
        },
        "set-parameter": {
          "audit-authorization-success": "bool",
          "enable-flow-control": "bool"
        },
        "storage": {
          "wired-tiger": {
            "engine-config": {
              "cache-size": "double",
              "cache-size-gb": "double"
            }
          }
        }
      },
      "config-mongos": {
        "audit-log": {
          "filter": "str"
        },
        "chunk-size": "int",
        "net": {
          "compression": {
            "compressors": [
              "SNAPPY|ZLIB|ZSTD|DISABLED", ...
            ]
          },
          "max-incoming-connections": "int"
        },
        "set-parameter": {
          "audit-authorization-success": "bool",
          "read-hedging-mode": "str",
          "sharding-task-executor-pool-host-timeout-ms": "int",
          "sharding-task-executor-pool-max-connecting": "int",
          "sharding-task-executor-pool-max-size": "int",
          "sharding-task-executor-pool-max-size-for-config-servers": "int",
          "sharding-task-executor-pool-min-size": "int",
          "sharding-task-executor-pool-min-size-for-config-servers": "int",
          "sharding-task-executor-pool-refresh-requirement-ms": "int",
          "sharding-task-executor-pool-refresh-timeout-ms": "int",
          "sharding-task-executor-pool-replica-set-matching": "str",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup": "bool",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms": "int"
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "int",
        "emergency-usage-threshold": "int",
        "planned-usage-threshold": "int"
      },
      "resources": {
        "disk-size": "int",
        "disk-type-id": "str",
        "resource-preset-id": "str"
      }
    },
    "mongos": {
      "config": {
        "audit-log": {
          "filter": "str"
        },
        "chunk-size": "int",
        "net": {
          "compression": {
            "compressors": [
              "SNAPPY|ZLIB|ZSTD|DISABLED", ...
            ]
          },
          "max-incoming-connections": "int"
        },
        "set-parameter": {
          "audit-authorization-success": "bool",
          "read-hedging-mode": "str",
          "sharding-task-executor-pool-host-timeout-ms": "int",
          "sharding-task-executor-pool-max-connecting": "int",
          "sharding-task-executor-pool-max-size": "int",
          "sharding-task-executor-pool-max-size-for-config-servers": "int",
          "sharding-task-executor-pool-min-size": "int",
          "sharding-task-executor-pool-min-size-for-config-servers": "int",
          "sharding-task-executor-pool-refresh-requirement-ms": "int",
          "sharding-task-executor-pool-refresh-timeout-ms": "int",
          "sharding-task-executor-pool-replica-set-matching": "str",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup": "bool",
          "warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms": "int"
        }
      },
      "disk-size-autoscaling": {
        "disk-size-limit": "int",
        "emergency-usage-threshold": "int",
        "planned-usage-threshold": "int"
      },
      "resources": {
        "disk-size": "int",
        "disk-type-id": "str",
        "resource-preset-id": "str"
      }
    }
  },
  "mongodb-spec": {
    "mongodb-spec-3-6": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "journal": {
              "commit-interval": "int",
              "enabled": "bool"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB"
              },
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-4-0": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongod": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB"
              },
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "config-mongos": {
          "net": {
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-4-2": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "set-parameter": {
            "enable-flow-control": "bool"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-4-4": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "set-parameter": {
            "enable-flow-control": "bool"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-4-4-enterprise": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongod": {
        "config": {
          "audit-log": {
            "filter": "str"
          },
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "security": {
            "enable-encryption": "bool",
            "kmip": {
              "client-certificate": "str",
              "key-identifier": "str",
              "port": "int",
              "server-ca": "str",
              "server-name": "str"
            }
          },
          "set-parameter": {
            "audit-authorization-success": "bool",
            "enable-flow-control": "bool"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-5-0": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "set-parameter": {
            "enable-flow-control": "bool",
            "min-snapshot-history-window-in-seconds": "int"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-5-0-enterprise": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongod": {
        "config": {
          "audit-log": {
            "filter": "str",
            "runtime-configuration": "bool"
          },
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "security": {
            "enable-encryption": "bool",
            "kmip": {
              "client-certificate": "str",
              "key-identifier": "str",
              "port": "int",
              "server-ca": "str",
              "server-name": "str"
            }
          },
          "set-parameter": {
            "audit-authorization-success": "bool",
            "enable-flow-control": "bool",
            "min-snapshot-history-window-in-seconds": "int"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-6-0": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "set-parameter": {
            "enable-flow-control": "bool",
            "min-snapshot-history-window-in-seconds": "int"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    },
    "mongodb-spec-6-0-enterprise": {
      "mongocfg": {
        "config": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongod": {
        "config": {
          "audit-log": {
            "filter": "str",
            "runtime-configuration": "bool"
          },
          "net": {
            "compression": {
              "compressors": [
                "SNAPPY|ZLIB|ZSTD|DISABLED", ...
              ]
            },
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-sample-rate": "double",
            "slow-op-threshold": "int"
          },
          "security": {
            "enable-encryption": "bool",
            "kmip": {
              "client-certificate": "str",
              "key-identifier": "str",
              "port": "int",
              "server-ca": "str",
              "server-name": "str"
            }
          },
          "set-parameter": {
            "audit-authorization-success": "bool",
            "enable-flow-control": "bool",
            "min-snapshot-history-window-in-seconds": "int"
          },
          "storage": {
            "journal": {
              "commit-interval": "int"
            },
            "wired-tiger": {
              "collection-config": {
                "block-compressor": "NONE|SNAPPY|ZLIB|ZSTD"
              },
              "engine-config": {
                "cache-size-gb": "double"
              },
              "index-config": {
                "prefix-compression": "bool"
              }
            }
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      },
      "mongoinfra": {
        "config-mongocfg": {
          "net": {
            "max-incoming-connections": "int"
          },
          "operation-profiling": {
            "mode": "OFF|SLOW_OP|ALL",
            "slow-op-threshold": "int"
          },
          "storage": {
            "wired-tiger": {
              "engine-config": {
                "cache-size-gb": "double"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
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
            "max-incoming-connections": "int"
          }
        },
        "disk-size-autoscaling": {
          "disk-size-limit": "int",
          "emergency-usage-threshold": "int",
          "planned-usage-threshold": "int"
        },
        "resources": {
          "disk-size": "int",
          "disk-type-id": "str",
          "resource-preset-id": "str"
        }
      }
    }
  },
  "performance-diagnostics": {
    "profiling-enabled": "bool"
  },
  "version": "str"
}
```

Fields:

```
access -> (struct)
  Access policy to DB
  data-lens -> (bool)
    Allow access for DataLens.
  data-transfer -> (bool)
    Allow access for DataTransfer.
  web-sql -> (bool)
    Allow access for Web SQL.
backup-retain-period-days -> (int)
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
      chaining-allowed -> (bool)
        Chained replication setting
      net -> (struct)
        'net' section of mongocfg configuration.
        max-incoming-connections -> (int)
          The maximum number of simultaneous connections that mongocfg will accept.
      operation-profiling -> (struct)
        'operationProfiling' section of mongocfg configuration.
        mode -> (struct)
          Mode which specifies operations that should be profiled.
        slow-op-threshold -> (int)
          The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
      oplog -> (struct)
        'Oplog' section of mongod configuration.
        max-size-percent -> (int)
          Oplog maxsize in percents.
        min-retention-hours -> (double)
          The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour.
      set-parameter -> (struct)
        'setParameter' section of mongocfg configuration.
        audit-authorization-success -> (bool)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        enable-flow-control -> (bool)
          Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
      storage -> (struct)
        'storage' section of mongocfg configuration.
        wired-tiger -> (struct)
          Configuration of the WiredTiger storage engine.
          engine-config -> (struct)
            Engine configuration for WiredTiger.
            cache-size -> (double)
              The maximum size of the internal cache that WiredTiger will use for all data in percents.
            cache-size-gb -> (double)
              The maximum size of the internal cache that WiredTiger will use for all data.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (int)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (int)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (int)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongocfg host.
      disk-size -> (int)
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
        runtime-configuration -> (bool)
          Allows runtime configuration of audit filter and auditAuthorizationSuccess
      chaining-allowed -> (bool)
        Chained replication setting
      net -> (struct)
        'net' section of mongod configuration.
        compression -> (struct)
          Compression settings
          compressors -> ([]struct)
            Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
        max-incoming-connections -> (int)
          The maximum number of simultaneous connections that mongod will accept.
      operation-profiling -> (struct)
        'operationProfiling' section of mongod configuration.
        mode -> (struct)
          Mode which specifies operations that should be profiled.
        slow-op-sample-rate -> (double)
          The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
        slow-op-threshold -> (int)
          The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
      oplog -> (struct)
        'Oplog' section of mongod configuration.
        max-size-percent -> (int)
          Oplog maxsize in percents.
        min-retention-hours -> (double)
          The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour.
      security -> (struct)
        'security' section of mongod configuration.
        enable-encryption -> (bool)
          If encryption at rest should be enabled or not
        kmip -> (struct)
          'kmip' section of mongod security config
          client-certificate -> (string)
            KMIP client certificate + private key (unencrypted)
          key-identifier -> (string)
            KMIP Key identifier (if any)
          port -> (int)
            KMIP server port
          server-ca -> (string)
            KMIP Server CA
          server-name -> (string)
            KMIP server name
      set-parameter -> (struct)
        'SetParameter' section of mongod configuration.
        audit-authorization-success -> (bool)
          Enables the auditing of authorization successes
        enable-flow-control -> (bool)
          Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        flow-control-target-lag-seconds -> (int)
          The target maximum majority committed lag when running with flow control
        flow-control-warn-threshold-seconds -> (int)
          The amount of time to wait to log a warning once the flow control mechanism detects the majority commit point has not moved.
        migrate-clone-insertion-batch-delay-ms -> (int)
          Time in milliseconds to wait between batches of insertions during cloning step of the migration process.
        migrate-clone-insertion-batch-size -> (int)
          The maximum number of documents to insert in a single batch during the cloning step of the migration process.
        min-snapshot-history-window-in-seconds -> (int)
          The minimum time window in seconds for which the storage engine keeps the snapshot history.
        mirror-reads -> (struct)
          Specifies the settings for mirrored reads for the mongod instance
          max-time-ms -> (int)
            The maximum time in milliseconds for the mirrored reads.
          sampling-rate -> (double)
            The sampling rate used to mirror a subset of operations that support mirroring.
        orphan-cleanup-delay-secs -> (int)
          Minimum delay before a migrated chunk is deleted from the source shard.
        persisted-chunk-cache-update-max-batch-size -> (int)
          Specifies the maximum batch size used for updating the persisted chunk cache.
        range-deleter-batch-delay-ms -> (int)
          The amount of time in milliseconds to wait before the next batch of deletion during the cleanup stage of chunk migration (or the cleanupOrphaned command).
        range-deleter-batch-size -> (int)
          The maximum number of documents in each batch to delete during the cleanup stage of chunk migration (or the cleanupOrphaned command).
      storage -> (struct)
        'storage' section of mongod configuration.
        journal -> (struct)
          Configuration of the MongoDB journal.
          commit-interval -> (int)
            Commit interval between journal operations, in milliseconds. Default: 100.
        wired-tiger -> (struct)
          Configuration of the WiredTiger storage engine.
          collection-config -> (struct)
            Collection configuration for WiredTiger.
            block-compressor -> (struct)
              Default type of compression to use for collection data.
          engine-config -> (struct)
            Engine configuration for WiredTiger.
            cache-size -> (double)
              The maximum size of the internal cache that WiredTiger will use for all data in percents.
            cache-size-gb -> (double)
              The maximum size of the internal cache that WiredTiger will use for all data.
          index-config -> (struct)
            Index configuration for WiredTiger
            prefix-compression -> (bool)
              Enables or disables prefix compression
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (int)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (int)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (int)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongod host.
      disk-size -> (int)
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
      chaining-allowed -> (bool)
        Chained replication setting
      net -> (struct)
        'net' section of mongocfg configuration.
        max-incoming-connections -> (int)
          The maximum number of simultaneous connections that mongocfg will accept.
      operation-profiling -> (struct)
        'operationProfiling' section of mongocfg configuration.
        mode -> (struct)
          Mode which specifies operations that should be profiled.
        slow-op-threshold -> (int)
          The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
      oplog -> (struct)
        'Oplog' section of mongod configuration.
        max-size-percent -> (int)
          Oplog maxsize in percents.
        min-retention-hours -> (double)
          The minimum number of hours to preserve an oplog entry, where decimal values represent the fractions of an hour.
      set-parameter -> (struct)
        'setParameter' section of mongocfg configuration.
        audit-authorization-success -> (bool)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        enable-flow-control -> (bool)
          Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
      storage -> (struct)
        'storage' section of mongocfg configuration.
        wired-tiger -> (struct)
          Configuration of the WiredTiger storage engine.
          engine-config -> (struct)
            Engine configuration for WiredTiger.
            cache-size -> (double)
              The maximum size of the internal cache that WiredTiger will use for all data in percents.
            cache-size-gb -> (double)
              The maximum size of the internal cache that WiredTiger will use for all data.
    config-mongos -> (struct)
      Configuration for mongoinfra hosts.
      audit-log -> (struct)
        'AuditLog' section of mongos configuration.
        filter -> (string)
          Audit filter, should be valid JSON object string
      chunk-size -> (int)
        'ChunkSize' parameter of mongos configuration.
      net -> (struct)
        Network settings for mongos.
        compression -> (struct)
          Compression settings
          compressors -> ([]struct)
            Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
        max-incoming-connections -> (int)
          The maximum number of simultaneous connections that mongos will accept.
      set-parameter -> (struct)
        'setParameter' section of mongos configuration.
        audit-authorization-success -> (bool)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        read-hedging-mode -> (str)
          Specifies whether mongos supports hedged reads for those read operations whose read preference have enabled the hedged read option.
        sharding-task-executor-pool-host-timeout-ms -> (int)
          Maximum time that mongos goes without communication to a host before mongos drops all connections to the host.
        sharding-task-executor-pool-max-connecting -> (int)
          Maximum number of simultaneous initiating connections (including pending connections in setup/refresh state) each TaskExecutor connection pool can have to a mongod instance.
        sharding-task-executor-pool-max-size -> (int)
          Maximum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-max-size-for-config-servers -> (int)
          Optional override for ShardingTaskExecutorPoolMaxSize to set the maximum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-min-size -> (int)
          Minimum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-min-size-for-config-servers -> (int)
          Optional override for ShardingTaskExecutorPoolMinSize to set the minimum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-refresh-requirement-ms -> (int)
          Maximum time the mongos waits before attempting to heartbeat an idle connection in the pool.
        sharding-task-executor-pool-refresh-timeout-ms -> (int)
          Maximum time the mongos waits for a heartbeat before timing out the heartbeat.
        sharding-task-executor-pool-replica-set-matching -> (str)
          On a mongos instance, this parameter sets the policy that determines the minimum size limit of its connection pools to nodes within replica sets.
        warm-min-connections-in-sharding-task-executor-pool-on-startup -> (bool)
          Configures a mongos instance to prewarm its connection pool on startup.
        warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms -> (int)
          Sets the timeout threshold in milliseconds for a mongos to wait for ShardingTaskExecutorPoolMinSize connections to be established per shard host when using the warmMinConnectionsInShardingTaskExecutorPoolOnStartup parameter.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (int)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (int)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (int)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongoinfra (mongos+mongocfg) host.
      disk-size -> (int)
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
      chunk-size -> (int)
        'ChunkSize' parameter of mongos configuration.
      net -> (struct)
        Network settings for mongos.
        compression -> (struct)
          Compression settings
          compressors -> ([]struct)
            Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
        max-incoming-connections -> (int)
          The maximum number of simultaneous connections that mongos will accept.
      set-parameter -> (struct)
        'setParameter' section of mongos configuration.
        audit-authorization-success -> (bool)
          Enables the auditing of authorization successes https://www.mongodb.com/docs/manual/reference/parameters/#mongodb-parameter-param.auditAuthorizationSuccess
        read-hedging-mode -> (str)
          Specifies whether mongos supports hedged reads for those read operations whose read preference have enabled the hedged read option.
        sharding-task-executor-pool-host-timeout-ms -> (int)
          Maximum time that mongos goes without communication to a host before mongos drops all connections to the host.
        sharding-task-executor-pool-max-connecting -> (int)
          Maximum number of simultaneous initiating connections (including pending connections in setup/refresh state) each TaskExecutor connection pool can have to a mongod instance.
        sharding-task-executor-pool-max-size -> (int)
          Maximum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-max-size-for-config-servers -> (int)
          Optional override for ShardingTaskExecutorPoolMaxSize to set the maximum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-min-size -> (int)
          Minimum number of outbound connections each TaskExecutor connection pool can open to any given mongod instance.
        sharding-task-executor-pool-min-size-for-config-servers -> (int)
          Optional override for ShardingTaskExecutorPoolMinSize to set the minimum number of outbound connections each TaskExecutor connection pool can open to a configuration server.
        sharding-task-executor-pool-refresh-requirement-ms -> (int)
          Maximum time the mongos waits before attempting to heartbeat an idle connection in the pool.
        sharding-task-executor-pool-refresh-timeout-ms -> (int)
          Maximum time the mongos waits for a heartbeat before timing out the heartbeat.
        sharding-task-executor-pool-replica-set-matching -> (str)
          On a mongos instance, this parameter sets the policy that determines the minimum size limit of its connection pools to nodes within replica sets.
        warm-min-connections-in-sharding-task-executor-pool-on-startup -> (bool)
          Configures a mongos instance to prewarm its connection pool on startup.
        warm-min-connections-in-sharding-task-executor-pool-on-startup-wait-ms -> (int)
          Sets the timeout threshold in milliseconds for a mongos to wait for ShardingTaskExecutorPoolMinSize connections to be established per shard host when using the warmMinConnectionsInShardingTaskExecutorPoolOnStartup parameter.
    disk-size-autoscaling -> (struct)
      Disk size autoscaling settings
      disk-size-limit -> (int)
        Limit on how large the storage for database instances can automatically grow, in bytes.
      emergency-usage-threshold -> (int)
        Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
      planned-usage-threshold -> (int)
        Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
    resources -> (struct)
      Resources allocated to each mongos host.
      disk-size -> (int)
        Volume of the storage available to a host, in bytes.
      disk-type-id -> (string)
        Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
      resource-preset-id -> (string)
        ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
performance-diagnostics -> (struct)
  Performance Diagnosics configuration
  profiling-enabled -> (bool)
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
          max-incoming-connections -> (int)
            The maximum number of incoming connections.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Operation profiling level. For details, see MongoDB documentation.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
            enabled -> (bool)
              Whether the journal is enabled or disabled. Possible values: * true (default) - the journal is enabled. * false - the journal is disabled.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of incoming connections.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Operation profiling level. For details, see MongoDB documentation.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 3.6 hosts.
        net -> (struct)
          Network settings for mongos.
          max-incoming-connections -> (int)
            The maximum number of incoming connections.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of incoming connections.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.0 hosts.
        net -> (struct)
          Network settings for mongos.
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'replication' section of mongod configuration.
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.2 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'replication' section of mongod configuration.
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.4 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (int)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 5.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (int)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 6.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        security -> (struct)
          'security' section of mongod configuration.
          enable-encryption -> (bool)
            If encryption at rest should be enabled or not
          kmip -> (struct)
            'kmip' section of mongod security config
            client-certificate -> (string)
              KMIP client certificate + private key (unencrypted)
            key-identifier -> (string)
              KMIP Key identifier (if any)
            port -> (int)
              KMIP server port
            server-ca -> (string)
              KMIP Server CA
            server-name -> (string)
              KMIP server name
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          audit-authorization-success -> (bool)
            Enables the auditing of authorization successes
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 4.4 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          runtime-configuration -> (bool)
            Allows runtime configuration of audit filter and auditAuthorizationSuccess
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        security -> (struct)
          'security' section of mongod configuration.
          enable-encryption -> (bool)
            If encryption at rest should be enabled or not
          kmip -> (struct)
            'kmip' section of mongod security config
            client-certificate -> (string)
              KMIP client certificate + private key (unencrypted)
            key-identifier -> (string)
              KMIP Key identifier (if any)
            port -> (int)
              KMIP server port
            server-ca -> (string)
              KMIP Server CA
            server-name -> (string)
              KMIP server name
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          audit-authorization-success -> (bool)
            Enables the auditing of authorization successes
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (int)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 5.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongocfg host.
        disk-size -> (int)
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
          runtime-configuration -> (bool)
            Allows runtime configuration of audit filter and auditAuthorizationSuccess
        net -> (struct)
          'net' section of mongod configuration.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongod will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongod configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-sample-rate -> (double)
            The fraction of slow operations that should be profiled or logged. operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.
        security -> (struct)
          'security' section of mongod configuration.
          enable-encryption -> (bool)
            If encryption at rest should be enabled or not
          kmip -> (struct)
            'kmip' section of mongod security config
            client-certificate -> (string)
              KMIP client certificate + private key (unencrypted)
            key-identifier -> (string)
              KMIP Key identifier (if any)
            port -> (int)
              KMIP server port
            server-ca -> (string)
              KMIP Server CA
            server-name -> (string)
              KMIP server name
        set-parameter -> (struct)
          'SetParameter' section of mongod configuration.
          audit-authorization-success -> (bool)
            Enables the auditing of authorization successes
          enable-flow-control -> (bool)
            Enables or disables the mechanism that controls the rate at which the primary applies its writes with the goal of keeping the secondary members majority committed lag under a configurable maximum value.
          min-snapshot-history-window-in-seconds -> (int)
            The minimum time window in seconds for which the storage engine keeps the snapshot history.
        storage -> (struct)
          'storage' section of mongod configuration.
          journal -> (struct)
            Configuration of the MongoDB journal.
            commit-interval -> (int)
              Commit interval between journal operations, in milliseconds. Default: 100.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            collection-config -> (struct)
              Collection configuration for WiredTiger.
              block-compressor -> (struct)
                Default type of compression to use for collection data.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
            index-config -> (struct)
              Index configuration for WiredTiger
              prefix-compression -> (bool)
                Enables or disables prefix compression
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongod host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongocfg will accept.
        operation-profiling -> (struct)
          'operationProfiling' section of mongocfg configuration.
          mode -> (struct)
            Mode which specifies operations that should be profiled.
          slow-op-threshold -> (int)
            The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see MongoDB documentation.
        storage -> (struct)
          'storage' section of mongocfg configuration.
          wired-tiger -> (struct)
            Configuration of the WiredTiger storage engine.
            engine-config -> (struct)
              Engine configuration for WiredTiger.
              cache-size-gb -> (double)
                The maximum size of the internal cache that WiredTiger will use for all data.
      config-mongos -> (struct)
        Configuration for mongoinfra 6.0 hosts.
        net -> (struct)
          Network settings for mongos.
          compression -> (struct)
            Compression settings
            compressors -> ([]struct)
              Specifies the default compressor(s) to use for communication between this mongod or mongos instance and: - other members of the deployment if the instance is part of a replica set or a sharded cluster - mongosh - drivers that support the OP_COMPRESSED message format. MongoDB supports the following compressors:
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongoinfra (mongos+mongocfg) host.
        disk-size -> (int)
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
          max-incoming-connections -> (int)
            The maximum number of simultaneous connections that mongos will accept.
      disk-size-autoscaling -> (struct)
        Disk size autoscaling settings
        disk-size-limit -> (int)
          Limit on how large the storage for database instances can automatically grow, in bytes.
        emergency-usage-threshold -> (int)
          Amount of used storage for immediately automatic disk scaling, 0 means disabled, in percent.
        planned-usage-threshold -> (int)
          Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.
      resources -> (struct)
        Resources allocated to each mongos host.
        disk-size -> (int)
          Volume of the storage available to a host, in bytes.
        disk-type-id -> (string)
          Type of the storage environment for the host. Possible values: * network-hdd - network HDD drive, * network-ssd - network SSD drive, * local-ssd - local SSD storage.
        resource-preset-id -> (string)
          ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the documentation.
``` ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the cluster ||
|| `--description` | `string`

New description of the MongoDB cluster. ||
|| `--labels` | `stringToString`

Custom labels for the MongoDB cluster as '' key:value '' pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary". The new set of labels will completely replace the old ones. To add a label, request the current set with the [ClusterService.Get] method, then send an [ClusterService.Update] request with the new label added to the set. ||
|| `--maintenance-window` | `shorthand/json`

New maintenance window settings for the cluster.

Shorthand Syntax:

```hcl
{
  policy = anytime={} | weekly-maintenance-window={
    day = MON|TUE|WED|THU|FRI|SAT|SUN,
    hour = int
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
      "hour": "int"
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
    hour -> (int)
      Hour of the day in UTC (in 'HH' format).
``` ||
|| `--name` | `string`

New name for the cluster. ||
|| `--network-id` | `string`

ID of the network to move the cluster to. ||
|| `--security-group-ids` | `strings`

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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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