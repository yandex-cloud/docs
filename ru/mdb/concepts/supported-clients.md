# Поддерживаемые клиенты СУБД

[!KEYREF mdb-short-name] гарантирует работу только для определенных клиентов СУБД, но не накладывает ограничений на использованиие остальных клиентов. 


## [!KEYREF PG]

Поддерживаются следующие клиенты:

- все клиенты, использующие библиотеку `libpq`: `psql`, `pqxx`, `psycopg2` и т. д.;
- драйвер [JDBC](https://jdbc.postgresql.org).


## [!KEYREF CH]

Поддерживаются следующие клиенты:

- `clickhouse-client`;
- клиенты, которые используют [!KEYREF CH] HTTP API и поддерживают SSL.


## [!KEYREF MG]   

Поддерживаются следующие клиенты:

- [mongo](https://docs.mongodb.com/manual/mongo/);
- [драйвер для Python](https://docs.mongodb.com/ecosystem/drivers/python/);
- [драйвер для Java](http://mongodb.github.io/mongo-java-driver/).
