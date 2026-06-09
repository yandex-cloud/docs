# Настройки Apache Kafka®

Для кластера {{ mkf-name }} можно задать настройки, которые относятся к {{ KF }}. Часть настроек задается [на уровне кластера](#cluster-settings), часть — [на уровне топиков](#topic-settings).

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md) или {{ TF }}. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса одна и та же настройка будет представлена по-разному. Например, **Compression type** в консоли управления соответствует:

* `--compression-type` в CLI;
* `compression_type` в gRPC API и {{ TF }};
* `compressionType` в REST API.

## Настройки уровня кластера {#cluster-settings}

Доступны следующие настройки:

* **Auto create topics enable** {{ tag-all }}{#settings-auto-create-topics}

    Управляет автоматическим созданием топиков.

    По умолчанию автоматическое создание топиков выключено (`false`).

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_auto.create.topics.enable).

* **Compression type** {{ tag-all }} {#settings-compression-type}    

    Кодек, используемый для сжатия сообщений:

    | Консоль управления, {{ TF }} и API | CLI            | Описание                                                                                         |
    | ---------------------------------- | -------------- | ------------------------------------------------------------------------------------------------ |
    | `COMPRESSION_TYPE_UNCOMPRESSED`    | `uncompressed` | Сжатие выключено                                                                                 |
    | `COMPRESSION_TYPE_ZSTD`            | `zstd`         | Кодек [zstd](https://facebook.github.io/zstd/)                                                   |
    | `COMPRESSION_TYPE_LZ4`             | `lz4`          | Кодек [lz4](https://lz4.github.io/lz4/)                                                          |
    | `COMPRESSION_TYPE_SNAPPY`          | `snappy`       | Кодек [snappy](https://github.com/google/snappy)                                                 |
    | `COMPRESSION_TYPE_GZIP`            | `gzip`         | Кодек [gzip](https://www.gzip.org)                                                               |
    | `COMPRESSION_TYPE_PRODUCER`        | `producer`     | Кодек задается на стороне [производителя](producers-consumers.md)|

    По умолчанию кодек для сжатия устанавливается производителем (`COMPRESSION_TYPE_PRODUCER`).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-compression-type). В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-compression-type }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_compression.type).

* **Default replication factor** {{ tag-all }} {#settings-default-replication-factor}

    Количество [копий данных](brokers.md) для топика в кластере.

    Настройка применяется только для [автоматически создаваемых топиков](#settings-auto-create-topics).

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    См. также описание настройки уровня топика [Replication factor](#settings-topic-replication-factor).

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_default.replication.factor).

* **Log flush interval messages** {{ tag-all }} {#settings-log-flush-interval-messages}

    Количество сообщений топика, которое может накопиться в памяти прежде, чем эти сообщения будут записаны на диск. Например, если параметр равен `1`, запись на диск будет происходить после получения каждого сообщения, а если `5`, то сообщения будут записываться на диск группами по пять.

    Минимальное значение — `1`, максимальное значение и значение по умолчанию — `9223372036854775807`.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-flush-messages). В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-flush-messages }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.interval.messages).

* **Log flush interval ms** {{ tag-all }} {#settings-log-flush-interval-ms}

    Максимальное время в миллисекундах, в течение которого сообщение может храниться в памяти перед принудительным сбросом на диск. Если значение не задано, то используется значение настройки [Log flush scheduler interval ms](#settings-log-flush-scheduler-interval-ms).

    Максимальное значение — `9223372036854775807`.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-flush-ms).

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.interval.ms).

* **Log flush scheduler interval ms** {{ tag-all }} {#settings-log-flush-scheduler-interval-ms}

    Период времени (в миллисекундах), по истечении которого проверяется наличие логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.

    Максимальное значение и значение по умолчанию — `9223372036854775807`.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.scheduler.interval.ms).

* **Log preallocate** {{ tag-all }} {#settings-log-preallocate}

    Определяет, будет ли заранее выделяться место под файлы сегментов лога.

    По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-preallocate).

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.preallocate).

* **Log retention bytes** {{ tag-all }} {#settings-log-retention-bytes}    

    Максимальный размер (в байтах), до которого может вырасти раздел. Когда раздел достигнет заданного размера, {{ KF }} начнет удалять старые сегменты лога. Настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`.

    Минимальное значение и значение по умолчанию — `-1` (размер лога не ограничивается), максимальное значение — `9223372036854775807`.

    Используйте эту настройку, если необходимо контролировать размер лога из-за ограниченного дискового пространства.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-retention-bytes). В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-retention-bytes }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.bytes).

    См. также настройку [Log retention ms](#settings-log-retention-ms).

* **Log retention hours** {{ tag-all }} {#settings-log-retention-hours}

    Время (в часах), в течение которого {{ KF }} будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Значение по умолчанию — `168`.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.hours).

* **Log retention minutes** {{ tag-all }} {#settings-log-retention-minutes}

    Время (в минутах), в течение которого {{ KF }} будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Максимальное значение — `2147483647`. Если значение не задано, то используется настройка [Log retention hours](#settings-log-retention-hours).

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.minutes).

* **Log retention ms** {{ tag-all }} {#settings-log-retention-ms}    

    Время (в миллисекундах), в течение которого {{ KF }} будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Минимальное значение — `-1` (логи хранятся без ограничений по времени), максимальное значение — `9223372036854775807`. Если значение не задано, используется настройка [Log retention minutes](#settings-log-retention-minutes).

    {% note warning %}

    Если для настроек **Log retention bytes** и **Log retention ms** указано значение `-1`, лог растет неограниченно. Это может привести к быстрому исчерпанию места в хранилище кластера.

    {% endnote %}

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-log-retention-ms). В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.ms).

    См. также настройку [Log retention bytes](#settings-log-retention-bytes).

* **Log segment bytes** {{ tag-all }} {#settings-log-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким. 

    Минимальное значение — `14`, максимальное значение — `2147483647`, значение по умолчанию — `1073741824` (1 гигабайт).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-segment-bytes).

    Полное описание настройки приведено в разделе [{#T}](storage.md#maximum-log-segment-size) и в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.segment.bytes).

* **Message max bytes** {{ tag-all }} {#settings-message-max-bytes}

    Максимальный размер сообщения от производителя (в байтах).

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048588`. Значение настройки связано со значением настройки [Replica fetch max bytes](#settings-replica-fetch-max-bytes) следующим образом:
    `replica.fetch.max.bytes >= message.max.bytes + 12`

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_message.max.bytes).

* **Num partitions** {{ tag-all }} {#settings-num-partitions}

    Количество разделов лога на топик в кластере.

    Настройка применяется только для [автоматически создаваемых топиков](#settings-auto-create-topics).

    Минимальное значение и значение по умолчанию — `1`.

    См. также описание настройки уровня топика [Num partitions](#settings-topic-num-partitions).

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.partitions).

* **Offsets retention minutes** {{ tag-all }} {#settings-offsets-retention-minutes}

    Время хранения смещений для неактивных [групп потребителей](producers-consumers.md#consumer-groups) (в минутах).

    Минимальное значение — `1`, значение по умолчанию — `10080`.

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.retention.minutes).

* **Replica fetch max bytes** {{ tag-all }} {#settings-replica-fetch-max-bytes}

    Размер буфера межброкерных сообщений (в байтах).

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048576`. Значение настройки связано со значением настройки **Message max bytes** следующим образом:
    `message.max.bytes <= replica.fetch.max.bytes - 12` 

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.max.bytes).

* **Sasl enabled mechanisms** {{ tag-all }} {#settings-sasl-enabled-mechanisms}

    Механизмы шифрования, которые можно использовать при подключении к кластеру.

    Можно выбрать одно или несколько значений:

    | Консоль управления, {{ TF }} и API | CLI             |
    | ---------------------------------- | --------------- |
    | `SASL_MECHANISM_SCRAM_SHA_256`     | `SCRAM-SHA-256` |
    | `SASL_MECHANISM_SCRAM_SHA_512`     | `SCRAM-SHA-512` |

    Если настройка не задана пользователем, используется только механизм `SCRAM-SHA-512`.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.enabled.mechanisms).

* **Socket receive buffer bytes** {{ tag-con }} {{ tag-tf }} {{ tag-api }}{#settings-socket-receive-buffer-bytes}

    Размер буфера для сокета приема (в байтах).

    Минимальное значение и значение по умолчанию — `-1` (используются настройки операционной системы), максимальное значение — `2147483647`.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.receive.buffer.bytes).

* **Socket send buffer bytes** {{ tag-con }} {{ tag-tf }} {{ tag-api }}{#settings-socket-send-buffer-bytes}

    Размер буфера для сокета отправки (в байтах).

    Минимальное значение и значение по умолчанию — `-1` (используются настройки операционной системы), максимальное значение — `2147483647`.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.send.buffer.bytes).

* **Ssl cipher suites** {{ tag-all }} {#settings-ssl-cipher-suites}

    Список алгоритмов шифрования кластера.

    Значение по умолчанию отсутствует (поддерживаются все наборы алгоритмов шифрования).

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.cipher.suites).

## Настройки отдельных топиков {#topic-settings}

Доступны следующие настройки:

* **Cleanup policy** {{ tag-all }} {#settings-topic-cleanup-policy}

    Политика хранения старых сообщений лога:

    * `Delete` (`CLEANUP_POLICY_DELETE` для {{ TF }} и API) — удалять сегменты лога либо по истечении срока их хранения, либо при достижении предельного размера лога;
    * `Compact` (`CLEANUP_POLICY_COMPACT` для {{ TF }} и API) — сжимать сообщения в логе;
    * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` для {{ TF }} и API) — использовать как сжатие сообщений, так и удаление сегментов лога.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_cleanup.policy). В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**.

* **Compression type** {{ tag-all }} {#settings-topic-compression-type}

    Кодек, используемый для сжатия сообщений.

    Подробнее в настройке уровня кластера [Compression type](#settings-compression-type).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-compression-type }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_compression.type).

* **Delete delay, ms** {{ tag-all }} {#settings-topic-file-delete-delay}

    Время ожидания перед удалением файла из файловой системы.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-delete-delay }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_file.delete.delay.ms).

* **Delete retention** {{ tag-all }} {#settings-delete-retention}

    Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. Эта настройка применяется только в том случае, если [политика очистки лога](#settings-topic-cleanup-policy) установлена в режим `Compact` или `CompactAndDelete`.

    Полное описание настройки см. [в документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_delete.retention.ms).

* **Flush messages** {{ tag-all }} {#settings-topic-flush-messages}

    Количество сообщений топика, которое может накопиться в памяти прежде, чем эти сообщения будут записаны на диск.

    Подробнее в настройке уровня кластера [Log flush interval messages](#settings-log-flush-interval-messages).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-flush-messages }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_flush.messages).

* **Flush, ms** {{ tag-all }} {#settings-topic-flush-ms}

    Максимальное время в миллисекундах, в течение которого сообщение может храниться в памяти перед принудительным сбросом на диск.    

    Подробнее в настройке уровня кластера [Log flush interval ms](#settings-log-flush-interval-ms).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-flush-ms }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_flush.ms).

* **Message max bytes** {{ tag-all }} {#settings-topic-message-max-bytes}    

    Максимальный размер сообщения от производителя в байтах.

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048588`. Значение настройки не должно превышать значение **Replica fetch max bytes** более, чем на 12 байт.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_max-message-bytes }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_max.message.bytes).

* **Min compaction lag, ms** {{ tag-all }} {#settings-topic-max-compaction-lag-ms}    

    Минимальное время, в течение которого сообщение в логе будет оставаться несжатым.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-min-compaction-lag }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.compaction.lag.ms).

* **Minimum number of in-sync replicas** {{ tag-all }} {#settings-topic-min-insync-replicas}

    Минимальное количество реплик, от которых необходимо дождаться подтверждения записи, чтобы запись сообщения в топик считалась успешной. Используйте эту настройку, если производитель (Producer) ожидает подтверждения успешной записи от всех хостов-брокеров кластера слишком долго.

    Минимальное значение зависит от количества [хостов-брокеров](brokers.md):

    * для кластеров с одним хостом-брокером — `1`;
    * для кластеров с двумя и более хостами-брокерами — `2`.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_min-insync-replicas }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.insync.replicas).

* **Num partitions** {{ tag-all }} {#settings-topic-num-partitions}    

    Количество разделов лога на топик.

    Минимальное значение и значение по умолчанию — `1`.

    Подробнее в настройке уровня кластера [Num partitions](#settings-num-partitions).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_partitions }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.partitions).

* **Pre-allocation of the segment file** {{ tag-all }} {#settings-topic-preallocate}    

    Определяет, будет ли заранее выделяться место под файлы сегментов лога. По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Подробнее в настройке уровня кластера [Log preallocate](#settings-log-preallocate).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-preallocate }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_preallocate).

* **Replication factor** {{ tag-all }} {#settings-topic-replication-factor}

    Количество [копий данных](brokers.md) для топика.

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    Подробнее в настройке уровня кластера [Default replication factor](#settings-default-replication-factor).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_replication-factor }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/kafka-streams-configs/#streamsconfigs_replication.factor).

* **Retention, bytes** {{ tag-all }} {#settings-topic-retention-bytes}

    Максимальный размер (в байтах), до которого может вырасти раздел.

    Подробнее в настройке уровня кластера [Log retention bytes](#settings-log-retention-bytes).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-retention-bytes }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_retention.bytes).

* **Retention, ms** {{ tag-all }} {#settings-topic-log-retention-ms}

    Время (в миллисекундах), в течение которого {{ KF }} будет хранить файл сегмента лога. 

    Подробнее в настройке уровня кластера [Log retention ms](#settings-log-retention-ms).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}**.

    Полное описание настройки приведено в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_retention.ms).

* **Segment bytes** {{ tag-all }} {#settings-topic-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким.

    Минимальное значение — `14`, значение по умолчанию — `1073741824` (1 гигабайт).

    Подробнее в настройке уровня кластера [Log segment bytes](#settings-log-segment-bytes).

    Полное описание настройки приведено в разделе [{#T}](storage.md#maximum-log-segment-size) и в [документации {{ KF }}](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_segment.bytes).