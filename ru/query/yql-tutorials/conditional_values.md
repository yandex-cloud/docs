# Дополнительные условия агрегации

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Данные можно агрегировать не только по значениям колонок, но и по выражениям.

В примере ниже показано, как расчитать число поездок, сгруппированных по длинному или короткому расстоянию:

```sql
SELECT 
    distance_type, 
    COUNT(*)
FROM 
    bindings.`tutorial-analytics` 
GROUP BY                                -- CASE проверяет список условий
    CASE                                -- и возвращает одно из нескольких возможных
        WHEN trip_distance > 10         -- выражении или с любым оператором,
        THEN "long"                     -- поддерживающим данное выражение. Например, CASE можно использовать
        ELSE "short"                    -- в выражениях SELECT, UPDATE, DELETE,
    END AS distance_type                -- и с операторами IN, WHERE, ORDER BY.
                                        -- GROUP BY можно выполнить
                                        -- для произвольного выражения.
                                        -- Результат будет доступен в SELECT
                                        -- через псевдоним, указанный с помощью AS.
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* Оператор [CASE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/expressions#case){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/expressions#case){% endif %}.
