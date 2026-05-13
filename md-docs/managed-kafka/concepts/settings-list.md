# Настройки Apache Kafka®

Для кластера Managed Service for Apache Kafka® можно задать настройки, которые относятся к Apache Kafka®. Часть настроек задается [на уровне кластера](#cluster-settings), часть — [на уровне топиков](#topic-settings).

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md) или Terraform. Метка <code><b><small>Все интерфейсы</small></b></code> указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса одна и та же настройка будет представлена по-разному. Например, **Compression type** в консоли управления соответствует:

* `--compression-type` в CLI;
* `compression_type` в gRPC API и Terraform;
* `compressionType` в REST API.

## Настройки уровня кластера {#cluster-settings}

Доступны следующие настройки:

* **Auto create topics enable** <code><b><small>Все интерфейсы</small></b></code>{#settings-auto-create-topics}

    Управляет автоматическим созданием топиков.

    По умолчанию автоматическое создание топиков выключено (`false`).

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_auto.create.topics.enable).

* **Compression type** <code><b><small>Все интерфейсы</small></b></code> {#settings-compression-type}    

    Кодек, используемый для сжатия сообщений:

    | Консоль управления, Terraform и API | CLI            | Описание                                                                                         |
    | ---------------------------------- | -------------- | ------------------------------------------------------------------------------------------------ |
    | `COMPRESSION_TYPE_UNCOMPRESSED`    | `uncompressed` | Сжатие выключено                                                                                 |
    | `COMPRESSION_TYPE_ZSTD`            | `zstd`         | Кодек [zstd](https://facebook.github.io/zstd/)                                                   |
    | `COMPRESSION_TYPE_LZ4`             | `lz4`          | Кодек [lz4](https://lz4.github.io/lz4/)                                                          |
    | `COMPRESSION_TYPE_SNAPPY`          | `snappy`       | Кодек [snappy](https://github.com/google/snappy)                                                 |
    | `COMPRESSION_TYPE_GZIP`            | `gzip`         | Кодек [gzip](https://www.gzip.org)                                                               |
    | `COMPRESSION_TYPE_PRODUCER`        | `producer`     | Кодек задается на стороне [производителя](producers-consumers.md)|

    По умолчанию кодек для сжатия устанавливается производителем (`COMPRESSION_TYPE_PRODUCER`).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-compression-type). В консоли управления этой настройке соответствует **Тип сжатия**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_compression.type).

* **Default replication factor** <code><b><small>Все интерфейсы</small></b></code> {#settings-default-replication-factor}

    Количество [копий данных](brokers.md) для топика в кластере.

    Настройка применяется только для [автоматически создаваемых топиков](#settings-auto-create-topics).

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    См. также описание настройки уровня топика [Replication factor](#settings-topic-replication-factor).

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_default.replication.factor).

* **Log flush interval messages** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-flush-interval-messages}

    Количество сообщений топика, которое может накопиться в памяти прежде, чем эти сообщения будут записаны на диск. Например, если параметр равен `1`, запись на диск будет происходить после получения каждого сообщения, а если `5`, то сообщения будут записываться на диск группами по пять.

    Минимальное значение — `1`, максимальное значение и значение по умолчанию — `9223372036854775807`.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-flush-messages). В консоли управления этой настройке соответствует **Максимальное число сообщений в памяти**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.interval.messages).

* **Log flush interval ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-flush-interval-ms}

    Максимальное время в миллисекундах, в течение которого сообщение может храниться в памяти перед принудительным сбросом на диск. Если значение не задано, то используется значение настройки [Log flush scheduler interval ms](#settings-log-flush-scheduler-interval-ms).

    Максимальное значение — `9223372036854775807`.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-flush-ms).

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.interval.ms).

* **Log flush scheduler interval ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-flush-scheduler-interval-ms}

    Период времени (в миллисекундах), по истечении которого проверяется наличие логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.

    Максимальное значение и значение по умолчанию — `9223372036854775807`.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.flush.scheduler.interval.ms).

* **Log preallocate** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-preallocate}

    Определяет, будет ли заранее выделяться место под файлы сегментов лога.

    По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-preallocate).

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.preallocate).

