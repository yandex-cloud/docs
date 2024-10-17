# Выбрать данные из определенных колонок

Данные можно получать не только из всех колонок, но и из их подмножества. Также можно переименовывать существующие колонки или создавать новые.

Например:

* Выбрать данные из колонок `age`, `last_visit_time` и `region`.
* Переименовать `region` в `area`.
* Сменить тип колонки `release_date` с `Int32` на `DateTime`

```sql
SELECT
    VendorID,                           -- Имена колонок (VendorID, trip_distance)
    trip_distance,                      -- перечисляются через запятую.
    fare_amount AS fare,                -- С помощью AS можно переименовать столбцы
    (total_amount/1000) AS total_amount_thousand_dollars, -- или дать имя произвольному выражению,
    CAST(VendorID as Uint32) AS vendorID -- с помощью CAST можно поменять тип данных.
FROM
    `tutorial-analytics`
LIMIT 10
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Результат выполнения запроса отобразится на вкладке **{{ ui-key.yql.yq-query-results.result.tab-text }}** в виде таблицы или схемы.

## Смотрите также {#see-also}

* Оператор [SELECT](https://ydb.tech/docs/ru/yql/reference/syntax/select).
* [Типы данных YQL](https://ydb.tech/docs/ru/yql/reference/types/).
* [Преобразование типов данных в YQL](https://ydb.tech/docs/ru/yql/reference/types/cast).
* [Функции работы с датами](https://ydb.tech/docs/ru/yql/reference/udf/list/datetime).
