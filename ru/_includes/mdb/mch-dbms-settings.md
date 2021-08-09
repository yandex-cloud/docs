* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Адрес архива с [пользовательской геобазой](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) в {{ objstorage-name }}.
  
* **Keep alive timeout**{#setting-} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Время в секундах после поступления последнего запроса к {{ CH }}, в течение которого сервер ожидает новый запрос. Если в течение этого времени запросов не поступит, {{ CH }} разорвет соединение. Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#keep-alive-timeout){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#keep-alive-timeout){% endif %}.

* **Log level**{#setting-log-level} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Уровень логирования событий. На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
  1. `ERROR` — информация об ошибках в работе кластера;
  1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе кластера;
  1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе кластера;
  1. `DEBUG` — системная информации для последующего использования в отладке;
  1. `TRACE` — вся доступная информации о работе кластера.

  Подробнее об уровнях логирования см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger){% else %}(https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger){% endif %}.

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Приблизительный размер в байтах кэша засечек, используемых движками таблиц семейства MergeTree. Кэш общий для сервера, память выделяется по мере необходимости.
  
  Подробнее о логировании в {{ CH }} см. в [документации]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#server-mark-cache-size){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#server-mark-cache-size){% endif %}.
  
* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Максимальное количество одновременно обрабатываемых запросов. 
  
  Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max-concurrent-queries){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max-concurrent-queries){% endif %}.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Максимальное количество входящих соединений.
  
  Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max-connections){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max-connections){% endif %}.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Максимальный размер в байтах [партиции]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/custom_partitioning_key/){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/custom_partitioning_key/){% endif %} таблицы семейства [MergeTree]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/){% endif %}, которую можно удалить с помощью запроса `DROP`.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Максимальный размер в байтах таблицы семейства [MergeTree]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/){% endif %}, которую можно удалить с помощью запроса `DROP`.
  
  Значение по умолчанию: `53687091200` (50 Гбайт).
  
  Значение 0 означает, что можно удалять все таблицы без ограничений.

  Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#max-table-size-to-drop){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max-table-size-to-drop){% endif %}.

* **Metric log enabled**{#setting-metric-log-enabled} {{ tag-con }} {{ tag-tf }}

  Включает или выключает логирование истории значений метрик из таблиц [system.metrics]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/metrics){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/metrics){% endif %} и [system.events]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/events){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/events){% endif %} в таблицу [system.metric_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/metric_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/metric_log){% endif %}.
  
  По умолчанию логирование включено (`true`).
  
* **Metric log retention size**{#setting-metric-log-retention-size} {{ tag-con }} {{ tag-tf }}

  Максимальный размер в байтах, которого может достигнуть таблица [system.metric_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/metric_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/metric_log){% endif %}, прежде чем из нее начнут удаляться старые записи.
  
  Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).

* **Metric log retention time**{#setting-metric-log-retention-time} {{ tag-con }} {{ tag-tf }}

  Период времени в миллисекундах, по истечении которого запись в таблице [system.metric_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/metric_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/metric_log){% endif %} подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. 
  
  Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
  
* **Part log retention size**{#setting-part-log-retention-size} {{ tag-con }} {{ tag-tf }}

  Максимальный размер в байтах, которого может достигнуть таблица [system.part_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/part_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/part_log){% endif %}, прежде чем из нее начнут удаляться старые записи.
  
  Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).

* **Part log retention time**{#setting-part-log-retention-time} {{ tag-con }} {{ tag-tf }}

  Период времени в миллисекундах, по истечении которого запись в таблице [system.part_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/part_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/part_log){% endif %} подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение должно быть кратно 1000.
  
  Значение 0 означает, что записи не будут удаляться по истечении времени. Значение по умолчанию: 2592000000 (30 дней).
  
* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-tf }}

  Максимальный размер в байтах, которого может достигнуть таблица [system.query_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/query_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/query_log){% endif %}, прежде чем из нее начнут удаляться старые записи. 
  
  Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 1073741824 (1 ГБ).

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-tf }}

  Период времени в миллисекундах, по истечении которого запись в таблице [system.query_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/query_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/query_log){% endif %} подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение должно быть кратно 1000. 
  
  Значение 0 означает, что записи не будут удаляться по истечении времени. Значение по умолчанию: 2592000000 (30 дней).

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-tf }}

  Включает или выключает логирование информации о потоках, которые выполняют запросы, например, имя потока, время его запуска, продолжительность обработки запроса. Логи пишутся в таблицу [system.query_thread_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/query_thread_log){% endif %}
  
  По умолчанию логирование включено (`true`).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-tf }}

  Максимальный размер в байтах, которого может достигнуть таблица [system.query_thread_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/query_thread_log){% endif %}, прежде чем из нее начнут удаляться старые записи.
  
  Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-tf }}

  Период времени в миллисекундах, по истечении которого запись в таблице [system.query_thread_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/query_thread_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/query_thread_log){% endif %} подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение должно быть кратно 1000. 
  
  Значение 0 означает, что записи не будут удаляться по истечении времени. Значение по умолчанию: 2592000000 (30 дней).