* **Log retention bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-retention-bytes}    

    Максимальный размер (в байтах), до которого может вырасти раздел. Когда раздел достигнет заданного размера, Apache Kafka® начнет удалять старые сегменты лога. Настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`.

    Минимальное значение и значение по умолчанию — `-1` (размер лога не ограничивается), максимальное значение — `9223372036854775807`.

    Используйте эту настройку, если необходимо контролировать размер лога из-за ограниченного дискового пространства.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-retention-bytes). В консоли управления этой настройке соответствует **Максимальный размер раздела, байт**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.bytes).

    См. также настройку [Log retention ms](#settings-log-retention-ms).

* **Log retention hours** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-retention-hours}

    Время (в часах), в течение которого Apache Kafka® будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Значение по умолчанию — `168`.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.hours).

* **Log retention minutes** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-retention-minutes}

    Время (в минутах), в течение которого Apache Kafka® будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Максимальное значение — `2147483647`. Если значение не задано, то используется настройка [Log retention hours](#settings-log-retention-hours).

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.minutes).

* **Log retention ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-retention-ms}    

    Время (в миллисекундах), в течение которого Apache Kafka® будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Минимальное значение — `-1` (логи хранятся без ограничений по времени), максимальное значение — `9223372036854775807`. Если значение не задано, используется настройка [Log retention minutes](#settings-log-retention-minutes).

    {% note warning %}

    Если для настроек **Log retention bytes** и **Log retention ms** указано значение `-1`, лог растет неограниченно. Это может привести к быстрому исчерпанию места в хранилище кластера.

    {% endnote %}

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-log-retention-ms). В консоли управления этой настройке соответствует **Время жизни сегмента лога, мс**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.retention.ms).

    См. также настройку [Log retention bytes](#settings-log-retention-bytes).

* **Log segment bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-log-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким. 

    Минимальное значение — `14`, максимальное значение — `2147483647`, значение по умолчанию — `1073741824` (1 гигабайт).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-segment-bytes).

    Полное описание настройки см. в разделе [Максимальный размер сегмента логов](storage.md#maximum-log-segment-size) и в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_log.segment.bytes).

* **Message max bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-message-max-bytes}

    Максимальный размер сообщения от производителя (в байтах).

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048588`. Значение настройки связано со значением настройки [Replica fetch max bytes](#settings-replica-fetch-max-bytes) следующим образом:
    `replica.fetch.max.bytes >= message.max.bytes + 12`

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_message.max.bytes).

* **Num partitions** <code><b><small>Все интерфейсы</small></b></code> {#settings-num-partitions}

    Количество разделов лога на топик в кластере.

    Настройка применяется только для [автоматически создаваемых топиков](#settings-auto-create-topics).

    Минимальное значение и значение по умолчанию — `1`.

    См. также описание настройки уровня топика [Num partitions](#settings-topic-num-partitions).

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.partitions).

* **Offsets retention minutes** <code><b><small>Все интерфейсы</small></b></code> {#settings-offsets-retention-minutes}

    Время хранения смещений для неактивных [групп потребителей](producers-consumers.md#consumer-groups) (в минутах).

    Минимальное значение — `1`, значение по умолчанию — `10080`.

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_offsets.retention.minutes).

* **Replica fetch max bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-replica-fetch-max-bytes}

    Размер буфера межброкерных сообщений (в байтах).

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048576`. Значение настройки связано со значением настройки **Message max bytes** следующим образом:
    `message.max.bytes <= replica.fetch.max.bytes - 12` 

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_replica.fetch.max.bytes).

* **Sasl enabled mechanisms** <code><b><small>Все интерфейсы</small></b></code> {#settings-sasl-enabled-mechanisms}

    Механизмы шифрования, которые можно использовать при подключении к кластеру.

    Можно выбрать одно или несколько значений:

    | Консоль управления, Terraform и API | CLI             |
    | ---------------------------------- | --------------- |
    | `SASL_MECHANISM_SCRAM_SHA_256`     | `SCRAM-SHA-256` |
    | `SASL_MECHANISM_SCRAM_SHA_512`     | `SCRAM-SHA-512` |

    Если настройка не задана пользователем, используется только механизм `SCRAM-SHA-512`.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_sasl.enabled.mechanisms).

* **Socket receive buffer bytes** <code><b><small>Консоль управления</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>{#settings-socket-receive-buffer-bytes}

    Размер буфера для сокета приема (в байтах).

    Минимальное значение и значение по умолчанию — `-1` (используются настройки операционной системы), максимальное значение — `2147483647`.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.receive.buffer.bytes).

* **Socket send buffer bytes** <code><b><small>Консоль управления</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>{#settings-socket-send-buffer-bytes}

    Размер буфера для сокета отправки (в байтах).

    Минимальное значение и значение по умолчанию — `-1` (используются настройки операционной системы), максимальное значение — `2147483647`.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_socket.send.buffer.bytes).

* **Ssl cipher suites** <code><b><small>Все интерфейсы</small></b></code> {#settings-ssl-cipher-suites}

    Список алгоритмов шифрования кластера.

    Значение по умолчанию отсутствует (поддерживаются все наборы алгоритмов шифрования).

    Это глобальная настройка, которая задается на уровне кластера.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_ssl.cipher.suites).

## Настройки отдельных топиков {#topic-settings}

Доступны следующие настройки:

* **Cleanup policy** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-cleanup-policy}

    Политика хранения старых сообщений лога:

    * `Delete` (`CLEANUP_POLICY_DELETE` для Terraform и API) — удалять сегменты лога либо по истечении срока их хранения, либо при достижении предельного размера лога;
    * `Compact` (`CLEANUP_POLICY_COMPACT` для Terraform и API) — сжимать сообщения в логе;
    * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` для Terraform и API) — использовать как сжатие сообщений, так и удаление сегментов лога.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_cleanup.policy). В консоли управления этой настройке соответствует **Политика очистки лога**.

