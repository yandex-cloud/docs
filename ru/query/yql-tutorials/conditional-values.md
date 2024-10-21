# Добавить дополнительные условия агрегации

Данные можно агрегировать не только по значениям колонок, но и по выражениям.

Например:

* Сгруппировать поездки по длинному расстоянию.
* Сгруппировать поездки по короткому расстоянию.
* Рассчитать сумму сгруппированных поездок.

```sql
SELECT
    distance_type,
    COUNT(*)
FROM
    `tutorial-analytics`
GROUP BY                                -- CASE проверяет список условий
    CASE                                -- и возвращает одно из нескольких возможных
        WHEN trip_distance > 10         -- выражении или с любым оператором,
        THEN "long"                     -- поддерживающим данное выражение. Например, CASE можно использовать
        ELSE "short"                    -- в выражениях SELECT
    END AS distance_type                -- и с операторами IN, WHERE, ORDER BY.
                                        -- GROUP BY можно выполнить
                                        -- для произвольного выражения.
                                        -- Результат будет доступен в SELECT
                                        -- через псевдоним, указанный с помощью AS.
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Результат выполнения запроса отобразится на вкладке **{{ ui-key.yql.yq-query-results.result.tab-text }}** в виде таблицы или схемы.

#### См. также {#see-also}

* Оператор [SELECT]({{ ydb.docs }}/yql/reference/syntax/select)
* Оператор [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by)
* Оператор [CASE]({{ ydb.docs }}/yql/reference/syntax/expressions#case)
