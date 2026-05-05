---
editable: false
---

# Managed Service for MongoDB Audit Trails Events: StopCluster

## Event JSON schema {#yandex.cloud.audit.mdb.mongodb.StopCluster2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "cluster": {
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
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
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
                  "minSnapshotHistoryWindowInSeconds": "string",
                  "flowControlTargetLagSeconds": "string",
                  "flowControlWarnThresholdSeconds": "string",
                  "migrateCloneInsertionBatchDelayMs": "string",
                  "migrateCloneInsertionBatchSize": "string",
                  "orphanCleanupDelaySecs": "string",
                  "persistedChunkCacheUpdateMaxBatchSize": "string",
                  "rangeDeleterBatchDelayMs": "string",
                  "rangeDeleterBatchSize": "string",
                  "mirrorReads": {
                    "samplingRate": "number",
                    "maxTimeMs": "string"
                  },
                  "redactClientLogData": "boolean"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
              },
              "userConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
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
                  "minSnapshotHistoryWindowInSeconds": "string",
                  "flowControlTargetLagSeconds": "string",
                  "flowControlWarnThresholdSeconds": "string",
                  "migrateCloneInsertionBatchDelayMs": "string",
                  "migrateCloneInsertionBatchSize": "string",
                  "orphanCleanupDelaySecs": "string",
                  "persistedChunkCacheUpdateMaxBatchSize": "string",
                  "rangeDeleterBatchDelayMs": "string",
                  "rangeDeleterBatchSize": "string",
                  "mirrorReads": {
                    "samplingRate": "number",
                    "maxTimeMs": "string"
                  },
                  "redactClientLogData": "boolean"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
              },
              "defaultConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
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
                  "minSnapshotHistoryWindowInSeconds": "string",
                  "flowControlTargetLagSeconds": "string",
                  "flowControlWarnThresholdSeconds": "string",
                  "migrateCloneInsertionBatchDelayMs": "string",
                  "migrateCloneInsertionBatchSize": "string",
                  "orphanCleanupDelaySecs": "string",
                  "persistedChunkCacheUpdateMaxBatchSize": "string",
                  "rangeDeleterBatchDelayMs": "string",
                  "rangeDeleterBatchSize": "string",
                  "mirrorReads": {
                    "samplingRate": "number",
                    "maxTimeMs": "string"
                  },
                  "redactClientLogData": "boolean"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
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
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
                    }
                  }
                },
                "operationProfiling": {
                  "mode": "string",
                  "slowOpThreshold": "string"
                },
                "net": {
                  "maxIncomingConnections": "string"
                },
                "setParameter": {
                  "enableFlowControl": "boolean",
                  "auditAuthorizationSuccess": "boolean",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
              },
              "userConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
                    }
                  }
                },
                "operationProfiling": {
                  "mode": "string",
                  "slowOpThreshold": "string"
                },
                "net": {
                  "maxIncomingConnections": "string"
                },
                "setParameter": {
                  "enableFlowControl": "boolean",
                  "auditAuthorizationSuccess": "boolean",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
              },
              "defaultConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
                    }
                  }
                },
                "operationProfiling": {
                  "mode": "string",
                  "slowOpThreshold": "string"
                },
                "net": {
                  "maxIncomingConnections": "string"
                },
                "setParameter": {
                  "enableFlowControl": "boolean",
                  "auditAuthorizationSuccess": "boolean",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
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
                },
                "setParameter": {
                  "auditAuthorizationSuccess": "boolean",
                  "readHedgingMode": "string",
                  "shardingTaskExecutorPoolMaxSize": "string",
                  "shardingTaskExecutorPoolMaxConnecting": "string",
                  "shardingTaskExecutorPoolMinSize": "string",
                  "shardingTaskExecutorPoolReplicaSetMatching": "string",
                  "shardingTaskExecutorPoolHostTimeoutMs": "string",
                  "shardingTaskExecutorPoolRefreshRequirementMs": "string",
                  "shardingTaskExecutorPoolRefreshTimeoutMs": "string",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartup": "boolean",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs": "string",
                  "shardingTaskExecutorPoolMaxSizeForConfigServers": "string",
                  "shardingTaskExecutorPoolMinSizeForConfigServers": "string",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "chunkSize": "string"
              },
              "userConfig": {
                "net": {
                  "maxIncomingConnections": "string",
                  "compression": {
                    "compressors": [
                      "string"
                    ]
                  }
                },
                "setParameter": {
                  "auditAuthorizationSuccess": "boolean",
                  "readHedgingMode": "string",
                  "shardingTaskExecutorPoolMaxSize": "string",
                  "shardingTaskExecutorPoolMaxConnecting": "string",
                  "shardingTaskExecutorPoolMinSize": "string",
                  "shardingTaskExecutorPoolReplicaSetMatching": "string",
                  "shardingTaskExecutorPoolHostTimeoutMs": "string",
                  "shardingTaskExecutorPoolRefreshRequirementMs": "string",
                  "shardingTaskExecutorPoolRefreshTimeoutMs": "string",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartup": "boolean",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs": "string",
                  "shardingTaskExecutorPoolMaxSizeForConfigServers": "string",
                  "shardingTaskExecutorPoolMinSizeForConfigServers": "string",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "chunkSize": "string"
              },
              "defaultConfig": {
                "net": {
                  "maxIncomingConnections": "string",
                  "compression": {
                    "compressors": [
                      "string"
                    ]
                  }
                },
                "setParameter": {
                  "auditAuthorizationSuccess": "boolean",
                  "readHedgingMode": "string",
                  "shardingTaskExecutorPoolMaxSize": "string",
                  "shardingTaskExecutorPoolMaxConnecting": "string",
                  "shardingTaskExecutorPoolMinSize": "string",
                  "shardingTaskExecutorPoolReplicaSetMatching": "string",
                  "shardingTaskExecutorPoolHostTimeoutMs": "string",
                  "shardingTaskExecutorPoolRefreshRequirementMs": "string",
                  "shardingTaskExecutorPoolRefreshTimeoutMs": "string",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartup": "boolean",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs": "string",
                  "shardingTaskExecutorPoolMaxSizeForConfigServers": "string",
                  "shardingTaskExecutorPoolMinSizeForConfigServers": "string",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "chunkSize": "string"
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
                },
                "setParameter": {
                  "auditAuthorizationSuccess": "boolean",
                  "readHedgingMode": "string",
                  "shardingTaskExecutorPoolMaxSize": "string",
                  "shardingTaskExecutorPoolMaxConnecting": "string",
                  "shardingTaskExecutorPoolMinSize": "string",
                  "shardingTaskExecutorPoolReplicaSetMatching": "string",
                  "shardingTaskExecutorPoolHostTimeoutMs": "string",
                  "shardingTaskExecutorPoolRefreshRequirementMs": "string",
                  "shardingTaskExecutorPoolRefreshTimeoutMs": "string",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartup": "boolean",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs": "string",
                  "shardingTaskExecutorPoolMaxSizeForConfigServers": "string",
                  "shardingTaskExecutorPoolMinSizeForConfigServers": "string",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "chunkSize": "string"
              },
              "userConfig": {
                "net": {
                  "maxIncomingConnections": "string",
                  "compression": {
                    "compressors": [
                      "string"
                    ]
                  }
                },
                "setParameter": {
                  "auditAuthorizationSuccess": "boolean",
                  "readHedgingMode": "string",
                  "shardingTaskExecutorPoolMaxSize": "string",
                  "shardingTaskExecutorPoolMaxConnecting": "string",
                  "shardingTaskExecutorPoolMinSize": "string",
                  "shardingTaskExecutorPoolReplicaSetMatching": "string",
                  "shardingTaskExecutorPoolHostTimeoutMs": "string",
                  "shardingTaskExecutorPoolRefreshRequirementMs": "string",
                  "shardingTaskExecutorPoolRefreshTimeoutMs": "string",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartup": "boolean",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs": "string",
                  "shardingTaskExecutorPoolMaxSizeForConfigServers": "string",
                  "shardingTaskExecutorPoolMinSizeForConfigServers": "string",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "chunkSize": "string"
              },
              "defaultConfig": {
                "net": {
                  "maxIncomingConnections": "string",
                  "compression": {
                    "compressors": [
                      "string"
                    ]
                  }
                },
                "setParameter": {
                  "auditAuthorizationSuccess": "boolean",
                  "readHedgingMode": "string",
                  "shardingTaskExecutorPoolMaxSize": "string",
                  "shardingTaskExecutorPoolMaxConnecting": "string",
                  "shardingTaskExecutorPoolMinSize": "string",
                  "shardingTaskExecutorPoolReplicaSetMatching": "string",
                  "shardingTaskExecutorPoolHostTimeoutMs": "string",
                  "shardingTaskExecutorPoolRefreshRequirementMs": "string",
                  "shardingTaskExecutorPoolRefreshTimeoutMs": "string",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartup": "boolean",
                  "warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs": "string",
                  "shardingTaskExecutorPoolMaxSizeForConfigServers": "string",
                  "shardingTaskExecutorPoolMinSizeForConfigServers": "string",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "chunkSize": "string"
              }
            },
            "configMongocfg": {
              "effectiveConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
                    }
                  }
                },
                "operationProfiling": {
                  "mode": "string",
                  "slowOpThreshold": "string"
                },
                "net": {
                  "maxIncomingConnections": "string"
                },
                "setParameter": {
                  "enableFlowControl": "boolean",
                  "auditAuthorizationSuccess": "boolean",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
              },
              "userConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
                    }
                  }
                },
                "operationProfiling": {
                  "mode": "string",
                  "slowOpThreshold": "string"
                },
                "net": {
                  "maxIncomingConnections": "string"
                },
                "setParameter": {
                  "enableFlowControl": "boolean",
                  "auditAuthorizationSuccess": "boolean",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
              },
              "defaultConfig": {
                "storage": {
                  "wiredTiger": {
                    "engineConfig": {
                      "cacheSizeGb": "number",
                      "cacheSize": "number"
                    }
                  }
                },
                "operationProfiling": {
                  "mode": "string",
                  "slowOpThreshold": "string"
                },
                "net": {
                  "maxIncomingConnections": "string"
                },
                "setParameter": {
                  "enableFlowControl": "boolean",
                  "auditAuthorizationSuccess": "boolean",
                  "redactClientLogData": "boolean"
                },
                "auditLog": {
                  "filter": "string"
                },
                "oplog": {
                  "maxSizePercent": "string",
                  "minRetentionHours": "number"
                },
                "chainingAllowed": "boolean"
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
        "fullVersion": "string"
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
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.mongodb.StopCluster2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.mongodb.ClusterEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.mongodb.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.mongodb.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.mongodb.v1.Cluster}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| environment | **enum** (Environment)

