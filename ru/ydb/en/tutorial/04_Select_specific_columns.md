# Выборка данных из определенных колонок

Task:
1. Select columns: "series_id", "release_date" and "title";
2. Rename "title" to "series_title";
3. Convert "release_date" Uint64 into Date.


{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

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

