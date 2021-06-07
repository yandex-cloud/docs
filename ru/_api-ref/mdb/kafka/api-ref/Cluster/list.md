---
editable: false
---

# Метод list
Получает список кластеров Apache Kafka®, принадлежащих указанному каталогу.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров Apache Kafka®.  Чтобы получить идентификатор каталога, выполните запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем [pageSize](/docs/managed-kafka/api-ref/Cluster/list#query_params), сервис вернет значение [nextPageToken](/docs/managed-kafka/api-ref/Cluster/list#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение [pageToken](/docs/managed-kafka/api-ref/Cluster/list#query_params) равным значению поля [nextPageToken](/docs/managed-kafka/api-ref/Cluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Выражение, позволяющее отфильтровать информацию о ресурсах в ответе, оставив только нужную.  В этом выражении должны быть указаны: 1. Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю [Cluster.name](/docs/managed-kafka/api-ref/Cluster#representation). 2. Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. 3. Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.  Пример фильтра: `name NOT IN 'test,beta'`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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
        "kafka": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },

          // `clusters[].config.kafka` включает только одно из полей `kafkaConfig_2_1`, `kafkaConfig_2_6`
          "kafkaConfig_2_1": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer"
          },
          "kafkaConfig_2_6": {
            "compressionType": "string",
            "logFlushIntervalMessages": "integer",
            "logFlushIntervalMs": "integer",
            "logFlushSchedulerIntervalMs": "integer",
            "logRetentionBytes": "integer",
            "logRetentionHours": "integer",
            "logRetentionMinutes": "integer",
            "logRetentionMs": "integer"
          },
          // конец списка возможных полей`clusters[].config.kafka`

        },
        "zookeeper": {
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          }
        },
        "zoneId": [
          "string"
        ],
        "brokersCount": "integer",
        "assignPublicIp": true
      },
      "networkId": "string",
      "health": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
clusters[] | **object**<br><p>Кластер Apache Kafka. Подробнее читайте в разделе <a href="/docs/managed-kafka/concepts">Концепции</a>.</p> 
clusters[].<br>id | **string**<br><p>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера.</p> 
clusters[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Apache Kafka®.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
clusters[].<br>name | **string**<br><p>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению ``[a-zA-Z0-9_-]*``.</p> 
clusters[].<br>description | **string**<br><p>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов.</p> 
clusters[].<br>labels | **object**<br><p>Пользовательские метки для кластера Apache Kafka® в виде пар ``key:value``. Максимум 64 на ресурс.</p> 
clusters[].<br>environment | **string**<br><p>Среда развертывания кластера Apache Kafka®.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li> </ul> 
clusters[].<br>monitoring[] | **object**<br><p>Метаданные системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
clusters[].<br>monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера Apache Kafka®.</p> 
clusters[].<br>config | **object**<br><p>Конфигурация кластера Apache Kafka®.</p> 
clusters[].<br>config.<br>version | **string**<br><p>Версия Apache Kafka®, которая используется в кластере. Возможные значения: ``2.1``, ``2.6``.</p> 
clusters[].<br>config.<br>kafka | **object**<br><p>Конфигурация и распределение ресурсов для брокеров Kafka.</p> 
clusters[].<br>config.<br>kafka.<br>resources | **object**<br>Вычислительные ресурсы, выделенные брокерам Kafka.<br>
clusters[].<br>config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-kafka/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
clusters[].<br>config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1 | **object** <br>`clusters[].config.kafka` включает только одно из полей `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Конфигурация брокера Kafka версии 2.1.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для топиков кластера.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: кодек задается на стороне производителя (допустимые кодеки: ``ZSTD``, ``LZ4``, ``GZIP`` или ``SNAPPY``).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMessages``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. Если значение не задано, то используется значение настройки ``logFlushSchedulerIntervalMs``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMs``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>Частота проверки (в миллисекундах) наличия логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Ограничение размера раздела; Kafka отбросит старые сегменты лога, если , чтобы освободить место, если действует политика ``delete`` ``cleanupPolicy``. Этот настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionBytes``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>Количество часов до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>Количество минут до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionHours``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionMinutes``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionMs``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6 | **object** <br>`clusters[].config.kafka` включает только одно из полей `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Конфигурация брокера Kafka версии 2.6.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>compressionType | **string**<br><p>Тип сжатия для топиков кластера.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: кодек задается на стороне производителя (допустимые кодеки: ``ZSTD``, ``LZ4``, ``GZIP`` или ``SNAPPY``).</li> </ul> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMessages``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. Если значение не задано, то используется значение настройки ``logFlushSchedulerIntervalMs``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMs``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>Частота проверки (в миллисекундах) наличия логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionBytes | **integer** (int64)<br><p>Ограничение размера раздела; Kafka отбросит старые сегменты лога, чтобы освободить место, если действует политика ``delete`` ``cleanupPolicy``. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionBytes``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionHours | **integer** (int64)<br><p>Количество часов до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMinutes | **integer** (int64)<br><p>Количество минут до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionHours``.</p> 
clusters[].<br>config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionMinutes``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionMs``.</p> 
clusters[].<br>config.<br>zookeeper | **object**<br><p>Конфигурация и распределение ресурсов для хостов ZooKeeper.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources | **object**<br><p>Вычислительные ресурсы, выделенные хостам ZooKeeper.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-kafka/concepts/instance-types">документации</a>.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
clusters[].<br>config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> 
clusters[].<br>config.<br>zoneId[] | **string**<br><p>Идентификаторы зон доступности, в которых находятся брокеры Kafka.</p> 
clusters[].<br>config.<br>brokersCount | **integer** (int64)<br><p>Количество брокеров Kafka, развернутых в каждой зоне доступности.</p> 
clusters[].<br>config.<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно ``true``, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес.</p> 
clusters[].<br>networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
clusters[].<br>health | **string**<br><p>Здоровье кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` всех хостов в кластере — ``UNKNOWN``).</li> <li>ALIVE: Кластер работает нормально (``health`` всех хостов в кластере — ``ALIVE``).</li> <li>DEAD: Кластер не работает (``health`` всех хостов в кластере — ``DEAD``).</li> <li>DEGRADED: Кластер находится в состоянии деградации (``health`` по крайней мере одного из хостов в кластере — не ``ALIVE``).</li> </ul> 
clusters[].<br>status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: В кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageSize</a>, используйте <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-kafka/api-ref/Cluster/list#query_params">pageToken</a> в следующем запросе. Все последующие запросы будут получать свои значения <a href="/docs/managed-kafka/api-ref/Cluster/list#responses">nextPageToken</a> для перебора страниц результатов.</p> 