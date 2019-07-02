# Сортировка и фильтрация

Task: choose "IT Crowd" (series_id = 1) first three episodes from all seasons
except 1-st.

{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
$format = DateTime::Format("%Y-%m-%d");

SELECT
    series_id,
    season_id,
    episode_id,
    $format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(air_date AS Int16))) AS Uint32))) AS air_date,
    title
FROM episodes
WHERE
    series_id = 1             -- list of conditions for the row to remain in result
    AND season_id > 1         -- logical AND is used to build complex condition

ORDER BY                      -- used to sort results

    series_id,                -- ORDER BY clause can be followed by
    season_id,                -- list of fallback sorting criteria
    episode_id                -- separated by commas

LIMIT 3                       -- LIMIT N after ORDER BY
                              -- basically means "get Top N or Bottom N",
                              -- depending on sort order
;

COMMIT;
```

It's also possible but not recommended to paginate over sorted result using
"LIMIT N OFFSET M".