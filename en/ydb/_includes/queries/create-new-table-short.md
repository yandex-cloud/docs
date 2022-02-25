---
sourcePath: en/ydb/overlay/_includes/queries/create-new-table-short.md
---
```sql
CREATE TABLE series
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    PRIMARY KEY (series_id)
);
```