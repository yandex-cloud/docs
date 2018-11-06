# Cluster
Набор методов для управления ресурсами Cluster для MongoDB.
## JSON-представление
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

    // `config`включает только одно из полей `mongodb_3_6`
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
    // конец списка возможных полей`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string"
}
```

## Методы
Метод | Описание
--- | ---
[addHosts](addHosts.md) | Создает новые хосты для кластера.
[backup](backup.md) | Создает резервную копию для указанного кластера MongoDB.
[create](create.md) | Создает кластер MongoDB в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер MongoDB.
[deleteHosts](deleteHosts.md) | Удаляет указанные хосты кластера.
[get](get.md) | Возвращает указанный ресурс Cluster для MongoDB.
[list](list.md) | Получает список ресурсов Cluster для MongoDB, принадлежащих указанному каталогу.
[listBackups](listBackups.md) | Получает список доступных резервных копий для указанного кластера MongoDB.
[listHosts](listHosts.md) | Получает список хостов для указанного кластера.
[listLogs](listLogs.md) | Получает логи для указанного кластера MongoDB.
[listOperations](listOperations.md) | Получает список ресурсов Operation для указанного кластера.
[restore](restore.md) | Создает новый кластер MongoDB с использованием указанной резервной копии.
[update](update.md) | Изменяет указанный кластер MongoDB.