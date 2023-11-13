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
    bindings.`tutorial-analytics` 
LIMIT 10
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/console-icons/play-fill.svg) **Выполнить**.
Результат выполнения запроса отобразится на вкладке **Результат** в виде таблицы или схемы.

## Смотрите также {#see-also}

* Оператор [SELECT](https://ydb.tech/ru/docs/yql/reference/syntax/select).
* [Типы данных YQL](https://ydb.tech/ru/docs/yql/reference/types/).
* [Преобразование типов данных в YQL](https://ydb.tech/ru/docs/yql/reference/types/cast).
* [Функции работы с датами](https://ydb.tech/ru/docs/yql/reference/udf/list/datetime).
