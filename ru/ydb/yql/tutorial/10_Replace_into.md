# Вставка и модификация данных с помощью REPLACE

[REPLACE](../reference/syntax/replace_into.md) используется для вставки новой записи или обновления существующей. Если запись не существует, она будет создана. Существующие записи будут обновлены, а пустые записи будут заполнены значениями по умолчанию.

Основное различие между REPLACE и [UPSERT](../reference/syntax/upsert_into.md) в том, что значения колонок, не участвующих в запросе, будут изменены на значения по-умолчанию.

Операция REPLACE является более эффективной с точки зрения производительности, чем INSERT. При выполнении INSERT, {{ ydb-short-name }} сначала выполняет операции чтения, чтобы проверить, что такого первичного ключа не существует. Затем выполняется операция записи.

При выполнении REPLACE или UPSERT, {{ ydb-short-name }} выполняет слепую запись без предварительных чтений.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
REPLACE INTO episodes
(
    series_id,
    season_id,
    episode_id,
    title,
    air_date
)
VALUES
(
    2,
    5,
    12,
    "Test Episode !!!",
    CAST(Date("2018-08-27") AS Uint64)
)
;

-- Вызов COMMIT используется для того, чтобы следующей операции
-- SELECT были видны изменения, сделанные в рамках предыдущей
-- транзакции.
COMMIT;

-- Cтрока, измененная в транзакции выше.
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

COMMIT;
```

