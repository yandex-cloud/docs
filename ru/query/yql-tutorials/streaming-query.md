
# Выполнить запрос к данным реального времени

Данные можно обрабатывать не только из систем хранения типа {{objstorage-full-name}}, но и из шин потоков данных типа {{yds-full-name}}.

В примере ниже показано, как нарезать входные данные на одноминутные интервалы, внутри каждого интервала посчитать количество событий и сумму:

```sql
SELECT
    HOP_END() AS time,
    COUNT(*) AS ride_count,
    SUM(total_amount) AS total_amount
FROM 
(
    SELECT
        * 
    FROM
        bindings.`tutorial-streaming`
    LIMIT 10
)
GROUP BY 
    HOP(Just(CAST(tpep_pickup_datetime as Timestamp)), "PT1M", "PT1M", "PT1M");
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* Оператор [HOP](../concepts/stream-processing-windows.md).
* [Функции агрегации данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/aggregation){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/aggregation){% endif %}.