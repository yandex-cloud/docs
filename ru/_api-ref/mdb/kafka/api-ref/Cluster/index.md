---
editable: false
---

# Cluster
Набор методов для управления кластерами Apache Kafka®.
## JSON-представление {#representation}
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
    "kafka": {
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },

      // `config.kafka` включает только одно из полей `kafkaConfig_2_1`, `kafkaConfig_2_6`
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
      // конец списка возможных полей`config.kafka`

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
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит кластер Apache Kafka®.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов.</p> 
labels | **object**<br><p>Пользовательские метки для кластера Apache Kafka® в виде пар ``key:value``. Максимум 64 на ресурс.</p> 
environment | **string**<br><p>Среда развертывания кластера Apache Kafka®.</p> <ul> <li>PRODUCTION: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li> <li>PRESTABLE: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li> </ul> 
monitoring[] | **object**<br><p>Метаданные системы мониторинга.</p> 
monitoring[].<br>name | **string**<br><p>Название системы мониторинга.</p> 
monitoring[].<br>description | **string**<br><p>Описание системы мониторинга.</p> 
monitoring[].<br>link | **string**<br><p>Ссылка на графики системы мониторинга для кластера Apache Kafka®.</p> 
config | **object**<br><p>Конфигурация кластера Apache Kafka®.</p> 
config.<br>version | **string**<br><p>Версия Apache Kafka®, которая используется в кластере. Возможные значения: ``2.1``, ``2.6``.</p> 
config.<br>kafka | **object**<br><p>Конфигурация и распределение ресурсов для брокеров Kafka.</p> 
config.<br>kafka.<br>resources | **object**<br>
config.<br>kafka.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-kafka/concepts/instance-types">документации</a>.</p> 
config.<br>kafka.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>kafka.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> 
config.<br>kafka.<br>kafkaConfig_2_1 | **object** <br>`config.kafka` включает только одно из полей `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Конфигурация брокера Kafka версии 2.1.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>compressionType | **string**<br><p>Тип сжатия для топиков кластера.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: кодек задается на стороне производителя (допустимые кодеки: ``ZSTD``, ``LZ4``, ``GZIP`` или ``SNAPPY``).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMessages``.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushIntervalMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. Если значение не задано, то используется значение настройки ``logFlushSchedulerIntervalMs``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMs``.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>Частота проверки (в миллисекундах) наличия логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionBytes | **integer** (int64)<br><p>Ограничение размера раздела; Kafka отбросит старые сегменты лога, если , чтобы освободить место, если действует политика ``delete`` ``cleanupPolicy``. Этот настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionBytes``.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionHours | **integer** (int64)<br><p>Количество часов до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMinutes | **integer** (int64)<br><p>Количество минут до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionHours``.</p> 
config.<br>kafka.<br>kafkaConfig_2_1.<br>logRetentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionMinutes``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionMs``.</p> 
config.<br>kafka.<br>kafkaConfig_2_6 | **object** <br>`config.kafka` включает только одно из полей `kafkaConfig_2_1`, `kafkaConfig_2_6`<br><br><p>Конфигурация брокера Kafka версии 2.6.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>compressionType | **string**<br><p>Тип сжатия для топиков кластера.</p> <ul> <li>COMPRESSION_TYPE_UNCOMPRESSED: не использовать кодек (сообщения не сжимаются).</li> <li>COMPRESSION_TYPE_ZSTD: кодек Zstandard.</li> <li>COMPRESSION_TYPE_LZ4: Кодек LZ4.</li> <li>COMPRESSION_TYPE_SNAPPY: Кодек Snappy.</li> <li>COMPRESSION_TYPE_GZIP: кодек GZip.</li> <li>COMPRESSION_TYPE_PRODUCER: кодек задается на стороне производителя (допустимые кодеки: ``ZSTD``, ``LZ4``, ``GZIP`` или ``SNAPPY``).</li> </ul> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMessages | **integer** (int64)<br><p>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMessages``.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushIntervalMs | **integer** (int64)<br><p>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. Если значение не задано, то используется значение настройки ``logFlushSchedulerIntervalMs``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``flushMs``.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logFlushSchedulerIntervalMs | **integer** (int64)<br><p>Частота проверки (в миллисекундах) наличия логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionBytes | **integer** (int64)<br><p>Ограничение размера раздела; Kafka отбросит старые сегменты лога, чтобы освободить место, если действует политика ``delete`` ``cleanupPolicy``. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionBytes``.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionHours | **integer** (int64)<br><p>Количество часов до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMinutes | **integer** (int64)<br><p>Количество минут до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionHours``.</p> 
config.<br>kafka.<br>kafkaConfig_2_6.<br>logRetentionMs | **integer** (int64)<br><p>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога.</p> <p>Если значение не задано, то используется значение настройки ``logRetentionMinutes``.</p> <p>Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на уровне топика с помощью настройки ``retentionMs``.</p> 
config.<br>zookeeper | **object**<br><p>Конфигурация и распределение ресурсов для хостов ZooKeeper.</p> 
config.<br>zookeeper.<br>resources | **object**<br><p>Вычислительные ресурсы, выделенные хостам ZooKeeper.</p> 
config.<br>zookeeper.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-kafka/concepts/instance-types">документации</a>.</p> 
config.<br>zookeeper.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
config.<br>zookeeper.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> 
config.<br>zoneId[] | **string**<br><p>Идентификаторы зон доступности, в которых находятся брокеры Kafka.</p> 
config.<br>brokersCount | **integer** (int64)<br><p>Количество брокеров Kafka, развернутых в каждой зоне доступности.</p> 
config.<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно ``true``, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес.</p> 
networkId | **string**<br><p>Идентификатор сети, к которой принадлежит кластер.</p> 
health | **string**<br><p>Здоровье кластера.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` всех хостов в кластере — ``UNKNOWN``).</li> <li>ALIVE: Кластер работает нормально (``health`` всех хостов в кластере — ``ALIVE``).</li> <li>DEAD: Кластер не работает (``health`` всех хостов в кластере — ``DEAD``).</li> <li>DEGRADED: Кластер находится в состоянии деградации (``health`` по крайней мере одного из хостов в кластере — не ``ALIVE``).</li> </ul> 
status | **string**<br><p>Текущее состояние кластера.</p> <ul> <li>STATUS_UNKNOWN: Состояние кластера неизвестно.</li> <li>CREATING: Кластер создается.</li> <li>RUNNING: Кластер работает нормально.</li> <li>ERROR: В кластере произошла ошибка, блокирующая работу.</li> <li>UPDATING: Кластер изменяется.</li> <li>STOPPING: Кластер останавливается.</li> <li>STOPPED: Кластер остановлен.</li> <li>STARTING: Кластер запускается.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает новый кластер Apache Kafka® в указанном каталоге.
[delete](delete.md) | Удаляет указанный кластер Apache Kafka®.
[get](get.md) | Возвращает указанный кластер Apache Kafka®.
[list](list.md) | Получает список кластеров Apache Kafka®, принадлежащих указанному каталогу.
[listHosts](listHosts.md) | Получает список хостов для указанного кластера Apache Kafka®.
[listLogs](listLogs.md) | Получает логи для указанного кластера Apache Kafka®.
[listOperations](listOperations.md) | Получает список операций для указанного кластера Apache Kafka®.
[move](move.md) | Перемещает кластер Apache Kafka® в указанный каталог.
[start](start.md) | Запускает указанный кластер Apache Kafka®.
[stop](stop.md) | Останавливает указанный кластер Apache Kafka®.
[streamLogs](streamLogs.md) | То же самое, что [listLogs](/docs/managed-kafka/api-ref/Cluster/listLogs), с той разницей, что со стороны сервера передается поток логов. Допускается использовать семантику `tail -f` при работе с потоком логов.
[update](update.md) | Изменяет указанный кластер Apache Kafka®.