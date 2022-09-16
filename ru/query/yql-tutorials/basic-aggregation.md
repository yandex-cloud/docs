# Агрегировать данные

Данные в результате можно агрегировать по полям.

Например:

* Рассчитать количество поездок на такси.
* Рассчитать средний размер чаевых.
* Сгруппировать по зоне посадки в такси (`PULocationID`).

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
GROUP BY PULocationID           -- Колонка, по которой выполняется агрегация данных.
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/query/run.svg) **Выполнить**.
Результат выполнения запроса отобразится на вкладке **Результат** в виде таблицы или схемы.

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* [Функции агрегации данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/aggregation){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/aggregation){% endif %}.
