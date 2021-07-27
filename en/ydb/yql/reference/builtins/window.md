---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Window functions in YQL

## Aggregate functions {#aggregate-functions}

All the [aggregate functions](aggregation.md) can also be used as window functions. In this case, the aggregation result on each row is applied to the current window position **(by default, from the start of the partition to the current row, inclusive)**.

**Examples**

```sql
SELECT
    SUM(int_column) OVER w AS running_total
FROM my_table
WINDOW w AS ();
```

## ROW_NUMBER {#row_number}

Row number inside the partition. No arguments.

**Examples**

```sql
SELECT
    ROW_NUMBER() OVER w AS row_num
FROM my_table
WINDOW w AS ();
```

## LAG / LEAD {#lag-lead}

Accessing a value from the row that's behind (`LAG`) or ahead (`LEAD`) of the current row by a fixed number. The first argument specifies the expression to be accessed, and the second argument specifies the offset in rows. You may omit the offset. By default, the neighbor row is used: the previous or next, respectively (hence, 1 is assumed by default). In the rows that don't have neighbors at the specified distance (for example, `LAG(expr, 3)` in the first and second rows of the window), the expression value is `NULL`.

**Examples**

```sql
SELECT
   int_value - LAG(int_value) OVER w AS int_value_diff
FROM my_table
WINDOW w AS ();
```

## FIRST_VALUE / LAST_VALUE {#first-last-value}

Access values from the first and last rows of the window. The only argument is the expression that you need to access.

Optionally, `OVER` can be preceded by an additional modifier `IGNORE NULLS`. It changes the behavior of functions to the first or last __non-empty__ (i.e., non-`NULL`) value among the window rows. The antonym of this modifier is `RESPECT NULLS`: it's the default behavior that can be omitted.

**Examples**

```sql
SELECT
   LAST_VALUE(my_column) IGNORE NULLS OVER w
FROM my_table
WINDOW w AS ();
```

## RANK / DENSE_RANK {#rank}

Number the groups of neighboring rows having the same expression value in the argument. `DENSE_RANK` numbers the groups one-by-one, and `RANK` skips `(N - 1)` values, with `N` being the number of rows in the previous group.

If there is no argument, it uses the order specified in the ORDER BY section.

**Examples**

```sql
SELECT
   RANK(my_column) OVER w
FROM my_table
WINDOW w AS ();
```

```sql
SELECT
   RANK() OVER w
FROM my_table
WINDOW w AS (ORDER BY my_column);
```

