---
sourcePath: overlay/_includes/queries/select-from-3-columns.md
---
```sql
SELECT
    series_id,
    title AS series_title,
    CAST (release_date AS Date) AS release_date
FROM series;
```