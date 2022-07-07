* **Background pool size**{#setting-background-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Количество потоков для выполнения фоновых операций слияния и [мутаций](https://{{ ch-domain }}/docs/ru/sql-reference/statements/alter/#mutations) в таблицах семейства [MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/).

    По умолчанию выбрано значение `16`.

* **Background schedule pool size**{#setting-background-schedule-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Количество потоков для выполнения фоновых задач. Применяется для реплицируемых таблиц, стримов в {{ KF }} и обновления IP-адресов записей во внутреннем DNS-кеше.

    По умолчанию выбрано значение `128`.

* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Адрес архива с [пользовательской геобазой](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) в {{ objstorage-name }}.

* **Keep alive timeout**{#setting-keep-alive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Время (в секундах) от поступления последнего запроса к {{ CH }} до разрыва соединения. Если за это время поступает новый запрос, соединение не разрывается.

    По умолчанию выбрано значение `3`.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Уровень логирования событий. На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
    1. `ERROR` — информация об ошибках в работе кластера;
    1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе кластера;
    1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе кластера;
    1. `DEBUG` — системная информация для последующего использования в отладке;
    1. `TRACE` — вся доступная информация о работе кластера.

    Подробнее об уровнях логирования см. в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Приблизительный размер (в байтах) кеша засечек, используемых движками таблиц семейства [MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/). Кеш общий для хоста кластера, память выделяется по мере необходимости.

    Выбранное значение настройки не является строгим ограничением. {{ CH }} может использовать чуть меньше или чуть больше памяти под этот кеш.

    По умолчанию выбрано значение `5368709120`.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальное количество одновременно обрабатываемых запросов.

    Минимальное значение — `10`, по умолчанию — `500`.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальное количество входящих клиентских соединений. Настройка не учитывает служебные соединения, которые открываются для выполнения распределенных подзапросов.

    Минимальное значение — `10`, по умолчанию — `4096`.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальный размер (в байтах) [партиции](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key) таблицы семейства [MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/), при котором таблицу можно удалить с помощью запроса `DROP TABLE`. Настройку можно использовать, чтобы предотвратить ошибочное удаление таблиц с реальными данными: такие таблицы обычно имеют большой размер по сравнению с тестовыми таблицами.

    По умолчанию выбрано значение `53687091200` (50 ГБ). При значении `0` можно удалять таблицы любого размера.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальный размер (в байтах) таблицы семейства [MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/), которую можно удалить с помощью запроса `DROP TABLE`. Настройку можно использовать, чтобы предотвратить ошибочное удаление таблиц с реальными данными: такие таблицы обычно имеют большой размер по сравнению с тестовыми таблицами.

    По умолчанию выбрано значение `53687091200` (50 ГБ). При значении `0` можно удалять таблицы любого размера.

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будут ли логироваться значения метрик из таблиц `system.metrics` и `system.events` в таблицу `system.metric_log`.

    По умолчанию выбрано значение `true`.

* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.metric_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.metric_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.part_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.part_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.query_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `1073741824` (1 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будет ли логироваться информация о потоках, которые выполняют запросы. Логи сохраняются в таблицу `system.query_thread_log`.

    По умолчанию выбрано значение `true`.

    Подробнее см. в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/operations/system-tables/query_thread_log).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.query_thread_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_thread_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будут ли записываться системные логи. Логи сохраняются в таблицу `system.text_log`.

    По умолчанию выбрано значение `false`.

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Уровень логирования событий в таблице [system.text_log](https://{{ ch-domain }}/docs/ru/operations/system-tables/text_log). На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
    1. `ERROR` — информация об ошибках в работе СУБД;
    1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе СУБД;
    1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе СУБД;
    1. `DEBUG` — системная информация для последующего использования в отладке;
    1. `TRACE` — вся доступная информация о работе СУБД.

    По умолчанию выбрано значение `TRACE`.

* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.text_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.text_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Временная зона сервера. Указывается идентификатором IANA в виде часового пояса UTC или географического положения (например, Africa/Abidjan).
    
    Подробнее см. в документации [{{ CH }}](https://{{ ch-domain }}/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Определяет, будут ли логироваться стектрейсы (stack traces), собираемые профилировщиком запросов. Стектрейсы сохраняются в таблицу `system.trace_log`.

    По умолчанию выбрано значение `true`.

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.trace_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.trace_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Размер кеша (в байтах) для несжатых данных, используемых движками таблиц семейства [MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/).

    По умолчанию выбрано значение `8589934592` (8 ГБ).

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Правила сжатия данных для таблиц семейства [MergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/mergetree/). Для каждого правила указываются:

    * **Method** — метод сжатия. Доступно два метода: [LZ4](https://lz4.github.io/lz4/) и [zstd](https://facebook.github.io/zstd/).
    * **Min part size** — минимальный размер [куска данных](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/custom-partitioning-key/) (в байтах).
    * **Min part size ratio** — отношение размера наименьшего куска таблицы к полному размеру таблицы. {{ CH }} будет применять правило только к тем таблицам, у которых такое отношение больше или равно значению **Min part size ratio**.

    Вы можете добавить несколько правил сжатия. {{ CH }} проверит условия **Min part size** и **Min part size ratio** и применит правила к тем таблицам, для которых выполнены оба условия. Если к одной таблице подходит несколько правил, {{ CH }} применит первое из них. Если ни одно из правил не подходит, {{ CH }} применит метод сжатия [LZ4](https://lz4.github.io/lz4/).

    Подробнее см. в документации [{{ CH }}](https://{{ ch-domain }}/docs/ru/operations/settings/settings).

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Конфигурации движка [GraphiteMergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/graphitemergetree) для прореживания и агрегирования/усреднения (rollup) данных [Graphite](http://graphite.readthedocs.io/en/latest/index.html):
    * **Name** — имя конфигурации.
    * **Patterns** — набор правил прореживания. Правило применяется, если имя метрики соответствует значению параметра **Regexp**, а возраст данных соответствует значению группы параметров **Retention**.
        * **Function** — имя агрегирующей функции.
        * **Regexp** — регулярное выражение, которому должно соответствовать имя метрики.
        * **Retention** — параметры задержки. Функция применяется к данным, чей возраст оказался в интервале [Age, Age + Precision]. Вы можете задать несколько групп таких параметров.
            * **Age** — минимальный возраст данных в секундах.
            * **Precision** — точность определения возраста данных в секундах. Значение должно быть кратно `86400` (количеству секунд в сутках).

    Вы можете настроить несколько конфигураций и использовать их для разных таблиц.

    Подробнее о поддержке Graphite см. в документации [{{ CH }}](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/graphitemergetree/).

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Глобальные настройки аутентификации для [интеграции с {{ KF }}](https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/kafka/):
    * **Sasl mechanism** — механизм аутентификации SASL:
      * `GSSAPI` — аутентификация c [использованием Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
      * `PLAIN` — аутентификация с [использованием пары «логин-пароль» в виде открытого текста](https://kafka.apache.org/documentation/#security_sasl_plain).
      * `SCRAM-SHA-256` и `SCRAM-SHA-512` — аутентификация с [использованием механизмов семейства SCRAM](https://kafka.apache.org/documentation/#security_sasl_scram).
    * **Sasl password** — пароль учетной записи {{ KF }}.
    * **Sasl username** — имя учетной записи {{ KF }}.
    * **Security protocol** — протокол безопасности для использования при аутентификации:
        * `PLAINTEXT` — данные для аутентификации передаются в открытом виде.
        * `SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL.
        * `SASL_PLAINTEXT` — данные для аутентификации передаются в открытом виде, в качестве транспорта используется SASL.
        * `SASL_SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL, в качестве транспорта используется SASL.
    
* **Kafka topics**{#setting-kafka-topics} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Настройки аутентификации на уровне [топиков](../../managed-kafka/concepts/topics.md) для [интеграции с {{ KF }}](https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/kafka/):

    * **Name** — имя топика {{ KF }}.
    * **Settings** — настройки аутентификации для топика, аналогичные глобальным настройкам аутентификации в секции [**Kafka**](#setting-kafka).

        Если для таблицы на движке Kafka настройки аутентификации на уровне топика не заданы, то будут использованы глобальные настройки из секции **Kafka**.

        Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#security).

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Конфигурация движка MergeTree:

    * **Max bytes to merge at min space in pool** — максимальный общий размер кусков данных для слияния, когда в фоновом пуле минимум свободных ресурсов.

        По умолчанию выбрано значение `1048576` (1 МБ).

        Подробнее см. в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/operations/settings/merge-tree-settings/#max-bytes-to-merge-at-min-space-in-pool).

    * **Max replicated merges in queue** — максимальное количество задач слияния, которые могут одновременно находиться в очереди `ReplicatedMergeTree`.

        По умолчанию выбрано значение `16`.

    * **Number of free entries in pool to lower max size of merge** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} уменьшает максимальный размер куска данных для слияния. Это позволяет быстрее обрабатывать небольшие слияния.

        По умолчанию выбрано значение `8`.

    * **Parts to delay insert** — количество активных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу. Активным куском является новый кусок данных, образованный в результате слияния.

        По умолчанию выбрано значение `150`.

    * **Parts to throw insert** — предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ...`

        По умолчанию выбрано значение `300`.

        Подробнее см. в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/operations/settings/merge-tree-settings/#parts-to-throw-insert).

    * **Replicated deduplication window** — число блоков последних вставок хешей, которые {{ ZK }} будет хранить. Дедупликация работает только для последних вставленных данных. Старые блоки будут удалены.

        По умолчанию выбрано значение `100`.

        Подробнее см. в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/operations/settings/merge-tree-settings/#replicated-deduplication-window).

    * **Replicated deduplication window seconds** — время, в течение которого {{ ZK }} хранит блоки последних вставок хешей. Дедупликация работает только для последних вставленных данных. Старые блоки будут удалены.

        По умолчанию выбрано значение `604800`.

        Подробнее см. в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/operations/settings/merge-tree-settings/#replicated-deduplication-window-seconds).

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Глобальные настройки аутентификации для [интеграции с {{ RMQ }}](https://{{ ch-domain }}/docs/ru/engines/table-engines/integrations/rabbitmq/):

    * **Password** — пароль учетной записи {{ RMQ }}.
    * **Username** — имя учетной записи {{ RMQ }}.
