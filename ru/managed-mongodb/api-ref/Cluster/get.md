---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/api-ref/Cluster/get.md
---

# Method get
Returns the specified MongoDB Cluster resource.
 
To get the list of available MongoDB Cluster resources, make a [list](/docs/managed-mongodb/api-ref/Cluster/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the MongoDB Cluster resource to return. To get the cluster ID, use a <a href="/docs/managed-mongodb/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
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
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "backupRetainPeriodDays": "integer",
    "performanceDiagnostics": {
      "profilingEnabled": true
    },
    "access": {
      "dataLens": true,
      "dataTransfer": true
    },

    // `config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`
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
                "enabled": true,
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "enabled": true,
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "enabled": true,
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string"
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string"
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string"
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string",
              "runtimeConfiguration": true
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string",
              "runtimeConfiguration": true
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string",
              "runtimeConfiguration": true
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
                }
              },
              "journal": {
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string",
              "runtimeConfiguration": true
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string",
              "runtimeConfiguration": true
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
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
                "commitInterval": "integer"
              }
            },
            "operationProfiling": {
              "mode": "string",
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            },
            "security": {
              "enableEncryption": true,
              "kmip": {
                "serverName": "string",
                "port": "integer",
                "serverCa": "string",
                "clientCertificate": "string",
                "keyIdentifier": "string"
              }
            },
            "auditLog": {
              "filter": "string",
              "runtimeConfiguration": true
            },
            "setParameter": {
              "auditAuthorizationSuccess": true
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongoinfra": {
        "configMongos": {
          "effectiveConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "userConfig": {
            "net": {
              "maxIncomingConnections": "integer"
            }
          },
          "defaultConfig": {
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
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
              "slowOpThreshold": "integer"
            },
            "net": {
              "maxIncomingConnections": "integer"
            }
          }
        },
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    // end of the list of possible fields`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string",
  "sharded": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "plannedOperation": {
    "info": "string",
    "delayedUntil": "string"
  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true
}
```
A managed MongoDB cluster. For more information, see the [documentation](/docs/managed-mongodb/concepts).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the MongoDB cluster. This ID is assigned by MDB at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the MongoDB cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the MongoDB cluster. The name is unique within the folder. 1-63 characters long.</p> 
description | **string**<br><p>Description of the MongoDB cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Custom labels for the MongoDB cluster as ``key:value`` pairs. Maximum 64 per resource.</p> 
environment | **string**<br><p>Deployment environment of the MongoDB cluster.</p> <p>Deployment environment.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
monitoring[] | **object**<br><p>Description of monitoring systems relevant to the MongoDB cluster.</p> 
monitoring[].<br>name | **string**<br><p>Name of the monitoring system.</p> 
monitoring[].<br>description | **string**<br><p>Description of the monitoring system.</p> 
monitoring[].<br>link | **string**<br><p>Link to the monitoring system charts for the MongoDB cluster.</p> 
config | **object**<br><p>Configuration of the MongoDB cluster.</p> 
config.<br>version | **string**<br><p>Version of MongoDB server software. Possible values: ``3.6``, ``4.0``, ``4.2``, ``4.4``, ``4.4-enterprise``, ``5.0``, ``5.0-enterprise``, ``6.0``, ``6.0-enterprise``.</p> 
config.<br>featureCompatibilityVersion | **string**<br><p>MongoDB feature compatibility version. See usage details in <a href="https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/">MongoDB documentation</a>.</p> <p>Possible values:</p> <ul> <li>``3.6`` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or lower.</li> <li>``4.0`` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or lower.</li> <li>``4.2`` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or lower.</li> <li>``4.4`` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or lower.</li> <li>``5.0`` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 5.0 or lower.</li> <li>``6.0`` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 6.0 or lower.</li> </ul> 
config.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
config.<br>backupRetainPeriodDays | **integer** (int64)<br><p>Retain period of automatically created backup in days</p> 
config.<br>performanceDiagnostics | **object**<br>Performance Diagnostic
config.<br>performanceDiagnostics.<br>profilingEnabled | **boolean** (boolean)
config.<br>access | **object**<br>Access policy to DB
config.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens.</p> 
config.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
config.<br>mongodb_3_6 | **object**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_3_6.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config | **object**<br><p>Configuration for a mongod 3.6 hosts.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 3.6 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) - the journal is enabled.</li> <li>false - the journal is disabled.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 3.6 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) - the journal is enabled.</li> <li>false - the journal is disabled.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 3.6 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) - the journal is enabled.</li> <li>false - the journal is disabled.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources | **object**<br><p>Resources allocated to MongoDB hosts.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config | **object**
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 3.6 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_3_6.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config | **object**
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective settings for a MongoDB 3.6 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined settings for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default configuration for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_3_6.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective settings for a MongoDB 3.6 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined settings for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default configuration for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 3.6 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 3.6 cluster.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_3_6.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_0 | **object**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_4_0.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.0 hosts.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 4.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 4.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 4.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.0 hosts.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_0.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.0 hosts.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_0.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.0 cluster.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_0.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_2 | **object**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_4_2.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.2 hosts.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 4.2 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 4.2 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 4.2 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.2 hosts.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.2 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_2.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.2 hosts.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.2 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_2.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.2 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.2 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.2 cluster.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_2.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4 | **object**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_4_4.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.4 hosts.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 4.4 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 4.4 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.4 hosts.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.4 hosts.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0 | **object**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_5_0.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 5.0 hosts.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 5.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 5.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 5.0 hosts.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 5.0 hosts.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0 | **object**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_6_0.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 6.0 hosts.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 6.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 6.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 6.0 hosts.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 6.0 hosts.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4Enterprise | **object**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_4_4Enterprise.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.4 hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 4.4 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>userConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 4.4 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.4 hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.4 hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 4.4 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 4.4 cluster.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_4_4Enterprise.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0Enterprise | **object**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_5_0Enterprise.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 5.0 hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 5.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 5.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 5.0 hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 5.0 hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 5.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_5_0Enterprise.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0Enterprise | **object**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. <br>`config` includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`<br>
config.<br>mongodb_6_0Enterprise.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 6.0 hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongod settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>effectiveConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig | **object**<br><p>User-defined mongod settings for a MongoDB 6.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>userConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Default mongod configuration for a MongoDB 6.0 cluster.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>config.<br>defaultConfig.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>resources | **object**<br><p>Resources allocated to mongod hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 6.0 hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to mongocfg hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 6.0 hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>resources | **object**<br><p>Resources allocated to mongos hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) in a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos | **object**
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig | **object**<br><p>Effective mongos settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig | **object**<br><p>User-defined mongos settings for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig | **object**<br><p>Default mongos configuration for a MongoDB 5.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net | **object**<br><p>Network settings for mongos.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg | **object**
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig | **object**<br><p>Effective mongocfg settings for a MongoDB 6.0 cluster (a combination of settings defined in ``userConfig`` and ``defaultConfig``).</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig | **object**<br><p>User-defined mongocfg settings for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig | **object**<br><p>Default mongocfg configuration for a MongoDB 6.0 cluster.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to mongoinfra (mongos+mongocfg) hosts.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
config.<br>mongodb_6_0Enterprise.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
networkId | **string**<br><p>ID of the network that the cluster belongs to.</p> 
health | **string**<br><p>Aggregated cluster health.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown (``health`` for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well (``health`` for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable (``health`` for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity (``health`` for at least one host in the cluster is not ALIVE).</li> </ul> 
status | **string**<br><p>Current state of the cluster.</p> <ul> <li>STATUS_UNKNOWN: Cluster state is unknown.</li> <li>CREATING: Cluster is being created.</li> <li>RUNNING: Cluster is running normally.</li> <li>ERROR: Cluster encountered a problem and cannot operate.</li> <li>UPDATING: Cluster is being updated.</li> <li>STOPPING: Cluster is stopping.</li> <li>STOPPED: Cluster stopped.</li> <li>STARTING: Cluster is starting.</li> </ul> 
sharded | **boolean** (boolean)<br><p>Indicates current sharding status of the cluster.</p> 
maintenanceWindow | **object**<br><p>Maintenance window for the cluster.</p> <p>A maintenance window settings.</p> 
maintenanceWindow.<br>anytime | **object**<br>Maintenance operation can be scheduled anytime. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Maintenance operation can be scheduled on a weekly basis. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week (in ``DDD`` format).</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC (in ``HH`` format).</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
plannedOperation | **object**<br><p>Planned maintenance operation to be started for the cluster within the nearest <a href="/docs/managed-mongodb/api-ref/Cluster#representation">maintenanceWindow</a>.</p> <p>A planned maintenance operation.</p> 
plannedOperation.<br>info | **string**<br><p>Information about this maintenance operation.</p> <p>The maximum string length in characters is 256.</p> 
plannedOperation.<br>delayedUntil | **string** (date-time)<br><p>Time until which this maintenance operation is delayed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 