- `PRODUCTION`
- `PRESTABLE` ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.mongodb.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.mongodb.v1.ClusterConfig)** ||
|| networkId | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `UPDATING`
- `STOPPING`
- `STOPPED`
- `STARTING` ||
|| sharded | **boolean** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.mongodb.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| deletionProtection | **boolean** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.mongodb.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.mongodb.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string** ||
|| featureCompatibilityVersion | **string** ||
|| mongodb_3_6 | **[Mongodb3_6](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_4_0 | **[Mongodb4_0](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_4_2 | **[Mongodb4_2](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_4_4 | **[Mongodb4_4](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_5_0 | **[Mongodb5_0](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_6_0 | **[Mongodb6_0](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_4_4Enterprise | **[Mongodb4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_5_0Enterprise | **[Mongodb5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| mongodb_6_0Enterprise | **[Mongodb6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise)**

Includes only one of the fields `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`, `mongodb_4_4`, `mongodb_5_0`, `mongodb_6_0`, `mongodb_4_4Enterprise`, `mongodb_5_0Enterprise`, `mongodb_6_0Enterprise`. ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| backupRetainPeriodDays | **string** (int64) ||
|| performanceDiagnostics | **[PerformanceDiagnosticsConfig](#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig)** ||
|| access | **[Access](#yandex.cloud.mdb.mongodb.v1.Access)** ||
|| mongodbConfig | **[Mongodb](#yandex.cloud.mdb.mongodb.v1.Mongodb)** ||
|| fullVersion | **string** ||
|#

## Mongodb3_6 {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet3_6}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)** ||
|| userConfig | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)** ||
|| defaultConfig | **[MongodConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6)** ||
|#

## MongodConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB` ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Storage.Journal}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig3_6.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)** ||
|| userConfig | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)** ||
|| defaultConfig | **[MongoCfgConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6)** ||
|#

## MongoCfgConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig3_6.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)** ||
|| userConfig | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)** ||
|| defaultConfig | **[MongosConfig3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6)** ||
|#

## MongosConfig3_6 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig3_6.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb3_6.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet3_6)** ||
|| configMongocfg | **[MongoCfgConfigSet3_6](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet3_6)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb4_0 {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)** ||
|| userConfig | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)** ||
|| defaultConfig | **[MongodConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0)** ||
|#

## MongodConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB` ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)** ||
|| userConfig | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)** ||
|| defaultConfig | **[MongoCfgConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0)** ||
|#

## MongoCfgConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)** ||
|| userConfig | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)** ||
|| defaultConfig | **[MongosConfig4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0)** ||
|#

## MongosConfig4_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_0.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_0)** ||
|| configMongocfg | **[MongoCfgConfigSet4_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb4_2 {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_2}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)** ||
|| userConfig | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)** ||
|| defaultConfig | **[MongodConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2)** ||
|#

## MongodConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_2.SetParameter}

#|
||Field | Description ||
|| enableFlowControl | **boolean** ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)** ||
|| userConfig | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)** ||
|| defaultConfig | **[MongoCfgConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2)** ||
|#

## MongoCfgConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_2.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)** ||
|| userConfig | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)** ||
|| defaultConfig | **[MongosConfig4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2)** ||
|#

## MongosConfig4_2 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_2.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_2.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_2)** ||
|| configMongocfg | **[MongoCfgConfigSet4_2](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_2)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb4_4 {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)** ||
|| userConfig | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)** ||
|| defaultConfig | **[MongodConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4)** ||
|#

## MongodConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4.SetParameter}

#|
||Field | Description ||
|| enableFlowControl | **boolean** ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)** ||
|| userConfig | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)** ||
|| defaultConfig | **[MongoCfgConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4)** ||
|#

## MongoCfgConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)** ||
|| userConfig | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)** ||
|| defaultConfig | **[MongosConfig4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4)** ||
|#

## MongosConfig4_4 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4)** ||
|| configMongocfg | **[MongoCfgConfigSet4_4](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb5_0 {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)** ||
|| userConfig | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)** ||
|| defaultConfig | **[MongodConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0)** ||
|#

## MongodConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0.SetParameter}

#|
||Field | Description ||
|| enableFlowControl | **boolean** ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum value is 0. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)** ||
|| userConfig | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)** ||
|| defaultConfig | **[MongoCfgConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0)** ||
|#

## MongoCfgConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)** ||
|| userConfig | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)** ||
|| defaultConfig | **[MongosConfig5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0)** ||
|#

## MongosConfig5_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0)** ||
|| configMongocfg | **[MongoCfgConfigSet5_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb6_0 {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)** ||
|| userConfig | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)** ||
|| defaultConfig | **[MongodConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0)** ||
|#

## MongodConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0.SetParameter}

#|
||Field | Description ||
|| enableFlowControl | **boolean** ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum value is 0. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)** ||
|| userConfig | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)** ||
|| defaultConfig | **[MongoCfgConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0)** ||
|#

## MongoCfgConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)** ||
|| userConfig | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)** ||
|| defaultConfig | **[MongosConfig6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0)** ||
|#

## MongosConfig6_0 {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0)** ||
|| configMongocfg | **[MongoCfgConfigSet6_0](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)** ||
|| userConfig | **[MongodConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)** ||
|| defaultConfig | **[MongodConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise)** ||
|#

## MongodConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network)** ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security)** ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security}

#|
||Field | Description ||
|| enableEncryption | **boolean** ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP)** ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string** ||
|| port | **string** (int64) ||
|| serverCa | **string** ||
|| clientCertificate | **string** ||
|| keyIdentifier | **string** ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string** ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig4_4_enterprise.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean** ||
|| enableFlowControl | **boolean** ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)** ||
|| userConfig | **[MongoCfgConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)** ||
|| defaultConfig | **[MongoCfgConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise)** ||
|#

## MongoCfgConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)** ||
|| userConfig | **[MongosConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)** ||
|| defaultConfig | **[MongosConfig4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise)** ||
|#

## MongosConfig4_4_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig4_4_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb4_4_enterprise.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet4_4_enterprise)** ||
|| configMongocfg | **[MongoCfgConfigSet4_4Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet4_4_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)** ||
|| userConfig | **[MongodConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)** ||
|| defaultConfig | **[MongodConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise)** ||
|#

## MongodConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network)** ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security)** ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security}

#|
||Field | Description ||
|| enableEncryption | **boolean** ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP)** ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string** ||
|| port | **string** (int64) ||
|| serverCa | **string** ||
|| clientCertificate | **string** ||
|| keyIdentifier | **string** ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string** ||
|| runtimeConfiguration | **boolean** ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig5_0_enterprise.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean** ||
|| enableFlowControl | **boolean** ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum value is 0. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)** ||
|| userConfig | **[MongoCfgConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)** ||
|| defaultConfig | **[MongoCfgConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise)** ||
|#

## MongoCfgConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)** ||
|| userConfig | **[MongosConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)** ||
|| defaultConfig | **[MongosConfig5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise)** ||
|#

## MongosConfig5_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig5_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb5_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet5_0_enterprise)** ||
|| configMongocfg | **[MongoCfgConfigSet5_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet5_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## Mongodb6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)** ||
|| userConfig | **[MongodConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)** ||
|| defaultConfig | **[MongodConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise)** ||
|#

## MongodConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network)** ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security)** ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security}

#|
||Field | Description ||
|| enableEncryption | **boolean** ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP)** ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string** ||
|| port | **string** (int64) ||
|| serverCa | **string** ||
|| clientCertificate | **string** ||
|| keyIdentifier | **string** ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.AuditLog}

#|
||Field | Description ||
|| filter | **string** ||
|| runtimeConfiguration | **boolean** ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig6_0_enterprise.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean** ||
|| enableFlowControl | **boolean** ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum value is 0. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)** ||
|| userConfig | **[MongoCfgConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)** ||
|| defaultConfig | **[MongoCfgConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise)** ||
|#

## MongoCfgConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network)** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)** ||
|| userConfig | **[MongosConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)** ||
|| defaultConfig | **[MongosConfig6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise)** ||
|#

## MongosConfig6_0_enterprise {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network)** ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig6_0_enterprise.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb6_0_enterprise.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet6_0_enterprise)** ||
|| configMongocfg | **[MongoCfgConfigSet6_0Enterprise](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet6_0_enterprise)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## PerformanceDiagnosticsConfig {#yandex.cloud.mdb.mongodb.v1.PerformanceDiagnosticsConfig}

#|
||Field | Description ||
|| profilingEnabled | **boolean** ||
|#

