# Memory limit has been exceeded during query execution

`ERR.DS_API.DB.MEMORY_LIMIT_EXCEEDED`

Недостаточно памяти в источнике данных для выполнения запроса.

Ошибка возникает, когда базе данных не хватает памяти, чтобы выполнить запрос от {{ datalens-short-name }}.



Чтобы исправить ошибку, оптимизируйте таблицу-источник или уменьшите объем данных в запросе с помощью фильтров в чарте.

Для оптимизации таблиц обратитесь к администратору вашей базы данных.

Если собираетесь оптимизировать самостоятельно, попробуйте дополнить базу данных индексами и сортировками.

{% note tip %}

Если источник данных — {{ CH }}, найдите запросы от {{ datalens-short-name }} в [system.query_log]({{ ch.docs }}/operations/system-tables/query_log/).


Если  источник данных — MBD {{ PG }}, посмотрите [анализ производительности](../../../tutorials/dataplatform/mpg-profiling.md).


{% endnote %}


{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
