* **Asynchronous insert log enabled**{#setting-asynchronous-insert-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация об асинхронных вставках. Логи сохраняются в таблицу `system.asynchronous_insert_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/operations/system-tables/asynchronous_insert_log).

* **Asynchronous insert log retention size**{#setting-asynchronous-insert-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.asynchronous_insert_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Asynchronous insert log retention time**{#setting-asynchronous-insert-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.asynchronous_insert_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Asynchronous metric log enabled**{#setting-asynchronous-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будут ли логироваться исторические значения метрик из таблицы `system.asynchronous_metrics` в таблицу `system.asynchronous_metric_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/system-tables/asynchronous_metric_log).

* **Asynchronous metric log retention size**{#setting-asynchronous-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.asynchronous_metric_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Asynchronous metric log retention time**{#setting-asynchronous-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.asynchronous_metric_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Background buffer flush schedule pool size**{#setting-background-buffer-flush-schedule-pool-size} {{ tag-con }}

    Количество потоков для выполнения фонового сброса данных в таблицах семейства [Buffer]({{ ch.docs }}/engines/table-engines/special/buffer).

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_buffer_flush_schedule_pool_size).

* **Background common pool size**{#setting-background-common-pool-size} {{ tag-con }} {{ tag-api }}

    Количество потоков для выполнения фоновых неспециализированных операций, например, очистки файловой системы, в таблицах семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/).

    Минимальное значение — `1`, по умолчанию — `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_common_pool_size).

* **Background distributed schedule pool size**{#setting-background-distributed-schedule-pool-size} {{ tag-con }}

    Количество потоков для выполнения фоновых операций в таблицах семейства [Distributed]({{ ch.docs }}/engines/table-engines/special/distributed).

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_distributed_schedule_pool_size).

* **Background fetches pool size**{#setting-background-fetches-pool-size} {{ tag-con }} {{ tag-api }}

    Количество потоков для выполнения фоновых задач копирования данных с реплики в таблицах семейства [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication).

    Минимальное значение — `1`, по умолчанию — `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_fetches_pool_size).

* **Background merges mutations concurrency ratio**{#setting-background-merges-mutations-concurrency-ratio} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Количество фоновых слияний и мутаций, которые могут выполняться одновременно каждым потоком.

    По умолчанию выбрано значение `2`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).

* **Background message broker schedule pool size**{#setting-background-message-broker-schedule-pool-size} {{ tag-con }}

    Количество потоков для выполнения фоновых трансляций сообщений. Новое значение настройки устанавливается при перезапуске сервера {{ CH }}.

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_message_broker_schedule_pool_size).

* **Background move pool size**{#setting-background-move-pool-size} {{ tag-con }}

    Количество потоков для фонового перемещения кусков данных в таблицах семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/).

    Минимальное значение — `1`, по умолчанию — `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#background_move_pool_size).

* **Background pool size**{#setting-background-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Количество потоков для выполнения фоновых слияний и [мутаций]({{ ch.docs }}/sql-reference/statements/alter/#mutations) в таблицах семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/).

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#background_pool_size).

* **Background schedule pool size**{#setting-background-schedule-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Количество потоков для выполнения фоновых задач. Применяется для реплицируемых таблиц, стримов в {{ KF }} и обновления IP-адресов записей во внутреннем DNS-кеше.

    Минимальное значение — `1`, по умолчанию — `128`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Правила сжатия данных для таблиц семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/). Для каждого правила указываются:

    * **Level** — уровень сжатия. Доступен только для метода сжатия [zstd]({{ ch.docs }}/sql-reference/statements/create/table#zstd). Минимальное значение — `1`, максимальное — `12`, по умолчанию — `9`.
    * **Method** — метод сжатия. Доступно два метода: [LZ4](https://lz4.github.io/lz4/) и [zstd](https://facebook.github.io/zstd/).
    * **Min part size** — минимальный размер [куска данных]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key/) (в байтах).
    * **Min part size ratio** — отношение размера наименьшего куска таблицы к полному размеру таблицы. {{ CH }} будет применять правило только к тем таблицам, у которых это отношение не превышает значение **Min part size ratio**.

    Вы можете добавить несколько правил сжатия. {{ CH }} проверит условия **Min part size** и **Min part size ratio** и применит правила к тем таблицам, для которых выполнены оба условия. Если к одной таблице подходит несколько правил, {{ CH }} применит первое из них. Если ни одно из правил не подходит, {{ CH }} применит метод сжатия [LZ4](https://lz4.github.io/lz4/).

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/settings).

* **Default database**{#setting-default-database} {{ tag-con }} {{ tag-api }}

    База данных по умолчанию. Инструкцию о получении списка баз данных в кластере см. в разделе [Управление базами данных](../../managed-clickhouse/operations/databases#list-db).

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Dictionaries lazy load**{#setting-dictionaries-lazy-load} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

    Если настройка включена, каждый словарь загружается при его первом использовании. Если загрузить не получилось, функция, использующая словарь, возвращает исключение.

    Если настройка выключена, словари загружаются при запуске сервера. Сервер ожидает, пока загрузятся все словари, до того как начать обработку соединений.

    По умолчанию настройка включена.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings#server_configuration_parameters-dictionaries_lazy_load).

* **Geobase enabled**{#setting-geobase-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Включение [встроенного словаря-геобазы](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts).

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Адрес архива с [пользовательской геобазой](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) в {{ objstorage-name }}.

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Конфигурации движка [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree) для прореживания и агрегирования (rollup) данных [Graphite](http://graphite.readthedocs.io/en/latest/index.html):
    * **Name** — имя конфигурации.
    * **Patterns** — набор правил прореживания. Правило применяется, если имя метрики соответствует значению параметра **Regexp**, а возраст данных соответствует значению группы параметров **Retention**.
        * **Function** — имя агрегирующей функции.
        * **Regexp** — регулярное выражение, которому должно соответствовать имя метрики.
        * **Retention** — параметры задержки. Функция применяется к данным, чей возраст оказался в интервале [Age, Age + Precision]. Вы можете задать несколько групп таких параметров.
            * **Age** — минимальный возраст данных (в секундах).
            * **Precision** — точность определения возраста данных (в секундах). Значение должно быть кратно `86400` (количеству секунд в сутках).

    Вы можете настроить несколько конфигураций и использовать их для разных таблиц. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Чтобы создавать таблицы семейства `GraphiteMergeTree`, укажите названия столбцов для каждой такой таблицы:

    * **Path column name** — столбец с именем метрики (сенсора `Graphite`). Значение по умолчанию — `Path`.
    * **Time column name** — столбец со временем измерения метрики. Значение по умолчанию — `Time`.
    * **Value column name** — столбец со значением метрики. Значение по умолчанию — `Value`.
    * **Version column name** — столбец с версией метрики. Значение по умолчанию — `Timestamp`.

    Подробнее о поддержке Graphite см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/).

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Глобальные настройки аутентификации для [интеграции с {{ KF }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/):

    * **Auto offset reset** — начальная позиция, откуда начинается чтение сообщений [потребителем](../../managed-kafka/concepts/producers-consumers.md). С этой позиции потребитель добавляет сдвиги для новых сообщений по мере того, как движется и читает поступаемые сообщения. По умолчанию значение не выбрано (эквивалентно `latest`). Подробнее см. в [документации Confluent](https://docs.confluent.io/platform/current/clients/consumer.html#offset-management).
    * **Debug** — контекст для отладки. По умолчанию значение не выбрано. В настройке можно указать только одно значение. Список доступных значений см. в документации библиотеки `librdkafka` на [GitHub](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).
    * **Enable ssl certificate verification** — определяет, будет ли проводиться проверка SSL-сертификата. По умолчанию выбрано значение `false`.
    * **Max poll interval ms** — максимальный интервал (в миллисекундах) между вызовами для получения сообщений высокоуровневых потребителей. При превышении интервала пользователь удаляется из группы и запускается перебалансировка. По умолчанию значение не задано (эквивалентно `300000` — 5 минут).
    * **Sasl mechanism** — механизм аутентификации SASL:
      * `GSSAPI` (по умолчанию) — аутентификация с [использованием Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
      * `PLAIN` — аутентификация с [использованием пары логин-пароль в виде открытого текста](https://kafka.apache.org/documentation/#security_sasl_plain).
      * `SCRAM-SHA-256` и `SCRAM-SHA-512` — аутентификация с [использованием механизмов семейства SCRAM](https://kafka.apache.org/documentation/#security_sasl_scram).

      По умолчанию значение не выбрано (эквивалентно `GSSAPI`).

    * **Sasl password** — пароль учетной записи {{ KF }}.
    * **Sasl username** — имя учетной записи {{ KF }}.
    * **Security protocol** — протокол безопасности для использования при аутентификации:
        * `PLAINTEXT` — данные для аутентификации передаются в открытом виде.
        * `SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL.
        * `SASL_PLAINTEXT` — данные для аутентификации передаются в открытом виде, в качестве транспорта используется SASL.
        * `SASL_SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL, в качестве транспорта используется SASL.

        По умолчанию значение не выбрано (эквивалентно `PLAINTEXT`).

    * **Session timeout ms** — время ожидания (в миллисекундах) периодического сигнала от пользователя для поддержки сессии клиентской группы. При превышении времени брокер удаляет пользователя из группы и запускает перебалансировку. По умолчанию значение не задано (эквивалентно `45000` — 45 секунд).

    Изменение настроек приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Kafka topics**{#setting-kafka-topics} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Настройки аутентификации на уровне [топиков](../../managed-kafka/concepts/topics.md) для [интеграции с {{ KF }}]({{ ch.docs }}/engines/table-engines/integrations/kafka/):

    * **Name** — имя топика {{ KF }}.
    * **Settings** — настройки аутентификации для топика, аналогичные глобальным настройкам аутентификации в секции [**Kafka**](#setting-kafka).

        Если для таблицы на движке Kafka настройки аутентификации на уровне топика не заданы, то будут использованы глобальные настройки из секции **Kafka**.

        Изменение настроек приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#security).

* **Keep alive timeout**{#setting-keep-alive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Время (в секундах) от поступления последнего запроса к {{ CH }} до разрыва соединения. Если за это время поступает новый запрос, соединение не разрывается.

    По умолчанию выбрано значение `3`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Уровень логирования событий. На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
    1. `ERROR` — информация об ошибках в работе кластера;
    1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе кластера;
    1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе кластера;
    1. `DEBUG` — системная информация для последующего использования в отладке;
    1. `TRACE` — вся доступная информация о работе кластера.

    Подробнее об уровнях логирования см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Приблизительный размер (в байтах) кеша засечек, используемых движками таблиц семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/). Кеш общий для хоста кластера, память выделяется по мере необходимости.

    Выбранное значение настройки не является строгим ограничением. {{ CH }} может использовать чуть меньше или чуть больше памяти под этот кеш.

    По умолчанию выбрано значение `5368709120`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальное количество одновременно обрабатываемых запросов.

    Минимальное значение — `10`, по умолчанию — `500`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальное количество входящих клиентских соединений. Настройка не учитывает служебные соединения, которые открываются для выполнения распределенных подзапросов.

    Минимальное значение — `10`, по умолчанию — `4096`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальный размер (в байтах) [партиции]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key) таблицы семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/), при котором таблицу можно удалить с помощью запроса `DROP TABLE`. Настройку можно использовать, чтобы предотвратить ошибочное удаление таблиц с реальными данными: такие таблицы обычно имеют большой размер по сравнению с тестовыми таблицами.

    По умолчанию выбрано значение `53687091200` (50 ГБ). При значении `0` можно удалять таблицы любого размера.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальный размер (в байтах) таблицы семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/), которую можно удалить с помощью запроса `DROP TABLE`. Настройку можно использовать, чтобы предотвратить ошибочное удаление таблиц с реальными данными: такие таблицы обычно имеют большой размер по сравнению с тестовыми таблицами.

    По умолчанию выбрано значение `53687091200` (50 ГБ). При значении `0` можно удалять таблицы любого размера.

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Конфигурация движка MergeTree:

    * **Allow remote fs zero copy replication** — определяет, разрешена ли удаленная репликация с нулевой копией для S3 и HDFS-дисков.

        По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/integrations/s3#disable-zero-copy-replication).

    * **Check sample column is correct** — при создании таблицы включает проверку, что тип данных столбца является верным для сэмплирования или выражений сэмплирования.

        По умолчанию проверка включена. Вы можете ее отключить, если у вас уже есть таблицы с некорректными выражениями сэмплирования. Тогда не будет возникать ложных срабатываний и исключений при запуске сервера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings#check_sample_column_is_correct).

    * **Cleanup delay period** — интервал времени (в секундах) между запусками [распределенных DDL-запросов]({{ ch.docs }}/sql-reference/distributed-ddl) для очистки устаревших данных.

        По умолчанию выбрано значение `60` (1 минута). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server-settings-distributed_ddl).

    * **Inactive parts to delay insert** — количество неактивных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу.

        По умолчанию ограничение скорости выключено (`0`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-delay-insert).

    * **Inactive parts to throw insert** — количество неактивных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many inactive parts ...`.

        По умолчанию отправка исключений выключена (`0`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#inactive-parts-to-throw-insert).

    * **Max avg part size for too many parts** — максимальный средний размер активных кусков данных таблицы (в байтах) для выполнения проверок **Parts to delay insert** и **Parts to throw insert**. При превышении указанного значения вставки данных в таблицу не будут замедлены или отклонены.

        Минимальное значение — `0`, по умолчанию — `1073741824` (1 ГБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Max bytes to merge at max space in pool** — максимальный общий размер кусков данных (в байтах) для слияния, когда в фоновом пуле есть свободные ресурсы.

        По умолчанию выбрано значение `161061273600` (150 ГБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-max-space-in-pool).

    * **Max bytes to merge at min space in pool** — максимальный общий размер кусков данных для слияния, когда в фоновом пуле минимум свободных ресурсов.

        По умолчанию выбрано значение `1048576` (1 МБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool).

    * **Max cleanup delay period** — максимальный период в секундах для очистки устаревших данных: логов запросов, хешей блоков и кусков данных.

        Укажите значение не меньше, чем у настройки **Cleanup delay period**.

        Значение по умолчанию — `300`.

    * **Max merge selecting sleep ms** — максимальное время ожидания для слияния выборки (в миллисекундах).

        Укажите значение не меньше, чем у настройки **Merge selecting sleep ms**.

        Значение по умолчанию — `60000` (1 минута). Если указать меньшее значение, задачи выборки будут часто запускаться в пуле фоновых задач. В результате в кластерах с большими мощностями скопится большое количество запросов к {{ ZK }}.

    * **Max number of merges with ttl in pool** — предельное количество слияний по TTL в фоновом пуле.

        По умолчанию выбрано значение `2`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Max parts in total** — количество активных кусков данных во всех партициях таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ...`.

        По умолчанию выбрано значение `100000`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#max-parts-in-total).

    * **Max replicated merges in queue** — максимальное количество задач слияния, которые могут одновременно находиться в очереди `ReplicatedMergeTree`.

        По умолчанию выбрано значение `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Merge max block size** — из скольки строк состоят блоки, которые формируют объединяемые куски данных.

        База данных читает строки из этих кусков, затем объединяет эти строки и записывает их в новый кусок. Читаемые строки помещаются в оперативную память (RAM), поэтому настройка влияет на ее размер, необходимый для слияния строк. Если уменьшить значение настройки, сократится допустимый размер RAM, и слияние строк замедлится.

        Значение по умолчанию — `8192`.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings#merge-max-block-size).

    * **Merge selecting sleep ms** — время ожидания (в миллисекундах) для слияния выборки, если ни один кусок не выбран.

        По умолчанию выбрано значение `5000` (5 секунд). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/settings#merge_selecting_sleep_ms).

    * **Merge with recompression TTL timeout** — минимальное время (в секундах) между слияниями для повторного сжатия данных с истекшим TTL.

        По умолчанию выбрано значение `14400` (4 часа). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

    * **Merge with TTL timeout** — минимальное время (в секундах) между слияниями для удаления данных с истекшим TTL.

        По умолчанию выбрано значение `14400` (4 часа). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/guides/developer/ttl/#triggering-ttl-events).

    * **Min age to force merge on partition only** — определяет, применять ли объединение из настройки **Min age to force merge seconds** только к [партициям]({{ ch.docs }}/engines/table-engines/mergetree-family/custom-partitioning-key).

        По умолчанию применение только к партициям отключено. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).

    * **Min age to force merge seconds** — минимальное время (в секундах) существования кусков данных для объединения.

        По умолчанию выбрано значение `0` (объединение отключено). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).

    * **Min bytes for wide part** — минимальное количество байтов в куске данных, который может храниться в формате `Wide`. Можно задать одновременно с параметром **Min rows for wide part**.

        Если количество байтов в куске данных меньше заданного значения, тогда этот кусок данных хранится в формате `Compact`.

        Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    * **Min rows for wide part** — минимальное количество строк в куске данных, который может храниться в формате `Wide`. Можно задать одновременно с параметром **Min bytes for wide part**.

        Если количество строк в куске данных меньше заданного значения, тогда этот кусок данных хранится в формате `Compact`.

        Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/#mergetree-data-storage).

    * **Number of free entries in pool to execute mutation** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} перестает выполнять операции [мутаций]({{ ch.docs }}/sql-reference/statements/alter/#mutations). Это позволяет оставлять свободные потоки для слияний и избежать исключения `Too many parts ...`.

        По умолчанию выбрано значение `20`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings/#number-of-free-entries-in-pool-to-execute-mutation).

    * **Number of free entries in pool to lower max size of merge** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} уменьшает максимальный размер куска данных для слияния. Это позволяет быстрее обрабатывать небольшие слияния.

        По умолчанию выбрано значение `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Parts to delay insert** — количество активных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу. Активным куском является новый кусок данных, образованный в результате слияния.

        По умолчанию выбрано значение `150`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-delay-insert).

    * **Parts to throw insert** — предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ...`

        По умолчанию выбрано значение `300`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#parts-to-throw-insert).

    * **Replicated deduplication window** — число блоков последних вставок хешей, которые {{ ZK }} будет хранить. Дедупликация работает только для последних вставленных данных. Старые блоки будут удалены.

        По умолчанию выбрано значение `100`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window).

    * **Replicated deduplication window seconds** — время, в течение которого {{ ZK }} хранит блоки последних вставок хешей. Дедупликация работает только для последних вставленных данных. Старые блоки будут удалены.

        По умолчанию выбрано значение `604800`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/merge-tree-settings/#replicated-deduplication-window-seconds).

    * **TTL only drop parts** — определяет режим удаления данных по TTL:

        * `true` — целыми кусками данных.
        * `false` — построчно, с выполнением дополнительных слияний данных. Этот режим потребляет значительно больше ресурсов, чем удаление целыми кусками.

        По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/settings/settings/#ttl_only_drop_parts).

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будут ли логироваться значения метрик из таблиц `system.metrics` и `system.events` в таблицу `system.metric_log`.

    По умолчанию выбрано значение `true`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.metric_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.metric_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Opentelemetry span log enabled**{#setting-opentelemetry-span-log-enabled} {{ tag-con }}

    Определяет, будут ли логироваться значения трассировок и метрик из распределенного приложения. Логи сохраняются в таблицу `system.opentelemetry_span_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/opentelemetry).

* **Opentelemetry span log retention size**{#setting-opentelemetry-span-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.opentelemetry_span_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Opentelemetry span log retention time**{#setting-opentelemetry-span-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.opentelemetry_span_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.part_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.part_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query cache**{#setting-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Настройки [кеша запросов](https://clickhouse.com/docs/en/operations/query-cache). Кеш позволяет выполнять запросы `SELECT` по одному разу и использовать сохраненные результаты в дальнейших операциях. В итоге снижается задержка и сокращается потребление ресурсов кластера при обработке запросов.

    Доступные настройки кеша запросов:

    * **Max entries** — максимальное количество результатов, которое можно сохранить в кеше при выполнении запросов `SELECT`. Значение по умолчанию — `1024`.
    * **Max entry size in bytes** — максимальное число байтов, которое можно выделить в кеше каждому результату выполнения запроса `SELECT`. Значение по умолчанию — `1048576` (один мегабайт).
    * **Max entry size in rows** — максимальное число строк, которое можно выделить в кеше каждому результату выполнения запроса `SELECT`. Значение по умолчанию — `30000000`.
    * **Max size in bytes** — максимальный размер кеша в байтах. Если указать `0`, кеш запросов будет отключен. Значение по умолчанию — `1073741824` (один гигабайт).

    Подробнее о настройках см. в [документации {{ CH }}](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings#server_configuration_parameters_query-cache).

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.query_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `1073741824` (1 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query masking rules**{#setting-query-masking-rules} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Настройки [маскирования запросов]({{ ch.docs }}/operations/server-configuration-parameters/settings#query-masking-rules). Позволяют применить регулярные выражения к запросам и сообщениям в логах. В результате данные хранятся в логах в защищенном виде, так как регулярные выражения помогают предотвратить утечку конфиденциальных данных (например, имени, электронной почты, данных банковских карт).

    Доступные настройки для правил маскирования запросов:

    * **Name** — название правила. Необязательный параметр.
    * **Regexp** — регулярное выражение с синтаксисом RE2.
    * **Replace** — выражение, которым надо заменить конфиденциальные данные. По умолчанию используются шесть звездочек.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Активирует таблицу `system.query_thread_log` для логирования в ней потоков, которые выполняют запросы. Чтобы записывались логи, убедитесь, что также включена настройка [Log query threads](../../managed-clickhouse/concepts/settings-list.md#setting-log-query-threads).

    По умолчанию выбрано значение `true`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/system-tables/query_thread_log).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.query_thread_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_thread_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query views log enabled**{#setting-query-views-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация о зависимых представлениях, выполняемых при выполнении запроса. Логи сохраняются в таблицу `system.query_views_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/system-tables/query_views_log).

