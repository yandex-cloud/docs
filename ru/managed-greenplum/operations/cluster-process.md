---
title: Как управлять клиентскими процессами и сессиями пользователей в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете управлять клиентскими процессами и сессиями пользователей.
---

# Управление клиентскими процессами и сессиями пользователей

{{ GP }} запускает новый внутренний процесс для каждого клиентского подключения. Пользователь-администратор или другой пользователь с [ролью](../concepts/cluster-users.md#mdb_admin) `mdb_admin` может:

* [{#T}](#list).
* [{#T}](#cancel-sessions).
* [{#T}](#cancel-backend).
* [{#T}](#terminate-backend).
* [{#T}](#load-management).

## Получить список процессов {#list}

Выполните запрос к функции `mdb_toolkit.pg_stat_activity()`. В списке процессов будут получены в том числе запросы пользователей:

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

## Отменить сессию пользователя {#cancel-sessions}

1. [Завершите процесс с сессией](#cancel-backend).
1. [Завершите соединение с базой данных](#terminate-backend).

## Завершить определенный процесс {#cancel-backend}

Выполните запрос к функции `mdb_toolkit.gp_cancel_backend()`:

```sql
SELECT *
FROM mdb_toolkit.gp_cancel_backend(<идентификатор_процесса>);
```

Идентификатор процесса можно получить со [списком процессов в кластере](#list).

## Завершить соединение с базой данных {#terminate-backend}

Выполните запрос к функции `mdb_toolkit.gp_terminate_backend()`:

```sql
SELECT *
FROM mdb_toolkit.gp_terminate_backend(<идентификатор_процесса>);
```

Идентификатор процесса можно получить со [списком процессов в кластере](#list).

## Управлять нагрузкой {#load-management}

1. Выполните запрос к конфигурационному файлу `gp_toolkit.gp_resgroup_config`, чтобы получить название ресурсной группы и узнать текущее количество параллельных транзакций:

    ```sql
    SELECT groupname, concurrency
    FROM gp_toolkit.gp_resgroup_config;
    ```

1. Установите количество параллельных транзакций для [ресурсной группы](../../managed-greenplum/concepts/resource-groups.md):

    ```sql
    ALTER RESOURCE GROUP <имя_ресурсной_группы>
    SET concurrency <количество_параллельных_транзакций>;
    ```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
