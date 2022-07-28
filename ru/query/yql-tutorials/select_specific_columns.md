# Выборка данных из определенных колонок

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Данные можно получать не только из всех колонок, но и из их подмножества. Также можно переименовывать существующие колонки или создавать новые.

В примере ниже показано, как выбрать данные из колонок `age`, `last_visit_time` и `region`. При этом колонка `region` будет переименована в `area`, а тип колонки `release_date` будет преобразован из `Int32` в `DateTime`:

```sql

SELECT 
    age,            -- Имена колонок (age, area)
                    -- перечисляются через запятую.

    region AS area,  -- С помощью AS можно переименовать столбцы
                     -- или дать имя произвольному выражению,
    DateTime::Format("%Y-%m-%d %H:%M:%S")(DateTime::FromSeconds(CAST(last_visit_time AS UInt32))) as last_visit_time
    -- CAST из Int32 в UInt32 можно избежать, указав в схеме сразу требуемый тип.
    -- Больше про преобразования типов: https://cloud.yandex.ru/docs/query/yql-docs-core/types/cast.
    -- Документация Datetime https://cloud.yandex.ru/docs/query/yql-docs-core/udf/list/datetime.

FROM
    `tutorial`.`tutorial/users.json` 
WITH 
(
    format=json_each_row,
    SCHEMA 
    (
        last_visit_time Int32,
        ip String,
        age Int32,
        last_time_on_site Float,
        user_agent String,
        name String,
        region Int32,
        last_url String 
    )
);
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [Типы данных YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/types/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/types/){% endif %}.
* [Преобразование типов данных в YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/types/cast){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/types/cast){% endif %}.
* [Функции работы с датами]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/udf/list/datetime){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/udf/list/datetime){% endif %}.
