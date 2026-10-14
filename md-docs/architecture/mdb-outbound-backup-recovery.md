[Документация Yandex Cloud](../index.md) > [Архитектурные решения](index.md) > Отказоустойчивость > Восстановление кластеров БД из резервных копий во внешнее S3-хранилище

# Восстановление кластеров БД из резервных копий во внешнее S3-хранилище

Резервные копии кластеров управляемых баз данных создаются с помощью специальных утилит (например, WAL-G) и хранятся в S3-совместимом хранилище. При передаче кластера заказчику вместе с ним передаются базовые резервные копии из каталога `basebackups_005/` и архив журналов транзакций: файлов WAL, бинарных логов или oplog в зависимости от СУБД.

Восстановление данных выполняется на собственной инфраструктуре без доступа к Yandex Cloud и к сервисам управляемых баз данных. Для этого нужно развернуть СУБД той же мажорной версии, что и в исходном кластере, установить WAL-G, получить доступ на чтение к бакету с копиями и закрытый ключ шифрования. Сначала скачивается базовая резервная копия, созданная до нужного момента времени, затем поверх нее воспроизводятся журналы транзакций.

Для восстановления данных используйте инструкцию для конкретной СУБД:

#|
|| **Сервис** | **Инструкция** ||
|| Managed Service for PostgreSQL | [Восстановление PostgreSQL из резервной копии WAL-G](../managed-postgresql/operations/cluster-outbound-backups.md) ||
|| Managed Service for MySQL® | [Восстановление базы данных MySQL® из резервной копии WAL-G](../managed-mysql/operations/cluster-outbound-backups.md) ||
|| Yandex Managed Service for Valkey™ | [Восстановление Yandex Managed Service for Valkey™ из резервной копии WAL-G](../managed-valkey/operations/cluster-outbound-backups.md) ||
|| Yandex StoreDoc | [Восстановление MongoDB из резервной копии WAL-G](../storedoc/operations/cluster-outbound-backups.md) ||
|| Yandex MPP Analytics for PostgreSQL | [Восстановление Greenplum® из резервной копии WAL-G](../managed-greenplum/operations/cluster-outbound-backups.md) ||
|| Managed Service for ClickHouse® | [Восстановление данных из резервной копии ch-backup](../managed-clickhouse/operations/cluster-outbound-backups.md) ||
|#