* **Compression type** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-compression-type}

    Кодек, используемый для сжатия сообщений.

    Подробнее см. в настройке уровня кластера [Compression type](#settings-compression-type).

    В консоли управления этой настройке соответствует **Тип сжатия**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_compression.type).

* **Delete delay, ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-file-delete-delay}

    Время ожидания перед удалением файла из файловой системы.

    В консоли управления этой настройке соответствует **Задержка удаления, мс**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_file.delete.delay.ms).

* **Delete retention** <code><b><small>Все интерфейсы</small></b></code> {#settings-delete-retention}

    Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. Эта настройка применяется только в том случае, если [политика очистки лога](#settings-topic-cleanup-policy) установлена в режим `Compact` или `CompactAndDelete`.

    Полное описание настройки см. [в документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_delete.retention.ms).

* **Flush messages** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-flush-messages}

    Количество сообщений топика, которое может накопиться в памяти прежде, чем эти сообщения будут записаны на диск.

    Подробнее см. в настройке уровня кластера [Log flush interval messages](#settings-log-flush-interval-messages).

    В консоли управления этой настройке соответствует **Максимальное число сообщений в памяти**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_flush.messages).

* **Flush, ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-flush-ms}

    Максимальное время в миллисекундах, в течение которого сообщение может храниться в памяти перед принудительным сбросом на диск.    

    Подробнее см. в настройке уровня кластера [Log flush interval ms](#settings-log-flush-interval-ms).

    В консоли управления этой настройке соответствует **Время хранения сообщения в памяти, мс**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_flush.ms).

* **Message max bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-message-max-bytes}    

    Максимальный размер сообщения от производителя в байтах.

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048588`. Значение настройки не должно превышать значение **Replica fetch max bytes** более, чем на 12 байт.

    В консоли управления этой настройке соответствует **Максимальный размер группы сообщений**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_max.message.bytes).

* **Min compaction lag, ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-max-compaction-lag-ms}    

    Минимальное время, в течение которого сообщение в логе будет оставаться несжатым.

    В консоли управления этой настройке соответствует **Минимальная задержка сжатия, мс**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.compaction.lag.ms).

* **Minimum number of in-sync replicas** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-min-insync-replicas}

    Минимальное количество реплик, от которых необходимо дождаться подтверждения записи, чтобы запись сообщения в топик считалась успешной. Используйте эту настройку, если производитель (Producer) ожидает подтверждения успешной записи от всех хостов-брокеров кластера слишком долго.

    Минимальное значение зависит от количества [хостов-брокеров](brokers.md):

    * для кластеров с одним хостом-брокером — `1`;
    * для кластеров с двумя и более хостами-брокерами — `2`.

    В консоли управления этой настройке соответствует **Минимальное число синхронных реплик**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_min.insync.replicas).

* **Num partitions** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-num-partitions}    

    Количество разделов лога на топик.

    Минимальное значение и значение по умолчанию — `1`.

    Подробнее см. в настройке уровня кластера [Num partitions](#settings-num-partitions).

    В консоли управления этой настройке соответствует **Количество разделов**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/broker-configs/#brokerconfigs_num.partitions).

* **Pre-allocation of the segment file** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-preallocate}    

    Определяет, будет ли заранее выделяться место под файлы сегментов лога. По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Подробнее см. в настройке уровня кластера [Log preallocate](#settings-log-preallocate).

    В консоли управления этой настройке соответствует **Предварительное выделение файла сегмента**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_preallocate).

* **Replication factor** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-replication-factor}

    Количество [копий данных](brokers.md) для топика.

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    Подробнее см. в настройке уровня кластера [Default replication factor](#settings-default-replication-factor).

    В консоли управления этой настройке соответствует **Фактор репликации**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/kafka-streams-configs/#streamsconfigs_replication.factor).

* **Retention, bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-retention-bytes}

    Максимальный размер (в байтах), до которого может вырасти раздел.

    Подробнее см. в настройке уровня кластера [Log retention bytes](#settings-log-retention-bytes).

    В консоли управления этой настройке соответствует **Максимальный размер раздела, байт**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_retention.bytes).

* **Retention, ms** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-log-retention-ms}

    Время (в миллисекундах), в течение которого Apache Kafka® будет хранить файл сегмента лога. 

    Подробнее см. в настройке уровня кластера [Log retention ms](#settings-log-retention-ms).

    В консоли управления этой настройке соответствует **Время жизни сегмента лога, мс**.

    Полное описание настройки см. в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_retention.ms).

* **Segment bytes** <code><b><small>Все интерфейсы</small></b></code> {#settings-topic-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким.

    Минимальное значение — `14`, значение по умолчанию — `1073741824` (1 гигабайт).

    Подробнее см. в настройке уровня кластера [Log segment bytes](#settings-log-segment-bytes).

    Полное описание настройки см. в разделе [Максимальный размер сегмента логов](storage.md#maximum-log-segment-size) и в [документации Apache Kafka®](https://kafka.apache.org/42/configuration/topic-configs/#topicconfigs_segment.bytes).