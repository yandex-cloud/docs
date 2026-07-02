- **Catchup timeout**{#setting-catchup-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    Максимально допустимое время отставания реплики от мастера (в секундах).

    Если задано ненулевое значение настройки, то [менеджер подключений Odyssey](../../managed-postgresql/concepts/pooling.md) не разрешит подключиться к репликам, которые сильно отстают от мастера. Этот механизм позволяет защититься от чтения устаревших данных с таких реплик.

    Odyssey периодически запрашивает у кластера информацию об отставании реплик. При попытке подключения к реплике, которая отстает от мастера на большее время, чем указано в настройке, подключение будет прервано. Odyssey вернет сообщение вида:

    ```text
    remote server read/write error: failed to wait replica for catchup
    ```

    Минимальное значение и значение по умолчанию — `0` (можно подключиться к любым репликам вне зависимости от того, насколько они отстают от мастера).

- **Conn limit**{#setting-conn-limit} {{ tag-all }}

  В транзакционном пулинге (transaction pooling) настройка ограничивает количество одновременных активных соединений для пользователя. При использовании этого типа пулинга пользователь может открыть тысячи соединений, но одновременно работать смогут только `N` соединений, где `N` — значение настройки.

  В сессионном пулинге (session pooling) настройка ограничивает количество соединений пользователя с каждым хостом в кластере {{ PG }}. При использовании этого типа пулинга значение настройки должно быть не меньше суммы всех соединений, которые могут быть открыты бэкендами пользовательского сервиса. Каждое открытое серверное соединение немного замедляет работу {{ PG }} на [OLTP](../../glossary/oltp.md)-нагрузке.

  Для сессионного пулинга применяются следующие принципы:

  - При добавлении пользователя {{ mpg-name }} по умолчанию резервирует для него 50 подключений к каждому хосту в кластере {{ PG }}. Минимальное количество подключений на пользователя — 1.
  - Суммарное количество подключений, зарезервированных для пользователей, не должно превышать значение параметра [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections). {{ mpg-name }} резервирует 15 служебных подключений на каждом хосте.

    Например, если для кластера задана настройка `"max_connections": 100`, то вы можете зарезервировать не больше 85 подключений для пользователей на каждый хост кластера.

  - Рекомендуется разнести по разным пользователям разные сервисы, использующие {{ PG }}, и задать нужное значение настройки для каждого пользователя. Если при проблемах в одном сервисе возникнет большое количество соединений, другие сервисы не будут затронуты и смогут подключаться к {{ PG }}.

  Эта настройка [зависит от выбранного класса хостов](#settings-instance-dependent).

- **Default transaction isolation**{#setting-user-default-transaction-isolation} {{ tag-all }}

  Описание настройки уровня кластера [Default transaction isolation](#setting-default-transaction-isolation).

- **Grants**{#setting-user-grants} {{ tag-all }}

  Набор [ролей](../../managed-postgresql/concepts/roles.md), выданных пользователю.

- **Idle in transaction session timeout**{#setting-user-idle-transaction-timeout} {{ tag-all }}

  Описание настройки уровня кластера [Idle in transaction session timeout](#setting-idle-transaction-timeout).

- **Idle session timeout**{#setting-user-idle-session-timeout} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Описание настройки уровня кластера [Idle session timeout](#setting-idle-session-timeout).

- **Lock timeout**{#setting-user-lock-timeout} {{ tag-all }}

  Описание настройки уровня кластера [Lock timeout](#setting-lock-timeout).

- **Log min duration statement**{#setting-user-log-min-duration-statement} {{ tag-all }}

  Описание настройки уровня кластера [Log min duration statement](#setting-log-min-duration-statement).

  Рекомендуется определить для каждого сервиса и соответствующего ему пользователя, что считается медленным выполнением запроса, и логировать только такие запросы. Например, для веб-сервиса медленным может считаться запрос, выполняющийся более одной секунды, а для сервиса построения отчетов — запрос, выполняющийся более 10 минут.

  Подробнее [в документации {{ PG }}](https://www.postgresql.org/docs/current/runtime-config-logging.html).

- **Log statement**{#setting-user-log-statement} {{ tag-all }}

  Описание настройки уровня кластера [Log statement](#setting-log-statement).

- **Login**{#setting-user-login} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Определяет, может ли пользователь подключаться к кластеру {{ PG }}.

  Значение по умолчанию — `true` (пользователь может подключаться к кластеру).

- **Pg audit log**{#setting-pg-audit-log} {{ tag-all }}

  Определяет, какие запросы пользователя попадут в лог для аудита.

  Настройка имеет силу только если:

  * к кластеру [подключена библиотека](../../managed-postgresql/operations/extensions/cluster-extensions.md#libraries-connection) `pgaudit`;
  * к базе данных [подключено расширение](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) `pgaudit`.

  Возможные значения:

  {% list tabs group=instructions %}

  - Консоль управления/CLI {#console}

    - `read` — в лог попадут запросы `SELECT` и `COPY`, когда источником данных выступает отношение или запрос.
    - `write` — в лог попадут запросы `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE` и `COPY`, когда приемником данных выступает отношение.
    - `function` — в лог попадут вызовы функций и блоки `DO`.
    - `role` — в лог попадут выражения, связанные с управлением ролями и привилегиями: `GRANT`, `REVOKE`, `CREATE/ALTER/DROP ROLE`.
    - `ddl` — в лог попадут все `DDL`, которые не входят в класс `ROLE`.
    - `misc` — в лог попадут вспомогательные команды: `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, `SET`.
    - `misc_set` — в лог попадут вспомогательные команды `SET`, например, `SET ROLE`.

  - {{ TF }} {#tf}

    - `READ` — в лог попадут запросы `SELECT` и `COPY`, когда источником данных выступает отношение или запрос.
    - `WRITE` — в лог попадут запросы `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE` и `COPY`, когда приемником данных выступает отношение.
    - `FUNCTION` — в лог попадут вызовы функций и блоки `DO`.
    - `ROLE` — в лог попадут выражения, связанные с управлением ролями и привилегиями: `GRANT`, `REVOKE`, `CREATE/ALTER/DROP ROLE`.
    - `DDL` — в лог попадут все `DDL`, которые не входят в класс `ROLE`.
    - `MISC` — в лог попадут вспомогательные команды: `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, `SET`.
    - `MISC_SET` — в лог попадут вспомогательные команды `SET`, например, `SET ROLE`.

  - API {#api}

    - `PG_AUDIT_SETTINGS_LOG_READ` — в лог попадут запросы `SELECT` и `COPY`, когда источником данных выступает отношение или запрос.
    - `PG_AUDIT_SETTINGS_LOG_WRITE` — в лог попадут запросы `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE` и `COPY`, когда приемником данных выступает отношение.
    - `PG_AUDIT_SETTINGS_LOG_FUNCTION` — в лог попадут вызовы функций и блоки `DO`.
    - `PG_AUDIT_SETTINGS_LOG_ROLE` — в лог попадут выражения, связанные с управлением ролями и привилегиями: `GRANT`, `REVOKE`, `CREATE/ALTER/DROP ROLE`.
    - `PG_AUDIT_SETTINGS_LOG_DDL` — в лог попадут все `DDL`, которые не входят в класс `ROLE`.
    - `PG_AUDIT_SETTINGS_LOG_MISC` — в лог попадут вспомогательные команды: `DISCARD`, `FETCH`, `CHECKPOINT`, `VACUUM`, `SET`.
    - `PG_AUDIT_SETTINGS_LOG_MISC_SET` — в лог попадут вспомогательные команды `SET`, например, `SET ROLE`.

  {% endlist %}

  Можно выбрать несколько значений. По умолчанию логи аудита для пользователя отключены.

  Подробнее о настройке логов для аудита читайте в разделе [Использование pgaudit](../../managed-postgresql/operations/extensions/pgaudit.md).

- **Pool mode**{#setting-pool-mode} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

    [Режим управления соединениями](../../managed-postgresql/concepts/pooling.md), который использует менеджер соединений Odyssey.

    Возможные значения:

    * `SESSION` — сессионный режим.
    * `TRANSACTION` — транзакционный режим.
    * `STATEMENT` — режим запроса.

    
    Значение по умолчанию — `SESSION`.


- **Prepared statements pooling**{#setting-prepared-statements-pooling} {{ tag-con }} {{ tag-api }} {{ tag-tf }}

  Позволяет использовать подготовленные операторы ([prepared statements](https://www.postgresql.org/docs/current/sql-prepare.html)) для транзакционного режима [менеджера соединений](../../managed-postgresql/concepts/pooling.md).

  Настройка доступна только для значения **Pool mode** `TRANSACTION`.

- **Statement timeout**{#setting-user-statement-timeout} {{ tag-all }}

  Описание настройки уровня кластера [Statement timeout](#setting-statement-timeout).

- **Synchronous commit**{#setting-user-synchronous-commit} {{ tag-all }}

  Описание настройки уровня кластера [Synchronous commit](#setting-synchronous-commit).

- **Temp file limit**{#setting-temp-file-limit} {{ tag-all }}

  Описание настройки уровня кластера [Temp file limit](#setting-temp-file-limit).

- **Wal sender timeout**{#setting-wal-sender-timeout} {{ tag-all }}

  Время (в миллисекундах), по истечении которого прерываются неактивные соединения репликации.

  {% include [settings-version](../../_includes/mdb/mpg/mpg-settings-v-12.md) %}
