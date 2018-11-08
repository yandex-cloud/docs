# Cluster
A set of methods for managing MongoDB Cluster resources.
## JSON Representation {#representation}
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

    // `config`includes only one of the fields `mongodb_3_6`
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
      }
    },
    // end of the list of possible fields`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```

## Methods {#methods}
Method | Description
--- | ---
[addHosts](addHosts.md) | Creates new hosts for a cluster.
[backup](backup.md) | Creates a backup for the specified MongoDB cluster.
[create](create.md) | Creates a MongoDB cluster in the specified folder.
[delete](delete.md) | Deletes the specified MongoDB cluster.
[deleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster.
[get](get.md) | Returns the specified MongoDB Cluster resource.
[list](list.md) | Retrieves the list of MongoDB Cluster resources that belong to the specified folder.
[listBackups](listBackups.md) | Retrieves the list of available backups for the specified MongoDB cluster.
[listHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster.
[listLogs](listLogs.md) | Retrieves logs for the specified MongoDB cluster. See the [Logs](/docs/yandex-mdb-guide/concepts/logs) section in the developers guide for detailed logs description.
[listOperations](listOperations.md) | Retrieves the list of Operation resources for the specified cluster.
[restore](restore.md) | Creates a new MongoDB cluster using the specified backup.
[update](update.md) | Updates the specified MongoDB cluster.