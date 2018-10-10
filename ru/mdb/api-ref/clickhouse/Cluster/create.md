# Метод create
Создает кластер ClickHouse в указанной папке.
 

 
## HTTP-запрос
`POST /managed-clickhouse/v1/clusters`
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "clickhouse": {
      "config": {
        "logLevel": "string",
        "mergeTree": {
          "replicatedDeduplicationWindow": "integer",
          "replicatedDeduplicationWindowSeconds": "integer"
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

            // `configSpec.clickhouse.config.dictionaries`включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`
            "fixedLifetime": "string",
            "lifetimeRange": {
              "min": "string",
              "max": "string"
            },
            // конец списка возможных полей`configSpec.clickhouse.config.dictionaries`

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
        "builtinDictionariesReloadInterval": "integer"
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
      ]
    }
  ],
  "hostSpecs": [
    {
      "zoneId": "string",
      "type": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "networkId": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер ClickHouse.  Максимальная длина — 50 символов.
name | **string**<br>Обязательное поле. Имя не может быть изменено после создания кластера ClickHouse.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов.  Максимальная длина — 256 символов.
labels | **object**<br>Пользовательские метки для кластера ClickHouse в виде пар ключ-значение. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary".  Не более 64 на ресурс.  Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.
environment | **string**<br>Обязательное поле. Среда развертывания кластера ClickHouse.  Среда развертывания.   - PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.  - PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.<br>`PRODUCTION`<br>`PRESTABLE`<br>
configSpec | **object**<br>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера ClickHouse.
configSpec.<br>clickhouse | **object**<br>Конфигурация и ресурсы для сервера ClickHouse.
configSpec.<br>clickhouse.<br>config | **object**<br>Конфигурация для сервера ClickHouse.  Настройки конфигурации ClickHouse. Подробное описание для каждого набора настроек доступно в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/). Любые настройки, не перечисленные здесь, не поддерживаются.
configSpec.<br>clickhouse.<br>config.<br>logLevel | **string**<br>Уровень логирования для кластера ClickHouse.<br>`TRACE`<br>`DEBUG`<br>`INFORMATION`<br>`WARNING`<br>`ERROR`<br>
configSpec.<br>clickhouse.<br>config.<br>mergeTree | **object**<br>Параметры движка MergeTree. См. описание в [документации ClickHouse](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#merge_tree).  Настройки движка таблицы MergeTree.
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindow | **integer** (int64)<br>Количество блоков хэшей, которые должен хранить ZooKeeper. См. подробное описание в [исходном коде ClickHouse](https://github.com/yandex/ClickHouse/blob/v18.1.0-sta ble/dbms/src/Storages/MergeTree/MergeTreeSettings.h#L59).
configSpec.<br>clickhouse.<br>config.<br>mergeTree.<br>replicatedDeduplicationWindowSeconds | **integer** (int64)<br>Период времени, в течение которого следует хранить блоки хэшей. См. подробное описание в [исходном коде ClickHouse](https://github.com/yandex/ClickHous e/blob/v18.1.0-stable/dbms/src/Storages/MergeTree/MergeTreeSettings.h#L64).
configSpec.<br>clickhouse.<br>config.<br>compression | **object**<br>Параметры сжатия для кластера ClickHouse. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression).
configSpec.<br>clickhouse.<br>config.<br>compression.<br>method | **string**<br>Метод сжатия, используемый для указанной комбинации `min_part_size` и `min_part_size_ratio`.   - LZ4: Алгоритм сжатия [LZ4](https://lz4.github.io/lz4/).  - ZSTD: Алгоритм сжатия [Zstandard](https://facebook.github.io/zstd/).<br>`LZ4`<br>`ZSTD`<br>
configSpec.<br>clickhouse.<br>config.<br>compression.<br>minPartSize | **string** (int64)<br>Минимальный размер части таблицы.  Минимальная значение — 1.
configSpec.<br>clickhouse.<br>config.<br>compression.<br>minPartSizeRatio | **number** (double)<br>Минимальное отношение части к размеру всех данных в таблице.
configSpec.<br>clickhouse.<br>config.<br>dictionaries | **object**<br>Конфигурация внешних словарей для кластера ClickHouse. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts/).
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>name | **string**<br>Обязательное поле. Имя внешнего словаря.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure | **object**<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>id | **object**<br>Идентификатор ключевого столбца для словаря.  Ключевой столбец для словаря.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>id.<br>name | **string**<br>Обязательное поле. Имя числового ключа.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key | **object**<br>Составной ключ для словаря, содержащий один или больше ключевых столбцов.  Составной ключ.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes | **object**<br>Обязательное поле. Аттрибуты составного ключа.  Должен содержать хотя бы один элемент.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes.<br>name | **string**<br>Обязательное поле. Имя столбца.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes.<br>type | **string**<br>Обязательное поле. Тип столбца.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes.<br>nullValue | **string**<br>Значение по умолчанию для элемента без данных (например, пустая строка).
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes.<br>expression | **string**<br>Выражение, описывающее атрибут, если применимо.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes.<br>hierarchical | **boolean** (boolean)<br>Признак поддержки иерархии. Значение по умолчанию: "false".
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>key.<br>attributes.<br>injective | **boolean** (boolean)<br>Признакт инъективного отображения "id -> атрибут". Значение по умолчанию: "false".
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes | **object**<br>Обязательное поле. Описание полей, доступных для запросов к базе данных.  Должен содержать хотя бы один элемент.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes.<br>name | **string**<br>Обязательное поле. Имя столбца.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes.<br>type | **string**<br>Обязательное поле. Тип столбца.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes.<br>nullValue | **string**<br>Значение по умолчанию для элемента без данных (например, пустая строка).
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes.<br>expression | **string**<br>Выражение, описывающее атрибут, если применимо.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes.<br>hierarchical | **boolean** (boolean)<br>Признак поддержки иерархии. Значение по умолчанию: "false".
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>structure.<br>attributes.<br>injective | **boolean** (boolean)<br>Признакт инъективного отображения "id -> атрибут". Значение по умолчанию: "false".
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>layout | **object**<br>Макет, определяющий способ хранения словаря в памяти.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>layout.<br>type | **string**<br>Обязательное поле. Тип макета для внешнего словаря.   - FLAT: Весь словарь хранится в памяти в виде плоских массивов. Доступно для любого источника словаря.  - HASHED: Весь словарь хранится в памяти в виде хэш-таблицы. Доступно для любого источника словаря.  - COMPLEX_KEY_HASHED: Аналогичен HASHED, для использования с составными ключами. Доступно для любого источника словаря.  - RANGE_HASHED: Весь словарь хранится в памяти в виде хэш-таблицы, с упорядоченным массивом диапазонов и соответствующих им значений. Доступно для любого источника словаря.  - CACHE: Словарь хранится в кэше с заданным количеством ячеек. Доступно для источников словарей MySQL, ClickHouse и HTTP.  - COMPLEX_KEY_CACHE: Аналогичен CACHE, для использования с составными ключами. Доступно для источников словарей MySQL, ClickHouse и HTTP.<br>`FLAT`<br>`HASHED`<br>`COMPLEX_KEY_HASHED`<br>`RANGE_HASHED`<br>`CACHE`<br>`COMPLEX_KEY_CACHE`<br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>layout.<br>sizeInCells | **string** (int64)<br>Количество ячеек в кэше. Округляется до степени двойки. Применимо только для типов макета CACHE и COMPLEX_KEY_CACHE.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>fixedLifetime | **string** (int64) <br>`configSpec.clickhouse.config.dictionaries` включает только одно из полей `fixedLifetime`, `lifetimeRange`<br><br>Жесткий интервал между обновлениями словаря.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>lifetimeRange | **object** <br>`configSpec.clickhouse.config.dictionaries` включает только одно из полей `fixedLifetime`, `lifetimeRange`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>lifetimeRange.<br>min | **string** (int64)<br>Минимальное время жизни словаря.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>lifetimeRange.<br>max | **string** (int64)<br>Максимальное время жизни словаря.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>httpSource | **object** <br>`configSpec.clickhouse.config.dictionaries` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>httpSource.<br>url | **string**<br>Обязательное поле. URL внешнего словаря, доступного по HTTP.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>httpSource.<br>format | **string**<br>Обязательное поле. Формат данных. Допустимые значения: все форматы, поддерживаемые диалектом ClickHouse SQL.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource | **object** <br>`configSpec.clickhouse.config.dictionaries` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>db | **string**<br>Обязательное поле. Имя базы данных MySQL, к которой нужно подключаться.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>table | **string**<br>Обязательное поле. Имя таблицы базы данных, которую следует использовать в качестве словаря ClickHouse.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>port | **string** (int64)<br>Порт по умолчанию, который нужно использовать при подключении к реплике источника словаря.  Допустимые значения — от 0 до 65535 включительно.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>user | **string**<br>Имя пользователя по умолчанию для реплик источника словаря.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>password | **string**<br>Пароль пользователя по умолчанию для реплик источника словаря.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>replicas | **object**<br>Обязательное поле. Список реплик базы данных MySQL, используемой в качестве источника словаря.  Должен содержать хотя бы один элемент.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>replicas.<br>host | **string**<br>Обязательное поле. Хост реплики MySQL.  Максимальная длина строки в символах — 253.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>replicas.<br>priority | **string** (int64)<br>Обязательное поле. Приоритет реплики, который ClickHouse должен учитывать при подключении. Реплике с наивысшим приоритетом должно соответствовать наименьшее значение в этом поле.  Значение должно быть больше 0.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>replicas.<br>port | **string** (int64)<br>Порт, который нужно использовать при подключении к реплике. Если для какой-либо реплики не указан порт, ClickHouse использует порт, указанный для источника.  Допустимые значения — от 0 до 65535 включительно.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>replicas.<br>user | **string**<br>Имя пользователя базы данных MySQL.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>replicas.<br>password | **string**<br>Пароль пользователя базы данных MySQL.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>where | **string**<br>Критерии выбора данных в указанной таблице MySQL.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mysqlSource.<br>invalidateQuery | **string**<br>Запрос на проверку состояния словаря, который позволит извлекать только обновленные данные. Дополнительные сведения см. в [документации ClickHouse про словари](https://clickhouse.yandex/docs/en/query_language/dicts/external_dicts_dict_lifetime/).
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource | **object** <br>`configSpec.clickhouse.config.dictionaries` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>db | **string**<br>Обязательное поле. Имя базы данных ClickHouse.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>table | **string**<br>Обязательное поле. Имя таблицы в указанной базе данных, используемой в качестве источника словаря.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>host | **string**<br>Обязательное поле. Хост ClickHouse для указанной базы данных.  Максимальная длина строки в символах — 253.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>port | **string** (int64)<br>Порт для подключения к хосту.  Допустимые значения — от 0 до 65535 включительно.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>user | **string**<br>Имя пользователя базы данных ClickHouse.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>password | **string**<br>Пароль пользователя базы данных ClickHouse.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>clickhouseSource.<br>where | **string**<br>Критерии выбора данных в указанной таблице ClickHouse.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource | **object** <br>`configSpec.clickhouse.config.dictionaries` включает только одно из полей `httpSource`, `mysqlSource`, `clickhouseSource`, `mongodbSource`<br><br>
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource.<br>db | **string**<br>Обязательное поле. Имя базы данных MongoDB.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource.<br>collection | **string**<br>Обязательное поле. Имя коллекции в указанной базе данных, которую следует использовать в качестве источника словаря.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource.<br>host | **string**<br>Обязательное поле. Хост MongoDB для указанной базы данных.  Максимальная длина строки в символах — 253.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource.<br>port | **string** (int64)<br>Порт для подключения к хосту.  Допустимые значения — от 0 до 65535 включительно.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource.<br>user | **string**<br>Имя пользователя базы данных MongoDB.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
configSpec.<br>clickhouse.<br>config.<br>dictionaries.<br>mongodbSource.<br>password | **string**<br>Пароль пользователя базы данных MongoDB.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup | **object**<br>Параметры свертки для движка таблицы GraphiteMergeTree.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>name | **string**<br>Обязательное поле. Имя указанной комбинации параметров для свертки Graphite.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>patterns | **object**<br>Обязательное поле. Шаблон, используемый для свертки.  Должен содержать хотя бы один элемент.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>patterns.<br>regexp | **string**<br>Шаблон для имен метрик.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>patterns.<br>function | **string**<br>Обязательное поле. Имя агрегирующей функции, которую следует применить к данным старше возраста, указанного в retention.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>patterns.<br>retention | **object**<br>Обязательное поле. Возраст данных, которые следует использовать для прореживания.  Должен содержать хотя бы один элемент.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>patterns.<br>retention.<br>age | **string** (int64)<br>Минимальный возраст данных в секундах.  Значение должно быть больше 0.
configSpec.<br>clickhouse.<br>config.<br>graphiteRollup.<br>patterns.<br>retention.<br>precision | **string** (int64)<br>Точность определения возраста данных, в секундах.  Значение должно быть больше 0.
configSpec.<br>clickhouse.<br>config.<br>maxConnections | **integer** (int64)<br>Максимальное количество входящих подключений.  Минимальная значение — 10.
configSpec.<br>clickhouse.<br>config.<br>maxConcurrentQueries | **integer** (int64)<br>Максимальное количество одновременно обрабатываемых запросов.  Минимальная значение — 10.
configSpec.<br>clickhouse.<br>config.<br>keepAliveTimeout | **integer** (int64)<br>Количество миллисекунд, в течение которых ClickHouse ожидает входящие запросы прежде чем закрыть подключение.
configSpec.<br>clickhouse.<br>config.<br>uncompressedCacheSize | **integer** (int64)<br>Размер кэша (в байтах) для несжатых данных, используемых таблицами MergeTree. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#uncompressed_cache_size).
configSpec.<br>clickhouse.<br>config.<br>markCacheSize | **integer** (int64)<br>Примерный размер (в байтах) кэша "меток", используемых таблицами MergeTree. Подробнее в [документации ClickHouse](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#mark_cache_size).  Значение должно быть больше 5368709120.
configSpec.<br>clickhouse.<br>config.<br>maxTableSizeToDrop | **integer** (int64)<br>Максимальный размер таблицы, которую можно удалить с помощью запроса DROP. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max_table_size_to_drop).
configSpec.<br>clickhouse.<br>config.<br>builtinDictionariesReloadInterval | **integer** (int64)<br>Интервал времени для перезагрузки встроенных словарей. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/en/operations/serv er_settings/settings/#builtin_dictionaries_reload_interval).
configSpec.<br>clickhouse.<br>resources | **object**<br>Ресурсы, выделенные хостам ClickHouse.
configSpec.<br>clickhouse.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types)
configSpec.<br>clickhouse.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
configSpec.<br>clickhouse.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
configSpec.<br>zookeeper | **object**<br>Конфигурация и ресурсы для сервера ZooKeeper.
configSpec.<br>zookeeper.<br>resources | **object**<br>Ресурсы, выделенные хостам ZooKeeper.
configSpec.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types)
configSpec.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
configSpec.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
databaseSpecs | **object**<br>Обязательное поле. Описания баз данных, которые нужно создать в кластере ClickHouse.  Должен содержать хотя бы один элемент.
databaseSpecs.<br>name | **string**<br>Обязательное поле. Имя базы данных ClickHouse. Длина имени должна быть от 1 до 63 символов.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
userSpecs | **object**<br>Обязательное поле. Описания пользователей базы данных, которых нужно создать в кластере ClickHouse.  Должен содержать хотя бы один элемент.
userSpecs.<br>name | **string**<br>Обязательное поле. Имя пользователя ClickHouse.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
userSpecs.<br>password | **string**<br>Обязательное поле. Пароль пользователя ClickHouse.  Длина строки в символах должна быть от 8 до 128.
userSpecs.<br>permissions | **object**<br>Набор разрешений, которые следует предоставить пользователю.
userSpecs.<br>permissions.<br>databaseName | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение.
hostSpecs | **object**<br>Обязательное поле. Конфигурации для отдельных хостов, которые должны быть созданы для кластера ClickHouse.  Должен содержать хотя бы один элемент.
hostSpecs.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [list](/docs/compute/api-ref/Zone/list).  Максимальная длина — 50 символов.
hostSpecs.<br>type | **string**<br>Обязательное поле. Тип развертываемого хоста.   - CLICKHOUSE: Хост ClickHouse.  - ZOOKEEPER: Хост ZooKeeper.<br>`CLICKHOUSE`<br>`ZOOKEEPER`<br>
hostSpecs.<br>subnetId | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.networkId](/docs/mdb/api-ref/clickhouse/Cluster#representation).  Максимальная длина — 50 символов.
hostSpecs.<br>assignPublicIp | **boolean** (boolean)<br>Должен ли хост получить публичный IP-адрес при создании.  После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля assignPublicIp.  Возможные значения: * false — не назначать хосту публичный IP-адрес. * true — у хоста должен быть публичный IP-адрес.
networkId | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер.  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор операции.
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
createdBy | **string**<br>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.
modifiedAt | **string** (date-time)<br>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
done | **boolean** (boolean)<br>Только для вывода. Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.
metadata | **object**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.
error | **object** <br> включает только одно из полей `error`, `response`<br><br>Описание ошибки в случае сбоя или отмены операции.
error.<br>code | **integer** (int32)<br>Код ошибки. Значение из списка [google.rpc.Code](https://cloud.google.com/appengine/docs/admin-api/reference/rpc/google.rpc#google.rpc.Code).
error.<br>message | **string**<br>Текст ошибки.
error.<br>details | **object**<br>Список сообщений с подробными сведениями об ошибке.
response | **object** <br> включает только одно из полей `error`, `response`<br><br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.