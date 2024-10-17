# Сортировать и фильтровать данные

При выборке данных можно указывать выражения-фильтры, которые будут ограничивать возвращаемые результаты. Также можно указать порядок возвращаемых значений.

Например:

* Найти 10 поездок, где были оставлены самые большие чаевые.
* Исключить поездки со стоимостью более 1000000 долларов.

```sql
SELECT
    *
FROM
    `tutorial-analytics`
WHERE
    tip_amount > 0          -- Список условий для формирования результата.
    AND                     -- Оператор И (AND) для написания сложных условий.
    total_amount < 1000000
ORDER BY tip_amount DESC    -- Упорядочить результат по убыванию значений в поле tip_amount.
LIMIT 10                    -- Взять только 10 записей.
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Результат выполнения запроса отобразится на вкладке **{{ ui-key.yql.yq-query-results.result.tab-text }}** в виде таблицы или схемы.

## Смотрите также {#see-also}

* Оператор [SELECT](https://ydb.tech/docs/ru/yql/reference/syntax/select).
* Оператор [WHERE](https://ydb.tech/docs/ru/yql/reference/syntax/select#where).
* Оператор [ORDER BY](https://ydb.tech/docs/ru/yql/reference/syntax/select#order-by).
