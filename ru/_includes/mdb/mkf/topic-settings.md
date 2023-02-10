* **Cleanup policy** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-cleanup-policy}

    В консоли управления этой настройке соответствует **Политика очистки лога**.

    Политика хранения старых сообщений лога:

    * `Delete` (`CLEANUP_POLICY_DELETE` для {{ TF }} и API) — удалять сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога;
    * `Compact` (`CLEANUP_POLICY_COMPACT` для {{ TF }} и API) — сжимать сообщения в логе;
    * `CompactAndDelete` (`CLEANUP_POLICY_COMPACT_AND_DELETE` для {{ TF }} и API) — использовать как сжатие сообщений, так и удаление сегментов лога.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#cleanup.policy).

* **Compression type** {{ tag-all }} {#settings-topic-compression-type }

    В консоли управления этой настройке соответствует **Тип сжатия**.

    См. описание настройки уровня кластера [Compression type](#settings-compression-type).

    Подробнее см в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_compression.type).

* **Delete delay, ms** {{ tag-all }} {#settings-topic-file-delete-delay}

    В консоли управления этой настройке соответствует **Задержка удаления, мс**.

    Время ожидания перед удалением файла из файловой системы.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#file.delete.delay.ms).

* **Delete retention** {{ tag-con }} {#settings-delete-retention}

    Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. Эта настройка применяется только в том случае, если [политика очистки лога](#settings-topic-cleanup-policy) установлена в режим `Compact` или `CompactAndDelete`.

    Подробнее см. [в документации {{ KF }}](https://kafka.apache.org/documentation/#delete.retention.ms).

* **Flush messages** {{ tag-all }} {#settings-topic-flush-messages}

    В консоли управления этой настройке соответствует **Максимальное число сообщений в памяти**.

    См. описание настройки уровня кластера [Log flush interval messages](#settings-log-flush-interval-messages).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_flush.messages).

* **Flush, ms** {{ tag-all }} {#settings-topic-flush-ms}

    В консоли управления этой настройке соответствует **Время хранения сообщения в памяти, мс**.

    См. описание настройки уровня кластера [Log flush interval ms](#settings-log-flush-interval-ms).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_flush.ms).

* **Message max bytes** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-message-max-bytes}

    В консоли управления этой настройке соответствует **Максимальный размер группы сообщений**.

    Максимальный размер сообщения от производителя в байтах.

    Минимальное значение — `0` (размер не ограничен), значение по умолчанию — `1048588`. Значение настройки не должно превышать значение **Replica fetch max bytes** более, чем на 12 байт.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_max.message.bytes).

* **Min compaction lag, ms** {{ tag-all }} {#settings-topic-max-compaction-lag-ms}

    В консоли управления этой настройке соответствует **Минимальная задержка сжатия, мс**.

    Минимальное время, в течение которого сообщение в логе будет оставаться несжатым.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#min.compaction.lag.ms).

* **Minimum number of in-sync replicas** {{ tag-con }} {{ tag-cli }} {{ tag-api }} {#settings-topic-min-insync-replicas}

    В консоли управления этой настройке соответствует **Минимальное число синхронных реплик**.

    Минимальное количество реплик, от которых необходимо дождаться подтверждения записи, чтобы запись сообщения в топик считалась успешной. Используйте эту настройку, если производитель (Producer) ожидает подтверждения успешной записи от всех хостов-брокеров кластера слишком долго.

    Минимальное значение зависит от количества [хостов-брокеров](../../../managed-kafka/concepts/brokers.md):

    * для кластеров с одним хостом-брокером — `1`;
    * для кластеров с двумя и более хостами-брокерами — `2`.

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_min.insync.replicas).

* **Num partitions** {{ tag-all }} {#settings-topic-num-partitions}

    В консоли управления этой настройке соответствует **Количество разделов**.

    Количество разделов лога на топик.

    Минимальное значение и значение по умолчанию — `1`.

    См. также описание настройки уровня кластера [Num partitions](#settings-num-partitions).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#brokerconfigs_num.partitions).

* **Pre-allocation of the segment file** {{ tag-cli }} {{ tag-tf }} {#settings-topic-preallocate}

    В консоли управления этой настройке соответствует **Предварительное выделение файла сегмента**.

    См. также описание настройки уровня кластера [Log preallocate](#settings-log-preallocate).

    По умолчанию место под файлы сегментов лога выделяется по мере их заполнения (`false`).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_preallocate).

* **Replication factor** {{ tag-all }} {#settings-topic-replication-factor}

    В консоли управления этой настройке соответствует **Фактор репликации**.

    Количество [копий данных](../../../managed-kafka/concepts/brokers.md) для топика.

    Минимальное значение и значение по умолчанию — `1`. Максимальное значение равно количеству хостов-брокеров в кластере.

    См. также описание настройки уровня кластера [Default replication factor](#settings-default-replication-factor).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#streamsconfigs_replication.factor).

* **Retention, bytes** {{ tag-all }} {#settings-topic-retention-bytes}

    В консоли управления этой настройке соответствует **Максимальный размер раздела, байт**.

    См. описание настройки уровня кластера [Log retention bytes](#settings-log-retention-bytes).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_retention.bytes).

* **Retention, ms** {{ tag-all }} {#settings-topic-log-retention-ms}

    В консоли управления этой настройке соответствует **Время жизни сегмента лога, мс**.

    См. описание настройки уровня кластера [Log retention ms](#settings-log-retention-ms).

    Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_retention.ms).

* **Segment bytes** {{ tag-all }} {#settings-topic-segment-bytes}

    Размер сегмента для файлов лога (в байтах).

    Сохранение и очистка файлов сегмента выполняются пофайлово. Чем меньше заданный размер сегмента, тем больше файлов будет в логе, зато контроль над хранением будет более гибким.

    Минимальное значение — `14`, значение по умолчанию — `1073741824` (1 гигабайт).

    См. описание настройки уровня кластера [Log segment bytes](#settings-log-segment-bytes).

    Подробнее см. в разделе [{#T}](../../../managed-kafka/concepts/storage.md#maximum-log-segment-size) и в [документации {{ KF }}](https://kafka.apache.org/documentation/#topicconfigs_segment.bytes).