## Access {#yandex.cloud.mdb.mongodb.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|| dataTransfer | **boolean** ||
|#

## Mongodb {#yandex.cloud.mdb.mongodb.v1.Mongodb}

#|
||Field | Description ||
|| mongod | **[Mongod](#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongod)** ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoCfg)** ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongos)** ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoInfra)** ||
|#

## Mongod {#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongod}

#|
||Field | Description ||
|| config | **[MongodConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongodConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongodConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)** ||
|| userConfig | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)** ||
|| defaultConfig | **[MongodConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig)** ||
|#

## MongodConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network)** ||
|| security | **[Security](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security)** ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter)** ||
|| oplog | **[Oplog](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Oplog)** ||
|| chainingAllowed | **boolean** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger)** ||
|| journal | **[Journal](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig)** ||
|| collectionConfig | **[CollectionConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig)** ||
|| indexConfig | **[IndexConfig](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|| cacheSize | **number** (double) ||
|#

## CollectionConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.CollectionConfig}

#|
||Field | Description ||
|| blockCompressor | **enum** (Compressor)

- `NONE`
- `SNAPPY`
- `ZLIB`
- `ZSTD` ||
|#

## IndexConfig {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.WiredTiger.IndexConfig}

#|
||Field | Description ||
|| prefixCompression | **boolean** ||
|#

## Journal {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Storage.Journal}

#|
||Field | Description ||
|| commitInterval | **string** (int64)

Acceptable values are 1 to 500, inclusive. ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|| slowOpSampleRate | **number** (double)

Acceptable values are 0 to 1, inclusive. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## Security {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security}

#|
||Field | Description ||
|| enableEncryption | **boolean** ||
|| kmip | **[KMIP](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP)** ||
|#

## KMIP {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Security.KMIP}

#|
||Field | Description ||
|| serverName | **string** ||
|| port | **string** (int64) ||
|| serverCa | **string** ||
|| clientCertificate | **string** ||
|| keyIdentifier | **string** ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string** ||
|| runtimeConfiguration | **boolean** ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean** ||
|| enableFlowControl | **boolean** ||
|| minSnapshotHistoryWindowInSeconds | **string** (int64)

The minimum value is 0. ||
|| flowControlTargetLagSeconds | **string** (int64)

Value must be greater than 0. ||
|| flowControlWarnThresholdSeconds | **string** (int64)

The minimum value is 0. ||
|| migrateCloneInsertionBatchDelayMs | **string** (int64)

The minimum value is 0. ||
|| migrateCloneInsertionBatchSize | **string** (int64)

The minimum value is 0. ||
|| orphanCleanupDelaySecs | **string** (int64) ||
|| persistedChunkCacheUpdateMaxBatchSize | **string** (int64) ||
|| rangeDeleterBatchDelayMs | **string** (int64)

The minimum value is 0. ||
|| rangeDeleterBatchSize | **string** (int64)

The minimum value is 0. ||
|| mirrorReads | **[MirrorReads](#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter.MirrorReads)** ||
|| redactClientLogData | **boolean** ||
|#

## MirrorReads {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.SetParameter.MirrorReads}

#|
||Field | Description ||
|| samplingRate | **number** (double) ||
|| maxTimeMs | **string** (int64) ||
|#

## Oplog {#yandex.cloud.mdb.mongodb.v1.config.MongodConfig.Oplog}

#|
||Field | Description ||
|| maxSizePercent | **string** (int64) ||
|| minRetentionHours | **number** (double) ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoCfg}

#|
||Field | Description ||
|| config | **[MongoCfgConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongoCfgConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)** ||
|| userConfig | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)** ||
|| defaultConfig | **[MongoCfgConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig)** ||
|#

## MongoCfgConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig}

