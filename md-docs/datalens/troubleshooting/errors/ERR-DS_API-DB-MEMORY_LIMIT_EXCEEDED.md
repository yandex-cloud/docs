# [Yandex DataLens] Memory limit has been exceeded during query execution

`ERR.DS_API.DB.MEMORY_LIMIT_EXCEEDED`

Недостаточно памяти в источнике данных для выполнения запроса.

Ошибка возникает, когда базе данных не хватает памяти, чтобы выполнить запрос от DataLens.



Чтобы исправить ошибку, оптимизируйте таблицу-источник или уменьшите объем данных в запросе с помощью фильтров в чарте.

Для оптимизации таблиц обратитесь к администратору вашей базы данных.

Если собираетесь оптимизировать самостоятельно, попробуйте дополнить базу данных индексами и сортировками.

{% note tip %}

Если источник данных — ClickHouse®, найдите запросы от DataLens в [system.query_log](https://clickhouse.com/docs/ru/operations/system-tables/query_log).


Если  источник данных — MBD PostgreSQL, посмотрите [анализ производительности](../../../tutorials/dataplatform/mpg-profiling.md).


{% endnote %}


_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._