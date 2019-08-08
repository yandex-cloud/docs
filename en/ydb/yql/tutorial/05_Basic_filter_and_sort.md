# Basic filter and sort

Task: choose "IT Crowd" (series_id = 1) first three episodes from all seasons except first.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

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

It's also possible but not recommended to paginate over sorted result using "LIMIT N OFFSET M".