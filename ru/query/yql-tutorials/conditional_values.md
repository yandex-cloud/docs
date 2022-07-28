# Дополнительные условия агрегации

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Данные можно агрегировать не только по значениям колонок, но и по выражениям.

В примере ниже показано, как вывести имена всех пользователей, сгруппированных по признаку достижения 18 лет:

```sql
SELECT
    category,                   -- category определена в секции GROUP BY ниже.

    String::JoinFromList(       -- Вызов С++ UDF,
                                -- см. ниже.

        AGGREGATE_LIST(name),   -- Функция агрегации,
                                -- возвращающая все переданные значения в виде списка.

        ", "                    -- String::JoinFromList преобразует
                                -- элементы указанного списка (первый аргумент)
                                -- в строку, используя разделитель (второй аргумент).
    ) AS names
FROM `tutorial`.`tutorial/users.json`
WITH (
    format=json_each_row,
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
)
GROUP BY
    CASE                        -- CASE проверяет список условий
                                -- и возвращает одно из нескольких возможных
                                -- выражений. CASE может быть использован в любом
                                -- выражении или с любым оператором,
                                -- поддерживающим данное выражение. Например, CASE можно использовать
                                -- выражениях SELECT, UPDATE, DELETE,
                                -- и с операторами IN, WHERE, ORDER BY.
        WHEN age < 18
        THEN "child"
        ELSE "adult"
    END AS category             -- GROUP BY можно выполнить
                                -- для произвольного выражения.
                                -- Результат будет доступен в SELECT
                                -- через алиас, указанный с помощью AS.
;
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* Оператор [CASE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/expressions#case){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/expressions#case){% endif %}.
