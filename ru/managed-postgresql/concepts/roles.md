# Назначение ролей {{ PG }}

Сервис {{ mpg-name }} позволяет вам [создавать собственные роли](https://www.postgresql.org/docs/current/sql-createrole.html) в базах {{ PG }}, но не дает доступа к [ролям по умолчанию](https://www.postgresql.org/docs/current/default-roles.html). Для пользователей, которые не являются владельцами базы, но должны получать административные привилегии, предусмотрена специальная роль `mdb_admin`.

Чтобы назначить роль пользователю, [используйте](../operations/grant.md) CLI или API {{ yandex-cloud }}: назначение роли запросом `GRANT` отменяется при следующей операции с базой.

## Роль mdb_admin {#mdb-admin}

Роль `mdb_admin` включает в себя следующие привилегии:

* Пользоваться привилегиями системных ролей:
  * `pg_monitor`
  * `pg_signal_backend`
* Использовать подписки для логической репликации (`CREATE | DROP | ALTER SUBSCRIPTION`).
* Использовать расширения:
  * `dblink`
  * `pg_repack`
  * `postgres_fdw`
* Использовать специфические функции расширений:
  * `pg_stat_kcache_reset()` из расширения `pg_stat_kcache`;
  * `pg_stat_reset()`, `pg_stat_statements_reset()` из расширения `pg_stat_statements`.
