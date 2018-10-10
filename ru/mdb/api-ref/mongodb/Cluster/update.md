# Метод update
Изменяет указанный кластер MongoDB.
 

 
## HTTP-запрос
`PATCH /managed-mongodb/v1/clusters/{clusterId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор изменяемого ресурса Cluster для MongoDB. Чтобы получить идентификатор кластера MongoDB, используйте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).  Максимальная длина — 50 символов.
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "updateMask": "string",
  "description": "string",
  "labels": "object",
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

  }
}
```

 
Поле | Описание
--- | ---
updateMask | **string**<br>Маска, которая указывает, какие поля ресурса Cluster для MongoDB должны быть изменены.  Имена всех обновляемых полей, разделенные запятыми. Только значения указанных полей будут изменены. Остальные останутся нетронутыми. Если поле указано в параметре `` update_mask `` и в запросе не было отправлено значение для этого поля, значение поля будет сброшено на значение по умолчанию. Значение по умолчанию для большинства полей — null или 0.  Если в запросе не передается `` update_mask ``, значения всех полей будут обновлены. Для полей, указанных в запросе, будут использованы переданные значения. Значения остальных полей будут сброшены на значения по умолчанию.
description | **string**<br>Новое описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов.  Максимальная длина — 256 символов.
labels | **object**<br>Пользовательские метки для кластера MongoDB в виде пар ключ-значение. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary".  Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [get](/docs/mdb/api-ref/mongodb/Cluster/get), затем отправьте запрос [update](/docs/mdb/api-ref/mongodb/Cluster/update), добавив новую метку в этот набор.  Не более 64 на ресурс.  Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.
configSpec | **object**<br>Новая конфигурация и ресурсы для хостов кластера.
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