* **Text log enabled**{#setting-text-log-enabled} {{ tag-con }} {{ tag-tf }}

  Включает или выключает запись системных логов в таблицу [system.text_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/text_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/text_log){% endif %}.

  По умолчанию логирование выключено (`false`).

* **Text log level**{#setting-text-log-level} {{ tag-con }} {{ tag-tf }}

  Уровень логирования событий в таблице [system.text_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/text_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/text_log){% endif %}. На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
  1. `ERROR` — информация об ошибках в работе СУБД;
  1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе СУБД;
  1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе СУБД;
  1. `DEBUG` — системная информации для последующего использования в отладке;
  1. `TRACE` — вся доступная информации о работе СУБД.
  
* **Text log retention size**{#setting-text-log-retention-size} {{ tag-con }} {{ tag-tf }}

  Максимальный размер в байтах, которого может достигнуть таблица [system.text_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/text_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/text_log){% endif %}, прежде чем из нее начнут удаляться старые записи.
  
  Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).

* **Text log retention time**{#setting-text-log-retention-time} {{ tag-con }} {{ tag-tf }}

  Период времени в миллисекундах, по истечении которого запись в таблице [system.text_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/text_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/text_log){% endif %} подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение должно быть кратно 1000. 
  
  Значение 0 означает, что записи не будут удаляться по истечении времени. Значение по умолчанию: 2592000000 (30 дней).
  
* **Timezone**{#setting-timezone} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Временная зона сервера. Указывается идентификатором IANA в виде часового пояса UTC или географического положения (например, Africa/Abidjan). 
  
  Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone){% else %}(https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone){% endif %}.

* **Trace log enabled**{#setting-trace-log-enabled} {{ tag-con }} {{ tag-tf }}

  Включает или выключает логирование стектрейсов, собираемых профилировщиком запросов, в таблицу [system.trace_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/trace_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/trace_log){% endif %}.
  
  По умолчанию логирование включено (`true`).

* **Trace log retention size**{#setting-trace-log-retention-size} {{ tag-con }} {{ tag-tf }}

  Максимальный размер в байтах, которого может достигнуть таблица [system.trace_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/trace_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/trace_log){% endif %}, прежде чем из нее начнут удаляться старые записи. 
  
  Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).

* **Trace log retention time**{#setting-trace-log-retention-time} {{ tag-con }} {{ tag-tf }}

  Период времени в миллисекундах, по истечении которого запись в таблице [system.trace_log]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/system-tables/trace_log){% else %}(https://clickhouse.tech/docs/ru/operations/system-tables/trace_log){% endif %} подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение должно быть кратно 1000.

  Значение 0 означает, что записи не будут удаляться по истечении времени. Значение по умолчанию: 2592000000 (30 дней).
  
* **Uncompressed cache size**{#setting-uncompressed-cache-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Размер кэша в байтах для несжатых данных, используемых движками таблиц семейства MergeTree.
  
  Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#server-settings-uncompressed_cache_size){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#server-settings-uncompressed_cache_size){% endif %}.

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Правила сжатия данных для таблиц семейства [MergeTree]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree){% else %}(https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree){% endif %}:
   * **Method** — метод сжатия. Доступно два метода: [LZ4](https://lz4.github.io/lz4/) и [zstd](https://facebook.github.io/zstd/).
   * **Min part size** — минимальный размер [куска данных]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/#mergetree-data-storage){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/#mergetree-data-storage){% endif %} таблицы в байтах. {{ CH }} будет применять правило только к тем таблицам, у которых размер кусков больше или равен значению **Min part size**.
   * **Min part size ratio** — отношение размера наименьшего куска таблицы к полному размеру таблицы. {{ CH }} будет применять правило только к тем таблицам, у которых такое отношение больше или равно значению **Min part size ratio**.

   Вы можете добавить несколько правил сжатия. {{ CH }} проверит условия **Min part size** и **Min part size ratio** и применит правила к тем таблицам, для которых выполнены оба условия. Если к одной таблице подходит несколько правил, {{ CH }} применит первое из них. Если ни одно из правил не подходит, {{ CH }} применит метод сжатия LZ4.
   
   Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/server_settings/settings/#compression){% else %}(https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#compression){% endif %}.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Конфигурации движка [GraphiteMergeTree]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/graphitemergetree/){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/graphitemergetree/){% endif %} для прореживания и агрегирования/усреднения (rollup) данных [Graphite](http://graphite.readthedocs.io/en/latest/index.html):
  * **Name** — имя конфигурации.
  * **Patterns** — набор правил прореживания. Правило применяется, если имя метрики соответствует значению параметра **Regexp**, а возраст данных соответствует значению группы параметров **Retention**.
     * **Function** — имя агрегирующей функции.
     * **Regexp** — регулярное выражение, которому должно соответствовать имя метрики.
     * **Retention** — параметры задержки. Функция применяется к данным, чей возраст оказался в интервале [Age, Age + Precision]. Вы можете задать несколько групп таких параметров.
       * **Age** — минимальный возраст данных в секундах.
       * **Precision** — точность определения возраста данных в секундах. Должен быть делителем для 86400 (количество секунд в сутках).

  Вы можете настроить несколько конфигураций и использовать их для разных таблиц.

  Подробнее о поддержке Graphite в {{ CH }} читайте в [документации]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/graphitemergetree/){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/graphitemergetree/){% endif %}.

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-tf }}

  Глобальные настройки аутентификации для [интеграции с {{ KF }}]{% if region =="int" %}(https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/){% else %}(https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/){% endif %}:
  * **Sasl mechanism** — механизм аутентификации SASL:
    - `GSSAPI` — аутентификация c [использованием Kerberos](https://kafka.apache.org/documentation/#security_sasl_kerberos).
    - `PLAIN` — аутентификация с [использованием пары «логин-пароль» в виде открытого текста](https://kafka.apache.org/documentation/#security_sasl_plain).
    - `SCRAM-SHA-256` и `SCRAM-SHA-512` — аутентификация с [использованием механизмов семейства SCRAM](https://kafka.apache.org/documentation/#security_sasl_scram).
  * **Sasl password** — пароль учетной записи {{ KF }}.
  * **Sasl username** — имя учетной записи {{ KF }}.
  * **Security protocol** — протокол безопасности для использования при аутентификации:
    * `PLAINTEXT` — данные для аутентификации передаются в открытом виде.
    * `SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL.
    * `SASL_PLAINTEXT` — данные для аутентификации передаются в открытом виде, в качестве транспорта используется SASL.
    * `SASL_SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL, в качестве транспорта используется SASL.
  
  Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#security).
    
* **Kafka topics**{#setting-kafka-topics} {{ tag-con }} {{ tag-tf }}

  Настройки аутентификации на уровне [топиков](../../managed-kafka/concepts/topics.md) для [интеграции с {{ KF }}]{% if region =="int" %}(https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/){% else %}(https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/){% endif %}:
  * **Name** — имя топика {{ KF }}.
  * **Settings** — настройки аутентификации для топика, аналогичные глобальным настройкам аутентификации в секции [**Kafka**](#setting-kafka).

  Если для таблицы на [движке Kafka]{% if region =="int" %}(https://clickhouse.tech/docs/en/engines/table-engines/integrations/kafka/){% else %}(https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/){% endif %} не будут найдены данные аутентификации для топика, то будут использованы глобальные настройки из секции **Kafka**.

  Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#security).

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Конфигурация движка MergeTree:
  * **Max bytes to merge at min space in pool** — максимальный общий размер [куска данных]{% if region =="int" %}(https://clickhouse.yandex/docs/en/operations/table_engines/mergetree/#mergetree-data-storage){% else %}(https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/#mergetree-data-storage){% endif %} для слияния, когда в фоновом пуле минимум свободных потоков.
  * **Max replicated merges in queue** — максимальное число задач слияния, которые могут одновременно находиться в очереди `ReplicatedMergeTree`.
  * **Number of free entries in pool to lower max size of merge** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} уменьшает максимальный размер куска данных для слияния. Это позволяет быстрее обрабатывать небольшие слияния, а не заполнять пул длительными.
  * **Parts to delay insert** — число активных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу.
  * **Parts to throw insert** — предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение 'Too many parts ...'.
  * **Replicated deduplication window** — число последних блоков хешей, которые {{ ZK }} будет хранить (старые блоки будут удалены).
  * **Replicated deduplication window seconds** — время, в течение которого {{ ZK }} хранит блоки хешей (старые блоки будут удалены).

  Подробнее см. в [документации {{ CH }}]{% if region =="int" %}(https://clickhouse.tech/docs/en/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree){% else %}(https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree){% endif %}.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-tf }}

  Глобальные настройки аутентификации для [интеграции с {{ RMQ }}]{% if region =="int" %}(https://clickhouse.tech/docs/en/engines/table-engines/integrations/rabbitmq/){% else %}(https://clickhouse.tech/docs/ru/engines/table-engines/integrations/rabbitmq/){% endif %}:
  * **Password** - пароль учетной записи {{ RMQ }}.
  * **Username** - имя учетной записи {{ RMQ }}.