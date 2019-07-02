# Вставка данных с помощью INSERT

Задача: вставить данные в таблицу.

[INSERT](../reference/syntax/insert_into.md) используется для вставки новых записей.
При попытке вставить строку с существующим первичным ключом, появится сообщение об ошибке ```"Transaction rolled back due to constraint violation: insert_pk"``` ("Транзакция не выполнена из-за нарушения ограничения: insert_pk").

Операция INSERT менее эффективна, чем UPSERT и REPLACE.

При выполнении INSERT, {{ ydb-short-name }} сначала выполняется операции чтения, чтобы проверить, что такого первичного ключа не существует. Затем выполняется операция записи.

При UPSERT {{ ydb-short-name }} и REPLACE производится слепая запись.

Настоятельно рекомендуется использовать UPSERT или REPLACE вместо INSERT.

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
INSERT INTO episodes
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
    21,
    "Test 21",
    CAST(Date("2018-08-27") AS Uint64)
),
(
    -- можно сразу вставить несколько строк, разделенных запятыми
    2,
    5,
    22,
    "Test 22",
    CAST(Date("2018-08-27") AS Uint64)
)
;

COMMIT;

-- результат
SELECT * FROM episodes WHERE series_id = 2 AND season_id = 5;

COMMIT;
```

