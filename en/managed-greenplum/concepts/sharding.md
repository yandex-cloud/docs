---
title: Data distribution in {{ mgp-name }}
description: This guide provides an overview of data distribution policies and best practices for choosing a distribution policy and key in {{ mgp-full-name }}.
---

# Data distribution in {{ mgp-name }}

In {{ mgp-name }}, all database tables are distributed row by row across the cluster's [segment hosts](index.md#architecture-segment). A _data distribution policy_ is a rule that defines how rows are distributed across segments.

{{ mgp-name }} supports the following distribution policies:

* Hash distribution: Rows are distributed across segments based on a hash function applied to the values of one or more columns defined as the [distribution key](#distribution-key).
* Random distribution: Rows are distributed across all segments in a round-robin fashion.
* Replicated distribution: A table copy is stored on each segment within the cluster.

You can [define a distribution policy](../operations/distribution-policy-management.md#set-distribution-policy) for a new table, as well as [modify the distribution policy and key](../operations/distribution-policy-management.md#change-distribution-policy) for an existing table. If you do not specify a distribution policy when creating a table, hash distribution is used. The `PRIMARY KEY` is used as the distribution key. If no primary key is defined, the first eligible column in the table is selected. For more on how the distribution key is selected when no policy is specified, see [this {{ GP }} reference]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-sql_commands-CREATE_TABLE.html) and [this {{ CB }} guide]({{ gp.docs.cloudberry }}/sql-stmts/create-table/).


## Choosing a distribution policy {#choice-distribution-policy}

In {{ mgp-name }}, query performance depends on how data is distributed across the cluster's segments. If data distribution is uneven, segments will process unequal amounts of data. This can lead to imbalanced workloads and memory shortages on individual segments. `JOIN` operations also affect query performance. If tables use the same distribution key, rows with identical key values are stored on the same segment. This allows join operations to run locally, without transferring data between segments.

To distribute workloads evenly across segments, use the following rules when choosing a distribution policy:

* Hash distribution: choose this policy if you can find a valid [distribution key](#distribution-key) for the table.
* Random distribution: use this strategy if no valid distribution key is available.
  
  With random distribution, individual `INSERT` and `COPY` operations may lead to data skew across segments. Additionally, tables with random distribution do not support local joins.

* Replicated distribution: use for small tables, such as dictionaries.


## Distribution key {#distribution-key}

A distribution key consists of one or more table columns whose values are used to assign rows to segments. Your [choice of the distribution key](#distribution-key-selection) controls how evenly your data is distributed across segments.


### Choosing a distribution key {#distribution-key-selection}

Select columns that are frequently used in JOIN operations as your distribution key. If the table has a primary key, the latter must include all columns of the distribution key. Similarly, if the table has a unique constraint, it must include all columns of the distribution key.

When choosing a distribution key, avoid columns that may lead to uneven data distribution:

* Date and time columns.
* Columns with multiple identical values.
* Columns with a large number of `NULL` values.
* Columns used in `WHERE` clauses.

Columns with geometric and custom data types cannot be used as a distribution key.

If a single column is not enough to distribute your data evenly, use a composite key consisting of two columns. Using a key of three or more columns does not improve data distribution balance, but only increases hashing time.

For more information, see [this {{ GP }} guide]({{ gp.docs.broadcom }}/6/greenplum-database/admin_guide-distribution.html) and [this {{ CB }} article]({{ gp.docs.cloudberry }}/performance/distribution-and-skew/).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../_includes/mdb/mgp/trademark-cloudberry.md) %}
