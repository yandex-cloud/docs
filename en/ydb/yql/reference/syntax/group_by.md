---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# GROUP BY

Group the `SELECT` results by the values of the specified columns or expressions. The [aggregate functions](../builtins/aggregation.md) (`COUNT`, `MAX`, `MIN`, `SUM`, `AVG`) are often used together with `GROUP BY` to perform calculations in each group.

**Syntax**

```sql
SELECT                               -- columns that are not used in AGGREGATE_FUNCTION
    column1, column2, ... column_n   -- and must be included into GROUP BY

AGGREGATE_FUNCTION                   -- the function COUNT, SUM, MAX, MIN, SUM, or AVG        
    (aggregate_column)               -- argument of the aggregate function

FROM table

GROUP by                             -- if you group by an expression, set the expression name
    column1, column2, ... column_n   -- using AS inside GROUP BY,
                                     -- and then use this name inside SELECT
```

{% note info %}

By default, the aggregate functions don't account for `NULL` in their arguments.

{% endnote %}

YQL also supports factories of aggregate functions implemented using the [`AGGREGATION_FACTORY`](../builtins/basic.md#aggregationfactory) and [`AGGREGATE_BY`](../builtins/aggregation.md#aggregateby) functions.

**Examples**

```sql
SELECT key, COUNT(*) FROM my_table
GROUP BY key;
```

```sql
SELECT double_key, COUNT(*) FROM my_table
GROUP BY key + key AS double_key;
```

## ROLLUP, CUBE, and GROUPING SETS {#rollup-cube-group-sets}

The results of calculating the aggregate function as subtotals for the groups and overall totals over individual columns or whole table.

**Syntax**

```sql
SELECT 
    c1, c2, -- the columns to group by

AGGREGATE_FUNCTION(c3) AS outcome_c  -- an aggregate function (SUM, AVG, MIN, MAX, COUNT)

FROM table_name

GROUP BY
    GROUP_BY_EXTENSION(c1, c2)       -- an extension of GROUP BY: ROLLUP, CUBE, or GROUPING SETS
```

* `ROLLUP` groups the column values in the order they are listed in the arguments (strictly from left to right), generates subtotals for each group and the overall total.
* `CUBE` groups the values for every possible combination of columns, generates the subtotals for each group and the overall total.
* `GROUPING SETS` sets the groups for subtotals.

`You can combine ROLLUP`, `CUBE` and `GROUPING SETS`, separating them by commas.

### GROUPING {#grouping}

The values of columns not used in calculations are replaced with `NULL` in the subtotal. In the overall total, the values of all columns are replaced by `NULL`. `GROUPING`: A function that allows you to distinguish the source `NULL` values from the `NULL` values added while calculating subtotals and overall totals.

`GROUPING` returns a bit mask:

* `0`: If `NULL` is used for the original empty value.
* `1`: If `NULL` is added for a subtotal or overall total.

**Example**

```sql
SELECT
    column1,
    column2,
    column3,

    CASE GROUPING(
        column1,
        column2,
        column3,
    )
        WHEN 1  THEN "Subtotal: column1 and column2"
        WHEN 3  THEN "Subtotal: column1"
        WHEN 4  THEN "Subtotal: column2 and column3"
        WHEN 6  THEN "Subtotal: column3"
        WHEN 7  THEN "Grand total"
        ELSE         "Individual group"
    END AS subtotal,

    COUNT(*) AS rows_count

FROM my_table

GROUP BY
    ROLLUP(
        column1,
        column2,
        column3
    ),
    GROUPING SETS(
        (column2, column3),
        (column3)
        -- if you add here (column2) as well, then together
        -- those ROLLUP and GROUPING SETS would produce the result
        -- similar to CUBE
    )
;
```

## DISTINCT {#distinct}

Applying [aggregate functions](../builtins/aggregation.md) only to distinct values of the column.

{% note info %}

Applying `DISTINCT` to calculated values is not currently implemented. For this purpose, use a [subquery](select.md#from) or the clause `GROUP BY ... AS ...`.

{% endnote %}

**Example**

```sql
SELECT
  key,
  COUNT (DISTINCT value) AS count -- top 3 keys by the number of unique values
FROM my_table
GROUP BY key
ORDER BY count DESC
LIMIT 3;
```

You can also use `DISTINCT` to fetch unique rows using [`SELECT DISTINCT`](select.md#distinct).

## HAVING {#having}

Filtering a `SELECT` based on the [aggregate function](../builtins/aggregation.md) calculation results. The syntax is similar to the [`WHERE`](select.md#where) clause.

**Example**

```sql
SELECT
    key
FROM my_table
GROUP BY key
HAVING COUNT(value) > 100;
```

