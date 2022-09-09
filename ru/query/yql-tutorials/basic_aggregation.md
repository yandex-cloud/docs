# Агрегирование данных

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Возвращаемые данные можно агрегировать по полям.

В примере ниже показано, как рассчитать количество поездок на такси, средний размер чаевых, сгруппированных по PULocationID - зоне посадки в такси:

```sql
SELECT 
    PULocationID, 
    COUNT(*) as rides_count,    -- Агрегатная функция COUNT возвращает количество строк,
                                -- полученных в результате выполнения запроса.
                                -- Звездочка (*) указывает, что функция COUNT
                                -- посчитает количество всех строк в таблице.
                                -- Функция считает каждую строку отдельно.
                                -- В результат также входят строки, содержащие значения null.                                
    AVG(tip_amount) as avg_tip_amount
FROM 
    bindings.`tutorial-analytics` 
GROUP BY PULocationID           -- Колонка, по которой выполняется агрегация данных
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* [Функции агрегации данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/aggregation){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/aggregation){% endif %}.