#|
||Field | Description ||
|| storage | **[Storage](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage)** ||
|| operationProfiling | **[OperationProfiling](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling)** ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.SetParameter)** ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.AuditLog)** ||
|| oplog | **[Oplog](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Oplog)** ||
|| chainingAllowed | **boolean** ||
|#

## Storage {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage}

#|
||Field | Description ||
|| wiredTiger | **[WiredTiger](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger)** ||
|#

## WiredTiger {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger}

#|
||Field | Description ||
|| engineConfig | **[EngineConfig](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig)** ||
|#

## EngineConfig {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Storage.WiredTiger.EngineConfig}

#|
||Field | Description ||
|| cacheSizeGb | **number** (double) ||
|| cacheSize | **number** (double) ||
|#

## OperationProfiling {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.OperationProfiling}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `OFF`
- `SLOW_OP`
- `ALL` ||
|| slowOpThreshold | **string** (int64)

Value must be greater than 0. ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.SetParameter}

#|
||Field | Description ||
|| enableFlowControl | **boolean** ||
|| auditAuthorizationSuccess | **boolean** ||
|| redactClientLogData | **boolean** ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string** ||
|#

## Oplog {#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfig.Oplog}

#|
||Field | Description ||
|| maxSizePercent | **string** (int64) ||
|| minRetentionHours | **number** (double) ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.Mongodb.Mongos}

#|
||Field | Description ||
|| config | **[MongosConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MongosConfigSet {#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)** ||
|| userConfig | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)** ||
|| defaultConfig | **[MongosConfig](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig)** ||
|#

## MongosConfig {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig}

#|
||Field | Description ||
|| net | **[Network](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network)** ||
|| setParameter | **[SetParameter](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.SetParameter)** ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.AuditLog)** ||
|| chunkSize | **string** (int64) ||
|#

## Network {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network}

#|
||Field | Description ||
|| maxIncomingConnections | **string** (int64)

Acceptable values are 10 to 32768, inclusive. ||
|| compression | **[Compression](#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression)** ||
|#

## Compression {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.Network.Compression}

#|
||Field | Description ||
|| compressors[] | **enum** (Compressor)

The number of elements must be in the range 1-3.

- `SNAPPY`
- `ZLIB`
- `ZSTD`
- `DISABLED` ||
|#

## SetParameter {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.SetParameter}

#|
||Field | Description ||
|| auditAuthorizationSuccess | **boolean** ||
|| readHedgingMode | **string** ||
|| shardingTaskExecutorPoolMaxSize | **string** (int64) ||
|| shardingTaskExecutorPoolMaxConnecting | **string** (int64) ||
|| shardingTaskExecutorPoolMinSize | **string** (int64) ||
|| shardingTaskExecutorPoolReplicaSetMatching | **string** ||
|| shardingTaskExecutorPoolHostTimeoutMs | **string** (int64) ||
|| shardingTaskExecutorPoolRefreshRequirementMs | **string** (int64) ||
|| shardingTaskExecutorPoolRefreshTimeoutMs | **string** (int64) ||
|| warmMinConnectionsInShardingTaskExecutorPoolOnStartup | **boolean** ||
|| warmMinConnectionsInShardingTaskExecutorPoolOnStartupWaitMs | **string** (int64) ||
|| shardingTaskExecutorPoolMaxSizeForConfigServers | **string** (int64) ||
|| shardingTaskExecutorPoolMinSizeForConfigServers | **string** (int64) ||
|| redactClientLogData | **boolean** ||
|#

## AuditLog {#yandex.cloud.mdb.mongodb.v1.config.MongosConfig.AuditLog}

#|
||Field | Description ||
|| filter | **string** ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.Mongodb.MongoInfra}

#|
||Field | Description ||
|| configMongos | **[MongosConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongosConfigSet)** ||
|| configMongocfg | **[MongoCfgConfigSet](#yandex.cloud.mdb.mongodb.v1.config.MongoCfgConfigSet)** ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.mongodb.v1.DiskSizeAutoscaling)** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.mongodb.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.mongodb.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#