# Агрегировать данные

Данные в результате можно агрегировать по полям.

Например:

* Рассчитать количество поездок на такси.
* Рассчитать средний размер чаевых.
* Сгруппировать по зоне посадки в такси (`PULocationID`).

```sql
SELECT
    PULocationID,
    COUNT(*) AS rides_count,    -- Агрегатная функция COUNT возвращает количество строк,
                                -- полученных в результате выполнения запроса.
                                -- Звездочка (*) указывает, что функция COUNT
                                -- посчитает количество всех строк в таблице.
                                -- Функция считает каждую строку отдельно.
                                -- В результат также входят строки, содержащие значения null.
    AVG(tip_amount) AS avg_tip_amount
FROM
    `tutorial-analytics`
GROUP BY PULocationID           -- Колонка, по которой выполняется агрегация данных.
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Результат выполнения запроса отобразится на вкладке **{{ ui-key.yql.yq-query-results.result.tab-text }}** в виде таблицы или схемы.

#### См. также {#see-also}

* Оператор [SELECT]({{ ydb.docs }}/yql/reference/syntax/select)
* Оператор [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by)
* [Функции агрегации данных]({{ ydb.docs }}/yql/reference/builtins/aggregation)
