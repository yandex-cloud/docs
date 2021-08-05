---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Назначение ролей {{ PG }}

Сервис {{ mpg-name }} не дает доступа к [ролям по умолчанию](https://www.postgresql.org/docs/current/default-roles.html). Вместо этого он предоставляет специальные роли:

* `mdb_admin` — для пользователей, которые не являются владельцами базы данных, но должны получать административные привилегии;
* `mdb_replication` — для пользователей, которые должны иметь возможность выполнять логическую репликацию.

Чтобы назначить роль пользователю, [используйте](../operations/grant.md) CLI или API {{ yandex-cloud }}: назначение роли запросом `GRANT` отменяется при следующей операции с базой.

## Роль mdb_admin {#mdb-admin}

Роль `mdb_admin` включает в себя следующие привилегии:

* Использование привилегий системных ролей:
    * `pg_monitor`
    * `pg_signal_backend`
    Подробнее о системных ролях см. в [документации](https://www.postgresql.org/docs/current/default-roles.html) {{ PG }}.
* Использование подписки для логической репликации (`CREATE | DROP | ALTER SUBSCRIPTION`).
* Использование расширений:
    * `dblink`
    * `pg_repack`
    * `postgres_fdw`
* Использование специфических функций расширений:
    * `pg_stat_kcache_reset()` из расширения `pg_stat_kcache`;
    * `pg_stat_reset()`, `pg_stat_statements_reset()` из расширения `pg_stat_statements`.

## Роль mdb_replication {#mdb-replication}

Роль `mdb_replication` включает в себя следующие привилегии:

* Подключение к кластеру с использованием протокола логической репликации (`replication=database`).
* Использование функции репликации:
    * `pg_create_logical_replication_slot`
    * `pg_drop_replication_slot`
