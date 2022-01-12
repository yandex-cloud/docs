---
sourcePath: overlay/_includes/queries/update-data.md
---
```sql
UPDATE series
SET series_info="Fake series updated"
WHERE
    series_id = 3
;
```