* **Query views log retention size**{#setting-query-views-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.query_views_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Query views log retention time**{#setting-query-views-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_views_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Глобальные настройки аутентификации для [интеграции с {{ RMQ }}]({{ ch.docs }}/engines/table-engines/integrations/rabbitmq/):

    * **Password** — пароль учетной записи {{ RMQ }}.
    * **Username** — имя учетной записи {{ RMQ }}.
    * **Vhost** — адрес виртуального хоста для {{ RMQ }}.

    Изменение настроек приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Session log enabled**{#setting-session-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация об успешных и неудачных событиях входа и выхода из системы. Логи сохраняются в таблицу `system.session_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/system-tables/session_log).

* **Session log retention size**{#setting-session-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.session_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Session log retention time**{#setting-session-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.session_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будут ли записываться системные логи. Логи сохраняются в таблицу `system.text_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Уровень логирования событий в таблице [system.text_log]({{ ch.docs }}/operations/system-tables/text_log). На каждом следующем уровне лог будет содержать всю информацию из предыдущего:

    * `ERROR` — информация об ошибках в работе СУБД.
    * `WARNING` — информация о событиях, которые могут привести к ошибкам в работе СУБД.
    * `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе СУБД.
    * `DEBUG` — системная информация для последующего использования в отладке.
    * `TRACE` — вся доступная информация о работе СУБД.

    По умолчанию выбрано значение `TRACE`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.text_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.text_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Временная зона сервера. Указывается идентификатором IANA в виде часового пояса UTC или географического положения (например, Africa/Abidjan).

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).

* **Total memory profiler step**{#setting-total-memory-profiler-step} {{ tag-con }} {{ tag-api }}

    Объем памяти (в байтах) для стектрейса (stack trace) на каждом шаге выделения памяти. Данные хранятся в системной таблице `system.trace_log`, при этом значение `query_id` является пустой строкой.

    По умолчанию выбрано значение `4194304` (4 МБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-profiler-step).

* **Total memory tracker sample probability**{#setting-total-memory-tracker-sample-probability} {{ tag-con }}

    Вероятность записи информации о случайных выделениях и освобождениях памяти (в процентах). Эти записи хранятся в системной таблице `system.trace_log`. Параметр `trace_type` принимает значение параметра `MemorySample`. Вероятность касается каждого выделения или освобождения памяти, независимо от размера выделения. Выборка происходит, только когда объем неотслеживаемой памяти превышает значение настройки [Total memory profiler step](#setting-total-memory-profiler-step).

    По умолчанию запись случайных выделений и освобождений памяти выключена (`0`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/server-configuration-parameters/settings/#total-memory-tracker-sample-probability).

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будут ли логироваться стектрейсы (stack traces), собираемые профилировщиком запросов. Стектрейсы сохраняются в таблицу `system.trace_log`.

    По умолчанию выбрано значение `true`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.trace_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.trace_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Размер кеша (в байтах) для несжатых данных, используемых движками таблиц семейства [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/).

    По умолчанию выбрано значение `8589934592` (8 ГБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Zookeeper log enabled**{#setting-zookeeper-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация о параметрах запроса к серверу {{ ZK }} и ответа от него. Логи сохраняются в таблицу `system.zookeeper_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}/operations/system-tables/zookeeper_log).

* **Zookeeper log retention size**{#setting-zookeeper-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.zookeeper_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Zookeeper log retention time**{#setting-zookeeper-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.zookeeper_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.
