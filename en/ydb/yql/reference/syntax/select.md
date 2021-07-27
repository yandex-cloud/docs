---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# SELECT

Returns a set of data from {{ ydb-short-name }}.

**Examples**

```sql
SELECT "Hello, world!";
```

```sql
SELECT 2 + 2;
```

## FROM {#from}

Data source for `SELECT`. The argument can accept the table name, the result of another `SELECT`, or a [named expression](expressions.md#named-nodes). Between `SELECT` and `FROM`, list the comma-separated column names from the source (or `*` to select all columns).

**Examples**

```sql
SELECT key FROM my_table;
```

```sql
SELECT * FROM
  (SELECT value FROM my_table);
```

```sql
$table_name = "my_table";
SELECT * FROM $table_name;
```

## WHERE {#where}

Filtering rows in the `SELECT`  result based on a condition.

**Example**

```sql
SELECT key FROM my_table
WHERE value > 0;
```

## ORDER BY {#order-by}

Sorting the `SELECT` result:

- `ASC`: Sorting in the ascending order. Applied by default.
- `DESC`: Sorting in the descending order.

Multiple sorting criteria will be applied left-to-right.

{% note info %}

Without `ORDER BY`, the `SELECT FROM` query returns unsorted data and doesn't save the order from the source table. In the [subqueries](#from), you can only use `ORDER BY` with [`LIMIT`](#limit-offset).

{% endnote %}

**Example**

```sql
SELECT key, string_column
FROM my_table
ORDER BY key DESC, LENGTH(string_column) ASC;
```

You can also use `ORDER BY` to enable sort in [window functions](../builtins/window.md).

## LIMIT and OFFSET {#limit-offset}

`LIMIT` limits the output to the specified number of rows. By default, the output is not restricted.

`OFFSET`: specifies the offset from the beginning (in rows). By default, it's zero.

**Examples**

```sql
SELECT key FROM my_table
LIMIT 7;
```

```sql
SELECT key FROM my_table
LIMIT 7 OFFSET 3;
```

```sql
SELECT key FROM my_table
LIMIT 3, 7; -- equivalent to the previous example
```

## DISTINCT {#distinct}

Selecting unique rows.

{% note info %}

Applying `DISTINCT` to calculated values is not currently implemented. For this purpose, use a subquery or the clause [`GROUP BY ... AS ...`](group_by.md).

{% endnote %}

**Example**

```sql
SELECT DISTINCT value -- only unique values from the table
FROM my_table;
```

`DISTINCT` can also be used to apply [aggregate functions](../builtins/aggregation.md) to unique values only. Read more in the section [{#T}](group_by.md).

## UNION ALL {#union-all}

Concatenation of the results of multiple `SELECT` statements.

**Example**

```sql
SELECT 1 AS x
UNION ALL
SELECT 2 AS y
UNION ALL
SELECT 3 AS z;
```

## WITHOUT {#without-select}

Excluding columns from the result of `SELECT *`.

**Examples**

```sql
SELECT * WITHOUT foo, bar FROM my_table;
```

```sql
PRAGMA simplecolumns;
SELECT * WITHOUT t.foo FROM my_table AS t
CROSS JOIN (SELECT 1 AS foo) AS v;
```

## FROM ... SELECT ... {#from-select}

An inverted format, first specifying the data source and then the operation.

**Examples**

```sql
FROM my_table SELECT key, value;
```

```sql
FROM a_table AS a
JOIN b_table AS b
USING (key)
SELECT *;
```

## SELECT by secondary index {#si-select}

{% include [select_by_secondary_index](../../../_includes/select-by-secondary-index.md) %}

## FROM AS_TABLE {#as-table}

Accessing named expressions as tables using the `AS_TABLE` function.

`AS_TABLE($variable)` lets you use the value of `$variable` as the data source for the query. In this case, the variable `$variable` must have the type `List>>`.

**Example**

```sql
$data = AsList(
    AsStruct(1u AS Key, "v1" AS Value),
    AsStruct(2u AS Key, "v2" AS Value),
    AsStruct(3u AS Key, "v3" AS Value));

SELECT Key, Value FROM AS_TABLE($data);
```

