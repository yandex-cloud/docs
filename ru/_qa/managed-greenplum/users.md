# Управление пользователями {{ GP }}

#### Как посмотреть запросы пользователей? {#pg-stat}

Выполните запрос от имени [пользователя-администратора с ролью MDB_ADMIN](../../managed-greenplum/concepts/cluster-users.md):

```sql
SELECT * from mdb_toolkit.pg_stat_activity();
```

#### Как отменить сессии других пользователей? {#cancel-sessions}

Выполните запрос от имени [пользователя-администратора с ролью MDB_ADMIN](../../managed-greenplum/concepts/cluster-users.md):

```sql
SELECT * from mdb_toolkit.gp_cancel_backend(<PID сессии>);
SELECT * from mdb_toolkit.gp_terminate_backend(<PID сессии>);
```

PID сессии можно получить вместе со [списком запросов пользователей](#pg-stat).

#### Как управлять нагрузкой? {#load-management}

Выполните запрос, который задает количество параллельных транзакций для [ресурсной группы](../../managed-greenplum/concepts/resource-groups.md), от имени [пользователя-администратора с ролью MDB_ADMIN](../../managed-greenplum/concepts/cluster-users.md):

```sql
SELECT * FROM gp_toolkit.gp_resgroup_config;
ALTER RESOURCE GROUP default_group SET concurrency <количество параллельных транзакций>;
```
