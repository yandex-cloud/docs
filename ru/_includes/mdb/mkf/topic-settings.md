* **Cleanup policy** {{ tag-all }} {#settings-topic-cleanup-policy}    

    Политика хранения старых сообщений лога:

    * `Delete` (`CLEANUP_POLICY_DELETE` для {{ TF }} и API) — удалять сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога;
    * `Compact` (`CLEANUP_POLICY_COMPACT` для {{ TF }} и API) — сжимать сообщения в логе;
    * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` для {{ TF }} и API) — использовать как сжатие сообщений, так и удаление сегментов лога.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#cleanup.policy). В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-cleanup-policy }}**.

* **Compression type** {{ tag-all }} {#settings-topic-compression-type}  

    Кодек, используемый для сжатия сообщений.  

    Подробнее см. в настройке уровня кластера [Compression type](#settings-compression-type).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-compression-type }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_compression.type).

* **Delete delay, ms** {{ tag-all }} {#settings-topic-file-delete-delay}

    Время ожидания перед удалением файла из файловой системы.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-delete-delay }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#file.delete.delay.ms).

* **Delete retention** {{ tag-all }} {#settings-delete-retention}

    Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. Эта настройка применяется только в том случае, если [политика очистки лога](#settings-topic-cleanup-policy) установлена в режим `Compact` или `CompactAndDelete`.

    Полное описание настройки см. [в документации {{ KF }}](https://kafka.apache.org/documentation/#delete.retention.ms).

* **Flush messages** {{ tag-all }} {#settings-topic-flush-messages}

    Количество сообщений топика, которое может накопиться в памяти прежде, чем эти сообщения будут записаны на диск.

    Подробнее см. в настройке уровня кластера [Log flush interval messages](#settings-log-flush-interval-messages).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-flush-messages }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_flush.messages).

* **Flush, ms** {{ tag-all }} {#settings-topic-flush-ms}

    Максимальное время в миллисекундах, в течение которого сообщение может храниться в памяти перед принудительным сбросом на диск.    

    Подробнее см. в настройке уровня кластера [Log flush interval ms](#settings-log-flush-interval-ms).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-flush-ms }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_flush.ms).

* **Message max bytes** {{ tag-all }} {#settings-topic-message-max-bytes}    

    Максимальный размер сообщения от производителя в байтах.

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048588`. Значение настройки не должно превышать значение **Replica fetch max bytes** более, чем на 12 байт.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_max-message-bytes }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_max.message.bytes).

* **Min compaction lag, ms** {{ tag-all }} {#settings-topic-max-compaction-lag-ms}    

    Минимальное время, в течение которого сообщение в логе будет оставаться несжатым.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-min-compaction-lag }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#min.compaction.lag.ms).

* **Minimum number of in-sync replicas** {{ tag-all }} {#settings-topic-min-insync-replicas}

    Минимальное количество реплик, от которых необходимо дождаться подтверждения записи, чтобы запись сообщения в топик считалась успешной. Используйте эту настройку, если производитель (Producer) ожидает подтверждения успешной записи от всех хостов-брокеров кластера слишком долго.

    Минимальное значение зависит от количества [хостов-брокеров](../../../managed-kafka/concepts/brokers.md):

    * для кластеров с одним хостом-брокером — `1`;
    * для кластеров с двумя и более хостами-брокерами — `2`.

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_min-insync-replicas }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_min.insync.replicas).

* **Num partitions** {{ tag-all }} {#settings-topic-num-partitions}    

    Количество разделов лога на топик.

    Минимальное значение и значение по умолчанию — `1`.

    Подробнее см. в настройке уровня кластера [Num partitions](#settings-num-partitions).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_partitions }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Pre-allocation of the segment file** {{ tag-all }} {#settings-topic-preallocate}    

    Определяет, будет ли заранее выделяться место под файлы сегментов лога. По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Подробнее см. в настройке уровня кластера [Log preallocate](#settings-log-preallocate).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-preallocate }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_preallocate).

* **Replication factor** {{ tag-all }} {#settings-topic-replication-factor}

    Количество [копий данных](../../../managed-kafka/concepts/brokers.md) для топика.

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    Подробнее см. в настройке уровня кластера [Default replication factor](#settings-default-replication-factor).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_replication-factor }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#streamsconfigs_replication.factor).

* **Retention, bytes** {{ tag-all }} {#settings-topic-retention-bytes}

    Максимальный размер (в байтах), до которого может вырасти раздел.

    Подробнее см. в настройке уровня кластера [Log retention bytes](#settings-log-retention-bytes).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-retention-bytes }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_retention.bytes).

* **Retention, ms** {{ tag-all }} {#settings-topic-log-retention-ms}

    Время (в миллисекундах), в течение которого {{ KF }} будет хранить файл сегмента лога. 

    Подробнее см. в настройке уровня кластера [Log retention ms](#settings-log-retention-ms).

    В консоли управления этой настройке соответствует **{{ ui-key.yacloud.kafka.label_topic-retention-ms }}**.

    Полное описание настройки см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_retention.ms).

* **Segment bytes** {{ tag-all }} {#settings-topic-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким.

    Минимальное значение — `14`, значение по умолчанию — `1073741824` (1 гигабайт).

    Подробнее см. в настройке уровня кластера [Log segment bytes](#settings-log-segment-bytes).

    Полное описание настройки см. в разделе [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) и в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_segment.bytes).
