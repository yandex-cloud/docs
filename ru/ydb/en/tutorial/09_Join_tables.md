# Соединения таблиц с помощью JOIN

[JOIN](../../yql/reference/syntax/join.md) clause allows you to combine columns from multiple input tables in
a single resulting table.

Unless stated otherwise, rows are matched by equality of
the specified column values and the cartesian product is created if
multiple rows have the same value.


{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
SELECT
    sa.title AS season_title,    -- "sa" and "sr" here are so called
    sr.title AS series_title,    -- "correlation names", table aliases
    sr.series_id,                -- declared below with AS; they are used
    sa.season_id                 -- to resolve ambiguity of mentioned column
                                 -- names
FROM
    seasons AS sa
INNER JOIN
    series AS sr
ON sa.series_id = sr.series_id
WHERE sa.series_id = 1
ORDER BY                         -- used to sort results
    sr.series_id,
                                 -- ORDER BY clause can be followed by
                                 -- list of fallback sorting criteria
                                 -- separated by commas
    sa.season_id
;

COMMIT;
```

YQL implements common join types available in SQL plus some special ones:
* INNER JOIN — a result contains only rows where keys matched,
  the rest rows are discarded.
* LEFT/RIGHT JOIN — a result contains all rows from one table
  (left or right) and for other table empty value (NULL) is used
  to fill values where matching key was not found.
* FULL JOIN — like LEFT/RIGHT, but symmetrical; all key values from
  both tables are present with mismatches filled in with NULL on
  the opposite side.
* CROSS JOIN — just cartesian product of tables without key matching,
  the only join type that does not require ON/USING clause.
* LEFT/RIGHT SEMI JOIN — opposite side is used as key whitelist
  and is not available to be used in any other way. Unlike INNER JOIN
  that could be used in similar case, SEMI JOIN does not (!) create
  cartesian product and thus can be more efficient in some cases.
* LEFT/RIGHT ONLY JOIN — key sets subtraction, opposite side is used
  as key blacklist and like in SEMI JOIN is not otherwise available.
* EXCLUSION JOIN — leaves only keys that are available on any one side.
  This is logically equivalent to FULL JOIN minus INNER JOIN.

{% note info %}

It is possible to use the same table or subquery more than once in JOIN, which is often called "self-join". But self-join is not a special join type like those listed above.

{% endnote %}
