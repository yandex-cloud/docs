---
title: JOIN in {{ datalens-full-name }}
description: This article covers some aspects of using the JOIN operator in {{ datalens-full-name }} and gives introductory info on JOIN query types in {{ CH }}.
---

# JOIN in {{ datalens-full-name }}

You can [join data](../../../dataset/create-dataset.md#links) via the dataset creation interface by dragging tables to the workspace and configuring links between them using the `JOIN` operator. For {{ ytsaurus-name }} tables, a join like this causes an error due to the table storage structure and default query logic in {{ ytsaurus-name }}. To avoid this error, use an [SQL query to the source](../../../dataset/create-dataset.md#add-data).

## Storing table data {#table-data-storage}

The table storage schema in {{ ytsaurus-name }} fundamentally differs from that in {{ CH }}:

* In {{ ytsaurus-name }}, the basic data storage primitive is a static table with rows grouped into chunks that are randomly distributed across a cluster. By default, the data is distributed across shards based on a sharding key. Static tables are highly inefficient for point data reads.

  {% note info %}

  In {{ CH }}, sharding ensures locality of rows with a single sharding expression value per VM.

  {% endnote %}

* {{ ytsaurus-name }} supports sorted tables: a table schema may factor in its row sorting by a column prefix. These columns are called key columns. This is a more efficient storage primitive: a dynamic table.

  {% note info %}

  In {{ ytsaurus-name }}, sorting ensures locality of rows with a single key value per chunk (or in a set of successive chunks).

  {% endnote %}

## Simple SELECT query in CHYT {#sql-select-query}

A SELECT query without a `JOIN` is basically a streaming query. It reads data from a single source and performs row processing. You can apply it to function and aggregation fields.

In CHYT, this query is implemented as follows:

1. A clique instance gets a query. The instance is called the query coordinator, as it determines the subsequent execution plan.
1. The coordinator sends an rewritten query to each instance over the internal TCP. In this query, the input table name is replaced with an encoded sequence of `chunk slice`, where `chunk slice` is a certain range within a chunk. (The range is set using border row numbers or keys.)
1. Each instance runs the rewritten query and returns its result to the coordinator for its final aggregation (if required) and for sending a response to the user.

## Types of queries with a JOIN in {{ CH }} {#sql-join-query-ch}

Same as a simple query, a SELECT query with a `JOIN` is sent to a clique instance called the query coordinator. The query coordinator determines the execution plan, while the load distribution between instances depends on how `lhs JOIN rhs USING/ON` is run:

* In {{ CH }}, a **distributed local JOIN** is run by default. If tables are sharded in the same way, a pair of matching keys cannot end up on different VMs. Therefore, `lhs` and `rhs` are interpreted on each instance as corresponding local tables. In this case, the query the coordinator rewrites into fragments can be run independently on each instance.

  {% note info %}

  For this method, tables must have the same sharding schema.

  {% endnote %}

* A **GLOBAL JOIN** is executed if you use the `GLOBAL` keyword with `JOIN`. The query coordinator fully executes and materializes the right-hand side, `rhs`. Next, its serialized representation is sent along with the query to the instances. They use this representation to retrieve the right-hand side in their memory. For more information, see [this guide](https://clickhouse.com/docs/en/sql-reference/operators/in#distributed-subqueries).

  {% note info %}

  * This method is efficient if `rhs` is relatively small and there are relatively few instances. Otherwise, you may lack resources when running `rhs` on the coordinator or when the coordinator sends a serialized representation with a subquery across the network.
  * This method does not require meeting any additional conditions for table data storage or sharding consistency.

  {% endnote %}

* **JOIN via subqueries**: {{ CH }} allows enclosing `lhs` and/or `rhs` in brackets, which significantly affects the execution plan:

  {% list tabs %}

  - Enclosing `lhs` in brackets

    1. The coordinator executes the LHS independently.
    1. The RHS is executed independently.
    1. The RHS is placed in-memory in a hash table.
    1. A `JOIN` is only fully executed on the coordinator.

  - Enclosing `rhs` in brackets

    1. The coordinator executes the LHS independently as if the query is SELECT `lhs`.
    1. The coordinator sends its queries to instances leaving `JOIN` (`rhs`) as is.
    1. Each instance executes `rhs` independently.

       {% note info %}

       This may significantly increase the load, since each instance will materialize the RHS independently. Therefore, the {{ CH }} security algorithm prohibits this behavior by default returning the `Double-distributed IN/JOIN subqueries is denied` error.

       {% endnote %}

  {% endlist %}

## Features of queries with a JOIN in CHYT {#sql-join-query-yt}

A SELECT query with a `JOIN` in CHYT runs as a **Sorted JOIN** by default. It uses the same column sorting schema. The standard `lhs JOIN rhs USING/ON` statement is used.

In this case, additional restrictions are imposed on `lhs` and `rhs`:

* The `lhs` and `rhs` must be sorted tables.
* The `USING/ON` clause must only use sorted columns.

For example:

* Let's assume that `lhs` is sorted by the `l1, l2, ..., ln` columns, and `rhs`, by the `r1, r2, ..., rm` columns.
* The `JOIN` `ON` clause should look like a set of `l1 = r1 , ..., lk = rk` equations for a certain `k` (the equations can be listed in any order).
* This can be represented as a set of equations in the `ON` clause and as a set of general key columns in the `USING` statement, but not as a set of equations in the `WHERE` clause.

If these conditions are met, the query coordinator generates pairs of matching ranges from `lhs` and `rhs` and distributes them across the instances in subqueries.

Otherwise, an error is returned. In this case, you should either use `GLOBAL JOIN` or enclose `rhs` in a subquery.

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
