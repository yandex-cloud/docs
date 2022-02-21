---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/expressions/tables.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/expressions/tables.md
---

## Table expressions {#table-contexts}

A table expression is an expression that returns a table. Table expressions in YQL are as follows:
* Subqueries: `(SELECT key, subkey FROM T)`
* [Named subqueries](#named-nodes): `$foo = SELECT * FROM T;` (in this case, `$foo` is also a table expression)

Semantics of a table expression depends on the context where it is used. In YQL, table expressions can be used in the following contexts:
* Table context: after [FROM](../../select.md#from).
In this case, table expressions work as expected: for example, `$input = SELECT a, b, c FROM T; SELECT * FROM $input` returns a table with three columns.
The table context also occurs after [UNION ALL](../../select.md#unionall), [JOIN](../../join.md#join);
* Vector context: after [IN](#in). In this context, the table expression must contain exactly one column (the name of this column doesn't affect the expression result in any way).
A table expression in a vector context is typed as a list (the type of the list element is the same as the column type in this case). Example: `SELECT * FROM T WHERE key IN (SELECT k FROM T1)`;
* A scalar context arises _in all the other cases_. As in a vector context,
a table expression must contain exactly one column, but the value of the table expression is a scalar,
that is, an arbitrarily selected value of this column (if no rows are returned, the result is `NULL`). Example: `$count = SELECT COUNT(*) FROM T; SELECT * FROM T ORDER BY key LIMIT $count / 2`;

The order of rows in a table context, the order of elements in a vector context, and the rule for selecting a value from a scalar context (if multiple values are returned), aren't defined. This order also cannot be affected by `ORDER BY`: `ORDER BY` without `LIMIT` is ignored in table expressions with a warning, and `ORDER BY` with `LIMIT` defines a set of elements rather than the order within that set.

