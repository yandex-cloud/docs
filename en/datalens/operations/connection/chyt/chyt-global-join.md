# Specifics of JOIN

You can [join data](../../dataset/join-data.md) through the dataset creation interface by dragging tables to the workspace and configuring links between them using the `JOIN` operator. For {{ ytsaurus-name }} tables, a join like this causes an error. It is due to table storage structure and the default query logic in {{ ytsaurus-name }}.

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

A SELECT with no `JOIN` is basically a streaming query. It reads data from the only source and performs row processing. You can apply it to function and aggregation fields.

In CHYT, this query is implemented as follows:

1. A query is made to a clique instance. The instance is called a query coordinator, as it determines the subsequent execution plan.
1. The coordinator sends a rewritten query to each instance over the internal TCP. In this query, the input table name is replaced with an encoded sequence of `chunk slices`, where a `chunk slice` is a certain range within a chunk. (The range is set using border row numbers or keys.)
1. Each instance executes the rewritten query and returns its result to the coordinator that performs its final aggregation (if required) and only then sends a response to the user.

## Types of queries using JOIN in {{ CH }} {#sql-join-query-ch}

Like a simple query, a SELECT that uses a `JOIN` is sent to a clique instance that is also called a query coordinator. It determines the subsequent query execution plan, while the load distribution across instances depends on how `lhs JOIN rhs USING/ON` is executed:

* A **distributed local JOIN** is run in {{ CH }} by default. If tables are sharded in the same way, a matching key pair may not be on different VMs. Therefore, the `lhs` and `rhs` are interpreted on each instance as respective local tables. In this case, the query that the coordinator splits in parts can be executed independently on each instance.

   {% note info %}

   This method requires that the tables use the same sharding scheme.

   {% endnote %}

* A **GLOBAL JOIN** is executed if you add the `GLOBAL` keyword to a `JOIN`. The right-hand argument, `rhs`, is fully executed and materialized in the coordinator. Next, its serialized representation is sent along with the query across the instances. They use this representation to retrieve the right-hand side in their memory.

   {% note info %}

   * This method is efficient if the `rhs` is relatively small and there are relatively few instances. Otherwise, there may be a shortage of resources when the coordinator is executing the `rhs` or sending the query's serialized representation with a subquery across the network.
   * This method does not require meeting any additional conditions for table data storage or sharding consistency.

   {% endnote %}

* **JOIN via subqueries**. {{ CH }} allows enclosing the `lhs` and/or `rhs` in brackets, which significantly affects the execution plan:

   {% list tabs %}

   - Enclosing the LHS in brackets

      1. The LHS is executed independently in the coordinator.
      1. The RHS is executed independently.
      1. The RHS is placed in-memory in a hash table.
      1. A `JOIN` is fully executed in the coordinator only.

   - Enclosing the RHS in brackets

      1. The LHS is executed independently in the coordinator as if the query looked just like a SELECT `lhs`.
      1. The coordinator sends its queries to instances leaving a `JOIN` (`rhs`) as is.
      1. Each instance executes the `rhs` independently.

         {% note info %}

         This may cause the load to increase significantly, since each instance will materialize the RHS on its own. Therefore, the {{ CH }} security mechanism disables this behavior by default. As a result, the `Double-distributed IN/JOIN subqueries is denied` error occurs.

         {% endnote %}

   {% endlist %}

## Specifics of queries using a JOIN in CHYT {#sql-join-query-yt}

When making a SELECT query that uses a `JOIN` in CHYT, the **Sorted JOIN** logic applies by default. It is based on the same column sorting. A regular `lhs JOIN rhs USING/ON` is used.

In this case, additional restrictions are imposed on the `LHS` and `RHS`:

* The `lhs` and `rhs` must be sorted tables.
* The `USING/ON` clause must use sorted columns only.

For example:

* Let's assume that the `lhs` is sorted by columns `l1, l2, ..., ln` and the `rhs`, by columns `r1, r2, ..., rm`.
* The `JOIN` `ON` clause should look like a set of `l1 = r1 , ..., lk = rk` equations for a `k` (the equations can be listed in any order).
* This can be represented as a set of equations in the `ON` clause and as a set of general key columns in the `USING` statement, but not as a set of equations in the `WHERE` clause.

If these conditions are met, the query coordinator generates pairs of matching ranges from the `lhs` and `rhs` and distributes them across the instances in subqueries.

Otherwise, an error is returned. In this case, you should either use a `GLOBAL JOIN` or enclose the `rhs` in a subquery.

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
