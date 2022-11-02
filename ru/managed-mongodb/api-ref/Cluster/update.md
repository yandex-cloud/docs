---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/api-ref/Cluster/update.md
---

# Method update
Updates the specified MongoDB cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the MongoDB Cluster resource to update. To get the MongoDB cluster ID use a <a href="/docs/managed-mongodb/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
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

    // `configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`
    "mongodbSpec_3_6": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_4_0": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_4_2": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_4_4": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_5_0": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_6_0": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_4_4Enterprise": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_5_0Enterprise": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    "mongodbSpec_6_0Enterprise": {
      "mongod": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongocfg": {
        "config": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "mongos": {
        "config": {
          "net": {
            "maxIncomingConnections": "integer"
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
          "net": {
            "maxIncomingConnections": "integer"
          }
        },
        "configMongocfg": {
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
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      }
    },
    // end of the list of possible fields`configSpec`

  },
  "name": "string",
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  },
  "securityGroupIds": [
    "string"
  ],
  "deletionProtection": true
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the MongoDB Cluster resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the MongoDB cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the MongoDB cluster as ``key:value`` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary".</p> <p>The new set of labels will completely replace the old ones. To add a label, request the current set with the <a href="/docs/managed-mongodb/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-mongodb/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>New configuration and resources for hosts in the cluster.</p> 
configSpec.<br>version | **string**<br><p>Version of MongoDB used in the cluster. Possible values: ``3.6``, ``4.0``, ``4.2``, ``4.4``, ``4.4-enterprise``, ``5.0``, ``5.0-enterprise``, ``6.0``, ``6.0-enterprise``.</p> 
configSpec.<br>featureCompatibilityVersion | **string**<br><p>MongoDB feature compatibility version. See usage details in <a href="https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/">MongoDB documentation</a>.</p> <p>Possible values:</p> <ul> <li>``3.6`` - persist data compatibility for version 3.6. After setting this option the data will not be compatible with 3.4 or older.</li> <li>``4.0`` - persist data compatibility for version 4.0. After setting this option the data will not be compatible with 3.6 or older.</li> <li>``4.2`` - persist data compatibility for version 4.2. After setting this option the data will not be compatible with 4.0 or older.</li> <li>``4.4`` - persist data compatibility for version 4.4. After setting this option the data will not be compatible with 4.2 or older.</li> <li>``5.0`` - persist data compatibility for version 5.0. After setting this option the data will not be compatible with 4.4 or older.</li> <li>``6.0`` - persist data compatibility for version 6.0. After setting this option the data will not be compatible with 5.0 or older.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Time to start the daily backup, in the UTC timezone.
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
configSpec.<br>backupRetainPeriodDays | **integer** (int64)<br><p>Retain period of automatically created backup in days</p> <p>Acceptable values are 7 to 35, inclusive.</p> 
configSpec.<br>performanceDiagnostics | **object**<br>Performance Diagnosics configuration
configSpec.<br>performanceDiagnostics.<br>profilingEnabled | **boolean** (boolean)
configSpec.<br>access | **object**<br>Access policy to DB
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Allow access for DataLens.</p> 
configSpec.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer.</p> 
configSpec.<br>mongodbSpec_3_6 | **object**<br>Configuration and resource allocation for a MongoDB 3.6 cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_3_6.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 3.6 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Whether the journal is enabled or disabled. Possible values:</p> <ul> <li>true (default) - the journal is enabled.</li> <li>false - the journal is disabled.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 3.6 hosts.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Operation profiling level. For details, see <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">MongoDB documentation</a>.</p> <ul> <li>OFF: The profiler is off and does not collect any data. This is the default profiler level.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of incoming connections.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_0 | **object**<br>Configuration and resource allocation for a MongoDB 4.0 cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_4_0.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.0 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 4.0 hosts.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_2 | **object**<br>Configuration and resource allocation for a MongoDB 4.2 cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_4_2.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.2 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.2/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 4.2 hosts.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.2/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4 | **object**<br>Configuration and resource allocation for a MongoDB 4.4 cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_4_4.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.4 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0 | **object**<br>Configuration and resource allocation for a MongoDB 5.0 cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_5_0.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 5.0 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0 | **object**<br>Configuration and resource allocation for a MongoDB 6.0 cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_6_0.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 6.0 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise | **object**<br>Configuration and resource allocation for a MongoDB 4.4 Enterprise cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 4.4 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v4.4/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>config.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 4.4 hosts.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v4.4/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_4_4Enterprise.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise | **object**<br>Configuration and resource allocation for a MongoDB 5.0 Enterprise cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 5.0 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v5.0/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>config.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 5.0 hosts.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v5.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_5_0Enterprise.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise | **object**<br>Configuration and resource allocation for a MongoDB 6.0 Enterprise cluster. <br>`configSpec` includes only one of the fields `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`, `mongodbSpec_4_4`, `mongodbSpec_5_0`, `mongodbSpec_6_0`, `mongodbSpec_4_4Enterprise`, `mongodbSpec_5_0Enterprise`, `mongodbSpec_6_0Enterprise`<br>
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod | **object**<br><p>Configuration and resource allocation for mongod 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config | **object**<br><p>Configuration for mongod 6.0 hosts.</p> <p>Configuration of a mongod daemon. Supported options are a limited subset of all options described in <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/">MongoDB documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Collection configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Default type of compression to use for collection data.</p> <ul> <li>NONE: No compression.</li> <li>SNAPPY: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-snappy">Snappy</a> compression.</li> <li>ZLIB: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zlib">zlib</a> compression.</li> <li>ZSTD: The <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-zstd">zstd</a> compression.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Configuration of the MongoDB <a href="https://docs.mongodb.com/v6.0/reference/glossary/#term-journal">journal</a>.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Commit interval between journal operations, in milliseconds. Default: 100.</p> <p>Acceptable values are 1 to 500, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongod will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security | **object**<br><p>``security`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>enableEncryption | **boolean** (boolean)<br><p>If encryption at rest should be enabled or not</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip | **object**<br><p>``kmip`` section of mongod security config</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>serverName | **string**<br><p>KMIP server name</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>port | **integer** (int64)<br><p>KMIP server port</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>serverCa | **string**<br><p>KMIP Server CA</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>clientCertificate | **string**<br><p>KMIP client certificate + private key (unencrypted)</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>security.<br>kmip.<br>keyIdentifier | **string**<br><p>KMIP Key identifier (if any)</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>auditLog | **object**<br><p>``AuditLog`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>auditLog.<br>filter | **string**<br><p>Audit filter</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>auditLog.<br>runtimeConfiguration | **boolean** (boolean)<br><p>Allows runtime configuration of audit filter and auditAuthorizationSuccess</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>setParameter | **object**<br><p>``SetParameter`` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>config.<br>setParameter.<br>auditAuthorizationSuccess | **boolean** (boolean)<br><p>Enables the auditing of authorization successes</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>resources | **object**<br><p>Resources allocated to each mongod host.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg | **object**<br><p>Configuration and resource allocation for mongocfg 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config | **object**<br><p>Configuration for mongocfg 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>resources | **object**<br><p>Resources allocated to each mongocfg host.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos | **object**<br><p>Configuration and resource allocation for mongos 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>config | **object**<br><p>Configuration for mongos 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>config.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>resources | **object**<br><p>Resources allocated to each mongos host.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra | **object**<br><p>Configuration and resource allocation for mongoinfra (mongos+mongocfg) 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongos | **object**<br><p>Configuration for mongoinfra 6.0 hosts.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>net | **object**<br><p>Network settings for mongos.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongos.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongos will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg | **object**
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger | **object**<br><p>Configuration of the WiredTiger storage engine.</p> <p>Configuration of WiredTiger storage engine.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Engine configuration for WiredTiger.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>The maximum size of the internal cache that WiredTiger will use for all data.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>mode | **string**<br><p>Mode which specifies operations that should be profiled.</p> <ul> <li>OFF: The profiler is off and does not collect any data.</li> <li>SLOW_OP: The profiler collects data for operations that take longer than the value of ``slowOpThreshold``.</li> <li>ALL: The profiler collects data for all operations.</li> </ul> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>The slow operation time threshold, in milliseconds. Operations that run for longer than this threshold are considered slow, and are processed by the profiler running in the SLOW_OP mode. For details see <a href="https://docs.mongodb.com/v6.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">MongoDB documentation</a>.</p> <p>Value must be greater than 0.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>configMongocfg.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>The maximum number of simultaneous connections that mongocfg will accept.</p> <p>Acceptable values are 10 to 16384, inclusive.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>resources | **object**<br><p>Resources allocated to each mongoinfra (mongos+mongocfg) host.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>mongodbSpec_6_0Enterprise.<br>mongoinfra.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
name | **string**<br><p>New name for the cluster.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
maintenanceWindow | **object**<br><p>New maintenance window settings for the cluster.</p> <p>A maintenance window settings.</p> 
maintenanceWindow.<br>anytime | **object**<br>Maintenance operation can be scheduled anytime. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Maintenance operation can be scheduled on a weekly basis. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week (in ``DDD`` format).</p> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC (in ``HH`` format).</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 