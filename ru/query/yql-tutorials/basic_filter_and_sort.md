# Сортировка и фильтрация

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

При выборке данных можно указывать выражения-фильтры, которые будут ограничивать возвращаемые результаты. Также можно указать порядок возвращаемых значений.

В пример ниже показано, как найти 10 поездок, где были оставлены самые большие чаевые, исключая поездки со стоимость более 1млн долларов.

```sql
SELECT 
    *
FROM 
    bindings.`tutorial-analytics` 
WHERE 
    tip_amount > 0          -- Список условий для формирования результата.
    AND                     -- Логическое И (AND) используется для написания сложных условий.
    total_amount < 1000000
ORDER BY tip_amount DESC    -- Возвращаемые результаты должны быть упорядочены по полю tip_amount по убыванию значений
LIMIT 10                    -- Нужно взять только 10 записей
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [WHERE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#where){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#where){% endif %}.
* Оператор [ORDER BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#order-by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#order-by){% endif %}.
