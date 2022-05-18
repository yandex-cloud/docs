# Сортировка и фильтрация

При выборке данных можно указывать выражения-фильтры, которые будут ограничивать возвращаемые результаты. Также можно указать порядок возвращаемых значений.

В пример ниже показано, как найти пользователей старше 5 лет из 255 региона с непустым именем, упорядоченных по возрасту пользователей:

```sql
SELECT 
    *
FROM
    `tutorial`.object("tutorial/users.json", json_each_row)
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
WHERE
    age > 5               -- Список условий для формирования результата.
    AND region == 225     -- Логическое И (AND) используется для написания сложных условий.
    AND name IS NOT NULL; -- Исключаются записи со значением NULL.
ORDER BY age              -- Возвращаемые результаты должны быть упорядочены по полю age
                          -- по возрастанию значений.
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [WHERE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#where){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#where){% endif %}.
* Оператор [ORDER BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#order-by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#order-by){% endif %}.
