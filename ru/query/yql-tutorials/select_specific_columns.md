# Выборка данных из определенных колонок

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Данные можно получать не только из всех колонок, но и из их подмножества. Также можно переименовывать существующие колонки или создавать новые.

В примере ниже показано, как выбрать данные из колонок `age`, `last_visit_time` и `region`. При этом колонка `region` будет переименована в `area`, а тип колонки `release_date` будет преобразован из `Int32` в `DateTime`:

```sql
SELECT 
    VendorID,                           -- Имена колонок (VendorID, trip_distance)
    trip_distance,                      -- перечисляются через запятую.
    fare_amount AS fare,                -- С помощью AS можно переименовать столбцы
    (total_amount/1000) AS total_amount_thousand_dollars, -- или дать имя произвольному выражению,
    CAST(VendorID as Uint32) AS vendorID -- с помощью CAST можно поменять тип данных
FROM 
    bindings.`tutorial-analytics` 
LIMIT 10
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [Типы данных YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/types/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/types/){% endif %}.
* [Преобразование типов данных в YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/types/cast){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/types/cast){% endif %}.
* [Функции работы с датами]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/udf/list/datetime){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/udf/list/datetime){% endif %}.
