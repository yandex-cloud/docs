---
editable: false
---

# Метод create
Создает кластер ClickHouse в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
POST https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters
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
    "clickhouse": {
      "config": {
        "logLevel": "string",
        "mergeTree": {
          "replicatedDeduplicationWindow": "integer",
          "replicatedDeduplicationWindowSeconds": "integer",
          "partsToDelayInsert": "integer",
          "partsToThrowInsert": "integer",
          "maxReplicatedMergesInQueue": "integer",
          "numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge": "integer",
          "maxBytesToMergeAtMinSpaceInPool": "integer"
        },
        "compression": [
          {
            "method": "string",
            "minPartSize": "string",
            "minPartSizeRatio": "number"
          }
        ],
        "dictionaries": [
          {
            "name": "string",
            "structure": {
              "id": {
                "name": "string"
              },
              "key": {
                "attributes": [
                  {
                    "name": "string",
                    "type": "string",
                    "nullValue": "string",
                    "expression": "string",
                    "hierarchical": true,
                    "injective": true
                  }
                ]
              },
              "rangeMin": {
                "name": "string",
                "type": "string",
                "nullValue": "string",
                "expression": "string",
                "hierarchical": true,
                "injective": true
              },
              "rangeMax": {
                "name": "string",
                "type": "string",
                "nullValue": "string",
                "expression": "string",
                "hierarchical": true,
                "injective": true
              },
              "attributes": [
                {
                  "name": "string",
                  "type": "string",
                  "nullValue": "string",
                  "expression": "string",
                  "hierarchical": true,
                  "injective": true
                }
              ]
            },
            "layout": {
              "type": "string",
              "sizeInCells": "string"
            },

            // `configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`
            "fixedLifetime": "string",
            "lifetimeRange": {
              "min": "string",
              "max": "string"
            },
            // конец списка возможных полей`configSpec.clickhouse.config.dictionaries[]`

            "httpSource": {
              "url": "string",
              "format": "string"
            },
            "mysqlSource": {
              "db": "string",
              "table": "string",
              "port": "string",
              "user": "string",
              "password": "string",
              "replicas": [
                {
                  "host": "string",
                  "priority": "string",
                  "port": "string",
                  "user": "string",
                  "password": "string"
                }
              ],
              "where": "string",
              "invalidateQuery": "string"
            },
            "clickhouseSource": {
              "db": "string",
              "table": "string",
              "host": "string",
              "port": "string",
              "user": "string",
              "password": "string",
              "where": "string"
            },
            "mongodbSource": {
              "db": "string",
              "collection": "string",
              "host": "string",
              "port": "string",
              "user": "string",
              "password": "string"
            },
            "postgresqlSource": {
              "db": "string",
              "table": "string",
              "hosts": [
                "string"
              ],
              "port": "string",
              "user": "string",
              "password": "string",
              "invalidateQuery": "string",
              "sslMode": "string"
            }
          }
        ],
        "graphiteRollup": [
          {
            "name": "string",
            "patterns": [
              {
                "regexp": "string",
                "function": "string",
                "retention": [
                  {
                    "age": "string",
                    "precision": "string"
                  }
                ]
              }
            ]
          }
        ],
        "maxConnections": "integer",
        "maxConcurrentQueries": "integer",
        "keepAliveTimeout": "integer",
        "uncompressedCacheSize": "integer",
        "markCacheSize": "integer",
        "maxTableSizeToDrop": "integer",
        "maxPartitionSizeToDrop": "integer",
        "builtinDictionariesReloadInterval": "integer",
        "timezone": "string",
        "geobaseUri": "string"
      },
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "zookeeper": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      }
    },
    "backupWindowStart": {
      "hours": "integer",
      "minutes": "integer",
      "seconds": "integer",
      "nanos": "integer"
    }
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
          "databaseName": "string"
        }
      ],
      "settings": {
        "readonly": "integer",
        "allowDdl": true,
        "insertQuorum": "integer",
        "insertQuorumTimeout": "integer",
        "selectSequentialConsistency": true,
        "maxReplicaDelayForDistributedQueries": "integer",
        "fallbackToStaleReplicasForDistributedQueries": true,
        "maxThreads": "integer",
        "maxBlockSize": "integer",
        "maxInsertBlockSize": "integer",
        "maxMemoryUsage": "integer",
        "maxMemoryUsageForUser": "integer",
        "maxRowsToRead": "integer",
        "maxBytesToRead": "integer",
        "readOverflowMode": "string",
        "maxRowsToGroupBy": "integer",
        "groupByOverflowMode": "string",
        "maxRowsToSort": "integer",
        "maxBytesToSort": "integer",
        "sortOverflowMode": "string",
        "maxResultRows": "integer",
        "maxResultBytes": "integer",
        "resultOverflowMode": "string",
        "maxRowsInDistinct": "integer",
        "maxBytesInDistinct": "integer",
        "distinctOverflowMode": "string",
        "maxRowsToTransfer": "integer",
        "maxBytesToTransfer": "integer",
        "transferOverflowMode": "string",
        "maxExecutionTime": "integer",
        "timeoutOverflowMode": "string",
        "maxColumnsToRead": "integer",
        "maxTemporaryColumns": "integer",
        "maxTemporaryNonConstColumns": "integer",
        "maxQuerySize": "integer",
        "maxAstDepth": "integer",
        "maxAstElements": "integer",
        "maxExpandedAstElements": "integer"
      }
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "type": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "shardName": "string"
    }
  ],
  "networkId": "string",
  "shardName": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер ClickHouse.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Обязательное поле. Имя кластера ClickHouse. Имя должно быть уникальным в каталоге.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_-]*</code>.</p> 
