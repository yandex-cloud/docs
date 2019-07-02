# Агрегирование данных

Task: calculate the number of unique episodes within every
season of every series.


{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
SELECT
    series_id,
    season_id,
    COUNT(*) AS cnt     -- aggregation function COUNT returns the number of rows
                        -- returned by the query.
                        -- Asterisk (*) specifies that COUNT should count all
                        -- rows to determine the total table row count to
                        -- return. COUNT(*) returns the number of rows in
                        -- a specified table, and it preserves duplicate rows.
                        -- It counts each row separately.
                        -- This includes rows that contain null values.
FROM episodes
GROUP BY
    series_id,          -- results will be grouped by these columns;
    season_id           -- you can specify several columns separated with comma;
                        -- other columns can be used after SELECT only if
                        -- they are passed to aggregation function
ORDER BY
    series_id,
    season_id
;

COMMIT;
```