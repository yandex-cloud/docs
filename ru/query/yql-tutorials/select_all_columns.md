# Выборка данных из всех колонок

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Для выборки данных из всех колонок, необходимо использовать оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}:

```sql
SELECT  -- Оператор выбора данных.
    *   -- Выбор всех колонок.
FROM
    `tutorial`.`tutorial/users.json`
WITH (
    format=json_each_row, -- Указание имени соединения, пути до файла в нем и формата данных файла.
    -- Список поддерживаемых форматов: https://cloud.yandex.ru/docs/query/sources-and-sinks/object-storage#formats.
    SCHEMA 
    (
        last_visit_time Int32,
        ip String,
        age Int32,
        last_time_on_site Float,
        user_agent String,
        name String,
        region Int32,
        last_url String 
    )
);
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [Список поддерживаемых форматов файлов](../sources-and-sinks/object-storage.md#formats).
