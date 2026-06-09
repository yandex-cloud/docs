# Настройки {{ CH }}

Для кластера {{ mch-name }} можно задать настройки, которые относятся к {{ CH }}:

   * [Настройки на уровне сервера](#server-level-settings) — задаются на уровне шарда или кластера. В пользовательской инсталляции {{ CH }} эти настройки меняются только через конфигурационные файлы, а в кластерах {{ mch-name }} — только через интерфейсы {{ yandex-cloud }}.
   * [Настройки на уровне запроса](#user-level-settings) — задаются на уровне пользователя, сессии или запроса.
   * [Настройки квот](#quota-settings) — задаются на уровне пользователя.

{% note info %}

В {{ CH }} доступно больше настроек, чем поддержано в интерфейсах {{ yandex-cloud }}. С помощью SQL-запросов можно изменить произвольные настройки {{ CH }}, в том числе [установить настройки {{ CH }} на уровне запроса](../operations/change-query-level-settings.md) или [изменить настройки таблиц MergeTree](../operations/change-server-level-settings.md#sql-queries).

{% endnote %}

Метки рядом с названием настройки позволяют определить, с помощью какого интерфейса задается значение этой настройки: консоль управления, CLI, [API](../../glossary/rest-api.md), SQL или {{ TF }}. Метка {{ tag-all }} указывает, что поддерживаются все перечисленные интерфейсы.

В зависимости от выбранного интерфейса, одна и та же настройка будет представлена по-разному, например:

- **Geobase uri** в консоли управления соответствует:
  - `geobase_uri` в gRPC API, {{ TF }};
  - `geobaseUri` в REST API;
- **Allow DDL** в консоли управления соответствует:
  - `allow_ddl` в CLI, gRPC API, SQL;
  - `allowDdl` в REST API.

## Настройки на уровне сервера {#server-level-settings}

{% note info %}

Чтобы с помощью {{ TF }} восстановить значения по умолчанию, явно укажите эти значения для настроек в манифесте. Удаление настроек из манифеста не приведет к их сбросу на значения по умолчанию.

{% endnote %}

Доступны следующие настройки:

* **Access control improvements**{#setting-access-control-improvements} {{ tag-con }}

    Настройки системы контроля доступа:

    * **Select from information schema requires grant**{#setting-select-from-information-schema-requires-grant} — определяет, требует ли запрос `SELECT * FROM information_schema.<table>` каких-либо разрешений и может ли запрос выполняться любым пользователем. Значение по умолчанию — `false`. При значении `true` для выполнения запроса требуется разрешение `GRANT SELECT ON information_schema.<table>`, как и для обычных таблиц.

    * **Select from system db requires grant**{#setting-select-from-system-db-requires-grant} — определяет, требует ли запрос `SELECT * FROM system.<table>` каких-либо разрешений и может ли запрос выполняться любым пользователем. Значение по умолчанию — `false`. При значении `true` для выполнения запроса требуется разрешение `GRANT SELECT ON system.<table>`, как и для обычных таблиц.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#access_control_improvements).

* **Asynchronous insert log enabled**{#setting-asynchronous-insert-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация об асинхронных вставках. Логи сохраняются в таблицу `system.asynchronous_insert_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/system-tables/asynchronous_insert_log).

* **Asynchronous insert log retention size**{#setting-asynchronous-insert-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.asynchronous_insert_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Asynchronous insert log retention time**{#setting-asynchronous-insert-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.asynchronous_insert_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Asynchronous metric log enabled**{#setting-asynchronous-metric-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будут ли логироваться исторические значения метрик из таблицы `system.asynchronous_metrics` в таблицу `system.asynchronous_metric_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/system-tables/asynchronous_metric_log).

* **Asynchronous metric log retention size**{#setting-asynchronous-metric-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.asynchronous_metric_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Asynchronous metric log retention time**{#setting-asynchronous-metric-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.asynchronous_metric_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Background buffer flush schedule pool size**{#setting-background-buffer-flush-schedule-pool-size} {{ tag-con }}

    Количество потоков для выполнения фонового сброса данных в таблицах семейства [Buffer]({{ ch.docs }}{{ lang }}/engines/table-engines/special/buffer).

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_buffer_flush_schedule_pool_size).

* **Background common pool size**{#setting-background-common-pool-size} {{ tag-con }} {{ tag-api }}

    Количество потоков для выполнения фоновых неспециализированных операций, например, очистки файловой системы, в таблицах семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

    Минимальное значение — `1`, по умолчанию — `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_common_pool_size).

* **Background distributed schedule pool size**{#setting-background-distributed-schedule-pool-size} {{ tag-con }}

    Количество потоков для выполнения фоновых операций в таблицах семейства [Distributed]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed).

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_distributed_schedule_pool_size).

* **Background fetches pool size**{#setting-background-fetches-pool-size} {{ tag-con }} {{ tag-api }}

    Количество потоков для выполнения фонового копирования данных с реплики в таблицах семейства [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication).

    Минимальное значение — `1`, по умолчанию для версий {{ CH }} 24.12 и ниже выбрано значение `16`, а для 25.1 и выше – `32`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_fetches_pool_size).

* **Background merges mutations concurrency ratio**{#setting-background-merges-mutations-concurrency-ratio} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Количество фоновых слияний и мутаций, которые могут выполняться одновременно каждым потоком.

    По умолчанию выбрано значение `2`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_merges_mutations_concurrency_ratio).

* **Background message broker schedule pool size**{#setting-background-message-broker-schedule-pool-size} {{ tag-con }}

    Количество потоков для выполнения фоновых трансляций сообщений. Новое значение настройки устанавливается при перезапуске сервера {{ CH }}.

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_message_broker_schedule_pool_size).

* **Background move pool size**{#setting-background-move-pool-size} {{ tag-con }}

    Количество потоков для фонового перемещения кусков данных в таблицах семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

    Минимальное значение — `1`, по умолчанию — `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_move_pool_size).

* **Background pool size**{#setting-background-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Количество потоков для выполнения фоновых слияний и [мутаций]({{ ch.docs }}{{ lang }}/sql-reference/statements/alter#mutations) в таблицах семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

    Минимальное значение — `1`, по умолчанию — `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#background_pool_size).

* **Background schedule pool size**{#setting-background-schedule-pool-size} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Количество потоков для выполнения фоновых задач. Применяется для реплицируемых таблиц, стримов в {{ KF }} и обновления IP-адресов записей во внутреннем DNS-кеше.

    Минимальное значение — `1`, по умолчанию — `128`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Compression**{#setting-compression} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Правила сжатия данных для таблиц семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree). Для каждого правила указываются:

    * **Level** — уровень сжатия. Доступен только для метода сжатия [zstd]({{ ch.docs }}{{ lang }}/sql-reference/statements/create/table#zstd). Минимальное значение — `1`, максимальное — `12`, по умолчанию — `9`.
    * **Method** — метод сжатия. Доступно два метода: [LZ4](https://lz4.github.io/lz4/) и [zstd](https://facebook.github.io/zstd/).
    * **Min part size** — минимальный размер [куска данных]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) (в байтах).
    * **Min part size ratio** — отношение размера наименьшего куска таблицы к полному размеру таблицы. {{ CH }} будет применять правило только к тем таблицам, у которых это отношение не превышает значение **Min part size ratio**.

    Вы можете добавить несколько правил сжатия. {{ CH }} проверит условия **Min part size** и **Min part size ratio** и применит правила к тем таблицам, для которых выполнены оба условия. Если к одной таблице подходит несколько правил, {{ CH }} применит первое из них. Если ни одно из правил не подходит, {{ CH }} применит метод сжатия [LZ4](https://lz4.github.io/lz4/).

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings).

* **Default database**{#setting-default-database} {{ tag-con }} {{ tag-api }}

    База данных по умолчанию. Инструкцию о получении списка баз данных в кластере см. в разделе [Управление базами данных](../operations/databases.md#list-db).

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Dictionaries lazy load**{#setting-dictionaries-lazy-load} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

    Если настройка включена, каждый словарь загружается при его первом использовании. Если загрузить не получилось, функция, использующая словарь, возвращает исключение.

    Если настройка выключена, словари загружаются при запуске сервера. Сервер ожидает, пока загрузятся все словари, до того как начать обработку соединений.

    По умолчанию для версий {{ CH }} 24.12 и ниже настройка выключена, а для 25.1 и выше – включена.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#server_configuration_parameters-dictionaries_lazy_load).

* **Geobase enabled**{#setting-geobase-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Включение [встроенного словаря-геобазы](dictionaries.md#internal-dicts).

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Geobase uri**{#setting-geobase-uri} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Адрес архива с [пользовательской геобазой](dictionaries.md#internal-dicts) в {{ objstorage-name }}.

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Graphite rollup**{#setting-graphite-rollup} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Конфигурации движка [GraphiteMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/graphitemergetree) для прореживания и агрегирования (rollup) данных [Graphite](http://graphite.readthedocs.io/en/latest/index.html):
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

    Подробнее о поддержке Graphite см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/graphitemergetree).

* **Jdbc bridge**{#setting-jdbc-bridge} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    JDBC-мост для запросов к внешним базам данных. Указываются хост и опционально порт для доступа к источнику данных.

    Изменение настроек приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/integrations/jdbc/jdbc-with-clickhouse).

* **Kafka**{#setting-kafka} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Глобальные настройки аутентификации для [интеграции с {{ KF }}]({{ ch.docs }}{{ lang }}/engines/table-engines/integrations/kafka):

    * **Auto offset reset** — начальная позиция, откуда начинается чтение сообщений [потребителем](../../managed-kafka/concepts/producers-consumers.md). С этой позиции потребитель добавляет сдвиги для новых сообщений по мере того, как движется и читает поступаемые сообщения. По умолчанию значение не выбрано (эквивалентно `latest`). Подробнее см. в [документации Confluent](https://docs.confluent.io/platform/current/clients/consumer.html#offset-management).
    * **Batch size** — максимальный суммарный размер всех сообщений в пакете (MessageSet), включая накладные данные протокола.
    
      Возможные значения от `1` до `2147483647` байт. Значение по умолчанию — `1000000`.

    * **Debug** — контекст для отладки. По умолчанию значение не выбрано. В настройке можно указать только одно значение. Список доступных значений см. в документации библиотеки `librdkafka` на [GitHub](https://github.com/confluentinc/librdkafka/blob/master/CONFIGURATION.md).
    * **Enable ssl certificate verification** — определяет, будет ли проводиться проверка SSL-сертификата. По умолчанию выбрано значение `false`.
    * **Max poll interval ms** — максимальный интервал (в миллисекундах) между вызовами для получения сообщений высокоуровневых потребителей. При превышении интервала пользователь удаляется из группы и запускается перебалансировка. По умолчанию значение не задано (эквивалентно `300000` — 5 минут).
    * **Message max bytes** — максимальный размер сообщения в запросе по протоколу {{ KF }}.
      
      Возможные значения от `1000` до `1000000000` байт. Значение по умолчанию — `1000000`.
    
    * **Sasl mechanism** — механизм аутентификации SASL:
      * `GSSAPI` (по умолчанию) — аутентификация с [использованием Kerberos](https://kafka.apache.org/42/security/authentication-using-sasl/#authentication-using-saslkerberos).
      * `PLAIN` — аутентификация с [использованием пары логин-пароль в виде открытого текста](https://kafka.apache.org/42/security/authentication-using-sasl/#authentication-using-saslplain).
      * `SCRAM-SHA-256` и `SCRAM-SHA-512` — аутентификация с [использованием механизмов семейства SCRAM](https://kafka.apache.org/42/security/authentication-using-sasl/#authentication-using-saslscram).

      По умолчанию значение не выбрано (эквивалентно `GSSAPI`).

    * **Sasl password** — пароль учетной записи {{ KF }}.
    * **Sasl username** — имя учетной записи {{ KF }}.
    * **Security protocol** — протокол безопасности для использования при аутентификации:
        * `PLAINTEXT` — данные для аутентификации передаются в открытом виде.
        * `SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL.
        * `SASL_PLAINTEXT` — данные для аутентификации передаются в открытом виде, в качестве транспорта используется SASL.
        * `SASL_SSL` — данные для аутентификации передаются в зашифрованном виде с помощью SSL, в качестве транспорта используется SASL.

        По умолчанию значение не выбрано (эквивалентно `PLAINTEXT`).

    * **Session timeout ms** — время ожидания (в миллисекундах) периодического сигнала от пользователя для поддержки сессии клиентской группы. При превышении времени брокер удаляет пользователя из группы и запускает перебалансировку. По умолчанию для версий {{ CH }} 25.1 и ниже выбрано значение `45000` (45 секунд), а для 25.2 и выше – `30000` (30 секунд).

    Изменение настроек приводит к перезапуску серверов {{ CH }} на хостах кластера.

    {% note tip %}

    Если вы хотите задать настройки аутентификации на уровне [топика](../../managed-kafka/concepts/topics.md), укажите их при [создании таблицы на движке Kafka]({{ ch.docs }}{{ lang }}/engines/table-engines/integrations/kafka#creating-a-table) или переиспользуйте их с помощью [именованных коллекций]({{ ch.docs }}{{ lang }}/operations/named-collections#named-collections-for-accessing-kafka).

    {% endnote %}

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

    Подробнее об уровнях логирования см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#server_configuration_parameters-logger).

* **Mark cache size**{#setting-mark-cache-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Приблизительный размер (в байтах) кеша засечек, используемых движками таблиц семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree). Кеш общий для хоста кластера, память выделяется по мере необходимости.

    Выбранное значение настройки не является строгим ограничением. {{ CH }} может использовать чуть меньше или чуть больше памяти под этот кеш.

    По умолчанию выбрано значение `5368709120`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Max concurrent queries**{#setting-max-concurrent-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальное количество одновременно обрабатываемых запросов.

    Минимальное значение — `10`, по умолчанию — `500`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Max connections**{#setting-max-connections} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальное количество входящих клиентских соединений. Настройка не учитывает служебные соединения, которые открываются для выполнения распределенных подзапросов.

    Минимальное значение — `10`, по умолчанию — `4096`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Max partition size to drop**{#setting-max-partition-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальный размер (в байтах) [партиции]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) таблицы семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree), при котором таблицу можно удалить с помощью запроса `DROP TABLE`. Настройку можно использовать, чтобы предотвратить ошибочное удаление таблиц с реальными данными: такие таблицы обычно имеют большой размер по сравнению с тестовыми таблицами.

    По умолчанию выбрано значение `53687091200` (50 ГБ). При значении `0` можно удалять таблицы любого размера.

* **Max table size to drop**{#setting-max-table-size-to-drop} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Максимальный размер (в байтах) таблицы семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree), которую можно удалить с помощью запроса `DROP TABLE`. Настройку можно использовать, чтобы предотвратить ошибочное удаление таблиц с реальными данными: такие таблицы обычно имеют большой размер по сравнению с тестовыми таблицами.

    По умолчанию выбрано значение `53687091200` (50 ГБ). При значении `0` можно удалять таблицы любого размера.

* **Merge tree**{#setting-merge-tree} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Конфигурация движка MergeTree:

    * **Allow remote fs zero copy replication** — определяет, разрешена ли удаленная репликация с нулевой копией для S3 и HDFS-дисков.

        По умолчанию выбрано значение `true`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/integrations/s3#disable-zero-copy-replication).

    * **Check sample column is correct** — при создании таблицы включает проверку, что тип данных столбца является верным для сэмплирования или выражений сэмплирования.

        По умолчанию проверка включена. Вы можете ее отключить, если у вас уже есть таблицы с некорректными выражениями сэмплирования. Тогда не будет возникать ложных срабатываний и исключений при запуске сервера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#check_sample_column_is_correct).

    * **Cleanup delay period** — интервал времени (в секундах) между запусками [распределенных DDL-запросов]({{ ch.docs }}{{ lang }}/sql-reference/distributed-ddl) для очистки устаревших данных.

        По умолчанию выбрано значение `30`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#server-settings-distributed_ddl).

    * **Deduplicate merge projection mode** {{ tag-con }} {{ tag-cli }} — определяет поведение фоновых слияний для таблиц с проекциями:

        * `ignore` — параметр игнорируется. Это значение используется только для обеспечения совместимости.
        * `throw` — генерируется исключение, которое предотвращает рассинхронизацию частей проекции.
        * `drop` — затронутая часть таблицы проекций удаляется.
        * `rebuild` — затронутая часть таблицы проекций перестраивается.

        По умолчанию значение не выбрано (эквивалентно `throw`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#deduplicate_merge_projection_mode).

    * **Inactive parts to delay insert** — количество неактивных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу.

        По умолчанию ограничение скорости выключено (`0`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#inactive-parts-to-delay-insert).

    * **Inactive parts to throw insert** — количество неактивных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many inactive parts ...`.

        По умолчанию отправка исключений выключена (`0`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#inactive-parts-to-throw-insert).

    * **Lightweight mutation projection mode** {{ tag-con }} {{ tag-cli }} — определяет поведение упрощенных удалений для таблиц с проекциями:

        * `throw` — генерируется исключение, которое предотвращает рассинхронизацию частей проекции.
        * `drop` — затронутая часть таблицы проекций удаляется.
        * `rebuild` — затронутая часть таблицы проекций перестраивается.

        По умолчанию значение не выбрано (эквивалентно `throw`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#lightweight_mutation_projection_mode).

    * **Materialize ttl recalculate only** {{ tag-con }} {{ tag-cli }} — включает применение измененных правил TTL таблиц или строк только при явном указании `MATERIALIZE TTL` в запросе.

        Значение по умолчанию:

        * Для версий {{ CH }} 25.2 и выше — `true`. Пересчитывается только информация о TTL, что облегчает материализацию TTL.
        * Для версий {{ CH }} 25.1 и ниже — `false`. Выполняется полная материализация TTL.

        Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#materialize_ttl_recalculate_only).

    * **Max avg part size for too many parts** — максимальный средний размер активных кусков данных таблицы (в байтах) для выполнения проверок **Parts to delay insert** и **Parts to throw insert**. При превышении указанного значения вставки данных в таблицу не будут замедлены или отклонены.

        Минимальное значение — `0`, по умолчанию — `1073741824` (1 ГБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Max bytes to merge at max space in pool** — максимальный общий размер кусков данных (в байтах) для слияния, когда в фоновом пуле есть свободные ресурсы.

        По умолчанию выбрано значение `161061273600` (150 ГБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#max-bytes-to-merge-at-max-space-in-pool).

    * **Max bytes to merge at min space in pool** — максимальный общий размер кусков данных для слияния, когда в фоновом пуле минимум свободных ресурсов.

        По умолчанию выбрано значение `1048576` (1 МБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#max-bytes-to-merge-at-min-space-in-pool).

    * **Max cleanup delay period** — максимальный период в секундах для очистки устаревших данных: логов запросов, хешей блоков и кусков данных.

        Укажите значение не меньше, чем у настройки **Cleanup delay period**.

        Значение по умолчанию — `300`.

    * **Max merge selecting sleep ms** — максимальное время ожидания для слияния выборки (в миллисекундах).

        Укажите значение не меньше, чем у настройки **Merge selecting sleep ms**.

        Значение по умолчанию — `60000` (1 минута). Если указать меньшее значение, задачи выборки будут часто запускаться в пуле фоновых задач. В результате в кластерах с большими мощностями скопится большое количество запросов к {{ ZK }}.

    * **Max number of merges with ttl in pool** — предельное количество слияний по TTL в фоновом пуле.

        По умолчанию выбрано значение `2`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Max parts in total** — количество активных кусков данных во всех партициях таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ...`.

        По умолчанию для версий {{ CH }} 25.1 и ниже выбрано значение `100000`, а для 25.2 и выше – `20000`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#max-parts-in-total).

    * **Max replicated merges in queue** — максимальное количество задач слияния, которые могут одновременно находиться в очереди `ReplicatedMergeTree`.

        По умолчанию выбрано значение `16`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Merge max block size** — из скольких строк состоят блоки, которые формируют объединяемые куски данных.

        База данных читает строки из этих кусков, затем объединяет эти строки и записывает их в новый кусок. Читаемые строки помещаются в оперативную память (RAM), поэтому настройка влияет на ее размер, необходимый для слияния строк. Если уменьшить значение настройки, сократится допустимый размер RAM, и слияние строк замедлится.

        Значение по умолчанию — `8192`.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#merge-max-block-size).

    * **Merge selecting sleep ms** — время ожидания (в миллисекундах) для слияния выборки, если ни один кусок не выбран.

        По умолчанию выбрано значение `5000` (5 секунд). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#merge_selecting_sleep_ms).

    * **Merge with recompression TTL timeout** — минимальное время (в секундах) между слияниями для повторного сжатия данных с истекшим TTL.

        По умолчанию выбрано значение `14400` (4 часа). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/guides/developer/ttl#triggering-ttl-events).

    * **Merge with TTL timeout** — минимальное время (в секундах) между слияниями для удаления данных с истекшим TTL.

        По умолчанию выбрано значение `14400` (4 часа). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/guides/developer/ttl#triggering-ttl-events).

    * **Min age to force merge on partition only** — определяет, применять ли объединение из настройки **Min age to force merge seconds** только к [партициям]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key).

        По умолчанию применение только к партициям отключено. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#min_age_to_force_merge_on_partition_only).

    * **Min age to force merge seconds** — минимальное время (в секундах) существования кусков данных для объединения.

        По умолчанию выбрано значение `0` (объединение отключено). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#min_age_to_force_merge_seconds).

    * **Min bytes for wide part** — минимальное количество байтов в куске данных, который может храниться в формате `Wide`. Можно задать одновременно с параметром **Min rows for wide part**.

        Если количество байтов в куске данных меньше заданного значения, тогда этот кусок данных хранится в формате `Compact`.

        Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#mergetree-data-storage).

    * **Min rows for wide part** — минимальное количество строк в куске данных, который может храниться в формате `Wide`. Можно задать одновременно с параметром **Min bytes for wide part**.

        Если количество строк в куске данных меньше заданного значения, тогда этот кусок данных хранится в формате `Compact`.

        Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#mergetree-data-storage).

    * **Number of free entries in pool to execute mutation** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} перестает выполнять операции [мутаций]({{ ch.docs }}{{ lang }}/sql-reference/statements/alter#mutations). Это позволяет оставлять свободные потоки для слияний и избежать исключения `Too many parts ...`.

        По умолчанию выбрано значение `20`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#number-of-free-entries-in-pool-to-execute-mutation).

    * **Number of free entries in pool to lower max size of merge** — предельное значение свободных записей в пуле. Если количество записей в пуле становится меньше этого значения, {{ CH }} уменьшает максимальный размер куска данных для слияния. Это позволяет быстрее обрабатывать небольшие слияния.

        По умолчанию выбрано значение `8`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    * **Parts to delay insert** — количество активных кусков данных таблицы, при превышении которого {{ CH }} будет искусственно уменьшать скорость вставки данных в таблицу. Активным куском является новый кусок данных, образованный в результате слияния.

        По умолчанию для версий {{ CH }} 24.12 и ниже выбрано значение `150`, а для 25.1 и выше – `1000`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#parts-to-delay-insert).

    * **Parts to throw insert** — предельное число активных кусков данных таблицы, при превышении которого {{ CH }} отправляет исключение `Too many parts ...`

        По умолчанию для версий {{ CH }} 24.12 и ниже выбрано значение `300`, а для 25.1 и выше – `3000`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#parts-to-throw-insert).

    * **Replicated deduplication window** — число блоков последних вставок хешей, которые {{ ZK }} будет хранить. Дедупликация работает только для последних вставленных данных. Старые блоки будут удалены.

        По умолчанию выбрано значение `100`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#replicated-deduplication-window).

    * **Replicated deduplication window seconds** — время, в течение которого {{ ZK }} хранит блоки последних вставок хешей. Дедупликация работает только для последних вставленных данных. Старые блоки будут удалены.

        По умолчанию выбрано значение `604800`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/merge-tree-settings#replicated-deduplication-window-seconds).

    * **TTL only drop parts** — определяет режим удаления данных по TTL:

        * `true` — целыми кусками данных.
        * `false` — построчно, с выполнением дополнительных слияний данных. Этот режим потребляет значительно больше ресурсов, чем удаление целыми кусками.

        По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

        Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#ttl_only_drop_parts).

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

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/opentelemetry).

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

* **Processors profile log enabled**{#setting-processors-profile-log-enabled} {{ tag-con }} {{ tag-cli }}

    Определяет, будет ли логироваться информация о профилировании на уровне процессоров. Логи сохраняются в таблицу `system.processors_profile_log`.

    Значение по умолчанию:

    * Для версий {{ CH }} 25.2 и выше — `true`.
    * Для версий {{ CH }} 25.1 и ниже — `false`.

    Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Processors profile log retention size**{#setting-processors-profile-log-retention-size} {{ tag-con }} {{ tag-cli }}

    Максимальный размер таблицы `system.processors_profile_log` (в байтах), при превышении которого из нее автоматически будут удаляться старые записи.

   Значение по умолчанию — `0` (старые записи не будут удаляться при росте размера таблицы).

* **Processors profile log retention time**{#setting-processors-profile-log-retention-time} {{ tag-con }} {{ tag-cli }}

    Время (в миллисекундах) от внесения записи в таблицу `system.processors_profile_log` до удаления этой записи. Значение должно быть кратно 1000.

    Значение по умолчанию — `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query cache**{#setting-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Настройки [кеша запросов]({{ ch.docs }}{{ lang }}/operations/query-cache). Кеш позволяет выполнять запросы `SELECT` по одному разу и использовать сохраненные результаты в дальнейших операциях. В итоге снижается задержка и сокращается потребление ресурсов кластера при обработке запросов.

    Доступные настройки кеша запросов:

    * **Max entries** — максимальное количество результатов, которое можно сохранить в кеше при выполнении запросов `SELECT`. Значение по умолчанию — `1024`.
    * **Max entry size in bytes** — максимальное число байтов, которое можно выделить в кеше каждому результату выполнения запроса `SELECT`. Значение по умолчанию — `1048576` (один мегабайт).
    * **Max entry size in rows** — максимальное число строк, которое можно выделить в кеше каждому результату выполнения запроса `SELECT`. Значение по умолчанию — `30000000`.
    * **Max size in bytes** — максимальный размер кеша в байтах. Если указать `0`, кеш запросов будет отключен. Значение по умолчанию — `1073741824` (один гигабайт).

    Подробнее о настройках см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#server_configuration_parameters_query-cache).

* **Query log retention size**{#setting-query-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.query_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `1073741824` (1 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Query log retention time**{#setting-query-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query masking rules**{#setting-query-masking-rules} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Настройки [маскирования запросов]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#query-masking-rules). Позволяют применить регулярные выражения к запросам и сообщениям в логах. В результате данные хранятся в логах в защищенном виде, так как регулярные выражения помогают предотвратить утечку конфиденциальных данных (например, имени, электронной почты, данных банковских карт).

    Доступные настройки для правил маскирования запросов:

    * **Name** — название правила. Необязательный параметр.
    * **Regexp** — регулярное выражение с синтаксисом RE2.
    * **Replace** — выражение, которым надо заменить конфиденциальные данные. По умолчанию используются шесть звездочек.

* **Query thread log enabled**{#setting-query-thread-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}

    Активирует таблицу `system.query_thread_log` для логирования в ней потоков, которые выполняют запросы. Чтобы записывались логи, убедитесь, что также включена настройка [Log query threads](settings-list.md#setting-log-query-threads).

    По умолчанию выбрано значение `true`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/system-tables/query_thread_log).

* **Query thread log retention size**{#setting-query-thread-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Размер таблицы `system.query_thread_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `536870912` (0,5 ГБ). При значении `0` старые записи не будут удаляться при росте размера таблицы.

* **Query thread log retention time**{#setting-query-thread-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_thread_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Query views log enabled**{#setting-query-views-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация о зависимых представлениях, выполняемых при выполнении запроса. Логи сохраняются в таблицу `system.query_views_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/system-tables/query_views_log).

* **Query views log retention size**{#setting-query-views-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.query_views_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Query views log retention time**{#setting-query-views-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.query_views_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

* **Rabbitmq**{#setting-rabbitmq} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-tf }}

    Глобальные настройки аутентификации для [интеграции с {{ RMQ }}]({{ ch.docs }}{{ lang }}/engines/table-engines/integrations/rabbitmq):

    * **Password** — пароль учетной записи {{ RMQ }}.
    * **Username** — имя учетной записи {{ RMQ }}.
    * **Vhost** — адрес виртуального хоста для {{ RMQ }}.

    Изменение настроек приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Session log enabled**{#setting-session-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация об успешных и неудачных событиях входа и выхода из системы. Логи сохраняются в таблицу `system.session_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/system-tables/session_log).

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

    Уровень логирования событий в таблице [system.text_log]({{ ch.docs }}{{ lang }}/operations/system-tables/text_log). На каждом следующем уровне лог будет содержать всю информацию из предыдущего:

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

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#server_configuration_parameters-timezone).

* **Total memory profiler step**{#setting-total-memory-profiler-step} {{ tag-con }} {{ tag-api }}

    Объем памяти (в байтах) для стектрейса (stack trace) на каждом шаге выделения памяти. Данные хранятся в системной таблице `system.trace_log`, при этом значение `query_id` является пустой строкой.

    По умолчанию выбрано значение `4194304` (4 МБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#total-memory-profiler-step).

* **Total memory tracker sample probability**{#setting-total-memory-tracker-sample-probability} {{ tag-con }}

    Вероятность записи информации о случайных выделениях и освобождениях памяти (в процентах). Эти записи хранятся в системной таблице `system.trace_log`. Параметр `trace_type` принимает значение параметра `MemorySample`. Вероятность касается каждого выделения или освобождения памяти, независимо от размера выделения. Выборка происходит, только когда объем неотслеживаемой памяти превышает значение настройки [Total memory profiler step](#setting-total-memory-profiler-step).

    По умолчанию запись случайных выделений и освобождений памяти выключена (`0`). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#total-memory-tracker-sample-probability).

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

    Размер кеша (в байтах) для несжатых данных, используемых движками таблиц семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

    По умолчанию выбрано значение `8589934592` (8 ГБ). Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

* **Zookeeper log enabled**{#setting-zookeeper-log-enabled} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Определяет, будет ли логироваться информация о параметрах запроса к серверу {{ ZK }} и ответа от него. Логи сохраняются в таблицу `system.zookeeper_log`.

    По умолчанию выбрано значение `false`. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

    Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/system-tables/zookeeper_log).

* **Zookeeper log retention size**{#setting-zookeeper-log-retention-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Размер таблицы `system.zookeeper_log` (в байтах), при превышении которого из нее начнут удаляться старые записи.

    По умолчанию выбрано значение `0` (старые записи при росте размера таблицы не удаляются).

* **Zookeeper log retention time**{#setting-zookeeper-log-retention-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

    Время (в миллисекундах) от внесения записи в таблицу `system.zookeeper_log` до удаления этой записи. Значение должно быть кратно 1000.

    По умолчанию выбрано значение `2592000000` (30 дней). При значении `0` записи хранятся бессрочно.

## Настройки на уровне запроса {#user-level-settings}

### Настройки СУБД {#dbms-user-settings}

Эти настройки действуют на уровне отдельного пользователя.

{% note info %}

Чтобы с помощью {{ TF }} восстановить значения по умолчанию, явно укажите эти значения для настроек в манифесте. Удаление настроек из манифеста не приведет к их сбросу на значения по умолчанию.

{% endnote %}

Доступны следующие настройки:

* **Add HTTP CORS header**{#setting-add-http-cors-header} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Включает заголовок [CORS](../../glossary/cors.md) в HTTP-ответы.

  По умолчанию заголовок CORS не включается в HTTP-ответы.

* **Allow DDL**{#setting-allow-ddl} {{ tag-all }}

  Определяет, будут ли выполняться DDL-запросы (`CREATE`, `ALTER`, `RENAME` и другие).

  По умолчанию выполнение DDL-запросов разрешено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/permissions-for-queries#settings_allow_ddl).

  См. также: настройка [Readonly](#setting-readonly).

* **Allow introspection functions**{#setting-allow-introspection-functions} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Включает [функции интроспекции]({{ ch.docs }}{{ lang }}/sql-reference/functions/introspection) для профилирования запросов.

  Возможные значения:

  * `0` — функции интроспекции отключены.
  * `1` — функции интроспекции включены.

  Значение по умолчанию — `0`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-allow_introspection_functions).

* **Allow suspicious low cardinality types**{#setting-allow-suspicious-low-cardinality-types} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Разрешает использовать тип данных [LowCardinality]({{ ch.docs }}{{ lang }}/sql-reference/data-types/lowcardinality) с типами данных с фиксированным размером 8 байт или меньше.

  Возможные значения:

  * `0` — использование `LowCardinality` ограничено.
  * `1` — использование `LowCardinality` не ограничено.

  Значение по умолчанию — `0`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#allow_suspicious_low_cardinality_types).

* **Any join distinct right table keys**{#setting-any-join-distinct-right-table-keys} {{ tag-con }} {{ tag-sql }}

  Включает устаревшее поведение сервера {{ CH }} при выполнении операций `ANY INNER|LEFT JOIN`.

  По умолчанию устаревшее поведение операции `JOIN` выключено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#any_join_distinct_right_table_keys).

* **Async insert**{#setting-async-insert} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Включает или отключает асинхронные вставки. Работает только для вставок по протоколу HTTP. При таких вставках дедупликация не производится.

  Если включено, данные собираются в пачки перед вставкой в таблицу. Это позволяет производить мелкие и частые вставки в {{ CH }} (до 15000 запросов в секунду) без промежуточных таблиц.

  Возможные значения:

  * `0` — вставки производятся синхронно, один запрос за другим.
  * `1` — включены множественные асинхронные вставки.

  Значение по умолчанию — `0`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#async-insert).

* **Async insert busy timeout**{#setting-async-insert-busy-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Максимальное время (в миллисекундах) ожидания вставки данных с момента первого запроса `INSERT`.

  Значение по умолчанию — `200`. Если указан `0`, ожидание отключено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#async-insert-busy-timeout-ms).

* **Async insert max data size**{#setting-async-insert-max-data-size} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Максимальный размер необработанных данных (в байтах), собранных за запрос, перед их вставкой.

  Значение по умолчанию — `1000000`. Если указан `0`, асинхронные вставки будут отключены.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#async-insert-max-data-size).

* **Async insert stale timeout**{#setting-async-insert-stale-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Максимальное время (в миллисекундах) ожидания вставки данных с момента последнего запроса `INSERT`. Если установлено ненулевое значение, [**Async insert busy timeout**](#setting-async-insert-busy-timeout) будет продлеваться с каждым запросом `INSERT`, пока не будет превышено значение [**Async insert max data size**](#setting-async-insert-max-data-size).

  Значение по умолчанию — `0`. Если указан `0`, ожидание отключено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#async-insert-stale-timeout-ms).

* **Async insert threads**{#setting-async-insert-threads} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Максимальное число потоков для фоновой обработки и вставки данных.

  Значение по умолчанию — `16`. Если указан `0`, асинхронные вставки будут отключены.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#async-insert-threads).

* **Async insert use adaptive busy timeout**{#setting-async-insert-use-adaptive-busy-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, использовать ли адаптивную асинхронную вставку, при которой {{ CH }} ограничивает количество вставок в зависимости от нагрузки на сервер.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#async_insert_use_adaptive_busy_timeout).

* **Cancel HTTP readonly queries on client close**{#setting-cancel-http-readonly-queries-on-client-close} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Если настройка включена, сервис отменяет HTTP readonly запросы (например, SELECT) в момент, когда клиент обрывает соединение до получения ответа.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#cancel-http-readonly-queries-on-client-close).

* **Compile expressions**{#setting-compile-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, компилировать ли выражения при выполнении запросов. При включенной компиляции запросы, в которых используются идентичные выражения, могут выполняться быстрее за счет использования скомпилированных выражений.

  Используется вместе с настройкой [Min count to compile expression](#setting-min-count-to-compile-expression).

  По умолчанию компиляция выражений выключена.

* **Connect timeout**{#setting-connect-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Время ожидания соединения (в миллисекундах).

  Минимальное значение — `1`, по умолчанию — `10000` (10 секунд).

* **Connect timeout with failover**{#setting-connect-timeout-with-failover} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Время ожидания соединения (в миллисекундах) с удаленным сервером для движка таблиц `Distributed`, если кластер использует шардирование и репликацию.

  Если установить соединение с сервером не удалось, будут предприняты попытки установить соединение с его репликами.

  Значение по умолчанию — `50`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#connect-timeout-with-failover-ms).

* **Count distinct implementation**{#setting-count-distinct-implementation} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Определяет, какая из функций `uniq*` используется при выполнении конструкции `COUNT(DISTINCT …)`:
  * [uniq]({{ ch.docs }}{{ lang }}/sql-reference/aggregate-functions/reference/uniq#agg_function-uniq)
  * [uniqCombined]({{ ch.docs }}{{ lang }}/sql-reference/aggregate-functions/reference/uniqcombined#agg_function-uniqcombined)
  * [uniqCombined64]({{ ch.docs }}{{ lang }}/sql-reference/aggregate-functions/reference/uniqcombined64#agg_function-uniqcombined64)
  * [uniqHLL12]({{ ch.docs }}{{ lang }}/sql-reference/aggregate-functions/reference/uniqhll12#agg_function-uniqhll12)
  * [uniqExact]({{ ch.docs }}{{ lang }}/sql-reference/aggregate-functions/reference/uniqexact#agg_function-uniqexact)

  По умолчанию используется функция `uniqExact`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#count_distinct_implementation).

* **Data type default nullable**{#setting-data-type-default-nullable} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, использовать ли по умолчанию тип данных `Nullable` в определении столбца без явных модификаторов `NULL` или `NOT NULL`.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#data_type_default_nullable).

* **Date time input format**{#setting-date-time-input-format} {{ tag-con }} {{ tag-sql }}

  Определяет, какой парсер используется для текстового представления даты и времени при обработке входного формата:
  * `best_effort` — расширенный парсер.
  * `basic` — базовый парсер.

  По умолчанию используется базовый парсер (`basic`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-date_time_input_format).

* **Date time output format**{#setting-date-time-output-format} {{ tag-con }} {{ tag-sql }}

  Определяет выходной формат для текстового представления даты и времени:
  * `simple` — простой формат.
  * `iso` — формат ISO.
  * `unix_timestamp` — формат Unix.

  По умолчанию используется простой формат (`simple`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-date_time_output_format).

* **Deduplicate blocks in dependent materialized views**{#setting-deduplicate-blocks-in-dependent-materialized-views} {{ tag-con }} {{ tag-sql }}

  Включает проверку дедупликации для материализованных представлений, которые получают данные из реплицируемых таблиц.

  По умолчанию проверка выключена (`0`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-deduplicate-blocks-in-dependent-materialized-views).

* **Distinct overflow mode**{#setting-distinct-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }} в ситуации, когда количество данных при выполнении запроса `SELECT DISTINCT` [превысило ограничения]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Distributed aggregation memory efficient**{#setting-distributed-aggregation-memory-efficient} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, включать ли режим экономии памяти при распределенной агрегации.

  При распределенной обработке запроса [внешняя агрегация](#setting-max-bytes-before-external-group-by) производится на удаленных серверах. Включите эту настройку, чтобы сократить использование оперативной памяти на сервере-инициаторе запроса.

  По умолчанию режим экономии памяти выключен.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/statements/select/group-by#select-group-by-in-external-memory).

* **Distributed ddl task timeout**{#setting-distributed-ddl-task-timeout} {{ tag-all }}

  Устанавливает время ожидания для ответов на DDL-запросы от всех хостов в кластере. Если DDL-запрос не был выполнен на всех хостах, то ответ будет содержать ошибку времени ожидания, и запрос будет выполнен в асинхронном режиме. Возможные значения:
  * положительное целое число — время ожидания равно этому числу (в секундах).
  * `0` — асинхронный режим.
  * отрицательное число — бесконечное время ожидания.

  По умолчанию используется значение `180`.

* **Distributed product mode**{#setting-distributed-product-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Изменяет поведение распределенных подзапросов, когда запрос содержит произведение распределённых таблиц:
  * `deny` — запрещает использование таких подзапросов.
  * `local` — заменяет базу данных и таблицу в подзапросе на локальные для конечного сервера (шарда), оставив обычный `IN/JOIN`.
  * `global` — заменяет запрос `IN/JOIN` на `GLOBAL IN/GLOBAL JOIN`.
  * `allow` — разрешает использование таких подзапросов.

  По умолчанию значение не выбрано (эквивалентно `deny`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#distributed-product-mode).

* **Do not merge across partitions select final** {#setting-do-not-merge-across-partitions-select-final} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, выполнять ли независимую обработку разделов таблицы для запросов `SELECT` с оператором `FINAL`.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/guides/replacing-merge-tree#exploiting-partitions-with-replacingmergetree).

* **Empty result for aggregation by empty set**{#setting-empty-result-for-aggregation-by-empty-set} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, в каком формате возвращается результат при агрегации данных без ключей (без `GROUP BY`) для пустого множества (например, `SELECT count(*) FROM table WHERE 0`):
  * настройка выключена (по умолчанию) — {{ CH }} вернет результат, состоящий из одной строки со значениями `NULL` для агрегатных функций, в соответствии со стандартом SQL.
  * настройка включена — {{ CH }} вернет пустой результат.

* **Enable HTTP compression**{#setting-enable-http-compression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, будут ли сжаты данные в ответе на HTTP-запрос.

  По умолчанию {{ CH }} хранит данные в сжатом виде. Результат выполнения запроса представлен в несжатом виде. Чтобы {{ CH }} сжимал результат запроса при отправке по HTTP, включите эту настройку и передайте в заголовке `Accept-Encoding` запроса выбранный метод сжатия:
  * `gzip`
  * `br`
  * `deflate`

  По умолчанию сжатие данных в ответе на HTTP-запрос выключено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/interfaces/http).

* **Enable reads from query cache**{#setting-enable-reads-from-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, будут ли результаты запросов `SELECT` извлекаться из кеша запросов.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#enable_reads_from_query_cache).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Enable writes to query cache**{#setting-enable-writes-to-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, будут ли результаты запросов `SELECT` сохраняться в кеш запросов.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#enable_writes_to_query_cache).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Fallback to stale replicas for distributed queries**{#setting-fallback-to-stale-replicas-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Форсирует запрос в устаревшую реплику в случае, если актуальные данные недоступны.

  {{ CH }} выберет наиболее актуальную из устаревших реплик таблицы. Настройка используется при выполнении запроса `SELECT` из распределенных таблиц, указывающих на реплицированные таблицы.

  По умолчанию форсирование запроса включено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-fallback_to_stale_replicas_for_distributed_queries).

  См. также настройку [Max replica delay for distributed queries](#setting-max-replica-delay-for-distributed-queries).

* **Flatten nested**{#setting-flatten-nested} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Задает формат данных [вложенных столбцов]({{ ch.docs }}{{ lang }}/sql-reference/data-types/nested-data-structures/nested).

  Возможные значения:

  * `0` — вложенный столбец преобразуется к массиву кортежей.
  * `1` — вложенный столбец преобразуется к отдельным массивам.

  Значение по умолчанию: `1`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#flatten-nested).

* **Force index by date**{#setting-force-index-by-date} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Запрещает выполнение запросов, если использовать индекс по дате невозможно. Работает с таблицами семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

  По умолчанию настройка выключена (выполнение запросов разрешено).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-force_index_by_date).

* **Force primary key**{#setting-force-primary-key} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Запрещает выполнение запросов, если использовать индекс по первичному ключу невозможно. Работает с таблицами семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

  По умолчанию настройка выключена (выполнение запросов разрешено).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-force_primary_key).

* **Format avro schema registry url**{#setting-format-avro-schema-registry-url} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  URL реестра схем Confluent для формата AvroConfluent.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/formats#format_avro_schema_registry_url).

* **Format regexp**{#setting-format-regexp} {{ tag-con }} {{ tag-sql }}

  Задает регулярное выражение в [формате re2](https://github.com/google/re2/wiki/Syntax), которое будет применяться к каждой строке импортируемых данных. Количество подшаблонов (скобочных групп) в выражении должно быть равно количеству столбцов в таблице, куда помещаются импортируемые данные. В качестве разделителей строк должны использоваться символы переноса строки `\n` или `\r\n`, экранировать перенос строки невозможно. Если строка не подходит регулярному выражению, то она пропускается.

  По умолчанию значение не задано.

* **Format regexp escaping rule**{#setting-format-regexp_escaping_rule} {{ tag-con }} {{ tag-sql }}

  Задает правило экранирования для регулярного выражения, заданного в настройке [Format regexp](#setting-format-regexp):
  * `CSV`
  * `Escaped`
  * `JSON`
  * `Quoted`
  * `Raw`
  * `XML`

  По умолчанию выбрано значение `Raw` (экранирование не используется).

* **Format regexp skip unmatched**{#setting-format-regexp-skip-unmatched} {{ tag-con }} {{ tag-sql }}

  Выводит сообщение об ошибке, если строку в импортируемых данных не получается разбить по шаблону, заданному в настройке [Format regexp](#setting-format-regexp).

  По умолчанию сообщение не выводится (`0`).

* **Group by overflow mode**{#setting-group-by-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }}, когда количество уникальных ключей при агрегации [превысило ограничение]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.
  * `any` — выполнить `GROUP BY` приближенно. Качество такого вычисления зависит от статистических свойств данных.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Group by two level threshold**{#setting-group-by-two-level-threshold} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет количество ключей, при достижении которого начинается двухуровневая агрегация.

  Минимальное значение — `0` (не установлено), по умолчанию — `100000`.

* **Group by two level threshold bytes**{#setting-group-by-two-level-threshold-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет количество байт в агрегате, при достижении которого начинается двухуровневая агрегация.

  Минимальное значение — `0` (не установлено), по умолчанию — `50000000`.

* **Hedged connection timeout ms**{#setting-hedged-connection-timeout-ms} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Время в миллисекундах, за которое нужно установить соединение с репликой для работы с хеджированными запросами. Используется вместе с настройкой [Use hedged requests](#setting-use-hedged-requests).

  Значение по умолчанию — `50`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#hedged_connection_timeout_ms).

* **HTTP connection timeout**{#setting-http-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Задает время ожидания установления HTTP-соединения (в миллисекундах).

  Минимальное значение — `1`, по умолчанию — `1000` (одна секунда).

* **HTTP headers progress interval**{#setting-http-headers-progress-interval} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Задает минимальный интервал (в миллисекундах) между уведомлениями о ходе выполнения запроса с помощью HTTP-заголовка `X-ClickHouse-Progress`.

  Минимальное значение — `1`, по умолчанию — `100`.

* **HTTP max field name size**{#setting-http-max-field-name-size} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Максимальная длина имени поля в HTTP-заголовке.

  Значение по умолчанию — `131072`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#http_max_field_name_size).

* **HTTP max field value size**{#setting-http-max-field-value-size} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Максимальная длина значения поля в HTTP-заголовке.

  Значение по умолчанию — `131072`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#http_max_field_value_size).

* **HTTP receive timeout**{#setting-http-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Задает время ожидания приема данных через HTTP-соединение (в миллисекундах).

  Минимальное значение — `1`, по умолчанию — `1800000` (30 минут).

* **HTTP send timeout**{#setting-http-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Задает время ожидания отправки данных через HTTP-соединение (в миллисекундах).

  Минимальное значение — `1`, по умолчанию — `1800000` (30 минут).

* **Idle connection timeout**{#setting-idle-connection-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Время в миллисекундах, через которое нужно закрыть простаивающие TCP-соединения.

  Если указано значение `0`, соединения закрываются незамедлительно.

  Значение по умолчанию — `360000` (шесть минут).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#idle_connection_timeout).

* **Ignore materialized views with dropped target table**{#setting-ignore-materialized-views-with-dropped-target-table} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, игнорировать ли материализованные представления с удаленной целевой таблицей при переходе к представлениям.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#ignore_materialized_views_with_dropped_target_table).

* **Input format defaults for omitted fields**{#setting-input-format-defaults-for-omitted-fields} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, будут ли пропущенные поля заполнены значениями по умолчанию для типа данных столбца при вставке данных запросом `INSERT`.

  По умолчанию замена включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#session_settings-input_format_defaults_for_omitted_fields).

* **Input format import nested json**{#setting-input-format-import-nested-json} {{ tag-con }}

  Определяет, вставлять ли данные JSON с вложенными объектами.

  По умолчанию такая вставка данных выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-input_format_import_nested_json).

* **Input format null as default**{#setting-input-format-null-as-default} {{ tag-con }} {{ tag-sql }}

  Определяет, заполнять ли ячейки со значением `NULL` значениями по умолчанию, если тип данных столбца не позволяет хранить значение `NULL`.

  По умолчанию настройка включена (ячейки `NULL` заполняются значениями по умолчанию).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-input-format-null-as-default).

* **Input format parallel parsing**{#setting-input-format-parallel-parsing} {{ tag-con }}

  Определяет, разбивать ли входящие данные на части, парсинг каждой из которых осуществляется параллельно с сохранением исходного порядка. Поддерживается только для форматов [TSV]({{ ch.docs }}{{ lang }}/interfaces/formats#tabseparated), [TKSV]({{ ch.docs }}{{ lang }}/interfaces/formats#tskv), [CSV]({{ ch.docs }}{{ lang }}/interfaces/formats#csv) и [JSONEachRow]({{ ch.docs }}{{ lang }}/interfaces/formats#jsoneachrow).

  По умолчанию такая разбивка входящих данных включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#input-format-parallel-parsing).

* **Input format values interpret expressions**{#setting-input-format-values-interpret-expressions} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Включает SQL-парсер, если потоковый парсер не может проанализировать данные. Используйте эту настройку, если вставляете в таблицу значения, содержащие выражения SQL.

  Например, потоковый парсер не распознает значение, содержащее в себе выражение `now()`, в то время как при включенном SQL-парсере выражение будет распознано корректно и в качестве значения будет вставлен результат выполнения SQL-функции `now()` (текущая дата и время).

  Эта настройка используется только для формата [Values]({{ ch.docs }}{{ lang }}/interfaces/formats#data-format-values) при вставке данных.

  По умолчанию парсер SQL включен.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-input_format_values_interpret_expressions).

* **Input format with names use header**{#setting-input-format-with-names-use-header} {{ tag-con }} {{ tag-sql }}

  Определяет, выполнять ли проверку порядка столбцов при вставке данных.

  По умолчанию проверка включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-input-format-with-names-use-header).

* **Insert keeper max retries**{#setting-insert-keeper-max-retries} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальное количество повторных попыток для запросов {{ CK }} (или {{ ZK }}) во время вставки в реплицированные таблицы семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

  Минимальное значение — `0` (повторные попытки отключены), по умолчанию — `20`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#insert_keeper_max_retries).

* **Insert null as default**{#setting-insert-null-as-default} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Включает подстановку [значений по умолчанию]({{ ch.docs }}{{ lang }}/sql-reference/statements/create/table#create-default-values) вместо [NULL]({{ ch.docs }}{{ lang }}/sql-reference/statements/create/table#null-modifiers) в столбцы, которые не позволяют хранить `NULL`.

  Возможные значения:

  * `0` — вставка `NULL` в столбец, не позволяющий хранить `NULL`, приведет к возникновению исключения.
  * `1` — вместо `NULL` вставляется значение столбца по умолчанию.

  Значение по умолчанию — `1`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#insert_null_as_default).

* **Insert quorum**{#setting-insert-quorum} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Управляет кворумной записью в кластере {{ CH }}:
  * Если значение меньше 2, то кворумная запись выключена.
  * Если значение больше или равно 2, то кворумная запись включена.

  Кворумная запись гарантирует, что {{ CH }} без ошибок запишет данные в кворум из Insert quorum реплик за время не больше [Insert quorum timeout](#setting-insert-quorum-timeout), а данные не потеряются при выходе из строя одной или нескольких реплик. Все реплики в кворуме консистентны, т.е. содержат данные всех более ранних запросов `INSERT`.

  При чтении данных, записанных с помощью Insert quorum, можно использовать настройку [Select sequential consistency](#setting-select-sequential-consistency).

  По умолчанию кворумная запись выключена (`0`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-insert_quorum).

* **Insert quorum parallel**{#setting-insert-quorum-parallel} {{ tag-con }} {{ tag-sql }}

  Когда настройка включена, возможно одновременно выполнять несколько запросов `INSERT` с кворумной записью. Когда настройка выключена, будет выполнен только один запрос `INSERT` с кворумной записью к одной и той же таблице.

  По умолчанию настройка включена.

* **Insert quorum timeout**{#setting-insert-quorum-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Задает время ожидания [кворумной записи](#setting-insert-quorum) в миллисекундах. Если время прошло, а запись так и не состоялась, то {{ CH }} прервет выполнение запроса `INSERT` и вернет ошибку.

  Минимальное значение — `1000` (1 секунда), по умолчанию — `60000` (1 минута).

* **Join algorithm**{#setting-join-algorithm} {{ tag-con }} {{ tag-sql }}

  Определяет алгоритм выполнения запроса `JOIN`:
  * `auto` — соединение хешированием (hash join), но если память на сервере заканчивается, {{ CH }} попытается применить соединение merge.
  * `direct` — соединение с помощью поиска по строкам в правой таблице, которые являются ключами в левой таблице. Соединение возможно только при выполнении двух условий:
    * Хранилище правой таблицы поддерживает запросы ключ-значение, например [Dictionary]({{ ch.docs }}{{ lang }}/engines/table-engines/special/dictionary#dictionary) или [EmbeddedRocksDB]({{ ch.docs }}{{ lang }}/engines/table-engines/integrations/embedded-rocksdb).
    * Выполняются запросы `LEFT` и `INNER JOIN`.
  * `hash` — соединение хешированием (hash join).
  * `parallel_hash` — вариант соединения хешированием (hash join), при котором данные разбиваются на сегменты и создается одновременно несколько хеш-таблиц вместо одной.
  * `partial_merge` — вариант соединения слиянием отсортированных списков (sort-merge join), при котором полностью отсортирована только правая часть таблицы.
  * `prefer_partial_merge` — алгоритм `partial_merge`. Применяется, когда это возможно, иначе используется `hash`.
  * `sorting_merge` — соединения слиянием отсортированных списков (sort-merge join).

  По умолчанию для версий {{ CH }} 24.11 и ниже выбрано значение `direct,auto`, а для 24.12 и выше – `direct,parallel_hash,hash`. Доступный алгоритм будет выбран для конкретного запроса в зависимости от типа и движка таблицы.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-join_algorithm).

* **Join overflow mode**{#setting-join-overflow-mode} {{ tag-all }}

  Определяет, какое действие выполняет {{ CH }} при достижении любого из следующих ограничений для `JOIN`:
  * `max_bytes_in_join`
  * `max_rows_in_join`

  Возможные значения:
  * `throw` — {{ CH }} генерирует исключение и прерывает операцию.
  * `break` — {{ CH }} прерывает операцию, но не генерирует исключение.

  По умолчанию используется действие `throw`.

* **Join use nulls**{#setting-join-use-nulls} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Управляет поведением запросов `JOIN`. Если настройка включена, то появившиеся при объединении пустые ячейки заполняются значениями `NULL`. В противном случае ячейки заполняются значениями по умолчанию для данного типа поля.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#join_use_nulls).

* **Joined subquery requires alias**{#setting-joined-subquery-requires-alias} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Требует наличия псевдонимов для подзапросов при выполнении операции `JOIN`.

  При включенной настройке подобный запрос не будет выполнен:

  ```sql
  SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2)
  ```

  При этом запрос с заданным псевдонимом будет выполнен успешно:

  ```sql
  SELECT col1, col2 FROM table1 JOIN (SELECT col3 FROM table2) AS MyQuery
  ```

  По умолчанию настройка включена.

* **Load balancing**{#setting-load-balancing} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Задает алгоритм выбора реплик, который используется при отправке и обработке распределенных запросов. {{ CH }} считает число ошибок на каждой реплике и выбирает реплику с наименьшим числом ошибок. Если у нескольких реплик это число одинаковое, настройка **Load balancing** определяет, в каком порядке сортируются реплики и какая из них выбирается.

  Возможные значения:

  * `random` — запрос отправляется на любую реплику случайным образом (значение по умолчанию).

     Недостаток: не учитывается близость хостов.

  * `nearest_hostname` — запрос отправляется на реплику, имя хоста которой наиболее близко к имени хоста сервера в конфигурационном файле {{ CH }}. Допустим, есть сервер `example-05-05-5` и две реплики `example-05-05-7` и `example-05-06-7`. Будет выбрана реплика `example-05-05-7`, так как ее имя отличается от имени сервера только на один символ.

     Такой подход повышает вероятность, что распределенные запросы будут отправляться на одни и те же реплики, расположенные близко друг к другу. Это устраняет недостаток значения `random`.

  * `hostname_levenshtein_distance` — для выбора реплики используется тот же принцип, что при значении `nearest_hostname`. Но подходящее имя хоста реплики определяется по [расстоянию Левенштейна](https://ru.wikipedia.org/wiki/Расстояние_Левенштейна).

  * `in_order` — запрос отправляется на реплику в порядке, заданном в конфигурационном файле {{ CH }}. В кластере {{ mch-name }} порядок реплик такой, что первое место занимает реплика в той же зоне доступности, где находится хост-инициатор распределенных подзапросов.

     Недостаток: если первая по порядку реплика выходит из строя, ее нагрузка переходит на следующую по очереди реплику. В результате на нее возникает двойная нагрузка.

  * `first_or_random` — запрос отправляется на первую по порядку реплику по аналогии со значением `in_order`. При этом закрывается недостаток `in_order`: если первая в списке реплика выходит из строя, случайным образом выбирается любая другая реплика.

  * `round_robin` — запрос отправляется в соответствии с политикой [Round-Robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)). Относится только к запросам, которые поддерживают эту политику.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-load_balancing).

* **Local filesystem read method**{#setting-local-filesystem-read-method} {{ tag-con }}

  Определяет способ считывания данных из локальной файловой системы.

  Возможные значения:

  * `mmap`
  * `pread`
  * `pread_threadpool`
  * `read`

  Значение по умолчанию — `pread`.

* **Log processors profiles**{#setting-log-processors-profiles} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, будет ли логироваться информация о профилировании на уровне процессоров. Логи записываются в таблицу `system.processors_profile_log`.

  По умолчанию настройка выключена. Изменение настройки приводит к перезапуску серверов {{ CH }} на хостах кластера.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#log_processors_profiles).

* **Log queries probability**{#setting-log-queries-probability} {{ tag-cli }} {{ tag-sql }}

  Определяет, записывать ли в системные таблицы `system.query_log`, `system.query_thread_log` и `system.query_views_log` только запросы, выбранные случайным образом с заданной вероятностью. Случайная выборка помогает снизить нагрузку при большом количестве запросов в секунду.

  Значение настройки — положительное число с плавающей запятой в диапазоне [0..1]. Например, если указано значение `0,5`, то примерно половина запросов регистрируется в системных таблицах. При значении `0` запросы не регистрируются в системных таблицах. При значении `1` (по умолчанию) все запросы регистрируются в системных таблицах.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#log_queries_probability).

* **Log query threads**{#setting-log-query-threads} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Включает логирование потоков, которые выполняют запросы. Логи записываются в таблицу [system.query_thread_log]({{ ch.docs }}{{ lang }}/operations/system-tables/query_thread_log).

  Настройка работает, только если включена настройка [Query thread log enabled](settings-list.md#setting-query-thread-log-enabled). По умолчанию настройка выключена.

  Настройку можно применить только для части пользователей или запросов.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-log-query-threads).

* **Log query views**{#setting-log-query-views} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, будет ли логироваться информация о зависимых представлениях в запросах. Логи записываются в таблицу `system.query_views_log`.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#log_query_views).

* **Low cardinality allow in native format**{#setting-low-cardinality-allow-in-native-format} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, использовать ли [тип LowCardinality]({{ ch.docs }}{{ lang }}/sql-reference/data-types/lowcardinality) в native-формате:
  * Настройка включена (по умолчанию) — использовать.
  * Настройка выключена — не использовать:
    * Для запроса `SELECT` конвертировать столбцы типа LowCardinality в обычные.
    * Для запроса `INSERT` конвертировать обычные столбцы в тип LowCardinality.

  Столбцы этого типа позволяют эффективнее хранить данные в виде хеш-таблиц. Если возможно, {{ CH }} использует столбцы типа LowCardinality.

  Некоторые сторонние клиенты для {{ CH }} не поддерживают столбцы типа LowCardinality и не могут правильно интерпретировать результат запроса, в котором присутствуют столбцы такого типа. Выключение настройки позволяет таким клиентам обрабатывать результаты запросов корректно.

  Официальный клиент {{ CH }} поддерживает работу со столбцами типа LowCardinality.

  По умолчанию настройка включена.

* **Max ast depth**{#setting-max-ast-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальная глубина вложенности синтаксического дерева.

  Для сложных запросов синтаксическое дерево может оказаться слишком глубоким. Настройка позволяет запретить выполнение излишне сложных или неоптимизированных запросов для больших таблиц.

  Например, запрос `SELECT *` в большинстве случаев породит более сложное и глубокое синтаксическое дерево, чем запрос `SELECT ... WHERE ...` с ограничениями и условиями.

  По умолчанию выбрано значение `1000`. Слишком маленькое значение может привести к невозможности выполнения большинства запросов.

* **Max ast elements**{#setting-max-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество элементов синтаксического дерева запроса (количество узлов дерева).

  Для сложных запросов синтаксическое дерево может содержать слишком большое количество элементов. Настройка позволяет запретить выполнение излишне сложных или неоптимизированных запросов для больших таблиц.

  По умолчанию выбрано значение `50000`. Слишком маленькое значение может привести к невозможности выполнения большинства запросов.

* **Max block size**{#setting-max-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Данные в {{ CH }} обрабатываются по блокам (наборам кусочков столбцов). Настройка задает рекомендованный размер блока (количество строк), который будет загружаться при обработке таблиц. Обработка каждого блока влечет за собой накладные расходы, поэтому слишком маленькое значение настройки может замедлить обработку.

  Минимальное значение — `1`, по умолчанию — `65536`.

* **Max bytes before external group by**{#setting-max-bytes-before-external-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Данные, накопленные при выполнении операции агрегации `GROUP BY`, некоторое время хранятся в оперативной памяти. Настройка задает порог (в байтах), после которого эти данные сбрасываются на диск для экономии оперативной памяти.

  Настройка полезна, если запросы завершаются с ошибкой из-за того, что для выполнения операции агрегации большого объема данных не хватает оперативной памяти. Задайте ненулевое значение этой настройки, чтобы {{ CH }} сбрасывал данные на диск и успешно выполнял агрегацию в этом случае.

  Минимальное значение — `0` (`GROUP BY` во внешней памяти отключен), по умолчанию — `0`.

  При использовании агрегации во внешней памяти рекомендуется задать значение этой настройки в два раза меньше значения настройки [Max memory usage](#setting-max-memory-usage) (по умолчанию максимальное использование памяти ограничено десятью гигабайтами).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/statements/select/group-by#select-group-by-in-external-memory).

  См. также настройку [Distributed aggregation memory efficient](#setting-distributed-aggregation-memory-efficient).

* **Max bytes before external sort**{#setting-max-bytes-before-external-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Объем оперативной памяти, который может быть использован для `ORDER BY`. При превышении этого значения используется внешняя сортировка.

  Минимальное значение — `0` (нет ограничения), по умолчанию — `0`.

  Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#max_bytes_before_external_sort).

* **Max bytes in distinct**{#setting-max-bytes-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный объем несжатых данных (в байтах), занимаемый хеш-таблицей при использовании `DISTINCT`.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max bytes in join**{#setting-max-bytes-in-join} {{ tag-all }}

  Максимальный объем несжатых данных (в байтах), занимаемый хеш-таблицей при использовании `JOIN`.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max bytes in set**{#setting-max-bytes-in-set} {{ tag-all }}

  Максимальный объем несжатых данных (в байтах), занимаемый множеством в секции `IN`, которое создается из подзапроса.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max bytes ratio before external group by**{#setting-max-bytes-ratio-before-external-group-by} {{ tag-con }} {{ tag-sql }}

  Доля доступной памяти запроса, которая может быть использована для `GROUP BY`. При превышении этого значения используется внешняя память.

  Возможные значения от `0` (нет ограничения) до `1`.

  Значение по умолчанию зависит от версии {{ CH }}:

  * для версий ниже `25.1` — `0`;
  * для версий `25.1` и выше — `0,5`.

  Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#max_bytes_ratio_before_external_group_by).

* **Max bytes ratio before external sort**{#setting-max-bytes-ratio-before-external-sort} {{ tag-con }} {{ tag-sql }}
  
  Доля доступной памяти запроса, которая может быть использована для `ORDER BY`.

  Эта настройка, а также лимит доступной памяти в байтах [Max bytes before external sort](#setting-max-bytes-before-external-sort), ограничивают использование сортировки в памяти. Если превышена доля доступной памяти запроса и размер блока сортировки больше **Max bytes before external sort**, используется внешняя сортировка.

  Возможные значения от `0` (нет ограничения) до `1`.

  Значение по умолчанию зависит от версии {{ CH }}:

  * для версий ниже `25.1` — `0`;
  * для версий `25.1` и выше — `0,5`.

  Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#max_bytes_ratio_before_external_sort).

* **Max bytes to read**{#setting-max-bytes-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный объем несжатых данных (в байтах), который можно прочитать из таблицы при выполнении запроса.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max bytes to sort**{#setting-max-bytes-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный объем несжатых данных (в байтах), который можно прочитать из таблицы до сортировки. Настройка позволяет ограничить потребление оперативной памяти при сортировке.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max bytes to transfer**{#setting-max-bytes-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный объем несжатых данных (в байтах), который можно передать на удаленный сервер или сохранить во временную таблицу при использовании `GLOBAL IN`.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max columns to read**{#setting-max-columns-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество столбцов, которое можно прочитать из таблицы в одном запросе. Запросы, требующие чтения большего количества столбцов, завершатся с ошибкой.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max concurrent queries for user**{#setting-max-concurrent-queries-for-user} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество одновременно обрабатываемых пользовательских запросов к таблице семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree).

  Минимальное значение `0` (нет ограничения), по умолчанию — `450`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings#max-concurrent-queries-for-user).

* **Max execution time**{#setting-max-execution-time} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное время выполнения запроса (в миллисекундах).

  Если выполнение запроса находится на одной из стадий сортировки, а также слияния и финализации агрегатных функций, то лимит на максимальное время выполнения запроса не будет проверяться и может быть превышен.

  Минимальное значение `0` (нет ограничения), по умолчанию — `600000`.

* **Max expanded ast elements**{#setting-max-expanded-ast-elements} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество элементов синтаксического дерева запроса (количество узлов дерева) после раскрытия псевдонимов и звездочки.

  Для сложных запросов синтаксическое дерево может содержать слишком большое количество элементов. Настройка позволяет запретить выполнение излишне сложных или неоптимизированных запросов для больших таблиц.

  По умолчанию выбрано значение `500000`. Слишком маленькое значение может привести к невозможности выполнения большинства запросов.

* **Max final threads**{#setting-max-final-threads} {{ tag-con }}

  Максимальное количество параллельных потоков для запроса `SELECT` с модификатором [FINAL]({{ ch.docs }}{{ lang }}/sql-reference/statements/select/from#select-from-final).

  По умолчанию выбрано значение, равное значению настройки [Max threads](#setting-max-threads).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#max-final-threads).

* **Max HTTP get redirects**{#setting-max-http-get-redirects} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Задает максимальное количество переходов по редиректам в таблицах на [движке URL]({{ ch.docs }}{{ lang }}/engines/table-engines/special/url) при выполнении HTTP-запросов методом GET.

  Если установлено значение `0`, переходы запрещены.

  Значение по умолчанию — `0`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#setting-max_http_get_redirects).

* **Max insert block size**{#setting-max-insert-block-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Формировать блоки указанного размера (в байтах) при вставке в таблицу. Настройка действует только когда сервер сам формирует такие блоки.

  По умолчанию выбрано значение `1048576`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-max_insert_block_size).

* **Max insert threads**{#setting-max-insert-threads} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество потоков для выполнения запроса `INSERT SELECT`.

  Если указано значение больше `1`, потоки запускаются параллельно. Значение по умолчанию — `0`.

  Запросы `INSERT SELECT` выполняются параллельно, только если настроен параллельный запуск запросов `SELECT` с помощью настройки [Max threads](#setting-max-threads).

  Чем больше значение настройки **Max insert threads**, тем выше потребление оперативной памяти кластера.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-max-insert-threads).

* **Max memory usage**{#setting-max-memory-usage} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный объем оперативной памяти (в байтах) для выполнения запроса на одном сервере. Настройка не учитывает объем свободной памяти или общий объем памяти на машине. Ограничение действует на один запрос в пределах одного сервера.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения). Максимальное значение ограничено настройкой Max server memory usage, значение которой нельзя изменить напрямую. Подробнее см. в разделе [{#T}](memory-management.md). Если задано значение больше, чем Max server memory usage, то применяется значение Max server memory usage.

  Если вы используете настройки [Max bytes before external `GROUP BY`](#setting-max-bytes-before-external-group-by) или [Max bytes before external sort](#setting-max-bytes-before-external-sort), рекомендуется задать им значения в два раза меньше значения Max memory usage.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#settings_max_memory_usage).

* **Max memory usage for user**{#setting-max-memory-usage-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный объем оперативной памяти (в байтах) для выполнения запросов пользователя на одном сервере. Настройка не учитывает объем свободной памяти или общий объем памяти на машине.

  Ограничение действует на все запросы пользователя, которые выполняются одновременно в пределах одного сервера, в отличие от [Max memory usage](#setting-max-memory-usage).

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max network bandwidth**{#setting-max-network-bandwidth} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальная скорость обмена данными по сети при выполнении одного запроса (в байтах в секунду).

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max network bandwidth for user**{#setting-max-network-bandwidth-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальная скорость обмена данными по сети (в байтах в секунду). Эта настройка влияет на все одновременно выполняющиеся запросы пользователя, в отличие от [Max network bandwidth](#setting-max-network-bandwidth).

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max parser depth**{#setting-max-parser-depth} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальная глубина рекурсии в парсере рекурсивного спуска. Позволяет контролировать размер стека.

  Минимальное значение — `0` (глубина рекурсии не ограничена), по умолчанию — `1000`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#max_parser_depth).

* **Max partitions per insert block**{#setting-partitions-per-insert-block} {{ tag-con }} {{ tag-sql }}

  Ограничивает максимальное количество партиций в одном вставленном блоке.

  Минимальное значение — `0` (количество разделов не ограничено), по умолчанию — `100`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#max-partitions-per-insert-block).

* **Max query size**{#setting-max-query-size} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Ограничивает размер (в байтах) наибольшей части запроса, которая может быть передана в оперативную память для разбора с помощью SQL-парсера.

  Минимальное значение — `1`, по умолчанию — `262144`.

* **Max read buffer size**{#setting-max-read-buffer-size} {{ tag-con }}

  Максимальный размер буфера (в байтах) для чтения из файловой системы.

  Значение по умолчанию — `1048576` (1 МБ).

* **Max replica delay for distributed queries**{#setting-max-replica-delay-for-distributed-queries} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное отставание реплики (в миллисекундах). Если задержка реплики больше значения настройки, реплика перестает использоваться.

  Минимальное значение — `1000` (1 секунда), по умолчанию — `300000` (5 минут).

  См. также описание настройки [Fallback to stale replicas for distributed queries](#setting-fallback-to-stale-replicas-for-distributed-queries).

* **Max result bytes**{#setting-max-result-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный размер результата запроса несжатых данных (в байтах). Ограничение распространяется также на подзапросы и на те части распределенных запросов, которые выполняются на удаленных серверах.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max result rows**{#setting-max-result-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество строк результата. Ограничение распространяется также на подзапросы и на те части распределенных запросов, которые выполняются на удаленных серверах.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max rows in distinct**{#setting-max-rows-in-distinct} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество различных строк при использовании `DISTINCT`.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max rows in join**{#setting-max-rows-in-join} {{ tag-all }}

  Максимальное количество строк в хеш-таблице, которая используется при соединении таблиц. Параметр применяется к операциям `SELECT… JOIN` и к движку таблиц `Join`.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#settings-max_rows_in_join).

* **Max rows in set**{#setting-max-rows-in-set} {{ tag-all }}

  Максимальное количество строк для множества в секции `IN`, которое создается из подзапроса.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max rows to group by**{#setting-max-rows-to-group-by} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество уникальных ключей, получаемых в процессе агрегации. Используйте настройку, чтобы ограничить потребление оперативной памяти при агрегации.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max rows to read**{#setting-max-rows-to-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество строк, которое можно прочитать из таблицы при выполнении запроса.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max rows to sort**{#setting-max-rows-to-sort} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество строк для сортировки. Используйте эту настройку, чтобы ограничить потребление оперативной памяти при сортировке.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max rows to transfer**{#setting-max-rows-to-transfer} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество строк, которое можно передать на удаленный сервер или сохранить во временную таблицу при использовании `GLOBAL IN`.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max temporary columns**{#setting-max-temporary-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество временных столбцов, которое единовременно хранится в оперативной памяти при выполнении запроса (с учетом постоянных столбцов).

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max temporary data on disk size for query**{#setting-max-temporary-data-on-disk-size-for-query} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальный объем данных (в байтах), потребляемых временными файлами на диске, для всех одновременно выполняемых запросов.

  Минимальное значение — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_query).

* **Max temporary data on disk size for user**{#setting-max-temporary-data-on-disk-size-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Максимальный объем данных (в байтах), потребляемых временными файлами на диске, для всех одновременно выполняемых пользовательских запросов.

  Минимальное значение — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#settings_max_temporary_data_on_disk_size_for_user).

* **Max temporary non const columns**{#setting-max-temporary-non-const-columns} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество временных столбцов, которое единовременно хранится в оперативной памяти при выполнении запроса (без учета постоянных столбцов).

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

* **Max threads**{#setting-max-threads} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальное количество потоков обработки запроса, без учета потоков для чтения данных с удаленных серверов. Настройка относится к потокам, которые используются для параллельного выполнения стадий конвейера запросов.

  Минимальное значение и значение по умолчанию — `0` (вычислять значение автоматически как количество процессорных ядер без учета Hyper-Threading).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-max_threads).

* **Memory overcommit ratio denominator**{#setting-memory-overcommit-ratio-denominator} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Лимит для [перегрузки памяти]({{ ch.docs }}{{ lang }}/operations/settings/memory-overcommit) (в ГБ), когда достигнут жесткий лимит на уровне пользователя.

  Минимальное значение — `0` (нет лимита). Значение по умолчанию — `1`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#memory_overcommit_ratio_denominator).

* **Memory overcommit ratio denominator for user**{#setting-memory-overcommit-ratio-denominator-for-user} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Лимит для [перегрузки памяти]({{ ch.docs }}{{ lang }}/operations/settings/memory-overcommit) (в ГБ), когда достигнут жесткий лимит на глобальном уровне.

  Минимальное значение — `0` (нет лимита). Значение по умолчанию — `1`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#memory_overcommit_ratio_denominator_for_user).

* **Memory profiler sample probability**{#setting-memory-profiler-sample-probability} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Система будет с указанной вероятностью сохранять информацию о том или ином выделении и освобождении оперативной памяти в файл лога `system.trace_log` с типом трассировки `MemorySample`. Вероятность сохранения не зависит от размера выделенной/освобожденной памяти.

  Возможные значения — от `0` до `1`. По умолчанию — `0`.

* **Memory profiler step**{#setting-memory-profiler-step} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Шаг профилировщика памяти (в байтах). Если на следующем шаге выполнения запроса потребление памяти возрастает на число байт, большее указанного в данной настройке, то профилировщик сохраняет выделенный стектрейс. Значения менее нескольких мегабайт замедляют обработку запросов.

  По умолчанию — `4194304` (4 МБ). Если задан `0` — профилировщик памяти отключен.

* **Memory usage overcommit max wait microseconds**{#setting-memory-usage-overcommit-max-wait-microseconds} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Время ожидания (в микросекундах) для освобождения памяти при [перегрузке памяти]({{ ch.docs }}{{ lang }}/operations/settings/memory-overcommit) на уровне пользователя.

  По умолчанию выбрано значение `5000000` (5 секунд).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#memory_usage_overcommit_max_wait_microseconds).

* **Merge tree max bytes to use cache**{#setting-merge-tree-max-bytes-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный размер запроса (в байтах), при котором используется кеш несжатых данных. Кеш не используется для запросов, превышающих указанный размер.

  Настройка используется совместно с [Use uncompressed cache](#setting-use-uncompressed-cache).

  По умолчанию выбрано значение `192x10x1024x1024`.

* **Merge tree max rows to use cache**{#setting-merge-tree-max-rows-to-use-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Максимальный размер запроса (в строках), при котором используется кеш несжатых данных. Кеш не используется для запросов, превышающих указанный размер.

  Настройка используется совместно с [Use uncompressed cache](#setting-use-uncompressed-cache).

  По умолчанию выбрано значение `128x8192`.

* **Merge tree min bytes for concurrent read**{#setting-merge-tree-min-bytes-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Если количество прочитанных из файла байт превышает значение настройки, то {{ CH }} пытается выполнить одновременное чтение из этого файла в несколько потоков.

  Минимальное значение — `1`, по умолчанию — `24x10x1024x1024`.

* **Merge tree min rows for concurrent read**{#setting-merge-tree-min-rows-for-concurrent-read} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Если количество прочитанных из файла строк превышает значение настройки, то {{ CH }} пытается выполнить одновременное чтение из этого файла в несколько потоков.

  Минимальное значение — `1`, по умолчанию — `20x8192`.

* **Min bytes to use direct io**{#setting-merge-tree-min-bytes-to-use-direct-io} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Объем данных (в байтах), необходимый для прямого чтения (Direct I/O) с диска.

  По умолчанию {{ CH }} читает данные не напрямую с диска, а полагается на файловую систему и ее кеш. Такое чтение эффективно при небольших объемах данных. Если данные читаются в больших объемах, эффективнее читать их с диска напрямую, минуя кеш файловой системы.

  Если общий объем всех хранимых данных для чтения превышает заданное значение настройки, тогда {{ CH }} читает данные с диска напрямую.

  Минимальное значение и значение по умолчанию — `0` (прямое чтение отключено).

* **Min count to compile**{#setting-min-count-to-compile} {{ tag-cli }} {{ tag-api }} {{ tag-sql }} 

  Настройка устарела.

  Определяет, после какого количества структурно идентичных запросов начать [компиляцию](#setting-compile).

  Для значения `0` компиляция выполняется синхронно: запрос ожидает окончания компиляции, затем продолжает выполняться. Рекомендуется использовать это значение только в целях тестирования.

  Для всех других значений компиляция выполняется асинхронно, в отдельном потоке: когда результат будет готов, он сразу же будет использован, в том числе уже выполняющимися в данный момент запросами.

  Минимальное значение — `0`, по умолчанию — `3`.

* **Min count to compile expression**{#setting-min-count-to-compile-expression} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, после какого количества идентичных выражений начать [компиляцию выражений](#setting-compile-expressions).

  Для значения `0` компиляция выполняется синхронно: выражение ожидает окончания компиляции, затем продолжается выполнение запроса. Рекомендуется использовать это значение только в целях тестирования.

  Для всех других значений компиляция выполняется асинхронно, в отдельном потоке: когда результат будет готов, он сразу же будет использован, в том числе уже выполняющимися в данный момент запросами.

  Минимальное значение — `0`, по умолчанию — `3`.

* **Min execution speed**{#setting-min-execution-speed} {{ tag-all }}

  Минимальная скорость выполнения запроса (в строках в секунду).

  При выполнении запросов {{ CH }} обрабатывает данные блоками (batches). Если блок обрабатывается дольше времени, заданного настройкой [timeout_before_checking_execution_speed]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#timeout-before-checking-execution-speed), проверяется скорость выполнения запроса. Если эта скорость ниже указанной в значении настройки, генерируется исключение.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#min-execution-speed).

* **Min execution speed bytes**{#setting-min-execution-speed-bytes} {{ tag-all }}

  Минимальная скорость выполнения запроса (в байтах в секунду).

  При выполнении запросов {{ CH }} обрабатывает данные блоками (batches). Если блок обрабатывается дольше времени, заданного настройкой [timeout_before_checking_execution_speed]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#timeout-before-checking-execution-speed), проверяется скорость выполнения запроса. Если эта скорость ниже указанной в значении настройки, генерируется исключение.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#min-execution-speed-bytes).

* **Min insert block size bytes**{#setting-min-insert-block-size-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Минимальный размер блока (в байтах), который может быть вставлен в таблицу запросом `INSERT`. Блоки меньшего размера [склеиваются вместе]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#mergetree-data-storage).

  Минимальное значение — `0` (склейка блоков выключена), по умолчанию — `268435456` (256 МБ).

* **Min insert block size rows**{#setting-min-insert-block-size-rows} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Минимальный размер блока (в строках), который может быть вставлен в таблицу запросом `INSERT`. Блоки меньшего размера [склеиваются вместе]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree#mergetree-data-storage).

  Минимальное значение — `0` (склейка блоков выключена), по умолчанию — `1048576`.

* **Output format json quote denormals**{#setting-output-format-json-quote-denormals} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, выводить ли специальные значения для чисел с плавающей запятой (`+nan`, `-nan`, `+inf` и `-inf`) при использовании формата JSON для результата.

  По умолчанию выбрано значение `false` — специальные значения не выводятся.

* **Output format json quote_64bit integers**{#setting-output-format-json-quote-64bit-integers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет формат чисел в JSON-выводе. Если настройка включена, то при выводе в JSON 64-битные числа (`UInt64` и `Int64`) выводятся в кавычках (из соображений совместимости с большинством реализаций JavaScript), иначе — без кавычек. 

  По умолчанию вывод 64-битных целых чисел в кавычках выключен.

* **Prefer localhost replica**{#setting-prefer-localhost-replica} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Включает отправку распределенных запросов на реплику `localhost`.

  Если настройка выключена, {{ mch-name }} распределяет запросы на основе настройки [Load balancing](#setting-load-balancing).

  По умолчанию настройка включена.

  {% note warning %}

  Если кластер содержит один шард и несколько реплик, отключение этой настройки может повредить работоспособности кластера.

  {% endnote %}

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-prefer-localhost-replica).

* **Priority**{#setting-priority} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет приоритет запроса:
  * `0` — приоритет не используется.
  * `1` — наивысший приоритет.
  * далее — чем выше число, тем ниже приоритет.

  Настройка выставляется отдельно для каждого запроса.

  Если в {{ CH }} поступает запрос с более высоким приоритетом, выполнение менее приоритетных запросов приостанавливается до завершения поступившего запроса.

  Минимальное значение и значение по умолчанию — `0`.

* **Query cache max entries**{#setting-query-cache-max-entries} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Максимальное количество результатов запроса, которое текущий пользователь может сохранить в кеше запросов.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_max_entries).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache max size in bytes**{#setting-query-cache-max-size-in-bytes} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Максимальный размер кеша (в байтах) для пользователя.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_max_size_in_bytes).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache min query duration**{#setting-query-cache-min-query-duration} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Минимальная продолжительность (в миллисекундах) запроса `SELECT`, при которой результаты будут записываться в кеш запросов.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_min_query_duration).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache min query runs**{#setting-query-cache-min-query-runs} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Минимальное количество выполненных запросов `SELECT`, при котором результаты будут записываться в кеш запросов.

  Минимальное значение и значение по умолчанию — `0` (нет ограничения).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_min_query_runs).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache nondeterministic function handling**{#setting-query-cache-nondeterministic-function-handling} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, как кеш запросов будет обрабатывать запросы `SELECT` с недетерминированными функциями, такими как `rand()` или `now()`.

  Возможные значения:

  * `throw` — сгенерировать исключение и не кешировать результат запроса.
  * `save` — кешировать результат запроса.
  * `ignore` — не генерировать исключение и не кешировать результат запроса.

  По умолчанию значение не выбрано (эквивалентно `throw`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_nondeterministic_function_handling).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache share between users**{#setting-query-cache-share-between-users} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, могут ли результаты запросов `SELECT`, сохраненные в кеше запросов, быть прочитаны другими пользователями. Не рекомендуется включать этот параметр по соображениям безопасности.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_share_between_users).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache tag**{#setting-query-cache-tag} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Строка, которая служит меткой для записей кеша запросов. Настройка позволяет кешировать несколько результатов одного и того же запроса. Запросы с разными тегами считаются разными.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_tag).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Query cache ttl**{#setting-query-cache-ttl} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Время (в секундах), по истечении которого записи в кеше запросов устаревают.

  Значение по умолчанию — `60`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#query_cache_ttl).

  См. также настройку [Use query cache](#setting-use-query-cache).

* **Quota mode**{#setting-quota-mode} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Режим учета потребляемых ресурсов при включенных [квотах]({{ link-console-quotas }}):
  * `default` — ключи не используются.
  * `keyed` — в параметре пользовательского запроса передается ключ `quota_key`, квота считается по отдельности для каждого значения ключа.
  * `keyed_by_ip` — аналогичен предыдущему, но в качестве ключа выступает IP-адрес пользователя. Рекомендуется использовать этот режим только в тех случаях, если у пользователя нет способов быстро сменить IP-адрес, например, для обхода ограничений квоты. Это относится как к IPv4-, так и IPv6-адресам.

  По умолчанию значение не выбрано (эквивалентно `default`).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/quotas).

* **Read overflow mode**{#setting-read-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }}, когда количество прочитанных данных [превысило одно из ограничений]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Readonly**{#setting-readonly} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Разрешения для запросов на изменение параметров, чтение и запись данных:
  * `0` (по умолчанию) — разрешено выполнять все типы запросов.
  * `1` — разрешено выполнять только запросы на чтение данных.
  * `2` — разрешено выполнять запросы на чтение данных и изменение настроек.

  Настройка не влияет на возможность выполнения DDL-запросов. Чтобы разрешить или запретить выполнение DDL-запросов, используйте настройку [Allow DDL](#setting-allow-ddl). 

  См. также: [пример создания пользователя с правами «только чтение»](../operations/cluster-users.md#example-create-readonly-user).

* **Receive timeout**{#setting-receive-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Время ожидания приема данных (в миллисекундах).

  По умолчанию выбрано значение `300000` (5 минут).

* **Remote filesystem read method**{#setting-remote-filesystem-read-method} {{ tag-con }} {{ tag-cli }} {{ tag-api }}

  Определяет способ считывания данных из удаленной файловой системы.

  Возможные значения:

  * `read`
  * `threadpool`

  Значение по умолчанию — `threadpool`.

* **Replication alter partitions sync**{#setting-replication-alter-partitions-sync} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Задает условия ожидания завершения асинхронных действий на репликах для запросов `ALTER ... ATTACH DETACH DROP`:
  * `0` — не ждать.
  * `1` — ждать выполнения только у себя (значение по умолчанию).
  * `2` — ждать всех.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/statements/alter#synchronicity-of-alter-queries).

* **Result overflow mode**{#setting-result-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }}, когда объем результата [превысил одно из ограничений]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Select sequential consistency**{#setting-select-sequential-consistency} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, нужно ли обеспечивать последовательную консистентность для запросов `SELECT`.

  По умолчанию последовательная консистентность не обеспечивается.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#settings-select_sequential_consistency).

* **Send progress in HTTP headers**{#setting-send-progress-in-http-headers} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Разрешает отправку уведомлений о ходе выполнения запроса с использованием заголовков `X-ClickHouse-Progress`.

  По умолчанию отсылка уведомлений выключена.

* **Send timeout**{#setting-send-timeout} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Время ожидания отправки данных (в миллисекундах).

  По умолчанию выбрано значение `300000` (5 минут).

* **Set overflow mode**{#setting-set-overflow-mode} {{ tag-all }}

  Определяет поведение {{ CH }}, когда количество данных [превысило одно из ограничений на сложность запроса]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Show Data Lake catalogs in system tables**{#setting-show-data-lake-catalogs-in-system_tables} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}
  
  Включает отображение каталогов [Data Lake](../../glossary/datalake.md) в системных таблицах.

  Значение по умолчанию зависит от версии {{ CH }}:

  * для версий ниже `25.10` — `true`;
  * для версий `25.10` и выше — `false`.

  Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#show_data_lake_catalogs_in_system_tables).

* **Skip unavailable shards**{#setting-skip-unavailable-shards} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Разрешает тихий пропуск недоступных шардов. Шард считается недоступным, если все его реплики недоступны.

  По умолчанию тихий пропуск недоступных шардов выключен.

* **Sort overflow mode**{#setting-sort-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }}, когда количество полученных перед сортировкой строк [превысило одно из ограничений]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Timeout before checking execution speed**{#setting-timeout-before-checking-execution-speed} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Время ожидания (в миллисекундах) между проверками скорости выполнения запроса. Проверяется, что скорость выполнения не ниже указанной в параметре [**Min execution speed**](#setting-min-execution-speed).

  Значение по умолчанию — `60000` (1 минута).

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#timeout-before-checking-execution-speed).

* **Timeout overflow mode**{#setting-timeout-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }}, когда запрос выполняется дольше [max_execution_time](#setting-max-execution-time):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Transfer overflow mode**{#setting-transfer-overflow-mode} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет поведение {{ CH }}, когда количество данных для передачи на другой сервер [превысило одно из ограничений]({{ ch.docs }}{{ lang }}/operations/settings/query-complexity#restrictions-on-query-complexity):
  * `throw` — прервать выполнение, вернуть ошибку.
  * `break` — вернуть неполный результат.

  По умолчанию значение не выбрано (эквивалентно `throw`).

* **Transform null in**{#setting-transform-null-in} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  При включенной опции сравнение `NULL = NULL` вернет `true` в операторе `IN`.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#transform_null_in).

* **Use hedged requests**{#setting-use-hedged-requests} {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }} {{ tag-sql }}

  Включает хеджированные запросы.

  Позволяет устанавливать множество соединений с различными репликами для отправки запросов. Новое соединение устанавливается, если текущие соединения с репликами не были установлены в течение времени [Hedged connection timeout ms](#setting-hedged-connection-timeout-ms).

  Первое соединение, которое отправило не пустой пакет о прогрессе выполнения запроса, используется для отправки этого запроса. Остальные соединения отменяются.

  По умолчанию настройка включена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#use_hedged_requests).

* **Use hive partitioning**{#setting-use-hive-partitioning} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Если настройка включена, {{ CH }} распознает партиционирование в стиле Hive в пути вида `/name=value/` для табличных движков `File/S3/URL/HDFS/AzureBlobStorage`. Это позволяет использовать столбцы партиций в качестве виртуальных столбцов в запросе. Виртуальные столбцы называются так же, как и столбцы партиций, но с префиксом `_`.

  Значение по умолчанию зависит от версии {{ CH }}:

  * для версий ниже `25.1` — `false`;
  * для версий `25.1` и выше — `true`.

  Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#use_hive_partitioning).

* **Use query cache**{#setting-use-query-cache} {{ tag-con }} {{ tag-cli }} {{ tag-sql }}

  Определяет, могут ли запросы `SELECT` использовать кеш запросов.

  По умолчанию настройка выключена.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#use_query_cache).

  См. также настройки [Enable reads from query cache](#setting-enable-reads-from-query-cache) и [Enable writes to query cache](#setting-enable-writes-to-query-cache).

* **Use uncompressed cache**{#setting-use-uncompressed-cache} {{ tag-con }} {{ tag-cli }} {{ tag-api }} {{ tag-sql }}

  Определяет, использовать ли кеш разжатых блоков. Использование этого кеша может существенно сократить задержку и увеличить пропускную способность при работе с большим количеством коротких запросов (только для таблиц семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree)). Включите эту настройку для пользователей, от которых идут частые короткие запросы.

  По умолчанию кеш не используется.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#setting-use_uncompressed_cache).

  См. также настройки [Merge tree max bytes to use cache](#setting-merge-tree-max-bytes-to-use-cache) и [Merge tree max rows to use cache](#setting-merge-tree-max-rows-to-use-cache).

* **Wait for async insert**{#setting-wait-for-async-insert} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Включает ожидание обработки [асинхронных вставок](#setting-async-insert).

  Возможные значения:

  * `0` — сервер возвращает `OK` даже если вставка данных еще не завершена.
  * `1` — сервер возвращает `OK` только после завершения вставки данных.

  Значение по умолчанию — `1`.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#wait-for-async-insert).

* **Wait for async insert timeout**{#setting-wait-for-async-insert-timeout} {{ tag-con }} {{ tag-api }} {{ tag-sql }}

  Время (в секундах) ожидания обработки асинхронной вставки.

  Значение по умолчанию — `120`. Если указан `0`, ожидание отключено.

  Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/settings/settings#wait-for-async-insert-timeout).

### Пользовательские настройки {#custom-settings}

[Пользовательские настройки]({{ ch.docs }}{{ lang }}/operations/settings#custom_settings) можно переопределять как переменные в [профиле настроек]({{ ch.docs }}{{ lang }}/operations/access-rights#settings-profiles-management), сессии или запросе. Работа с профилями настроек доступна, если для кластера включено [управление пользователями через SQL](../operations/cluster-users.md#sql-user-management).

Название пользовательской настройки в {{ mch-name }} должно начинаться с предопределенного префикса `custom_`. Префикс фиксированный — пользователь не может его менять.

## Настройки квот {#quota-settings}

Квота позволяет ограничить потребление ресурсов {{ CH }} в течение заданного интервала времени. Настройки квоты задаются для отдельно взятого пользователя.

Если пользователь превысил одно из ограничений квоты, то он не сможет выполнять новые запросы до того, как истечет интервал.
{{ CH }} выведет сообщение о превышении квоты и укажет время начала нового интервала, когда запрет на выполнение запросов будет снят, а счетчики ограничений — сброшены.

{{ CH }} также использует квоты для учета потребления ресурсов.
Для каждого пользователя есть квота по умолчанию, которая учитывает потребление всех ресурсов за каждый час, но не накладывает никаких ограничений.
Сведения об уровне потребления ресурсов записываются в лог сервера {{ CH }}.

Подробнее см. в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/quotas).

Доступны следующие настройки квот:

* **Errors**{#setting-quota-errors} {{ tag-all }}

    Ограничение на суммарное количество запросов, которые завершились с ошибкой.

    Минимальное значение — `0` (нет ограничений).

* **Execution time**{#setting-quota-execution-time} {{ tag-all }}

    Ограничение на суммарное время выполнения запросов в миллисекундах.

    Минимальное значение — `0` (нет ограничений).

* **Interval duration**{#setting-quota-interval-duration} {{ tag-all }}

    Интервал для квоты (в миллисекундах). Значение должно быть кратно 1000.

    Минимальное значение — `1000` (одна секунда).

* **Queries**{#setting-quota-queries} {{ tag-all }}

    Ограничение на суммарное количество запросов.

    Минимальное значение — `0` (нет ограничений).

* **Read rows**{#setting-quota-read-rows} {{ tag-all }}

    Ограничение на суммарное число исходных строк, считанных из таблиц для выполнения запросов (включая строки, считанные на удаленных серверах).

    Минимальное значение — `0` (нет ограничений).

* **Result rows**{#setting-quota-result-rows} {{ tag-all }}

    Ограничение на суммарное число строк в результатах запроса.

    Минимальное значение — `0` (нет ограничений).

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._