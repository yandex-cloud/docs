# Управление клиентскими процессами и сессиями пользователей

{{ mgp-name }} запускает новый внутренний процесс для каждого клиентского подключения. Пользователь-администратор или другой пользователь с [ролью](../concepts/cluster-users.md#mdb_admin) `mdb_admin` может:

* [Получить список процессов](#list).
* [Управлять нагрузкой](#load-management).
* [Отменить сессию пользователя](#cancel-sessions).

## Получить список процессов {#list}

Запросы для получения списка процессов различаются для {{ GP }} и {{ CB }}. В {{ GP }} используется поле `waiting`, а в {{ CB }} — поля `wait_event_type` и `wait_event`.

Подробнее о [доступных СУБД в {{ mgp-name }}](../concepts/overview.md).

{% list tabs group=instructions %}

- {{ GP }} {#gp}

  Чтобы получить список процессов, включая пользовательские запросы, выполните запрос к функции `mdb_toolkit.pg_stat_activity()`:

  ```sql
  SELECT usename, pid, waiting, state, query, datname
  FROM mdb_toolkit.pg_stat_activity();
  ```

  Результат:

  ```text
   usename |  pid     | waiting | state  |         query          | datname
  ---------+----------+---------+--------+------------------------+---------
    sammy  |   31861  |    f    | idle   | SELECT * FROM testtbl; | testdb
    billy  |   31905  |    t    | active | SELECT * FROM topten;  | testdb
  ```

  Где:

  * `usename` — имя пользователя.
  * `pid` — идентификатор процесса.
  * `waiting` — процесс ожидает транзакцию:

    * `t` — да.
    * `f` — нет.

  * `state` — состояние процесса:

    * `active` — действующий.
    * `idle` — бездействующий.

  * `query` — запрос.
  * `datname` — имя базы данных.

- {{ CB }} {#cb}

  Чтобы получить список процессов, включая пользовательские запросы, выполните запрос к функции `mdb_toolkit.pg_stat_activity()`:

  ```sql
  SELECT usename, pid, wait_event_type, wait_event, state, query, datname
  FROM mdb_toolkit.pg_stat_activity();
  ```

  Результат:

  ```text
   usename |    pid   | wait_event_type | wait_event | state  |             query              | datname
  ---------+----------+-----------------+------------+--------+--------------------------------+---------
    user1  |  1798921 |     Timeout     |  PgSleep   | active | SELECT pg_sleep(25);           |  mydb
    user2  |  1798938 |     Lock        |  advisory  | active | SELECT pg_advisory_lock(1234); |  mydb
  ```

  Где:

  * `usename` — имя пользователя.
  * `pid` — идентификатор процесса.
  * `wait_event_type` — тип события, которое ожидается бэкендом. При значении `NULL` бэкенд не ожидает события.
  * `wait_event` — имя события, которое ожидается бэкендом. При значении `NULL` бэкенд не ожидает события.
  * `state` — состояние процесса:

    * `active` — действующий.
    * `idle` — бездействующий.

  * `query` — запрос.
  * `datname` — имя базы данных.

  Подробнее о полях представления `pg_stat_activity` читайте в [документации {{ CB }}](https://cloudberry.apache.org/docs/sys-catalogs/sys-views/gp-stat-activity).

{% endlist %}

## Управлять нагрузкой {#load-management}

1. Выполните запрос к конфигурационному файлу `gp_toolkit.gp_resgroup_config`, чтобы получить название ресурсной группы и узнать текущее количество параллельных транзакций:

    ```sql
    SELECT groupname, concurrency
    FROM gp_toolkit.gp_resgroup_config;
    ```

1. Установите количество параллельных транзакций для [ресурсной группы](../concepts/resource-groups.md):

    ```sql
    ALTER RESOURCE GROUP <имя_ресурсной_группы>
    SET concurrency <количество_параллельных_транзакций>;
    ```

## Отменить сессию пользователя {#cancel-sessions}

Вы можете отменить сессию пользователя одним из следующих способов:

1. [Завершить процесс с сессией](#cancel-backend).
1. [Завершить соединение с базой данных](#terminate-backend).
1. [Завершить все пользовательские сессии](#terminate-all-user-backends).

### Завершить определенный процесс {#cancel-backend}

Выполните запрос к функции `mdb_toolkit.gp_cancel_backend()`:

```sql
SELECT *
FROM mdb_toolkit.gp_cancel_backend(<идентификатор_процесса>);
```

Идентификатор процесса можно получить со [списком процессов в кластере](#list).

### Завершить соединение с базой данных {#terminate-backend}

Выполните запрос к функции `mdb_toolkit.gp_terminate_backend()`:

```sql
SELECT *
FROM mdb_toolkit.gp_terminate_backend(<идентификатор_процесса>);
```

Идентификатор процесса можно получить со [списком процессов в кластере](#list).

### Завершить все пользовательские сессии {#terminate-all-user-backends}

Чтобы завершить все пользовательские сессии в кластере, выполните запрос к функции `mdb_toolkit.terminate_all_user_backends()`:

```sql
SELECT *
FROM mdb_toolkit.terminate_all_user_backends();
```

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._