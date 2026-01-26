- **Authentication plugin**{#setting-authentication-plugin} {{ tag-con }} {{ tag-cli }} {{ tag-tf }}

  Плагин аутентификации. Определяет политику аутентификации пользователя.

  Значение по умолчанию — не задано (действует настройка `Default authentication plugin`, задаваемая при создании кластера).

  Подробнее про плагины аутентификации см. [в документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/pluggable-authentication.html).

  
  {% note info %}

  Настройка **Authentication plugin** не действует, если для пользователя выбран способ авторизации **{{ ui-key.yacloud.mysql.cluster.label_iam_dgBhy }}**.

  {% endnote %}


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

  - [FLUSH OPTIMIZER COSTS](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_flush-optimizer-costs) — позволяет использовать оператор `FLUSH OPTIMIZER_COSTS`.

  - `SHOW ROUTINE` — позволяет просматривать все определения хранимых процедур и функций в таблице `information_schema.ROUTINES` (в том числе тех, где пользователь с этой привилегией не указан в поле `DEFINER`). Разрешает использовать операторы:

    - [SHOW CREATE FUNCTION](https://dev.mysql.com/doc/refman/8.0/en/show-create-function.html) – предоставляет развернутую информацию о хранимой функции.
    - [SHOW FUNCTION STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-function-status.html) – выводит краткие сведения о хранимой функции.
    - [SHOW CREATE PROCEDURE](https://dev.mysql.com/doc/refman/8.0/en/show-create-procedure.html) — предоставляет развернутую информацию о хранимой процедуре.
    - [SHOW PROCEDURE STATUS](https://dev.mysql.com/doc/refman/8.0/en/show-procedure-status.html) — выводит краткие сведения о хранимой процедуре.

  - `MDB ADMIN` — включает в себя привилегии `PROCESS`, `REPLICATION_CLIENT`, `REPLICATION_SLAVE`, `FLUSH_OPTIMIZER_COSTS`. Дополнительно позволяет выполнять следующие действия:

    - Использовать команду [KILL](https://dev.mysql.com/doc/refman/8.0/en/kill.html) для пользовательских запросов.
    - Создавать и удалять пользовательские базы и пользователей.
    - Выдавать права на объекты, созданные пользователем.

    {% note warning %}

    Объекты, созданные пользователем с привилегией `MDB ADMIN`, не отображаются в пользовательском интерфейсе. Используйте эту привилегию для создания временных вспомогательных баз данных и пользователей.

    {% endnote %}

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
