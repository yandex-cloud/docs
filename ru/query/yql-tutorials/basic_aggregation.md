# Агрегирование данных

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Возвращаемые данные можно агрегировать по полям.

В примере ниже показано, как рассчитать количество уникальных IP-адресов и средний возраст пользователей для каждого региона:

```sql
SELECT
    region,
    AVG(age) AS avg_age_in_region,
    COUNT(DISTINCT ip) AS ips_count 
                     -- Агрегатная функция COUNT возвращает количество строк,
                     -- полученных в результате выполнения запроса.
                     -- Звездочка (*) указывает, что функция COUNT
                     -- посчитает количество всех строк в таблице.
                     -- DISTINCT оставит только уникальные значения.
                     -- COUNT(*) возвращает количество строк в
                     -- указанной таблице с учетом повторяющихся строк.
                     -- Функция считает каждую строку отдельно.
                     -- В результат также входят строки, содержащие значения null.
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
GROUP BY region;    -- Результат выполнения запроса будет выведен в порядке указанных колонок.
                    -- Несколько колонок разделяются запятой.
                    -- Другие колонки можно указать после выполнения SELECT, только если
                    -- они передаются в функцию агрегации.
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* [Функции агрегации данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/aggregation){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/aggregation){% endif %}.
