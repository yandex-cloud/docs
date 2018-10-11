# Метод restore
Создает новый кластер MongoDB с использованием указанной
резервной копии.
 

 
## HTTP-запрос
`POST /managed-mongodb/v1/clusters:restore`
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "backupId": "string",
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
backupId | **string**<br><p>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос <a href="/docs/mdb/api-ref/mongodb/Cluster/listBackups">listBackups</a>.</p> 
name | **string**<br><p>Обязательное поле. Имя не может быть изменено после создания кластера MongoDB.</p> <p>Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению <code>[a-zA-Z0-9_]+</code>.</p> 
description | **string**<br><p>Описание нового кластера MongoDB. Длина описания должна быть от 0 до 256 символов.</p> <p>Максимальная длина — 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера MongoDB в виде пар ключ-значение. Максимум 64 на ресурс. Например, &quot;project&quot;: &quot;mvp&quot; или &quot;source&quot;: &quot;dictionary&quot;.</p> <p>Не более 64 на ресурс. Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
environment | **string**<br><p>Обязательное поле. Среда развертывания для нового кластера MongoDB.</p> <p>Среда развертывания.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li> </ul> 
configSpec | **object**<br><p>Обязательное поле. Конфигурация для создаваемого кластера MongoDB.</p> 
configSpec.<br>version | **string**<br><p>Версия MongoDB, используемая в кластере. Единственное допустимое значение: 3.6</p> 
configSpec.<br>mongodbSpec_3_6 | **object** <br>`configSpec` включает только одно из полей `mongodbSpec_3_6`<br><br>
configSpec.<br>mongodbSpec_3_6.<br>mongod | **object**<br><p>Обязательное поле. Конфигурация и выделенные ресурсы для узла mongod.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config | **object**<br><p>Конфигурация для хоста mongod 3.6.</p> <p>Конфигурация демона mongod. Поддерживаемые опции являются ограниченным подмножеством всех опций, описанных в <a href="https://docs.mongodb.com/v3.6/reference/configuration-options/">документации MongoDB</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage | **object**<br><p><code>storage</code> section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger | **object**<br><p>Конфигурация механизма хранения WiredTiger.</p> <p>Конфигурация механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig | **object**<br><p>Конфигурация для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>engineConfig.<br>cacheSizeGb | **number** (double)<br><p>Максимальный размер внутреннего кэша, который WiredTiger будет использовать для всех данных.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig | **object**<br><p>Конфигурация коллекций для механизма хранения WiredTiger.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>wiredTiger.<br>collectionConfig.<br>blockCompressor | **string**<br><p>Тип сжатия по умолчанию, который следует использовать для данных коллекции.</p> <ul> <li>NONE: Без сжатия.</li> <li>SNAPPY: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-snappy">Snappy</a>.</li> <li>ZLIB: Алгоритм сжатия <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-zlib">zlib</a>.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal | **object**<br><p>Конфигурация <a href="https://docs.mongodb.com/v3.6/reference/glossary/#term-journal">журналов</a> MongoDB.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>enabled | **boolean** (boolean)<br><p>Включен ли журнал. Возможные значения:</p> <ul> <li>true (по умолчанию) — журнал включен.</li> <li>false — журнал отключен.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>storage.<br>journal.<br>commitInterval | **integer** (int64)<br><p>Максимальный интервал между операциями в журнале, в миллисекундах. По умолчанию: 100.</p> <p>Допустимые значения — от 1 до 500 включительно.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling | **object**<br><p><code>operationProfiling</code> section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>mode | **string**<br><p>Режим, который определяет критерии для профилирования операций.</p> <ul> <li>OFF: Профайлер выключен и не собирает никакие данные.</li> <li>SLOW_OP: Профайлер собирает данные для операций, которые производятся дольше, чем значение slowOpThreshold.</li> <li>ALL: Профайлер собирает данные для всех операций.</li> </ul> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>operationProfiling.<br>slowOpThreshold | **integer** (int64)<br><p>Порог времени для медленных операций, в миллисекундах. Операции, которые выполняются дольше этого порога, считаются медленными и обрабатываются профайлером, работающим в режиме SLOW_OP.</p> <p>Значение должно быть больше 0.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net | **object**<br><p><code>net</code> section of mongod configuration.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>config.<br>net.<br>maxIncomingConnections | **integer** (int64)<br><p>Максимальное количество одновременных подключений, которые принимает mongod.</p> <p>Допустимые значения — от 10 до 16384 включительно.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources | **object**<br><p>Обязательное поле. Ресурсы, выделенные хостам mongod.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/mdb/concepts/instance-types">Классы баз данных</a>.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступный хосту, в байтах.</p> 
configSpec.<br>mongodbSpec_3_6.<br>mongod.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>local-ssd — хранилище на базе локальных SSD-дисков.</li> </ul> 
hostSpecs | **object**<br><p>Обязательное поле. Конфигурации для хостов MongoDB, которые должны быть созданы для кластера, создаваемого из резервной копии.</p> <p>Должен содержать хотя бы один элемент.</p> 
hostSpecs.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина — 50 символов.</p> 
hostSpecs.<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле <a href="/docs/mdb/api-ref/mongodb/Cluster#representation">Cluster.networkId</a>.</p> <p>Максимальная длина — 50 символов.</p> 
hostSpecs.<br>assignPublicIp | **boolean** (boolean)<br><p>Должен ли хост получить публичный IP-адрес при создании.</p> <p>После создания узла этот параметр изменить нельзя. Чтобы удалить назначенный публичный IP-адрес или назначить публичный IP уже созданному хосту, пересоздайте хост с нужным значением поля assignPublicIp.</p> <p>Возможные значения:</p> <ul> <li>false — не назначать хосту публичный IP-адрес.</li> <li>true — у хоста должен быть публичный IP-адрес.</li> </ul> 
networkId | **string**<br><p>Обязательное поле. Обязательное поле. Идентификатор сети, в которой нужно создать кластер MongoDB.</p> <p>Максимальная длина — 50 символов.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Только для вывода. Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 