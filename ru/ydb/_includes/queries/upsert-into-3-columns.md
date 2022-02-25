---
sourcePath: ru/ydb/overlay/_includes/queries/upsert-into-3-columns.md
---
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
    1,
    3,
    "Test Episode",
    CAST(Date("2018-08-27") AS Uint64)
)
;
```