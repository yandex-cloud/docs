# Select specific columns

Task:
1. Select columns: "series_id", "release_date" and "title";
2. Rename "title" to "series_title";
3. Convert "release_date" Uint64 into Date.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
$format = DateTime::Format("%Y-%m-%d");

SELECT
    series_id,                  -- column names are listed instead of asterisk
                                -- with comma used as separator

    title AS series_title,      -- using AS keyword you can rename columns
                                -- or give a name to an arbitrary expression

                                -- Foo::Bar(...) is a call of C++ UDF,
                                -- see section below about it
    $format(DateTime::FromSeconds(CAST(DateTime::ToSeconds(DateTime::IntervalFromDays(CAST(release_date AS Int16))) AS Uint32))) AS release_date
FROM series;

COMMIT;
```

