# Агрегирование данных

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
                     -- COUNT(*) возвращает количество строк
                     -- в указанной таблице с учетом повторяющихся строк.
                     -- Функция считает каждую строку отдельно.
                     -- В результат также входят строки, содержащие значения null.
FROM `tutorial`.object("tutorial/users.json", json_each_row)
WITH SCHEMA (
    Int32 AS last_visit_time,
    String AS ip,
    Int32 AS age,
    Float AS last_time_on_site,
    String AS user_agent,
    String AS name,
    Int32 AS region,
    String AS last_url
)
GROUP BY region;    -- Результат выполнения запроса будет выведен
                    -- в порядке указанных колонок.
                    -- Несколько колонок разделяются запятой.
                    -- Другие колонки можно указать после выполнения SELECT,
                    -- только если они передаются в функцию агрегации.
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* [Функции агрегации данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/aggregation){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/aggregation){% endif %}.
