# Логическая репликация PostgreSQL

Сервис {{ mpg-name }} поддерживает [логическую репликацию](https://www.postgresql.org/docs/current/logical-replication.html).

Потоки логической репликации для кластера {{ mpg-name }} свободно проходят через [пулер соединений Odyssey](../../managed-postgresql/concepts/pooling.md). Это позволяет выполнять следующие задачи с помощью логической репликации:

* [{#T}](../../managed-postgresql/tutorials/data-migration.md).
* [Миграция базы данных из {{ mpg-name }}](../../managed-postgresql/tutorials/outbound-replication.md).
{% if audience != "internal" %}
* [{#T}](../../managed-postgresql/operations/logical-replica-from-rds.md).
{% endif %}
