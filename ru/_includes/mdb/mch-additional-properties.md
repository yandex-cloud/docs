* **Geobase uri** — адрес архива с [пользовательской геобазой](../../managed-clickhouse/concepts/dictionaries.md#internal-dicts) в {{ objstorage-name }}.
* **Keep alive timeout** — время в секундах после поступления последнего запроса к {{ CH }}, в течение которого сервер ожидает новый запрос. Если в течение этого времени запросов не поступит, {{ CH }} разорвет соединение. Подробнее см. в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#keep-alive-timeout).
* **Log level** — уровень логирования событий. На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
   1. `ERROR` — информация об ошибках в работе кластера;
   1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе кластера;
   1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе кластера;
   1. `DEBUG` — системная информации для последующего использования в отладке;
   1. `TRACE` — вся доступная информации о работе кластера.

   Подробнее об уровнях логирования см. в [документации {{ CH }}](https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-logger).
* **Mark cache size** — приблизительный размер в байтах кэша засечек, используемых движками таблиц семейства MergeTree. Кэш общий для сервера, память выделяется по мере необходимости. Подробнее о логировании в {{ CH }} см. в [документации](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#server-mark-cache-size).
* **Max concurrent queries** — максимальное количество одновременно обрабатываемых запросов. Подробнее см. в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max-concurrent-queries).
* **Max connections** — максимальное количество входящих соединений. Подробнее см. в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max-connections).
* **Max partition size to drop** — максимальный размер в байтах [партиции](https://clickhouse.yandex/docs/ru/operations/table_engines/custom_partitioning_key/) таблицы семейства [MergeTree](https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/), которую можно удалить с помощью запроса `DROP`.
* **Max table size to drop** — максимальный размер в байтах таблицы семейства [MergeTree](https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/), которую можно удалить с помощью запроса `DROP`. Значение 0 означает, что можно удалять все таблицы без ограничений. Подробнее см. в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#max-table-size-to-drop).
* **Metric log enabled**  — включает или выключает логирование истории значений метрик из таблиц [system.metrics](https://clickhouse.tech/docs/ru/operations/system-tables/metrics) и [system.events](https://clickhouse.tech/docs/ru/operations/system-tables/events) в таблицу [system.metric_log](https://clickhouse.tech/docs/ru/operations/system-tables/metric_log). По умолчанию логирование включено (`true`).
* **Metric log retention size** — максимальный размер в байтах, которого может достигнуть таблица [system.metric_log](https://clickhouse.tech/docs/ru/operations/system-tables/metric_log), прежде чем из нее начнут удаляться старые записи. Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).
* **Metric log retention time** — период времени в миллисекундах, по истечении которого запись в таблице [system.metric_log](https://clickhouse.tech/docs/ru/operations/system-tables/metric_log) подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
* **Part log retention size** — максимальный размер в байтах, которого может достигнуть таблица [system.part_log](https://clickhouse.tech/docs/ru/operations/system-tables/part_log), прежде чем из нее начнут удаляться старые записи. Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).
* **Part log retention time** — период времени в миллисекундах, по истечении которого запись в таблице [system.part_log](https://clickhouse.tech/docs/ru/operations/system-tables/part_log) подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
* **Query log retention size** — максимальный размер в байтах, которого может достигнуть таблица [system.query_log](https://clickhouse.tech/docs/ru/operations/system-tables/query_log), прежде чем из нее начнут удаляться старые записи. Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 1073741824 (1 ГБ).
* **Query log retention time** — период времени в миллисекундах, по истечении которого запись в таблице [system.query_log](https://clickhouse.tech/docs/ru/operations/system-tables/query_log) подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
* **Query thread log enabled** — включает или выключает логирование информации о потоках, которые выполняют запросы, например, имя потока, время его запуска, продолжительность обработки запроса. Логи пишутся в таблицу [system.query_thread_log](https://clickhouse.tech/docs/ru/operations/system-tables/query_thread_log). По умолчанию логирование включено (`true`).
* **Query thread log retention size** — максимальный размер в байтах, которого может достигнуть таблица [system.query_thread_log](https://clickhouse.tech/docs/ru/operations/system-tables/query_thread_log), прежде чем из нее начнут удаляться старые записи. Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).
* **Query thread log retention time** — период времени в миллисекундах, по истечении которого запись в таблице [system.query_thread_log](https://clickhouse.tech/docs/ru/operations/system-tables/query_thread_log) подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
* **Text log enabled** — включает или выключает запись системных логов в таблицу [system.text_log](https://clickhouse.tech/docs/ru/operations/system-tables/text_log). По умолчанию логирование выключено (`false`).
* **Text log level** — уровень логирования событий в таблице [system.text_log](https://clickhouse.tech/docs/ru/operations/system-tables/text_log). На каждом следующем уровне лог будет содержать всю информацию из предыдущего:
   1. `ERROR` — информация об ошибках в работе СУБД;
   1. `WARNING` — информация о событиях, которые могут привести к ошибкам в работе СУБД;
   1. `INFORMATION` — подтверждения, информация о событиях, не приводящих к ошибкам в работе СУБД;
   1. `DEBUG` — системная информации для последующего использования в отладке;
   1. `TRACE` — вся доступная информации о работе СУБД.
* **Text log retention size** — максимальный размер в байтах, которого может достигнуть таблица [system.text_log](https://clickhouse.tech/docs/ru/operations/system-tables/text_log), прежде чем из нее начнут удаляться старые записи. Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).
* **Text log retention time**  — период времени в миллисекундах, по истечении которого запись в таблице [system.text_log](https://clickhouse.tech/docs/ru/operations/system-tables/text_log) подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
* **Timezone** — временная зона сервера. Указывается идентификатором IANA в виде часового пояса UTC или географического положения (например, Africa/Abidjan). Подробнее см. в [документации {{ CH }}](https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-timezone).
* **Trace log enabled**  — включает или выключает логирование стектрейсов, собираемых профилировщиком запросов, в таблицу [system.trace_log](https://clickhouse.tech/docs/ru/operations/system-tables/trace_log). По умолчанию логирование включено (`true`).
* **Trace log retention size**  — максимальный размер в байтах, которого может достигнуть таблица [system.trace_log](https://clickhouse.tech/docs/ru/operations/system-tables/trace_log), прежде чем из нее начнут удаляться старые записи. Значение 0 означает, что старые записи не будут удаляться из-за роста размера таблицы. Значение по умолчанию: 536870912 (0,5 ГБ).
* **Trace log retention time**  — период времени в миллисекундах, по истечении которого запись в таблице [system.trace_log](https://clickhouse.tech/docs/ru/operations/system-tables/trace_log) подлежит удалению. Отсчет начинается в момент внесения записи в таблицу. Значение 0 означает, что записи не будут удаляться по истечении времени. Значение должно быть кратно 1000. Значение по умолчанию: 2592000000 (30 дней).
* **Uncompressed cache size** — размер кэша в байтах для несжатых данных, используемых движками таблиц семейства MergeTree. Подробнее см. в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#server-settings-uncompressed_cache_size).
* **Compression** — правила сжатия данных для таблиц семейства [MergeTree](https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree).
   * **Method** — метод сжатия. Доступно два метода: [LZ4](https://lz4.github.io/lz4/) и [zstd](https://facebook.github.io/zstd/).
   * **Min part size** — минимальный размер [куска данных](https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/#mergetree-data-storage) таблицы в байтах. {{ CH }} будет применять правило только к тем таблицам, у которых размер кусков больше или равен значению **Min part size**.
   * **Min part size ratio** — отношение размера наименьшего куска таблицы к полному размеру таблицы. {{ CH }} будет применять правило только к тем таблицам, у которых такое отношение больше или равно значению **Min part size ratio**.

    Вы можете добавить несколько правил сжатия. {{ CH }} проверит условия **Min part size** и **Min part size ratio** и применит правила к тем таблицам, для которых выполнены оба условия. Если к одной таблице подходит несколько правил, {{ CH }} применит первое из них. Если ни одно из правил не подходит, {{ CH }} применит метод сжатия LZ4. Подробнее см. в [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/#compression)
* **Graphite rollup** — конфигурации движка [GraphiteMergeTree](https://clickhouse.yandex/docs/ru/operations/table_engines/graphitemergetree/) для прореживания и агрегирования/усреднения (rollup) данных [Graphite](http://graphite.readthedocs.io/en/latest/index.html). Вы можете настроить несколько конфигураций и использовать их для разных таблиц.

  Подробнее о поддержке Graphite в {{ CH }} читайте в [документации](https://clickhouse.yandex/docs/ru/operations/table_engines/graphitemergetree/).

   * **Name** — имя конфигурации.
   * **Patterns** — набор правил прореживания. Правило применяется, если имя метрики соответствует значению параметра **Regexp**, а возраст данных соответствует значению группы параметров **Retention**.
      * **Function** — имя агрегирующей функции.
      * **Regexp** — регулярное выражение, которому должно соответствовать имя метрики.
      * **Retention** — параметры задержки. Функция применяется к данным, чей возраст оказался в интервале [Age, Age + Precision]. Вы можете задать несколько групп таких параметров.
         * **Age** — минимальный возраст данных в секундах.
         * **Precision** — точность определения возраста данных в секундах. Должен быть делителем для 86400 (количество секунд в сутках).

* **Kafka** — глобальные настройки аутентификации для [интеграции с {{ KF }}](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/):
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
    
* **Kafka topics** — настройки аутентификации на уровне [топиков](../../managed-kafka/concepts/topics.md) для [интеграции с {{ KF }}](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/):
  * **Name** — имя топика {{ KF }}.
  * **Settings** — настройки аутентификации для топика, аналогичные глобальным настройкам аутентификации в секции **Kafka**.

  Если для таблицы на [движке Kafka](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/kafka/) не будут найдены данные аутентификации для топика, то будут использованы глобальные настройки из секции **Kafka**.

  Подробнее см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#security).

* **Merge tree** — конфигурация движка MergeTree. Подробнее см. в [документации {{ CH }}](https://clickhouse.tech/docs/ru/operations/server-configuration-parameters/settings/#server_configuration_parameters-merge_tree)
   * **Max bytes to merge at min space in pool** — максимальный общий размер [куска данных](https://clickhouse.yandex/docs/ru/operations/table_engines/mergetree/#mergetree-data-storage) для слияния, когда в фоновом пуле минимум свободных потоков.
   * **Max replicated merges in queue** — максимальное число задач слияния, которые могут одновременно находиться в очереди `ReplicatedMergeTree`.
   * **Number of free entries in pool to lower max size of merge** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} уменьшает максимальный размер куска данных для слияния. Это позволяет быстрее обрабатывать небольшие слияния, а не заполнять пул длительными.
   * **Parts to delay insert** — число активных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу.
   * **Parts to throw insert** — предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение 'Too many parts ...'.
   * **Replicated deduplication window** — число последних блоков хешей, которые {{ ZK }} будет хранить (старые блоки будут удалены).
   * **Replicated deduplication window seconds** — время, в течение которого {{ ZK }} хранит блоки хешей (старые блоки будут удалены).

* **Rabbitmq** - глобальные настройки аутентификации для [интеграции с {{ RMQ }}](https://clickhouse.tech/docs/ru/engines/table-engines/integrations/rabbitmq/):
   * **Password** - пароль учетной записи {{ RMQ }}.
   * **Username** - имя учетной записи {{ RMQ }}.