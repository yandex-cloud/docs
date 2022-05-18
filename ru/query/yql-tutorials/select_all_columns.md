# Выборка данных из всех колонок

Для выборки данных из всех колонок, необходимо использовать оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}:

```sql
SELECT  -- Оператор выбора данных.
    *   -- Выбор всех колонок.
FROM
    `tutorial`.object("tutorial/users.json", json_each_row) -- Указание имени соединения,
                                                            -- пути до файла в нем
                                                            -- и формата данных файла.
WITH SCHEMA (
    Int32 AS last_visit_time,
    String AS ip,
    Int32 AS age,
    Float AS last_time_on_site,
    String AS user_agent,
    String AS name,
    Int32 AS region,
    String AS last_url
);
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [Список поддерживаемых форматов файлов](../sources-and-sinks/object-storage.md#formats).
