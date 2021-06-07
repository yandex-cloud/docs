---
editable: false
---

# Метод get
Возвращает указанный ресурс Cluster для MongoDB.
 
Чтобы получить список доступных кластеров MongoDB, отправьте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор возвращаемого ресурса Cluster для MongoDB. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
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

    // `config` включает только одно из полей `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`
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
      }
    },
    // конец списка возможных полей`config`

  },
  "networkId": "string",
  "health": "string",
  "status": "string",
  "sharded": true
}
```
Управляемый кластер MongoDB. Подробнее см. в [документации](/docs/managed-mongodb/concepts).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер MongoDB.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> .</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов.</p> 
description | **string**<br><p>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MongoDB как пары ``key:value``. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания кластера MongoDB.</p> <p>Среда развертывания.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Система мониторинга.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для данного кластера MongoDB.</p> 
config | **object**<br><p>Конфигурация кластера MongoDB.</p> 
config.<br>version | **string**<br><p>Версия серверного программного обеспечения MongoDB. Возможные значения: ``3.6``, ``4.0``, ``4.2``.</p> 
config.<br>featureCompatibilityVersion | **string**<br><p>Функционально совместимая версия MongoDB. Подробнее в <a href="https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/">документации MongoDB</a>.</p> <p>Возможные значения:</p> <ul> <li>``3.6`` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже.</li> <li>``4.0`` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже.</li> <li>``4.2`` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li> </ul> 
config.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
config.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
config.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
config.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
config.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
config.<br>mongodb_3_6 | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. <br>`config` включает только одно из полей `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`<br><br>
config.<br>mongodb_3_6.<br>mongod | **object**<br><p>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config | **object**<br><p>Конфигурация для хостов mongod 3.6.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MongoDB 3.6 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>Секция ``storage`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>Секция ``operationProfiling`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Секция ``net`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongod для кластера MongoDB 3.6.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>Секция ``storage`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>Секция ``operationProfiling`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>Секция ``net`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongod по умолчанию для кластера MongoDB 3.6.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>Секция ``storage`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>Секция ``operationProfiling`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Секция ``net`` конфигурации mongod.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные хостам MongoDB.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg | **object**<br><p>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config | **object**<br>
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры mongocfg для кластера MongoDB 3.6 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Уровень профилирования операций. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">документации MongoDB</a>.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные. Это уровень профилирования по умолчанию.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongocfg для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Уровень профилирования операций. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">документации MongoDB</a>.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные. Это уровень профилирования по умолчанию.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongocfg по умолчанию для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Уровень профилирования операций. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">документации MongoDB</a>.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные. Это уровень профилирования по умолчанию.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongocfg.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_3_6.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_3_6.<br>mongos | **object**<br><p>Конфигурация и распределение ресурсов mongos для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config | **object**<br>
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MongoDB 3.6 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация по умолчанию для кластера MongoDB 3.6.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongocfg.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_3_6.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_4_0 | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. <br>`config` включает только одно из полей `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`<br><br>
config.<br>mongodb_4_0.<br>mongod | **object**<br><p>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config | **object**<br><p>Конфигурация для хостов mongod 4.0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MongoDB 4.0 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongod для кластера MongoDB 4.0.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongod по умолчанию для кластера MongoDB 4.0.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongod.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_4_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg | **object**<br><p>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config | **object**<br><p>Конфигурация для хостов mongocfg 4.0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры mongocfg для кластера MongoDB 4.0 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongocfg для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongocfg по умолчанию для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongocfg.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_4_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_4_0.<br>mongos | **object**<br><p>Конфигурация и распределение ресурсов mongos для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config | **object**<br><p>Конфигурация для хостов mongos 4.0.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры mongos для кластера MongoDB 4.0 (комбинация параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongos для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongos по умолчанию для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongos.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_4_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_4_2 | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. <br>`config` включает только одно из полей `mongodb_3_6`, `mongodb_4_0`, `mongodb_4_2`<br><br>
config.<br>mongodb_4_2.<br>mongod | **object**<br><p>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config | **object**<br><p>Конфигурация для хостов mongod 4.0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры для кластера MongoDB 4.0 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongod для кластера MongoDB 4.0.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongod по умолчанию для кластера MongoDB 4.0.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongod configuration.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongod.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_4_2.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg | **object**<br><p>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config | **object**<br><p>Конфигурация для хостов mongocfg 4.0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры mongocfg для кластера MongoDB 4.0 (сочетание параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongocfg для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongocfg по умолчанию для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage | **object**<br><p>``storage`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling | **object**<br><p>``operationProfiling`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение ``slowOpThreshold``.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>net | **object**<br><p>``net`` section of mongocfg configuration.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongocfg.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_4_2.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
config.<br>mongodb_4_2.<br>mongos | **object**<br><p>Конфигурация и распределение ресурсов mongos для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config | **object**<br><p>Конфигурация для хостов mongos 4.0.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>effectiveConfig | **object**<br><p>Действующие параметры mongos для кластера MongoDB 4.0 (комбинация параметров, определенных в ``userConfig`` и ``defaultConfig``).</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>effectiveConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>effectiveConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>userConfig | **object**<br><p>Пользовательские настройки mongos для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>userConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>userConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>defaultConfig | **object**<br><p>Конфигурация mongos по умолчанию для кластера MongoDB 4.0.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>defaultConfig.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>config.<br>defaultConfig.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources | **object**<br><p>Ресурсы, выделенные хостам mongos.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>mongodb_4_2.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Агрегированная работоспособность кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (``health`` для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (``health`` для каждого узла в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (``health`` по крайней мере для одного узла в кластере не ALIVE).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: На кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
sharded | **boolean** (boolean)<br><p>Указывает текущее состояние шардирования кластера.</p> 