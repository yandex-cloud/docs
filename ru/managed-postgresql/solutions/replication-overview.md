# Логическая репликация PostgreSQL

Сервис {{ mpg-name }} поддерживает [логическую репликацию](https://www.postgresql.org/docs/current/logical-replication.html).

Потоки логической репликации для кластера {{ mpg-name }} свободно проходят через [пулер соединений Odyssey](../concepts/pooling.md). Это позволяет выполнять следующие задачи с помощью логической репликации:

* [{#T}](../operations/data-migration.md).
* [{#T}](../solutions/outbound-replication.md).
* [{#T}](../operations/logical-replica-from-rds.md).
