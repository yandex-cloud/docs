# Логическая репликация PostgreSQL

Сервис Managed Service for PostgreSQL поддерживает [логическую репликацию](https://www.postgresql.org/docs/current/logical-replication.html).

Потоки логической репликации для кластера Managed Service for PostgreSQL свободно проходят через [менеджер подключений Odyssey](../../managed-postgresql/concepts/pooling.md). Это позволяет выполнять следующие задачи с помощью логической репликации:

* [Миграция базы данных из стороннего кластера PostgreSQL в Managed Service for PostgreSQL](postgresql-data-migration.md).
* [Миграция базы данных из Managed Service for PostgreSQL](outbound-replication.md).
* [Создание логической реплики Amazon RDS для PostgreSQL в Managed Service for PostgreSQL](../../managed-postgresql/tutorials/logical-replica-from-rds.md).