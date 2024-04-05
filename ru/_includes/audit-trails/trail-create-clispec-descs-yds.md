
* `destination.data_stream` — структура, описывающая целевой [поток данных](../../logging/operations/get-group.md) {{ yds-full-name }}.

    * `database_id` — идентификатор базы данных {{ ydb-short-name }}, которая используется потоком данных {{ yds-name }}. Получить идентификатор базы данных можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI `yc ydb database list`.
    * `stream_name` — имя потока данных {{ yds-name }}.
