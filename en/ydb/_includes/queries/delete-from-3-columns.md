---
sourcePath: en/ydb/overlay/_includes/queries/delete-from-3-columns.md
---
```sql
DELETE
FROM episodes
WHERE
    series_id = 2
    AND season_id = 5
    AND episode_id = 21
;
```
