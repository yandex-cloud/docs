
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
    HOP(Just(CAST(tpep_pickup_datetime AS Timestamp)), "PT1M", "PT1M", "PT1M");
```

## Смотрите также {#see-also}

* Оператор [SELECT](https://ydb.tech/ru/docs/yql/reference/syntax/select).
* Оператор [GROUP BY](https://ydb.tech/ru/docs/yql/reference/syntax/group_by).
* Оператор [HOP](../concepts/stream-processing-windows.md).
* [Функции агрегации данных](https://ydb.tech/ru/docs/yql/reference/builtins/aggregation).