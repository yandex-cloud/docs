---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}:start
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the MongoDB cluster to start.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Cluster/start.md
---

# Managed Service for MongoDB API, REST: Cluster.Start

Start the specified MongoDB cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}:start
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to start. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "environment": "string",
    "monitoring": [
      {
        "name": "string",
        "description": "string",
        "link": "string"
      }
    ],
    "config": {
      "version": "string",
      "featureCompatibilityVersion": "string",
      // Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`
      "mongodb_3_6": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  }
                },
                "journal": {
                  "enabled": "boolean",
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  }
                },
                "journal": {
                  "enabled": "boolean",
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  }
                },
                "journal": {
                  "enabled": "boolean",
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_4_0": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_4_2": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_4_4": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_5_0": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_6_0": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "setParameter": {
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_4_4Enterprise": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_5_0Enterprise": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      "mongodb_6_0Enterprise": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      },
      // end of the list of possible fields
      "backupWindowStart": {
        "hours": "integer",
        "minutes": "integer",
        "seconds": "integer",
        "nanos": "integer"
      },
      "backupRetainPeriodDays": "string",
      "performanceDiagnostics": {
        "profilingEnabled": "boolean"
      },
      "access": {
        "dataLens": "boolean",
        "webSql": "boolean",
        "dataTransfer": "boolean"
      },
      "mongodbConfig": {
        "mongod": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  },
                  "collectionConfig": {
                    "blockCompressor": "string"
                  },
                  "indexConfig": {
                    "prefixCompression": "boolean"
                  }
                },
                "journal": {
                  "commitInterval": "string"
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string",
                "slowOpSampleRate": "number"
              },
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              },
              "security": {
                "enableEncryption": "boolean",
                "kmip": {
                  "serverName": "string",
                  "port": "string",
                  "serverCa": "string",
                  "clientCertificate": "string",
                  "keyIdentifier": "string"
                }
              },
              "auditLog": {
                "filter": "string",
                "runtimeConfiguration": "boolean"
              },
              "setParameter": {
                "auditAuthorizationSuccess": "boolean",
                "enableFlowControl": "boolean",
                "minSnapshotHistoryWindowInSeconds": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongocfg": {
          "config": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongos": {
          "config": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        },
        "mongoinfra": {
          "configMongos": {
            "effectiveConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "userConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            },
            "defaultConfig": {
              "net": {
                "maxIncomingConnections": "string",
                "compression": {
                  "compressors": [
                    "string"
                  ]
                }
              }
            }
          },
          "configMongocfg": {
            "effectiveConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "userConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            },
            "defaultConfig": {
              "storage": {
                "wiredTiger": {
                  "engineConfig": {
                    "cacheSizeGb": "number"
                  }
                }
              },
              "operationProfiling": {
                "mode": "string",
                "slowOpThreshold": "string"
              },
              "net": {
                "maxIncomingConnections": "string"
              }
            }
          },
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "diskSizeAutoscaling": {
            "plannedUsageThreshold": "string",
            "emergencyUsageThreshold": "string",
            "diskSizeLimit": "string"
          }
        }
      }
    },
    "networkId": "string",
    "health": "string",
    "status": "string",
    "sharded": "boolean",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "weeklyMaintenanceWindow": {
        "day": "string",
        "hour": "string"
      }
      // end of the list of possible fields
    },
    "plannedOperation": {
      "info": "string",
      "delayedUntil": "string"
    },
    "securityGroupIds": [
      "string"
    ],
    "deletionProtection": "boolean",
    "diskEncryptionKeyId": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[StartClusterMetadata](#yandex.cloud.mdb.mongodb.v1.StartClusterMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## StartClusterMetadata {#yandex.cloud.mdb.mongodb.v1.StartClusterMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the MongoDB cluster. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Cluster {#yandex.cloud.mdb.mongodb.v1.Cluster}

A managed MongoDB cluster. For more information, see the [documentation](/docs/managed-mongodb/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the MongoDB cluster.
This ID is assigned by MDB at creation time. ||
|| folderId | **string**

ID of the folder that the MongoDB cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the MongoDB cluster.
The name is unique within the folder. 1-63 characters long. ||
|| description | **string**

Description of the MongoDB cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the MongoDB cluster as `` key:value `` pairs. Maximum 64 per resource. ||
|| environment | **enum** (Environment)

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
|| networkId | **string**

ID of the network that the cluster belongs to. ||
|| health | **enum** (Health)

Aggregated cluster health.

- `HEALTH_UNKNOWN`: State of the cluster is unknown ([Host.health](/docs/managed-mongodb/api-ref/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for every host in the cluster is UNKNOWN).
- `ALIVE`: Cluster is alive and well ([Host.health](/docs/managed-mongodb/api-ref/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for every host in the cluster is ALIVE).
- `DEAD`: Cluster is inoperable ([Host.health](/docs/managed-mongodb/api-ref/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for every host in the cluster is DEAD).
- `DEGRADED`: Cluster is working below capacity ([Host.health](/docs/managed-mongodb/api-ref/Cluster/listHosts#yandex.cloud.mdb.mongodb.v1.Host) for at least one host in the cluster is not ALIVE). ||
|| status | **enum** (Status)

Current state of the cluster.

- `STATUS_UNKNOWN`: Cluster state is unknown.
- `CREATING`: Cluster is being created.
- `RUNNING`: Cluster is running normally.
- `ERROR`: Cluster encountered a problem and cannot operate.
- `UPDATING`: Cluster is being updated.
- `STOPPING`: Cluster is stopping.
- `STOPPED`: Cluster stopped.
- `STARTING`: Cluster is starting. ||
|| sharded | **boolean**

Indicates current sharding status of the cluster. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow)**

Maintenance window for the cluster. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.mongodb.v1.MaintenanceOperation)**

Planned maintenance operation to be started for the cluster within the nearest `maintenanceWindow`. ||
|| securityGroupIds[] | **string**

User security groups ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the cluster ||
|| diskEncryptionKeyId | **string**

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
|| featureCompatibilityVersion | **string**

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

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_0 | **[Mongodb4_0](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0)**

Configuration and resource allocation for a MongoDB 4.0 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_2 | **[Mongodb4_2](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2)**

Configuration and resource allocation for a MongoDB 4.2 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_4 | **[Mongodb4_4](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4)**

Configuration and resource allocation for a MongoDB 4.4 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_5_0 | **[Mongodb5_0](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0)**

Configuration and resource allocation for a MongoDB 5.0 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_6_0 | **[Mongodb6_0](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0)**

Configuration and resource allocation for a MongoDB 6.0 cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_4_4Enterprise | **[Mongodb4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise)**

Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_5_0Enterprise | **[Mongodb5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise)**

Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| mongodb_6_0Enterprise | **[Mongodb6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise)**

Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster.

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`.

Configuration for MongoDB servers in the cluster. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)**

Time to start the daily backup, in the UTC timezone. ||
|| backupRetainPeriodDays | **string** (int64)

Retain period of automatically created backup in days ||
|| performanceDiagnostics | **[PerformanceDiagnosticsConfig](#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig)**

Performance Diagnostic ||
|| access | **[Access](#yandex.cloud.mdb.mongodb.v1.Access)**

Access policy to DB ||
|| mongodbConfig | **[Mongodb](#yandex.cloud.mdb.mongodb.v1.Mongodb)**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to MongoDB hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet3_6}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)**

Effective mongod settings for a MongoDB 3.6 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)**

User-defined mongod settings for a MongoDB 3.6 cluster. ||
|| defaultConfig | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)**

Default mongod configuration for a MongoDB 3.6 cluster. ||
|#

## MongodConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network)**

`net` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal}

#|
||Field | Description ||
|| enabled | **boolean**

Whether the journal is enabled or disabled.
Possible values:
* true (default) - the journal is enabled.
* false - the journal is disabled. ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)**

Effective mongocfg settings for a MongoDB 3.6 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)**

User-defined mongocfg settings for a MongoDB 3.6 cluster. ||
|| defaultConfig | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)**

Default mongocfg configuration for a MongoDB 3.6 cluster. ||
|#

## MongoCfgConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Operation profiling level. For details, see [MongoDB documentation](https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/).

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data. This is the default
profiler level.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of incoming connections. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)**

Effective settings for a MongoDB 3.6 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)**

User-defined settings for a MongoDB 3.6 cluster. ||
|| defaultConfig | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)**

Default configuration for a MongoDB 3.6 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of incoming connections. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6)** ||
|| configMongocfg | **[MongoCfgConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)**

Effective mongod settings for a MongoDB 4.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)**

User-defined mongod settings for a MongoDB 4.0 cluster. ||
|| defaultConfig | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)**

Default mongod configuration for a MongoDB 4.0 cluster. ||
|#

## MongodConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network)**

`net` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

Default type of compression to use for collection data.

- `COMPRESSOR_UNSPECIFIED`
- `NONE`: No compression.
- `SNAPPY`: The [Snappy](https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy) compression.
- `ZLIB`: The [zlib](https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib) compression. ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0)**

Configuration for mongocfg 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)**

Effective mongocfg settings for a MongoDB 4.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)**

User-defined mongocfg settings for a MongoDB 4.0 cluster. ||
|| defaultConfig | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)**

Default mongocfg configuration for a MongoDB 4.0 cluster. ||
|#

## MongoCfgConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0)**

Configuration for mongos 4.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)**

Effective mongos settings for a MongoDB 4.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)**

User-defined mongos settings for a MongoDB 4.0 cluster. ||
|| defaultConfig | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)**

Default mongos configuration for a MongoDB 4.0 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0)** ||
|| configMongocfg | **[MongoCfgConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_2}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)**

Effective mongod settings for a MongoDB 4.2 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)**

User-defined mongod settings for a MongoDB 4.2 cluster. ||
|| defaultConfig | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)**

Default mongod configuration for a MongoDB 4.2 cluster. ||
|#

## MongodConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network)**

`net` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter)**

`replication` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.2/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2)**

Configuration for mongocfg 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)**

Effective mongocfg settings for a MongoDB 4.2 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)**

User-defined mongocfg settings for a MongoDB 4.2 cluster. ||
|| defaultConfig | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)**

Default mongocfg configuration for a MongoDB 4.2 cluster. ||
|#

## MongoCfgConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2)**

Configuration for mongos 4.2 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)**

Effective mongos settings for a MongoDB 4.2 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)**

User-defined mongos settings for a MongoDB 4.2 cluster. ||
|| defaultConfig | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)**

Default mongos configuration for a MongoDB 4.2 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2)** ||
|| configMongocfg | **[MongoCfgConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)**

Effective mongod settings for a MongoDB 4.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)**

User-defined mongod settings for a MongoDB 4.4 cluster. ||
|| defaultConfig | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)**

Default mongod configuration for a MongoDB 4.4 cluster. ||
|#

## MongodConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network)**

`net` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter)**

`replication` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.4/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4)**

Configuration for mongocfg 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)**

Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)**

User-defined mongocfg settings for a MongoDB 4.4 cluster. ||
|| defaultConfig | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)**

Default mongocfg configuration for a MongoDB 4.4 cluster. ||
|#

## MongoCfgConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4)**

Configuration for mongos 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)**

Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)**

User-defined mongos settings for a MongoDB 4.4 cluster. ||
|| defaultConfig | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)**

Default mongos configuration for a MongoDB 4.4 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4)** ||
|| configMongocfg | **[MongoCfgConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)**

Effective mongod settings for a MongoDB 5.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)**

User-defined mongod settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)**

Default mongod configuration for a MongoDB 5.0 cluster. ||
|#

## MongodConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network)**

`net` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v5.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0)**

Configuration for mongocfg 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)**

Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)**

User-defined mongocfg settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)**

Default mongocfg configuration for a MongoDB 5.0 cluster. ||
|#

## MongoCfgConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0)**

Configuration for mongos 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)**

Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)**

User-defined mongos settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)**

Default mongos configuration for a MongoDB 5.0 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0)** ||
|| configMongocfg | **[MongoCfgConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)**

Effective mongod settings for a MongoDB 6.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)**

User-defined mongod settings for a MongoDB 6.0 cluster. ||
|| defaultConfig | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)**

Default mongod configuration for a MongoDB 6.0 cluster. ||
|#

## MongodConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network)**

`net` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v6.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0)**

Configuration for mongocfg 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)**

Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)**

User-defined mongocfg settings for a MongoDB 6.0 cluster. ||
|| defaultConfig | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)**

Default mongocfg configuration for a MongoDB 6.0 cluster. ||
|#

## MongoCfgConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0)**

Configuration for mongos 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)**

Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)**

User-defined mongos settings for a MongoDB 6.0 cluster. ||
|| defaultConfig | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)**

Default mongos configuration for a MongoDB 6.0 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0)** ||
|| configMongocfg | **[MongoCfgConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| config | **[MongodConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4_enterprise)**

Configuration for mongod 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)**

Effective mongod settings for a MongoDB 4.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)**

User-defined mongod settings for a MongoDB 4.4 cluster. ||
|| defaultConfig | **[MongodConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)**

Default mongod configuration for a MongoDB 4.4 cluster. ||
|#

## MongodConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security)**

`security` section of mongod configuration. ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v4.4/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableEncryption | **boolean**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string**

KMIP server name ||
|| port | **string** (int64)

KMIP server port ||
|| serverCa | **string**

KMIP Server CA ||
|| clientCertificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| keyIdentifier | **string**

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
|| auditAuthorizationSuccess | **boolean**

Enables the auditing of authorization successes ||
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise)**

Configuration for mongocfg 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)**

Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)**

User-defined mongocfg settings for a MongoDB 4.4 cluster. ||
|| defaultConfig | **[MongoCfgConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)**

Default mongocfg configuration for a MongoDB 4.4 cluster. ||
|#

## MongoCfgConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise)**

Configuration for mongos 4.4 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)**

Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)**

User-defined mongos settings for a MongoDB 4.4 cluster. ||
|| defaultConfig | **[MongosConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)**

Default mongos configuration for a MongoDB 4.4 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise)** ||
|| configMongocfg | **[MongoCfgConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| config | **[MongodConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0_enterprise)**

Configuration for mongod 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)**

Effective mongod settings for a MongoDB 5.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)**

User-defined mongod settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongodConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)**

Default mongod configuration for a MongoDB 5.0 cluster. ||
|#

## MongodConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security)**

`security` section of mongod configuration. ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v5.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableEncryption | **boolean**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string**

KMIP server name ||
|| port | **string** (int64)

KMIP server port ||
|| serverCa | **string**

KMIP Server CA ||
|| clientCertificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| keyIdentifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtimeConfiguration | **boolean**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean**

Enables the auditing of authorization successes ||
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise)**

Configuration for mongocfg 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)**

Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)**

User-defined mongocfg settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongoCfgConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)**

Default mongocfg configuration for a MongoDB 5.0 cluster. ||
|#

## MongoCfgConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise)**

Configuration for mongos 5.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)**

Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)**

User-defined mongos settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongosConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)**

Default mongos configuration for a MongoDB 5.0 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise)** ||
|| configMongocfg | **[MongoCfgConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

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
|| config | **[MongodConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0_enterprise)**

Configuration for mongod 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)**

Effective mongod settings for a MongoDB 6.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)**

User-defined mongod settings for a MongoDB 6.0 cluster. ||
|| defaultConfig | **[MongodConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)**

Default mongod configuration for a MongoDB 6.0 cluster. ||
|#

## MongodConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security)**

`security` section of mongod configuration. ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v6.0/reference/glossary/#term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableEncryption | **boolean**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string**

KMIP server name ||
|| port | **string** (int64)

KMIP server port ||
|| serverCa | **string**

KMIP Server CA ||
|| clientCertificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| keyIdentifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtimeConfiguration | **boolean**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean**

Enables the auditing of authorization successes ||
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v4.2/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise)**

Configuration for mongocfg 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)**

Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)**

User-defined mongocfg settings for a MongoDB 6.0 cluster. ||
|| defaultConfig | **[MongoCfgConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)**

Default mongocfg configuration for a MongoDB 6.0 cluster. ||
|#

## MongoCfgConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise)**

Configuration for mongos 6.0 hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)**

Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)**

User-defined mongos settings for a MongoDB 5.0 cluster. ||
|| defaultConfig | **[MongosConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)**

Default mongos configuration for a MongoDB 5.0 cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise)** ||
|| configMongocfg | **[MongoCfgConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## PerformanceDiagnosticsConfig {#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig}

#|
||Field | Description ||
|| profilingEnabled | **boolean** ||
|#

## Access {#yandex.cloud.mdb.mongodb.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean**

Allow access for DataLens. ||
|| webSql | **boolean**

Allow access for Web SQL. ||
|| dataTransfer | **boolean**

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
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongod hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongodConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)**

Effective mongod settings for a MongoDB cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)**

User-defined mongod settings for a MongoDB cluster. ||
|| defaultConfig | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)**

Default mongod configuration for a MongoDB cluster. ||
|#

## MongodConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig}

Configuration of a mongod daemon. Supported options are a limited subset of all
options described in [MongoDB documentation](https://docs.mongodb.com/v7.0/reference/configuration-options/).

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage)**

`storage` section of mongod configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling)**

`operationProfiling` section of mongod configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network)**

`net` section of mongod configuration. ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security)**

`security` section of mongod configuration. ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog)**

`AuditLog` section of mongod configuration. ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter)**

`SetParameter` section of mongod configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal)**

Configuration of the MongoDB [journal](https://docs.mongodb.com/v7.0/reference/glossary/#std-term-journal). ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig)**

Collection configuration for WiredTiger. ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig)**

Index configuration for WiredTiger ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

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
|| prefixCompression | **boolean**

Enables or disables [prefix compression](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-prefix-compression) ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Commit interval between journal operations, in milliseconds.
Default: 100. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. ||
|| slowOpSampleRate | **number** (double)

The fraction of slow operations that should be profiled or logged.
operationProfiling.slowOpSampleRate accepts values between 0 and 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongod will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| enableEncryption | **boolean**

If encryption at rest should be enabled or not ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP)**

`kmip` section of mongod security config ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string**

KMIP server name ||
|| port | **string** (int64)

KMIP server port ||
|| serverCa | **string**

KMIP Server CA ||
|| clientCertificate | **string**

KMIP client certificate + private key (unencrypted) ||
|| keyIdentifier | **string**

KMIP Key identifier (if any) ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string**

Audit filter ||
|| runtimeConfiguration | **boolean**

Allows runtime configuration of audit filter and auditAuthorizationSuccess ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean**

Enables the auditing of authorization successes ||
|| enableFlowControl | **boolean**

Enables or disables the mechanism that controls the rate at which the primary applies its writes with the
goal of keeping the secondary members [majority committed](https://www.mongodb.com/docs/v7.0/reference/command/replSetGetStatus/#replSetGetStatus.optimes.lastCommittedOpTime)
lag under a configurable maximum value. ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum time window in seconds for which the storage engine keeps the snapshot history. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet)**

Configuration for mongocfg hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongocfg hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongoCfgConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)**

Effective mongocfg settings for a MongoDB cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)**

User-defined mongocfg settings for a MongoDB cluster. ||
|| defaultConfig | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)**

Default mongocfg configuration for a MongoDB cluster. ||
|#

## MongoCfgConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage)**

`storage` section of mongocfg configuration. ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling)**

`operationProfiling` section of mongocfg configuration. ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network)**

`net` section of mongocfg configuration. ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger)**

Configuration of the WiredTiger storage engine. ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger}

Configuration of WiredTiger storage engine.

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig)**

Engine configuration for WiredTiger. ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double)

The maximum size of the internal cache that WiredTiger will use for all data. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode which specifies operations that should be profiled.

- `MODE_UNSPECIFIED`
- `OFF`: The profiler is off and does not collect any data.
- `SLOW_OP`: The profiler collects data for operations that take longer than the value of `slowOpThreshold`.
- `ALL`: The profiler collects data for all operations. ||
|| slowOpThreshold | **string** (int64)

The slow operation time threshold, in milliseconds. Operations that run
for longer than this threshold are considered slow, and are processed by the profiler
running in the SLOW_OP mode. For details see [MongoDB documentation](https://www.mongodb.com/docs/v7.0/reference/configuration-options/#mongodb-setting-operationProfiling.slowOpThresholdMs). ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongocfg will accept. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet)**

Configuration for mongos hosts. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongos hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MongosConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)**

Effective mongos settings for a MongoDB cluster (a combination of settings defined
in `userConfig` and `defaultConfig`). ||
|| userConfig | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)**

User-defined mongos settings for a MongoDB cluster. ||
|| defaultConfig | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)**

Default mongos configuration for a MongoDB cluster. ||
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
|| maxIncomingConnections | **string** (int64)

The maximum number of simultaneous connections that mongos will accept. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression)**

Compression settings ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

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
|| configMongos | **[MongosConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet)** ||
|| configMongocfg | **[MongoCfgConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to mongoinfra (mongos+mongocfg) hosts. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow}

A maintenance window settings.

#|
||Field | Description ||
|| anytime | **object**

Maintenance operation can be scheduled anytime.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow)**

Maintenance operation can be scheduled on a weekly basis.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`.

The maintenance policy in effect. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow}

Weelky maintenance window settings.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week (in `DDD` format).

- `WEEK_DAY_UNSPECIFIED`
- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Hour of the day in UTC (in `HH` format). ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.mongodb.v1.MaintenanceOperation}

A planned maintenance operation.

#|
||Field | Description ||
|| info | **string**

Information about this maintenance operation. ||
|| delayedUntil | **string** (date-time)

Time until which this maintenance operation is delayed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#