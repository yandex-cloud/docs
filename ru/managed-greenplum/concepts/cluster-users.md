# Управление пользователями

Вы можете управлять пользователями кластера с помощью SQL-команд, выполняемых от имени пользователя-администратора. Его имя и пароль задаются при [создании](../operations/cluster-create.md#create-cluster) кластера. Подробнее см. в [документации {{ GP }}](https://greenplum.docs.pivotal.io/6latest/admin_guide/roles_privs.html).

Не рекомендуется использовать учетную запись пользователя-администратора для выполнения повседневных задач, т. к. ошибочная команда, отправленная от его имени, может привести к неработоспособности кластера. Для таких задач создайте отдельных пользователей с минимально необходимым [набором привилегий](https://greenplum.docs.pivotal.io/6latest/admin_guide/roles_privs.html#topic4).

Пользователю-администратору недоступна роль `SUPERUSER`, вместо нее ему назначена роль `MDB_ADMIN`. Чтобы предоставить пользователю-администратору доступ к системным представлениям, воспользуйтесь командами SQL:

```sql
{% set admin_role = 'mdb_admin' %}
{% set schema = 'mdb_toolkit' %}

CREATE OR REPLACE FUNCTION not_var{{ schema }}.pg_stat_activity() RETURNS SETOF pg_stat_activity AS
$$ SELECT * FROM pg_catalog.pg_stat_activity; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;

CREATE OR REPLACE FUNCTION not_var{{ schema }}.pg_locks() RETURNS SETOF pg_locks AS
$$ SELECT * FROM pg_catalog.pg_locks; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;

CREATE OR REPLACE FUNCTION not_var{{ schema }}.session_level_memory_consumption() RETURNS SETOF session_state.session_level_memory_consumption AS
$$ SELECT * FROM session_state.session_level_memory_consumption; $$
LANGUAGE sql CONTAINS SQL SECURITY DEFINER;
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
