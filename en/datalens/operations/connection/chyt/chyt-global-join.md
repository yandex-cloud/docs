---
title: Specifics of JOIN
description: In this article, you will learn how to use the JOIN operator and discover various JOIN query types in {{ CH }}.
---

# Specifics of JOIN

You can [join data](../../../dataset/create-dataset.md#links) through the dataset creation interface by dragging tables to the workspace and configuring links between them using the `JOIN` operator. For {{ ytsaurus-name }} tables, a join like this causes an error. It is due to the table storage structure and default query logic in {{ ytsaurus-name }}. To avoid the error, use an [SQL query to the source](../../../dataset/create-dataset.md#add-data).

## Storing table data {#table-data-storage}

The table storage schema in {{ ytsaurus-name }} differs from that in {{ CH }}:

* In {{ ytsaurus-name }}, the basic data storage primitive is a static table with rows grouped into chunks that are randomly distributed across a cluster. By default, the data is distributed across shards based on a sharding key. Static tables are highly inefficient for point data reads.

  {% note info %}

  In {{ CH }}, sharding ensures locality of rows with a single sharding expression value per VM.

  {% endnote %}

* {{ ytsaurus-name }} supports sorted tables: a table schema may factor in its row sorting by a column prefix. Columns like this are called key columns. This is a more efficient storage primitive: a dynamic table.

  {% note info %}

  In {{ ytsaurus-name }}, sorting ensures locality of rows with a single key value per chunk (or in a set of successive chunks).

  {% endnote %}

## Simple SELECT query in CHYT {#sql-select-query}

A SELECT query that does not contain the `JOIN` operator is basically a streaming query. It reads data from the only source and performs row processing. You can apply it to function and aggregation fields.

In CHYT, this query is implemented as follows:

1. A query is made to a clique instance. The instance is called a query coordinator, as it determines the subsequent execution plan.
1. The coordinator sends a rewritten query to each instance over the internal TCP. In this query, the input table name is replaced with an encoded sequence of `chunk slice`, where `chunk slice` is a certain range within a chunk. (The range is set using border row numbers or keys.)
1. Each instance executes the rewritten query and returns its result to the coordinator that performs its final aggregation (if required) and only then sends a response to the user.

## Types of queries using JOIN in {{ CH }} {#sql-join-query-ch}

Same as a simple query, a SELECT query that uses the `JOIN` operator is sent to a clique instance called a query coordinator. The query coordinator determines the further execution plan, and the load distribution between instances depends on how `lhs JOIN rhs USING/ON` is executed:

* In {{ CH }}, **distributed local JOIN** is executed by default. If tables are sharded in the same way, a matching pair of keys cannot end up on different VMs. Therefore, `lhs` and `rhs` are interpreted on each instance as corresponding local tables. In this case, the query that the coordinator splits in parts can be executed independently on each instance.

  {% note info %}

  This method requires that the tables use the same sharding scheme.

  {% endnote %}

* **GLOBAL JOIN** is executed if you use the `GLOBAL` keyword next to `JOIN`. The right-hand argument, `rhs`, is fully executed and materialized on the query coordinator. Next, its serialized representation is sent along with the query across the instances. They use this representation to retrieve the right-hand side in their memory. For more information, see the [documentation](https://clickhouse.com/docs/en/sql-reference/operators/in#distributed-subqueries).

  {% note info %}

  * This method is effective if `rhs` is relatively small and there are relatively few instances. Otherwise, you may face a shortage of resources when executing `rhs` on the coordinator or when the coordinator distributes a serialized representation with a subquery around the network.
  * This method does not require meeting any additional conditions for table data storage or sharding consistency.

  {% endnote %}

* **JOIN via subqueries**. {{ CH }} allows enclosing `lhs` and/or `rhs` in brackets, which significantly affects the execution plan:

  {% list tabs %}

  - Enclosing the LHS in brackets

    1. The LHS is executed independently on the coordinator.
    1. The RHS is executed independently.
    1. The RHS is placed in-memory in a hash table.
    1. `JOIN` is fully executed only on the coordinator.

  - Enclosing the RHS in brackets

    1. The LHS is executed independently on the coordinator as if the query looked just like a SELECT `lhs`.
    1. The coordinator sends its queries to instances leaving `JOIN` (`rhs`) as is.
    1. Each instance executes `rhs` independently.

       {% note info %}

       This may cause the load to increase significantly, since each instance will materialize the RHS on its own. Therefore, the {{ CH }} security mechanism disables this behavior by default. As a result, the `Double-distributed IN/JOIN subqueries is denied` error occurs.

       {% endnote %}

  {% endlist %}

## Specifics of queries using a JOIN in CHYT {#sql-join-query-yt}

When making a SELECT query that uses the `JOIN` operator in CHYT, the **Sorted JOIN** logic applies by default. It is based on the same column sorting. The standard `lhs JOIN rhs USING/ON` construct is used.

In this case, additional restrictions are imposed on `lhs` and `rhs`:

* The `lhs` and `rhs` parts must be sorted tables.
* The `USING/ON` clause must use sorted columns only.

Here is an example:

* Let's assume that `lhs` is sorted by the `l1, l2, ..., ln` columns, and `rhs`, by the `r1, r2, ..., rm` columns.
* The `JOIN` `ON` clause should look like a set of `l1 = r1 , ..., lk = rk` equations for a certain `k` (the equations can be listed in any order).
* This can be represented as a set of equations in the `ON` clause and as a set of general key columns in the `USING` statement, but not as a set of equations in the `WHERE` clause.

If these conditions are met, the query coordinator generates pairs of matching ranges from `lhs` and `rhs` and distributes them across the instances in subqueries.

Otherwise, an error is returned. In this case, you should either use `GLOBAL JOIN` or enclose `rhs` in a subquery.

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