description | **string**<br><p>Описание кластера ClickHouse.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Пользовательские метки для кластера ClickHouse как пары <code>key:value</code>. Максимум 64 на ресурс. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Обязательное поле. Среда развертывания кластера ClickHouse.</p> <p>Среда развертывания.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера ClickHouse.</p> 
configSpec.<br>version | **string**<br><p>Версия серверного программного обеспечения ClickHouse.</p> 
configSpec.<br>clickhouse | **object**<br><p>Конфигурация и ресурсы для сервера ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config | **object**<br><p>Конфигурация для сервера ClickHouse.</p> <p>Настройки конфигурации ClickHouse. Подробное описание для каждого набора настроек доступно в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/">документации ClickHouse</a>.</p> <p>Любые настройки, не перечисленные здесь, не поддерживаются.</p> 
configSpec.<br>clickhouse.<br>config.<br>logLevel | **string**<br><p>Уровень логирования для кластера ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree | **object**<br><p>Параметры движка MergeTree. См. описание в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#merge_tree">документации ClickHouse</a>.</p> <p>Настройки движка таблицы MergeTree.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br><p>Количество блоков хэшей, которые должен хранить ZooKeeper. Смотрите подробное описание в <a href="https://github.com/yandex/ClickHouse/blob/v18.1.0-stable/dbms/src/Storages/MergeTree/MergeTreeSettings.h#L59">ClickHouse sources</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br><p>Период времени, в течение которого следует хранить блоки хэшей. См. описание в <a href="https://github.com/yandex/ClickHouse/blob/v18.1.0-stable/dbms/src/Storages/MergeTree/MergeTreeSettings.h#L64">ClickHouse sources</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>partsToDelayInsert | **integer** (int64)<br>
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>partsToThrowInsert | **integer** (int64)<br>
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxReplicatedMergesInQueue | **integer** (int64)<br>
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>numberOfFreeEntriesInPoolToLowerMaxSizeOfMerge | **integer** (int64)<br>
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>maxBytesToMergeAtMinSpaceInPool | **integer** (int64)<br>
configSpec.<br>clickhouse.<br>config.<br>compression[] | **object**<br><p>Параметры сжатия для кластера ClickHouse. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#compression">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>method | **string**<br><p>Метод сжатия, используемый для указанной комбинации <code>min_part_size</code> и <code>min_part_size_ratio</code>.</p> <ul> <li>LZ4: <a href="https://lz4.github.io/lz4/">LZ4 compression algorithm</a>.</li> <li>ZSTD: <a href="https://facebook.github.io/zstd/">Zstandard compression algorithm</a>.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>minPartSize | **string** (int64)<br><p>Минимальный размер части таблицы.</p> <p>Минимальное значение — 1.</p> 
configSpec.<br>clickhouse.<br>config.<br>compression[].<br>minPartSizeRatio | **number** (double)<br><p>Минимальное отношение части к размеру всех данных в таблице.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[] | **object**<br><p>Конфигурация внешних словарей для кластера ClickHouse. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts/">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>name | **string**<br><p>Обязательное поле. Имя внешнего словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure | **object**<br>Обязательное поле. Набор атрибутов внешнего словаря. Подробное описание см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/).<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>id | **object**<br><p>Один столбец с числовыми ключами для словаря.</p> <p>Числовой ключ.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>id.<br>name | **string**<br><p>Обязательное поле. Имя числового ключа.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key | **object**<br><p>Составной ключ для словаря, содержащего один или несколько столбцов с ключами. Подробнее см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#composite-key">документации ClickHouse</a>.</p> <p>Составной ключ.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[] | **object**<br><p>Обязательное поле. Поля составного ключа.</p> <p>Должен содержать хотя бы один элемент.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>key.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin | **object**<br><p>Поле, содержащее начало диапазона для словарей, которые хранятся в памяти способом<code>RANGE_HASHED</code>. Подробнее см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/#range-hashed">документации ClickHouse</a></p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMin.<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax | **object**<br><p>Поле, содержащее конец диапазона для словарей, которые хранятся в памяти способом<code>RANGE_HASHED</code>. Подробнее см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/#range-hashed">документации ClickHouse</a></p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>rangeMax.<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[] | **object**<br><p>Обязательное поле. Описание полей, доступных для запросов к базе данных. Подробнее см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_structure/#attributes">документации ClickHouse</a>.</p> <p>Должен содержать хотя бы один элемент.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>name | **string**<br><p>Обязательное поле. Имя столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>type | **string**<br><p>Обязательное поле. Тип столбца.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>nullValue | **string**<br><p>Значение по умолчанию для элемента без данных (например, пустая строка).</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>expression | **string**<br><p>Выражение, описывающее атрибут, если применимо.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>hierarchical | **boolean** (boolean)<br><p>Признак поддержки иерархии. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>structure.<br>attributes[].<br>injective | **boolean** (boolean)<br><p>Признакт инъективного отображения &quot;id -&gt; атрибут&quot;. Значение по умолчанию <code>false</code>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout | **object**<br>Обязательное поле. Макет для хранения словаря в памяти. Подробное описание см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_layout/).<br><p>Макет, определяющий способ хранения словаря в памяти.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout.<br>type | **string**<br><p>Обязательное поле. Тип макета для внешнего словаря.</p> <ul> <li>FLAT: Весь словарь хранится в памяти в виде плоских массивов. Доступно для любых источников словарей.</li> <li>HASHED: Весь словарь хранится в памяти в виде хэш-таблицы. Доступно для любых источников словарей.</li> <li>COMPLEX_KEY_HASHED: Аналогичен HASHED, для использования с составными ключами. Доступно для любых источников словарей.</li> <li>RANGE_HASHED: Весь словарь хранится в памяти в виде хэш-таблицы, с упорядоченным массивом диапазонов и соответствующих им значений. Доступно для любых источников словарей.</li> <li>CACHE: Словарь хранится в кэше с заданным количеством ячеек. Доступно для источников словарей MySQL, ClickHouse и HTTP.</li> <li>COMPLEX_KEY_CACHE: Аналогичен CACHE, для использования с составными ключами. Доступно для источников словарей MySQL, ClickHouse и HTTP.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>layout.<br>sizeInCells | **string** (int64)<br><p>Количество ячеек в кэше. Округляется до степени двойки. Применимо только для типов макета CACHE и COMPLEX_KEY_CACHE.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>fixedLifetime | **string** (int64) <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `fixedLifetime`, `lifetimeRange`<br><br><p>Жесткий интервал между обновлениями словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange | **object**<br>Диапазон интервалов между обновлениями словаря, из которых может выбирать ClickHouse. <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `fixedLifetime`, `lifetimeRange`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange.<br>min | **string** (int64)<br><p>Минимальное время жизни словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>lifetimeRange.<br>max | **string** (int64)<br><p>Максимальное время жизни словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource | **object**<br>HTTP-источник для словаря. <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource.<br>url | **string**<br><p>Обязательное поле. URL внешнего словаря, доступного по HTTP.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>httpSource.<br>format | **string**<br><p>Обязательное поле. Формат данных. Допустимые значения: все форматы, поддерживаемые диалектом ClickHouse SQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource | **object**<br>MySQL-источник для словаря. <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных MySQL, к которой нужно подключаться.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>table | **string**<br><p>Обязательное поле. Имя таблицы базы данных, которую следует использовать в качестве словаря ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>port | **string** (int64)<br><p>Порт по умолчанию, который нужно использовать при подключении к реплике источника словаря.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>user | **string**<br><p>Имя пользователя по умолчанию для реплик источника словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>password | **string**<br><p>Пароль пользователя по умолчанию для реплик источника словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[] | **object**<br><p>Обязательное поле. Список реплик базы данных MySQL, используемой в качестве источника словаря.</p> <p>Должен содержать хотя бы один элемент.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>host | **string**<br><p>Обязательное поле. Хост реплики MySQL.</p> <p>Максимальная длина строки в символах — 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>priority | **string** (int64)<br><p>Обязательное поле. Приоритет реплики, который ClickHouse должен учитывать при подключении. Реплике с наивысшим приоритетом должно соответствовать наименьшее значение в этом поле.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>port | **string** (int64)<br><p>Порт, который нужно использовать при подключении к реплике. Если для какой-либо реплики не указан порт, ClickHouse использует порт, указанный для источника.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>user | **string**<br><p>Имя пользователя базы данных MySQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>replicas[].<br>password | **string**<br><p>Пароль пользователя базы данных MySQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>where | **string**<br><p>Критерии выбора данных в указанной таблице MySQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mysqlSource.<br>invalidateQuery | **string**<br><p>Запрос на проверку состояния словаря, который позволит извлекать только обновленные данные. Дополнительные сведения см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_lifetime/">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource | **object**<br>ClickHouse-источник для словаря. <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>table | **string**<br><p>Обязательное поле. Имя таблицы в указанной базе данных, используемой в качестве источника словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>host | **string**<br><p>Обязательное поле. Хост ClickHouse для указанной базы данных.</p> <p>Максимальная длина строки в символах — 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>port | **string** (int64)<br><p>Порт для подключения к хосту.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>user | **string**<br><p>Обязательное поле. Имя пользователя базы данных ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>password | **string**<br><p>Пароль пользователя базы данных ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>clickhouseSource.<br>where | **string**<br><p>Критерии выбора данных в указанной таблице ClickHouse.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource | **object**<br>MongoDB-источник для словаря. <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных MongoDB.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>collection | **string**<br><p>Обязательное поле. Имя коллекции в указанной базе данных, которую следует использовать в качестве источника словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>host | **string**<br><p>Обязательное поле. Хост MongoDB для указанной базы данных.</p> <p>Максимальная длина строки в символах — 253.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>port | **string** (int64)<br><p>Порт для подключения к хосту.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>user | **string**<br><p>Обязательное поле. Имя пользователя базы данных MongoDB.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>mongodbSource.<br>password | **string**<br><p>Пароль пользователя базы данных MongoDB.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource | **object**<br>PostgreSQL-источник для словаря. <br>`configSpec.clickhouse.config.dictionaries[]` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`, `postgresqlSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>db | **string**<br><p>Обязательное поле. Имя базы данных PostrgreSQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>table | **string**<br><p>Обязательное поле. Имя таблицы в указанной базе данных, используемой в качестве источника словаря.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>hosts[] | **string**<br><p>Обязательное поле. Имя хоста PostrgreSQL.</p> <p>Должен содержать хотя бы один элемент.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>port | **string** (int64)<br><p>Порт для подключения к хосту.</p> <p>Допустимые значения — от 0 до 65535 включительно.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>user | **string**<br><p>Обязательное поле. Имя пользователя базы данных PostrgreSQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>password | **string**<br><p>Пароль пользователя базы данных PostrgreSQL.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>invalidateQuery | **string**<br><p>Запрос на проверку состояния словаря, который позволит извлекать только обновленные данные. Дополнительные сведения см. в <a href="https://clickhouse.yandex/docs/ru/query_language/dicts/external_dicts_dict_lifetime/">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>dictionaries[].<br>postgresqlSource.<br>sslMode | **string**<br><p>Режим SSL TCP/IP соединения с хостом PostgreSQL. Дополнительные сведения см. в <a href="https://www.postgresql.org/docs/current/libpq-ssl.html">документации PostgreSQL</a>.</p> <ul> <li>DISABLE: SSL-соединение не используется.</li> <li>ALLOW: Сначала предпринимается попытка установить незашифрованное соединение. Если это не удается, устанавливается SSL-соединение.</li> <li>PREFER: Сначала предпринимается попытка установить SSL-соединение. Если это не удается, устанавливается незашифрованное соединение.</li> <li>VERIFY_CA: Устанавливается только SSL-соединение и только при условии, что сертификат выдан доверенным центром сертификации (CA).</li> <li>VERIFY_FULL: Устанавливается только SSL-соединение и только при условии, что сертификат выдан доверенным центром сертификации и что имя хоста сервера совпадает с указанным в сертификате.</li> </ul> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[] | **object**<br><p>Параметры свертки для движка таблицы GraphiteMergeTree.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>name | **string**<br><p>Обязательное поле. Имя указанной комбинации параметров для свертки Graphite.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[] | **object**<br><p>Обязательное поле. Шаблон, используемый для свертки.</p> <p>Должен содержать хотя бы один элемент.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>regexp | **string**<br><p>Шаблон для имен метрик.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>function | **string**<br><p>Обязательное поле. Имя агрегирующей функции, которую следует применить к данным старше возраста, указанного в retention.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[] | **object**<br><p>Обязательное поле. Возраст данных, которые следует использовать для прореживания.</p> <p>Должен содержать хотя бы один элемент.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>age | **string** (int64)<br><p>Минимальный возраст данных в секундах.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup[].<br>patterns[].<br>retention[].<br>precision | **string** (int64)<br><p>Точность определения возраста данных, в секундах.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxConnections | **integer** (int64)<br><p>Максимальное количество входящих подключений.</p> <p>Минимальное значение — 10.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxConcurrentQueries | **integer** (int64)<br><p>Максимальное количество одновременно обрабатываемых запросов.</p> <p>Минимальное значение — 10.</p> 
configSpec.<br>clickhouse.<br>config.<br>keepAliveTimeout | **integer** (int64)<br><p>Количество миллисекунд, в течение которых ClickHouse ожидает входящие запросы прежде чем закрыть подключение.</p> 
configSpec.<br>clickhouse.<br>config.<br>uncompressedCacheSize | **integer** (int64)<br><p>Размер кэша (в байтах) для несжатых данных, используемых таблицами MergeTree. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#uncompressed_cache_size">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>markCacheSize | **integer** (int64)<br><p>Примерный размер (в байтах) кэша «меток», используемых таблицами MergeTree. Подробнее в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#mark_cache_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 5368709120.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxTableSizeToDrop | **integer** (int64)<br><p>Максимальный размер таблицы, которую можно удалить с помощью запроса DROP. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max_table_size_to_drop">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>maxPartitionSizeToDrop | **integer** (int64)<br><p>Максимальный размер раздела, который можно удалить с помощью запроса DROP. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max_partition_size_to_drop">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>builtinDictionariesReloadInterval | **integer** (int64)<br><p>Параметр устарел и не имеет никакого эффекта.</p> 
configSpec.<br>clickhouse.<br>config.<br>timezone | **string**<br><p>Часовой пояс сервера, используемый в преобразованиях полей DateTime. Указывается как идентификатор IANA. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#timezone">документации ClickHouse</a>.</p> 
configSpec.<br>clickhouse.<br>config.<br>geobaseUri | **string**<br>
configSpec.<br>clickhouse.<br>resources | **object**<br><p>Ресурсы, выделенные хостам ClickHouse.</p> 
configSpec.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-clickhouse/concepts/instance-types">документации</a>.</p> 
configSpec.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>zookeeper | **object**<br><p>Конфигурация и ресурсы для сервера ZooKeeper.</p> 
configSpec.<br>zookeeper.<br>resources | **object**<br><p>Ресурсы, выделенные хостам ZooKeeper. Если не задано, будет использоваться минимальный доступный набор ресурсов. Все доступные наборы ресурсов можно получить с помощью запроса <a href="/docs/managed-clickhouse/api-ref/ResourcePreset/list">list</a>.</p> 
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-clickhouse/concepts/instance-types">документации</a>.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
configSpec.<br>backupWindowStart | **object**<br><p>Время запуска ежедневного резервного копирования, в часовом поясе UTC.</p> <p>Описывает время суток. Дата и часовой пояс либо не имеют значения, либо указаны другим образом. API может разрешить високосные секунды. Связанные типы: [google.type.Date][google.type.Date] и <code>google.protobuf.Timestamp</code>.</p> 
configSpec.<br>backupWindowStart.<br>hours | **integer** (int32)<br><p>Час в 24-часовом формате. Допустимые значения — от 0 до 23. API может разрешить значение &quot;24:00:00&quot; для таких сценариев, как время закрытия заведения.</p> 
configSpec.<br>backupWindowStart.<br>minutes | **integer** (int32)<br><p>Минута часа. Допустимые значения — от 0 до 59.</p> 
configSpec.<br>backupWindowStart.<br>seconds | **integer** (int32)<br><p>Секунда минуты. Обычно допустимые значения — от 0 до 59. API может разрешить значение 60, если поддерживаются високосные секунды.</p> 
configSpec.<br>backupWindowStart.<br>nanos | **integer** (int32)<br><p>Доли секунды, в наносекундах. Допустимые значения — от 0 до 999 999 999.</p> 
databaseSpecs[] | **object**<br><p>Обязательное поле. Описания баз данных, которые нужно создать в кластере ClickHouse.</p> <p>Должен содержать хотя бы один элемент.</p> 
databaseSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя базы данных ClickHouse. Длина 1-63 символов.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_-]*</code>.</p> 
userSpecs[] | **object**<br><p>Обязательное поле. Описания пользователей базы данных, которых нужно создать в кластере ClickHouse.</p> <p>Должен содержать хотя бы один элемент.</p> 
userSpecs[].<br>name | **string**<br><p>Обязательное поле. Имя пользователя базы данных ClickHouse.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]*</code>.</p> 
userSpecs[].<br>password | **string**<br><p>Обязательное поле. Пароль пользователя ClickHouse.</p> <p>Длина строки в символах должна быть от 8 до 128.</p> 
userSpecs[].<br>permissions[] | **object**<br><p>Набор разрешений, которые следует предоставить пользователю.</p> 
userSpecs[].<br>permissions[].<br>databaseName | **string**<br><p>Имя базы данных, к которой предоставляет доступ разрешение.</p> 
userSpecs[].<br>settings | **object**<br><p>Пользовательские настройки ClickHouse. Поддерживаемые параметры входят в число параметров, описанных в разделе <a href="https://clickhouse.yandex/docs/ru/operations/settings/">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>readonly | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly">документации ClickHouse</a>.</p> <p>Допустимые значения — от 0 до 2 включительно.</p> 
userSpecs[].<br>settings.<br>allowDdl | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>insertQuorum | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>insertQuorumTimeout | **integer** (int64)<br><p>Время ожидания записи для кворума в миллисекундах. Значение по умолчанию: 60000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum_timeout">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
userSpecs[].<br>settings.<br>selectSequentialConsistency | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxReplicaDelayForDistributedQueries | **integer** (int64)<br><p>Максимальная задержка реплики в миллисекундах. Если реплика отстает на значение больше установленного, реплика перестает использоваться. Значение по умолчанию: 300000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries">документации ClickHouse</a>.</p> <p>Минимальное значение — 1000.</p> 
userSpecs[].<br>settings.<br>fallbackToStaleReplicasForDistributedQueries | **boolean** (boolean)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxThreads | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpecs[].<br>settings.<br>maxBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpecs[].<br>settings.<br>maxInsertBlockSize | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpecs[].<br>settings.<br>maxMemoryUsage | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxMemoryUsageForUser | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxRowsToRead | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToRead | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>readOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxRowsToGroupBy | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>groupByOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxRowsToSort | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToSort | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>sortOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxResultRows | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxResultBytes | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>resultOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxRowsInDistinct | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxBytesInDistinct | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>distinctOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxRowsToTransfer | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxBytesToTransfer | **integer** (int64)<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>transferOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxExecutionTime | **integer** (int64)<br><p>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>timeoutOverflowMode | **string**<br><p>См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode">документации ClickHouse</a>.</p> 
userSpecs[].<br>settings.<br>maxColumnsToRead | **integer** (int64)<br><p>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxTemporaryColumns | **integer** (int64)<br><p>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxTemporaryNonConstColumns | **integer** (int64)<br><p>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns">документации ClickHouse</a>.</p> <p>Минимальное значение — 0.</p> 
userSpecs[].<br>settings.<br>maxQuerySize | **integer** (int64)<br><p>Наибольшая часть запроса, которая может быть передана в RAM для разбора с помощью анализатора SQL, в байтах. Значение по умолчанию: 262144. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpecs[].<br>settings.<br>maxAstDepth | **integer** (int64)<br><p>Максимальная глубина синтаксического дерева запроса. Значение по умолчанию: 1000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-depth">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpecs[].<br>settings.<br>maxAstElements | **integer** (int64)<br><p>Максимальный размер синтаксического дерева запроса в количестве узлов. Значение по умолчанию: 50000. См. подробное описание в <a href="https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements">документации ClickHouse</a>.</p> <p>Значение должно быть больше 0.</p> 
userSpecs[].<br>settings.<br>maxExpandedAstElements | **integer** (int64)<br><p>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000.</p> <p>Значение должно быть больше 0.</p> 
hostSpecs[] | **object**<br><p>Обязательное поле. Конфигурации для отдельных хостов, которые должны быть созданы для кластера ClickHouse.</p> <p>Должен содержать хотя бы один элемент.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>type | **string**<br><p>Обязательное поле. Тип развертываемого хоста.</p> <ul> <li>CLICKHOUSE: Хост ClickHouse.</li> <li>ZOOKEEPER: Хост ZooKeeper.</li> </ul> 
hostSpecs[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле <a href="/docs/managed-clickhouse/api-ref/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля assignPublicIp.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
hostSpecs[].<br>shardName | **string**<br><p>Имя шарда, которому принадлежит хост.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_-]*</code>.</p> 
networkId | **string**<br><p>Обязательное поле. Идентификатор сети, в которой нужно создать кластер.</p> <p>Максимальная длина строки в символах — 50.</p> 
shardName | **string**<br><p>Имя первого шарда в кластере. Если параметр не указан, используется значение <code>shard1</code>.</p> <p>Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_-]*</code>.</p> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 