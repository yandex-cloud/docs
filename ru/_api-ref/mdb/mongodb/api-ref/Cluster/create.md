---
editable: false
---

# Метод create
Создает кластер MongoDB в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "featureCompatibilityVersion": "string",
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    },
    "access": {
      "dataLens": true
    },

    // `configSpec` включает только одно из полей `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`
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
      }
    },
    // конец списка возможных полей`configSpec`

  },
  "databaseSpecs": [
    {
      "name": "string"
    }
  ],
  "userSpecs": [
    {
      "name": "string",
      "password": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "type": "string",
      "shardName": "string"
    }
  ],
  "networkId": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер MongoDB.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Обязательное поле. Имя кластера MongoDB. Имя должно быть уникальным в каталоге.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.</p> 
description | **string**<br><p>Описание кластера MongoDB.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MongoDB как `` key:value `` pairs. Maximum 64 per resource. For example, `project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.</p> 
environment | **string**<br><p>Обязательное поле. Среда развертывания кластера MongoDB.</p> <p>Среда развертывания.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера MongoDB.</p> 
configSpec.<br>version | **string**<br><p>Версия MongoDB, используемая в кластере. Возможные значения: `3.6`, `4.0`, `4.2`.</p> 
configSpec.<br>featureCompatibilityVersion | **string**<br><p>Функционально совместимая версия MongoDB. Подробнее в <a href="https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/">документации MongoDB</a>.</p> <p>Возможные значения:</p> <ul> <li>`3.6` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже.</li> <li>`4.0` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже.</li> <li>`4.2` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC.<br><p>Время суток. Дата и часовой пояс либо не учитываются, либо задаются в других местах.</p> <p>API может разрешить использование високосной секунды.</p> <p>Связанные типы: <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> и <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Часы. Допустимые значения: от 0 до 23.</p> <p>API может разрешить использовать значение в формате &quot;24:00:00&quot; в требующих этого сценариях (например, для указания времени закрытия учреждения).</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минуты. Допустимые значения: от 0 до 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунды. Стандартные допустимые значения: от 0 до 59.</p> <p>API может разрешить использовать значение 60, если также разрешено использование високосной секунды.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды (в наносекундах). Допустимые значения: от 0 до 999999999.</p> 
configSpec.<br>access | **object**<br>Политика доступа к БД<br>
configSpec.<br>access.<br>dataLens | **boolean** (boolean)<br><p>Разрешить доступ для DataLens</p> 
configSpec.<br>mongodbSpec_3_6 | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. <br>`configSpec` включает только одно из полей `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`<br><br>
configSpec.<br>mongodbSpec_3_6.<br>mongod | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongod 3.6.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config | **object**<br><p>Конфигурация для хостов mongod 3.6.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage | **object**<br><p>Секция `storage` конфигурации mongod.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>Секция `operationProfiling` конфигурации mongod.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение `slowOpThreshold`.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net | **object**<br><p>Секция `net` конфигурации mongod.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные каждому хосту mongod.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongocfg 3.6.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config | **object**<br><p>Конфигурация для хостов mongocfg 3.6.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage | **object**<br><p>`storage` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>`operationProfiling` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Уровень профилирования операций. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/tutorial/manage-the-database-profiler/">документации MongoDB</a>.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные. Это уровень профилирования по умолчанию.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение `slowOpThreshold`.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>net | **object**<br><p>`net` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста mongocfg.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongos | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongos 3.6.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>config | **object**<br><p>Конфигурация для хостов mongos 3.6.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>config.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста mongos.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_4_0 | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. <br>`configSpec` включает только одно из полей `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`<br><br>
configSpec.<br>mongodbSpec_4_0.<br>mongod | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongod 4.0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config | **object**<br><p>Конфигурация для хостов mongod 4.0.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage | **object**<br><p>`storage` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>`operationProfiling` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение `slowOpThreshold`.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>net | **object**<br><p>`net` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные каждому хосту mongod.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongocfg 4.0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config | **object**<br><p>Конфигурация для хостов mongocfg 4.0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage | **object**<br><p>`storage` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>`operationProfiling` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение `slowOpThreshold`.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>net | **object**<br><p>`net` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста mongocfg.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_4_0.<br>mongos | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongos 4.0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>config | **object**<br><p>Конфигурация для хостов mongos 4.0.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>config.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста mongos.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_4_0.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_4_2 | **object**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. <br>`configSpec` включает только одно из полей `mongodbSpec_3_6`, `mongodbSpec_4_0`, `mongodbSpec_4_2`<br><br>
configSpec.<br>mongodbSpec_4_2.<br>mongod | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongod 4.0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config | **object**<br><p>Конфигурация для хостов mongod 4.0.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/">документации MongoDB</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage | **object**<br><p>`storage` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Сжатие <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v4.0/reference/glossary/#term-journal">journal</a> MongoDB.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p>`operationProfiling` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение `slowOpThreshold`.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>net | **object**<br><p>`net` section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources | **object**<br><p>Ресурсы, выделенные каждому хосту mongod.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongocfg 4.0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config | **object**<br><p>Конфигурация для хостов mongocfg 4.0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage | **object**<br><p>`storage` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>operationProfiling | **object**<br><p>`operationProfiling` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение `slowOpThreshold`.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP. Подробнее см. в <a href="https://docs.mongodb.com/v4.0/reference/configuration-options/#operationProfiling.slowOpThresholdMs">документации MongoDB</a>.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>net | **object**<br><p>`net` section of mongocfg configuration.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongocfg.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста mongocfg.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongocfg.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>mongodbSpec_4_2.<br>mongos | **object**<br><p>Конфигурация и выделенные ресурсы для хостов mongos 4.0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>config | **object**<br><p>Конфигурация для хостов mongos 4.0.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>config.<br>net | **object**<br><p>Сетевые настройки для mongos.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongos.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста mongos.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_4_2.<br>mongos.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
databaseSpecs[] | **object**<br><p>Обязательное поле. Описания баз данных, которые нужно создать в кластере MongoDB.</p> <p>Должен содержать хотя бы один элемент.</p> 
databaseSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя базы данных MongoDB. Длина 1-63 символов.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]{1,63} ``.</p> 
userSpecs[] | **object**<br><p>Обязательное поле. Описания пользователей базы данных, которых нужно создать в кластере MongoDB.</p> <p>Должен содержать хотя бы один элемент.</p> 
userSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя пользователя базы данных MongoDB.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.</p> 
userSpecs[].<br>password | **string**<br><p>Обязательное поле. Пароль пользователя MongoDB.</p> <p>Длина строки в символах должна быть от 8 до 128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Набор разрешений, которые следует предоставить пользователю.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
userSpecs[].<br>permissions[].<br>roles[] | **string**<br><p>Роли MongoDB базы данных `databaseName`, которые предоставляет разрешение.</p> 
hostSpecs[] | **object**<br><p>Обязательное поле. Конфигурации для отдельных хостов, которые должны быть созданы для кластера MongoDB.</p> <p>Должен содержать хотя бы один элемент.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле <a href="/docs/managed-mongodb/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля `assignPublicIp`.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
hostSpecs[].<br>type | **string**<br><p>Тип развертываемого хоста.</p> <ul> <li>MONGOD: Хост mongod.</li> <li>MONGOS: Хост mongos.</li> <li>MONGOCFG: Хост mongocfg.</li> </ul> 
hostSpecs[].<br>shardName | **string**<br><p>Имя шарда, которому принадлежит хост.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.</p> 
networkId | **string**<br><p>Обязательное поле. Идентификатор сети, в которой нужно создать кластер.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
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

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.</p> 