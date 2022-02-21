---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/join.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/join.md
---

# JOIN

It lets you combine multiple data sources (subqueries or tables) by equality of values in the specified columns or expressions (the `JOIN` keys).

**Syntax**

```sql
SELECT ...    FROM table_1
-- The first JOIN step:
  <Join_Type> JOIN table_2 <Join_Condition>
  -- The left-hand selection -- entries in table_1
  -- The right-hand selection -- entries in table_2
-- The next JOIN step:
  <Join_Type> JOIN table_n <Join_Condition>
  -- The left-hand selection is the JOIN result in the previous step
  -- The right-hand selection are entries in table_n
-- JOIN can include the following steps
...
WHERE  ...
```

At each JOIN step, rules are used to establish correspondences between rows in the left-hand and right-hand data selections, creating a new selection that includes every combination of rows that meet the JOIN conditions.

{% note warning %}

Since columns in YQL are identified by their names, and you can't have two columns with the same name in the selection, `SELECT * FROM ... JOIN ...` can't be executed if there are columns with identical names in the joined tables.

{% endnote %}

## Types of join (Join_Type)

* `INNER` <span style="color: gray;">(default)</span>: Rows from the joined selections that match no row on the other side won't be included in the result.
* `LEFT`: If there's no value in the right-hand selection, it adds a row to the result with column values from the left-hand selection, using `NULL` in columns from the right-hand selection
* `RIGHT`: If there's no value in the left-hand selection, it adds the row to the result, including column values from the right-hand selection, but using `NULL` in columns from the left-hand selection
* `FULL` = `LEFT` + `RIGHT`
* `LEFT/RIGHT SEMI`: One side of the query is a whitelist of keys, its values are not available. The result includes columns from one table only, no cartesian product is created.
* `LEFT/RIGHT ONLY`: Subtracting the sets by keys (blacklist). It's almost equivalent to adding `IS NULL` to the key on the opposite side in the regular `LEFT/RIGHT JOIN`, but with no access to values, same as in `SEMI` JOIN.
* `CROSS`: A full cartesian product of two tables without specifying key columns and no explicit `ON/USING`.
* `EXCLUSION`: Both sides minus the intersection.

![](../_assets/join-YQL-06.png)

{% note info %}

`NULL` is a special value to denote nothing. Hence, `NULL` values on both sides are **NOT** treated as equal to each other. This eliminates ambiguity in some types of `JOIN` and avoids a giant Cartesian product otherwise created.

{% endnote %}

## Conditions for joining (Join_Condition)

For `CROSS JOIN`, no join condition is specified. The result includes the Cartesian product of the left-hand and right-hand selection, that is, combines everything with everything. The number of rows in the result selection is the product of the number of rows in the left-hand and right-hand selections.

For any other JOIN types, specify the condition using one of the two methods:

1. `USING (column_name)`. Used if both the left-hand and right-hand selections share a column whose equality of values is a join condition.
2. `ON (equality_conditions)`. Lets you set a condition of equality for column values or expressions over columns in the left-hand and right-hand selections or use several such conditions combined by `and`.

**Examples:**

```sql
SELECT    a.value as a_value, b.value as b_value
FROM      a_table AS a
FULL JOIN b_table AS b USING (key);
```

```sql
SELECT    a.value as a_value, b.value as b_value
FROM      a_table AS a
FULL JOIN b_table AS b ON a.key = b.key;
```

```sql
SELECT     a.value as a_value, b.value as b_value, c.column2
FROM       a_table AS a
CROSS JOIN b_table AS b
LEFT  JOIN c_table AS c ON c.ref = a.key and c.column1 = b.value;
```


