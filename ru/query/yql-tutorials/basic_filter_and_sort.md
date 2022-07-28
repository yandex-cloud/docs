# Сортировка и фильтрация

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

При выборке данных можно указывать выражения-фильтры, которые будут ограничивать возвращаемые результаты. Также можно указать порядок возвращаемых значений.

В пример ниже показано, как найти пользователей старше 5 лет из 255 региона с непустым именем, упорядоченных по возрасту пользователей:

```sql
SELECT 
    *
FROM
    `tutorial`.`tutorial/users.json`
WITH
(
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
WHERE
    age > 5               -- Список условий для формирования результата.
    AND region == 225     -- Логическое И (AND) используется для написания сложных условий.
    AND name IS NOT NULL -- Исключаются записи со значением NULL.
ORDER BY age -- Возвращаемые результаты должны быть упорядочены по полю age по возрастанию значений
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [WHERE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#where){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#where){% endif %}.
* Оператор [ORDER BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#order-by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#order-by){% endif %}.
