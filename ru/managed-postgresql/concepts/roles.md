# Назначение ролей {{ PG }}

Сервис {{ mpg-name }} не дает доступа к [предопределенным ролям](https://www.postgresql.org/docs/current/predefined-roles.html), в том числе к роли суперпользователя. Вместо этого он предоставляет специальные роли:

* `mdb_admin` — для пользователей, которые не являются владельцами базы данных, но должны получать административные привилегии.
* `mdb_monitor` — для пользователей, которые должны читать различные параметры конфигурации, статистику и другую системную информацию.
* `mdb_replication` — для пользователей, которые должны иметь возможность выполнять логическую репликацию.

Чтобы назначить роль пользователю, [используйте](../operations/grant.md) CLI или [API](../../glossary/rest-api.md) {{ yandex-cloud }}: назначение роли запросом `GRANT` отменяется при следующей операции с базой.

## Роль mdb_admin {#mdb-admin}

Роль `mdb_admin` включает в себя следующие привилегии:

* Использование привилегий предопределенных ролей:
    * `pg_monitor`
    * `pg_signal_backend`
    Подробнее о предопределенных ролях см. в [документации](https://www.postgresql.org/docs/current/predefined-roles.html) {{ PG }}.
* Использование подписки для логической репликации (`CREATE | DROP | ALTER SUBSCRIPTION`).
* Использование расширений:
    * `dblink`
    * `pg_repack`
    * `postgres_fdw`
    * `pg_cron`
* Использование специфических функций расширений:
    * `pg_stat_kcache_reset()` из расширения `pg_stat_kcache`;
    * `pg_stat_reset()`, `pg_stat_statements_reset()` из расширения `pg_stat_statements`.

## Роль mdb_monitor {#mdb-monitor}

Роль `mdb_monitor` включает в себя следующие привилегии:

* Чтение и выполнение различных представлений и функций для мониторинга.
* Использование расширений:
    * `pg_stat_statements`
* Использование функций для работы с обычными файлами:
    * `pg_ls_logdir()`
    * `pg_ls_waldir()`
    * `pg_ls_archive_statusdir()`
    * `pg_ls_tmpdir ()`

## Роль mdb_replication {#mdb-replication}

Роль `mdb_replication` включает в себя следующие привилегии:

* Подключение к кластеру с использованием протокола логической репликации (`replication=database`).
* Использование функций репликации:
    * `pg_create_logical_replication_slot()`
    * `pg_drop_replication_slot()`
