# Логическая репликация {{ PG }}

Сервис {{ mpg-name }} поддерживает [логическую репликацию](https://www.postgresql.org/docs/current/logical-replication.html).

Потоки логической репликации для кластера {{ mpg-name }} свободно проходят через [менеджер подключений Odyssey](../../managed-postgresql/concepts/pooling.md). Это позволяет выполнять следующие задачи с помощью логической репликации:
