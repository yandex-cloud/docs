- **Authentication plugin**{#setting-authentication-plugin} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Плагин аутентификации. Определяет политику аутентификации пользователя.

  Значение по умолчанию — не задано (действует настройка `Default authentication plugin`, задаваемая при создании кластера).

  Подробнее про плагины аутентификации см. [в документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/pluggable-authentication.html).

- **Global permissions**{#setting-global-permissions} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Привилегии пользователя на уровне сервера (глобальные привилегии). Одному пользователю можно задать несколько глобальных привилегий. Доступные привилегии:
  - [REPLICATION CLIENT](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-client) — используйте эту глобальную привилегию если вы хотите подключиться к потоку репликации извне {{ yandex-cloud }}. В этом случае выдайте ее пользователю, под которым клиент репликации будет подключаться к кластеру. Привилегия позволяет использовать следующие операторы:
    - [SHOW MASTER STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-master-status.html) — предоставляет информацию о состоянии бинарных логов мастера.
    - [SHOW REPLICA | SLAVE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-replica-status.html) — предоставляет информацию о состоянии основных параметров потока репликации.
    - [SHOW BINARY LOGS](https://dev.mysql.com/doc/refman/8.0/en/show-binary-logs.html) — выводит список бинарных логов на сервере.
  
  - [REPLICATION SLAVE](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_replication-slave) — используйте эту глобальную привилегию если вы хотите подключиться к потоку репликации извне {{ yandex-cloud }}. В этом случае выдайте ее пользователю, под которым клиент репликации будет подключаться к кластеру. Привилегия позволяет использовать следующие операторы:
    - [SHOW REPLICAS | SHOW SLAVE HOSTS](https://dev.mysql.com/doc/refman/8.0/en/show-replicas.html) — выводит список зарегистрированных в данный момент реплик.
    - [SHOW RELAYLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-relaylog-events.html) — выводит события в логе ретрансляции реплики.
    - [SHOW BINLOG EVENTS](https://dev.mysql.com/doc/refman/8.0/en/show-binlog-events.html) — выводит события в бинарном логе.
  
  - [PROCESS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_process) — позволяет получать информацию о всех выполняемых на сервере потоках и использовать оператор [SHOW ENGINE](https://dev.mysql.com/doc/refman/8.0/en/show-engine.html) для доступа к [INNODB_-таблицам](https://dev.mysql.com/doc/refman/8.0/en/innodb-information-schema-system-tables.html).

  Значение по умолчанию — не задано (глобальные привилегии не выданы пользователю).

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
    Значение по умолчанию — не задано (действует общая серверная настройка [max_user_connections](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_user_connections)).

  Подробнее см. [в документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/user-resources.html).