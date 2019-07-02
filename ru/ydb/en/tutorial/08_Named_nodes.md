# Именованные выражения

If there are lot of subqueries involved in the query, or if
some subquery is used multiple times — the query becomes hard to
read and maintain pretty fast.

It is recommended to use non-standard syntax supported by
YQL and demonstrated below. Basically it allows to store arbitrary
expression (including subquery) to the so called "named node" to be
used further in the query by name (starting with $ prefix).
Named nodes syntax resembles variable assignment, but they work more like
macros by expanding to last assigned value before execution.

Task: print all titles of episodes from 1-st season of every series,
manually grouped by series title using "named nodes" syntax.
The following query does exactly the same as the query in the
[7.&nbsp;Conditional values](07_Conditional_values.md) example.


{% note info %}

In the example we assume that you have created demo tables
on step [1.&nbsp;Create demo tables](01_Create_demo_tables.md) and populated them with the demo data
on step [2.&nbsp;Fill tables with data](02_Fill_tables_with_data.md).

{% endnote %}

```sql
$list_episode_titles = (                        -- define some expression
    String::JoinFromList(AGGREGATE_LIST(title), ", ") AS episode_titles
);

$series_filter = (
    series_id IN (1,2) AND season_id = 1
);

$series_title = (
    CASE
        WHEN series_id = 1
        THEN "IT Crowd"
        ELSE "Silicon Valley"
    END
);

SELECT
    series_title,
    $list_episode_titles
FROM episodes
WHERE $series_filter
GROUP BY
$series_title AS series_title
;

COMMIT;
```

As you can see, using named nodes is more verbose for simple case
like this one, but it still might be preferable because of being
self-documented.