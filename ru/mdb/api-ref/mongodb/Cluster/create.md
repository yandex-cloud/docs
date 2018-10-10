# Метод create
Создает кластер MongoDB в указанном каталоге.
 

 
## HTTP-запрос
`POST /managed-mongodb/v1/clusters`
 
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

    // `configSpec`включает только одно из полей `mongodbSpec_3_6`
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
      "assignPublicIp": true
    }
  ],
  "networkId": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер MongoDB.  Максимальная длина — 50 символов.
name | **string**<br>Обязательное поле. Имя не может быть изменено после создания кластера MongoDB.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов.  Максимальная длина — 256 символов.
labels | **object**<br>Пользовательские метки для кластера MongoDB в виде пар ключ-значение. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary".  Не более 64 на ресурс.  Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.
environment | **string**<br>Обязательное поле. Среда развертывания кластера MongoDB.  Среда развертывания.   - PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.  - PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.<br>`PRODUCTION`<br>`PRESTABLE`<br>
configSpec | **object**<br>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера MongoDB.
configSpec.<br>version | **string**<br>Версия MongoDB, используемая в кластере. Единственное допустимое значение: 3.6
configSpec.<br>mongodbSpec_3_6 | **object** <br>`configSpec` включает только одно из полей `mongodbSpec_3_6`<br><br>
configSpec.<br>mongodbSpec_3_6.<br>mongod | **object**<br>Обязательное поле. Конфигурация и выделенные ресурсы для узла mongod.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config | **object**<br>Конфигурация для хоста mongod 3.6.  Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в [документации MongoDB](https://docs.mongodb.com/v3.6/reference/configuration-options/).
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage | **object**<br>`storage` section of mongod configuration.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br>Конфигурация механизма хранения WiredTiger.  Конфигурация механизма хранения WiredTiger.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br>Конфигурация для механизма хранения WiredTiger.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br>Конфигурация коллекций для механизма хранения WiredTiger.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br>Тип сжатия по умолчанию, который следует использовать для данных коллекции.   - NONE: Без сжатия.  - SNAPPY: Алгоритм сжатия [Snappy](https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy).  - ZLIB: Алгоритм сжатия [zlib](https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib).<br>`NONE`<br>`SNAPPY`<br>`ZLIB`<br>
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br>Конфигурация [журналов](https://docs.mongodb.com/v3.6/reference/glossary/#term-journal) MongoDB.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br>Включен ли журнал. Возможные значения: * true (по умолчанию) — журнал включен. * false — журнал отключен.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.  Допустимые значения — от 1 до 500 включительно.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling | **object**<br>`operationProfiling` section of mongod configuration.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br>Режим, который определяет критерии для профилирования операций.   - OFF: Профайлер выключен и не собирает никакие данные.  - SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.  - ALL: Профайлер собирает данные для всех операций.<br>`OFF`<br>`SLOW_OP`<br>`ALL`<br>
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.  Значение должно быть больше 0.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net | **object**<br>`net` section of mongod configuration.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br>Максимальное количество одновременных подключений, которые принимает mongod.  Допустимые значения — от 10 до 16384 включительно.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources | **object**<br>Обязательное поле. Ресурсы, выделенные хостам mongod.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
databaseSpecs | **object**<br>Обязательное поле. Описания баз данных, которые нужно создать в кластере MongoDB.  Должен содержать хотя бы один элемент.
databaseSpecs.<br>name | **string**<br>Обязательное поле. Имя базы данных MongoDB. Длина имени должна быть от 1 до 63 символов.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
userSpecs | **object**<br>Обязательное поле. Описания пользователей базы данных, которых нужно создать в кластере MongoDB.  Должен содержать хотя бы один элемент.
userSpecs.<br>name | **string**<br>Обязательное поле. Имя пользователя MongoDB.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]+ ``.
userSpecs.<br>password | **string**<br>Обязательное поле. Пароль пользователя MongoDB.  Длина строки в символах должна быть от 8 до 128.
userSpecs.<br>permissions | **object**<br>Набор разрешений, которые следует предоставить пользователю.
userSpecs.<br>permissions.<br>databaseName | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение.
userSpecs.<br>permissions.<br>roles | **string**<br>Роли MongoDB базы данных databaseName, которые предоставляет разрешение.
hostSpecs | **object**<br>Обязательное поле. Конфигурации для отдельных хостов, которые должны быть созданы для кластера MongoDB.  Должен содержать хотя бы один элемент.
hostSpecs.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [list](/docs/compute/api-ref/Zone/list).  Максимальная длина — 50 символов.
hostSpecs.<br>subnetId | **string**<br>Идентификатор подсети, к которой принадлежит хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле [Cluster.networkId](/docs/mdb/api-ref/mongodb/Cluster#representation).  Максимальная длина — 50 символов.
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