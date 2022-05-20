# Управление пользователями {{ GP }}

Вы можете управлять пользователями кластера с помощью суперпользователя (пользователя-администратора). Задать пароль суперпользователя можно при [создании](../operations/cluster-create.md#create-cluster) кластера. Управление доступно только через SQL.

Для выполнения повседневных задач создайте отдельных пользователей с минимально необходимым [набором привилегий](https://greenplum.docs.pivotal.io/6latest/admin_guide/roles_privs.html#topic4). Не рекомендуется применять для этих целей учетную запись суперпользователя, поскольку она имеет полный доступ к кластеру. Отправленная от ее имени ошибочная команда может привести к неработоспособности кластера.

Подробнее о ролях и привилегиях см. в [документации {{ GP }}](https://greenplum.docs.pivotal.io/6latest/admin_guide/roles_privs.html).

Суперпользователь может вызывать системные функции из специальной схемы, недоступной остальным пользователям:

```sql
{% set admin_role = 'mdb_admin' %}
{% set schema = 'mdb_toolkit' %}

CREATE OR REPLACE FUNCTION {{ schema }}.pg_stat_activity() RETURNS SETOF pg_stat_activity AS
$$ SELECT * FROM pg_catalog.pg_stat_activity; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;

CREATE OR REPLACE FUNCTION {{ schema }}.pg_locks() RETURNS SETOF pg_locks AS
$$ SELECT * FROM pg_catalog.pg_locks; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;

CREATE OR REPLACE FUNCTION {{ schema }}.session_level_memory_consumption() RETURNS SETOF session_state.session_level_memory_consumption AS
$$ SELECT * FROM session_state.session_level_memory_consumption; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;
```
