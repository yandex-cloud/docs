```sql
UPDATE episodes
SET title="Test Episode Updated"
WHERE
    series_id = 2
    AND season_id = 1
    AND episode_id = 3
;
```