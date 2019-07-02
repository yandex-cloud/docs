# Вставка и модификация данных с помощью UPSERT

[UPSERT](../reference/syntax/upsert_into.md) используется для вставки новых записей или обновлении существующих. Если запись не существует, она будет создана. Существующие записи будут обновлены, а пустые записи будут заполнены значениями по умолчанию.

Основное отличие между UPSERT и [REPLACE](../reference/syntax/replace_into.md) в том, что значения колонок, не участвующих в запросе, будут изменены на значения по-умолчанию.

UPSERT более эффективен, чем INSERT.

При выполнении INSERT, {{ ydb-short-name }} сначала выполняет операции чтения, чтобы проверить, что такого первичного ключа не существует. Затем выполняется операция записи.

При UPSERT {{ ydb-short-name }} производится слепая запись.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
UPSERT INTO episodes
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
    13,
    "Test Episode",
    CAST(Date("2018-08-27") AS Uint64)
)
;

COMMIT;

-- результат
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

COMMIT;
```

