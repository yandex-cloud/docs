# Решения для Managed Service for PostgreSQL

## Примеры конфигураций и сценариев Managed Service for PostgreSQL {#configuration-examples}

* [Как работает параметр `Conn limit`](how-to/conn-limit-parameter.md)
* [Как включить логирование SQL-запросов](how-to/sql-queries-logging.md)
* [Как настроить фильтрацию SQL-запросов](how-to/sql-queries-filtering.md)

## Решения для известных проблем Managed Service for PostgreSQL {#known-issues-resolving}

* [Восстановление работоспособности кластера Managed Service for PostgreSQL после исчерпания свободного места в хранилище данных](known-issues/restoring-health-of-a-cluster-after-switching-its-disks-to-read-only-mode.md)
* [Не удается удалить кластер Managed Service for PostgreSQL в состоянии `DEAD`, если на нем включена защита от удаления](known-issues/unable-to-remove-cluster-in-dead-state-if-delete-protection-is-activated.md)
* [Устранение проблем с изменением конфигурации кластера с дисками `local-ssd`](known-issues/unprocessable-entity-issue-when-enlarging-local-disk.md)
* [Устранение последствий переполнения хранилища кластера WAL-журналами](known-issues/cluster-in-readonly-due-to-wal-overflow.md)
* [Устранение ошибки `psql: error: could not translate host name to address: nodename nor servname provided, or not known`](known-issues/error-could-not-translate-host-name-to-address-nodename-nor-servname-provided-or-not-known.md)
* [Устранение ошибки `Unrecognized configuration parameter "stats_temp_directory"`](known-issues/error-unrecognized-configuration-parameter.md)
* [Устранение ошибки `max_connections сonn_limit is too high`](known-issues/conn-limit-is-too-high.md)
* [Устранение ошибки `Must be superuser to create this extension`](known-issues/must-be-superuser-to-create-this-extension.md)
* [Устранение ошибки `terminating connection due to administrator command` и `ERROR: odyssey: remote server read/write error`](known-issues/terminating-connection-due-to-administrator-command.md)
* [Устранение ошибки `422 UNPROCESSABLE ENTITY The specified extension <'ext_name'> is not present in shared_preload_libraries`](known-issues/error-422.md)