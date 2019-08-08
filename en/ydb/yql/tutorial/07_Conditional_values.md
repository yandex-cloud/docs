# Conditional values

Task: print all titles of episodes from the first season of every series, manually grouped by series title.

{% include [prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
SELECT
    series_title,               -- series_title is defined below in GROUP BY

    String::JoinFromList(       -- Foo::Bar(...) is a call of C++ UDF,
                                -- see section below about it

        AGGREGATE_LIST(title),  -- an aggregation function that
                                -- returns all passed values as list

        ", "                    -- String::JoinFromList concatenates
                                -- items of a list given as first
                                -- argument into a string, using
                                -- delimeter provided as second
                                -- argument
    ) AS episode_titles
FROM episodes
WHERE series_id IN (1,2)        -- IN returns values that match values
                                -- in a list or subquery.
                                -- Syntax:
                                -- test_expression ` NOT ` IN
                                -- ( subquery | expression ` ,...n ` )
                                -- If the value of test_expression is equal to
                                -- any value returned by subquery or is equal to
                                -- any expression from the comma-separated list,
                                -- the result value is TRUE; otherwise, the
                                -- result value is FALSE.
                                -- Using NOT IN negates the subquery value
                                -- or expression.
                                -- Warning: using null values in together with
                                -- IN or NOT IN can produce unexpected results.
AND season_id = 1
GROUP BY
    CASE                        -- CASE evaluates a list of conditions and
                                -- returns one of multiple possible result
                                -- expressions. CASE can be used in any
                                -- statement or clause that allows a valid
                                -- expression. For example, you can use CASE in
                                -- statements such as SELECT, UPDATE, DELETE,
                                -- and in clauses such as IN, WHERE, ORDER BY.
        WHEN series_id = 1
        THEN "IT Crowd"
        ELSE "Other serial"
    END AS series_title         -- GROUP BY can be performed on
                                -- arbitrary expression and its
                                -- result is available in SELECT
                                -- via alias specified with AS
;

COMMIT;
```