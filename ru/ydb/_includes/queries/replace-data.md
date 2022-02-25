---
sourcePath: ru/ydb/overlay/_includes/queries/replace-data.md
---
```sql
REPLACE INTO series (series_id, title, release_date, series_info)
VALUES
    (
        1,
        "IT Crowd",
        CAST(Date("2006-02-03") AS Uint64),
        "The IT Crowd is a British sitcom."
    ),
    (
        2,
        "Silicon Valley",
        CAST(Date("2014-04-06") AS Uint64),
        "Silicon Valley is an American comedy television series."
    ),
    (
        3,
        "Fake series",
        CAST(Date("2018-09-11") AS Uint64),
        "Fake series for testing purposes."
    )
    ;
```
