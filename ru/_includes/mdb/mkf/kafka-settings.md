* **Auto create topics enable** {{ tag-con }} {#settings-auto-create-topics}

    Управляет автоматическим созданием топиков.

    По умолчанию автоматическое создание топиков выключено (`false`).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_auto.create.topics.enable).

* **Compression type** {{ tag-all }} {#settings-compression-type}

    В консоли управления этой настройке соответствует **Тип сжатия**.

    Кодек, используемый для сжатия сообщений:

    |Консоль управления|CLI           |{{ TF }} и API                 |Описание                                        |
    |------------------|--------------|-------------------------------|------------------------------------------------|
    |`Uncompressed`    |`uncompressed`|`COMPRESSION_TYPE_UNCOMPRESSED`|Сжатие выключено                                |
    |`Zstd`            |`zstd`        |`COMPRESSION_TYPE_ZSTD`        |Кодек [zstd](https://facebook.github.io/zstd/)  |
    |`Lz4`             |`lz4`         |`COMPRESSION_TYPE_LZ4`         |Кодек [lz4](https://lz4.github.io/lz4/)         |
    |`Snappy`          |`snappy`      |`COMPRESSION_TYPE_SNAPPY`      |Кодек [snappy](https://github.com/google/snappy)|
    |`Gzip`            |`gzip`        |`COMPRESSION_TYPE_GZIP`        |Кодек [gzip](https://www.gzip.org)              |
    |`Producer`        |`producer`    |`COMPRESSION_TYPE_PRODUCER`    |Кодек задается на стороне [производителя](../../../managed-kafka/concepts/producers-consumers.md)|

    По умолчанию кодек для сжатия устанавливается производителем (`COMPRESSION_TYPE_PRODUCER`).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-compression-type).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_compression.type).

* **Default replication factor** {{ tag-all }} {#settings-default-replication-factor}

    Количество [копий данных](../../../managed-kafka/concepts/brokers.md) для топика в кластере.

    Настройка применяется только для [автоматически создаваемых топиков](#settings-auto-create-topics).

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    См. также описание настройки уровня топика [Replication factor](#settings-topic-replication-factor).

    Подробнее см. в [документации {{ KF }}](http://kafka.apache.org/documentation/#brokerconfigs_default.replication.factor).

* **Log flush interval messages** {{ tag-all }} {#settings-log-flush-interval-messages}

    В консоли управления этой настройке соответствует **Максимальное число сообщений в памяти**.

    Количество сообщений топика, которое может накопиться в памяти прежде, чем эти сообщения будут записаны на диск. Например, если параметр равен `1`, запись на диск будет происходить после получения каждого сообщения, а если `5`, то сообщения будут записываться на диск группами по пять.

    Минимальное значение — `1`, максимальное значение и значение по умолчанию — `9223372036854775807`.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-flush-messages).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#flush.messages).

* **Log flush interval ms** {{ tag-all }} {#settings-log-flush-interval-ms}

    Максимальное время в миллисекундах, в течение которого сообщение может храниться в памяти перед принудительным сбросом на диск. Если значение не задано, то используется значение настройки [Log flush scheduler interval ms](#settings-log-flush-scheduler-interval-ms).

    Максимальное значение — `9223372036854775807`.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-flush-ms).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#flush.ms).

* **Log flush scheduler interval ms** {{ tag-all }} {#settings-log-flush-scheduler-interval-ms}

    Период времени (в миллисекундах), по истечении которого проверяется наличие логов, которые нужно сбросить на диск. Эта проверка выполняется процессом, ответственным за сброс логов.

    Максимальное значение и значение по умолчанию — `9223372036854775807`.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.flush.scheduler.interval.ms).

* **Log preallocate** {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {#settings-log-preallocate}

    Определяет, будет ли заранее выделяться место под файлы сегментов лога.

    По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-preallocate).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.preallocate).

* **Log retention bytes** {{ tag-all }} {#settings-log-retention-bytes}

    В консоли управления этой настройке соответствует **Максимальный размер раздела, байт**.

    Максимальный размер (в байтах), до которого может вырасти раздел. Когда раздел достигнет заданного размера, {{ KF }} начнет удалять старые сегменты лога. Настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`.

    Минимальное значение и значение по умолчанию — `-1` (размер лога не ограничивается), максимальное значение — `9223372036854775807`.

    Используйте эту настройку, если необходимо контролировать размер лога из-за ограниченного дискового пространства.

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-retention-bytes).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.bytes).

    См. также настройку [Log retention ms](#settings-log-retention-ms).

* **Log retention hours** {{ tag-all }} {#settings-log-retention-hours}

    Время (в часах), в течение которого {{ KF }} будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Максимальное значение и значение по умолчанию — `168`.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.hours).

* **Log retention minutes** {{ tag-all }} {#settings-log-retention-minutes}

    Время (в минутах), в течение которого {{ KF }} будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Максимальное значение — `2147483647`. Если значение не задано, то используется настройка [Log retention hours](#settings-log-retention-hours).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.retention.minutes).

* **Log retention ms** {{ tag-all }} {#settings-log-retention-ms}

    В консоли управления этой настройке соответствует **Время жизни сегмента лога, мс**.

    Время (в миллисекундах), в течение которого {{ KF }} будет хранить файл сегмента лога. Эта настройка применяется, если действует [политика очистки лога](#settings-topic-cleanup-policy) `Delete`: по истечении заданного времени файл сегмента будет удален.

    Минимальное значение — `-1` (логи хранятся без ограничений по времени), максимальное значение — `9223372036854775807`. Если значение не задано, используется настройка [Log retention minutes](#settings-log-retention-minutes).

    {% note warning %}

    Если для настроек **Log retention bytes** и **Log retention ms** указано значение `-1`, лог растет неограниченно. Это может привести к быстрому исчерпанию места в хранилище кластера.

    {% endnote %}

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-log-retention-ms).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#retention.ms).

    См. также настройку [Log retention bytes](#settings-log-retention-bytes).

* **Log segment bytes** {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {#settings-log-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким. 

    Минимальное значение — `14`, максимальное значение — `2147483647`, значение по умолчанию — `1073741824` (1 гигабайт).

    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-segment-bytes).

    Подробнее см. в разделе [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) и в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_log.segment.bytes).

* **Message max bytes** {{ tag-all }} {#settings-message-max-bytes}
  
    Максимальный размер группы сообщений (после сжатия, если оно включено), который {{ KF }} разрешает записать в топик производителю или прочитать из топика потребителю, (в байтах).

    Для корректной репликации между брокерами значение этой настройки должно быть не меньше, чем значение [Replica fetch max bytes](#settings-replica-fetch-max-bytes).

    Минимальное значение — `0`, значение по умолчанию — `1048588` (1 мегабайт + 12 байт в служебных целях).
  
    Это глобальная настройка, которая задается на уровне кластера. Ее можно переопределить на [уровне топика](#settings-topic-max-message-bytes).
  
    Подробнее см. в [документации {{ KF }}](http://kafka.apache.org/documentation/#brokerconfigs_message.max.bytes).

* **Num partitions** {{ tag-all }} {#settings-num-partitions}

    Количество разделов лога на топик в кластере.

    Настройка применяется только для [автоматически создаваемых топиков](#settings-auto-create-topics).

    Минимальное значение и значение по умолчанию — `1`.

    См. также описание настройки уровня топика [Num partitions](#settings-topic-num-partitions).

    Подробнее см. в [документации {{ KF }}](http://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Offsets retention minutes** {{ tag-all }} {#settings-offsets-retention-minutes}

    Время (в минутах), в течение которого будут храниться оффсеты группы потребителей, где ни один потребитель не активен.

    Минимальное значение — `1`, значение по умолчанию — `10080`.

    Подробнее см. в [документации {{ KF }}](http://kafka.apache.org/documentation/#brokerconfigs_offsets.retention.minutes).

* **Replica fetch max bytes** {{ tag-all }} {#settings-replica-fetch-max-bytes}

    Максимальный размер группы сообщений, который {{ KF }} разрешает использовать для репликации между брокерами, (в байтах).

    Для корректной репликации между брокерами значение этой настройки должно быть не меньше, чем значения [Message max bytes](#settings-message-max-bytes) для кластера и [Max message bytes](#settings-topic-max-message-bytes) для каждого топика.

    Минимальное значение — `0`, значение по умолчанию — `1048576` (1 мегабайт).

    Подробнее см. в [документации {{ KF }}](http://kafka.apache.org/documentation/#brokerconfigs_replica.fetch.max.bytes).

* **Socket receive buffer bytes** {{ tag-con }} {#settings-socket-receive-buffer-bytes}

    Размер буфера для сокета приема (в байтах).

    Минимальное значение и значение по умолчанию — `-1` (используются настройки операционной системы), максимальное значение — `2147483647`.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_socket.receive.buffer.bytes).

* **Socket send buffer bytes** {{ tag-con }} {#settings-socket-send-buffer-bytes}

    Размер буфера для сокета отправки (в байтах).

    Минимальное значение и значение по умолчанию — `-1` (используются настройки операционной системы), максимальное значение — `2147483647`.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_socket.send.buffer.bytes).

* **Ssl cipher suites** {{ tag-con }} {#settings-ssl-cipher-suites}

    Набор вариантов шифрования для подключения к кластеру по протоколу SSL.

    По умолчанию поддерживаются все возможные варианты шифрования. 

    Подробнее см. в [документации {{ KF }}](http://kafka.apache.org/documentation/#brokerconfigs_ssl.cipher.suites).
