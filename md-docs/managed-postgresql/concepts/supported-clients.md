[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for PostgreSQL](../index.md) > [Концепции](index.md) > Поддерживаемые клиенты

# Рекомендуемые клиенты для СУБД Managed Service for PostgreSQL

Для подключения к Managed Service for PostgreSQL рекомендуется использовать следующие клиенты:

- все клиенты, использующие библиотеку `libpq`: `psql`, `pqxx`, `psycopg2` и т. д.;
- драйвер [JDBC](https://jdbc.postgresql.org).

Managed Service for PostgreSQL не накладывает ограничений на использование остальных клиентов. Однако при их использовании ознакомьтесь с известными ограничениями и проблемами во избежание проблем с подключением и работой с кластером.