- **Authentication plugin**{#setting-authentication-plugin} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Плагин аутентификации. Определяет политику аутентификации пользователя.

  Значение по умолчанию — не задано (действует настройка `Default authentication plugin`, задаваемая при создании кластера).

  Подробнее про плагины аутентификации см. [в документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/pluggable-authentication.html).

- **Administrative privileges**{#setting-administrative-privileges} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Административные привилегии — [права пользователя](../../managed-mysql/concepts/user-rights.md), которые действуют на уровне всего кластера баз данных.

  Пользователю можно предоставить административные привилегии:

  - [REPLICATION CLIENT](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-client) — разрешает использовать операторы:

    - [SHOW MASTER STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-master-status.html) — предоставляет информацию о состоянии бинарных логов мастера.
    - [SHOW REPLICA | SLAVE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-replica-status.html) — предоставляет информацию о состоянии основных параметров потока репликации.
    - [SHOW BINARY LOGS](https://dev.mysql.com/doc/refman/8.0/en/show-binary-logs.html) — выводит список бинарных логов на хосте кластера.

  - [REPLICATION SLAVE](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-slave) — позволяет подключиться к потоку репликации извне {{ yandex-cloud }}. Разрешает использовать операторы:

    - [SHOW REPLICAS | SHOW SLAVE HOSTS](https://dev.mysql.com/doc/refman/8.0/en/show-replicas.html) — выводит список зарегистрированных в данный момент реплик.
    - [SHOW RELAYLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-relaylog-events.html) — выводит события в логе ретрансляции реплики.
    - [SHOW BINLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-binlog-events.html) — выводит события в бинарном логе.

  - [PROCESS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_process) — позволяет использовать оператор `SHOW PROCESSLIST` и просматривать статус систем хранения данных (например, `SHOW ENGINE INNODB STATUS`). Кроме того, в {{ mmy-name }} эта привилегия предоставляет право на чтение таблиц системных баз данных [mysql](https://dev.mysql.com/doc/refman/8.0/en/system-schema.html), [performance_schema](https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html) и [sys](https://dev.mysql.com/doc/refman/8.0/en/sys-schema.html).

  Значение по умолчанию — не задано (у пользователя нет административных привилегий). Возможно предоставить несколько привилегий одновременно.

- **Connection limits**{#setting-connection-limits} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Раздел с настройками ограничений для пользователя.

  - **Max connections per hour**{#setting-max-connection-per-hour}
  
    Максимально допустимое для пользователя количество соединений в час.

    Минимальное значение — 0 (нет ограничений).
    Значение по умолчанию — не задано (нет ограничений).

  - **Max questions per hour**{#setting-max-questions-per-hour}
  
    Максимально допустимое для пользователя количество запросов в час. Не считая запросов, выполняемых в рамках хранимых процедур.

    Минимальное значение — 0 (нет ограничений).
    Значение по умолчанию — не задано (нет ограничений).

  - **Max updates per hour**{#setting-max-updates-per-hour}
  
    Максимально допустимое для пользователя количество запросов `UPDATE` в час.

    Минимальное значение — 0 (нет ограничений).
    Значение по умолчанию — не задано (нет ограничений).

  - **Max user connections**{#setting-max-user-connections}
  
    Максимально допустимое для пользователя количество одновременных соединений.

    Минимальное значение — 0 (нет ограничений).
    Значение по умолчанию — не задано (действует общая настройка кластера [max_user_connections](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_user_connections)).

  Подробнее см. [в документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/user-resources.html).
