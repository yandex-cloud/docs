---
title: Sharding in {{ mch-full-name }}
description: This article explains what sharding is and how to manage it in {{ mch-name }} and describes the benefits and use cases of sharding.
---

# Sharding in {{ mch-name }}

_Sharding_ in {{ CH }} is a horizontal cluster scaling strategy that splits data into a number of logical parts called _shards_. Each shard can consist of a single host or multiple [replica hosts](replication.md).

Advantages of sharding:
* Horizontal scaling enables you to bypass the limits of a single server in terms of CPU, RAM, disk space, and I/O throughput.
* Parallel query execution, where you run queries against the same logical table across different shards, allows you to balance the load, reduce resource contention, and accelerate read and write operations.

## Sharding specifics in {{ mch-name }} {#uses}

To implement distributed storage of table data in {{ mch-name }}, you need to create:
1. Identical _local tables_ on the [MergeTree family engine]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family) across multiple cluster shards.
1. _Distributed table_ on the [Distributed engine]({{ ch.docs }}{{ lang }}/engines/table-engines/special/distributed) that uses these shards.

Each local table stores some of the rows from the distributed dataset. The distributed table routes queries to the local tables but stores no data.

The distribution of table data across shards is determined by the _sharding key_ and the [shard weight](#shard-weight). During an `INSERT` query, the distributed table calculates the sharding key value and, considering the weight of each shard, routes the query to the relevant local table. The sharding key is defined when creating the distributed table. Examples of sharding keys include table fields, calculated expressions, and random distribution functions.

Choosing the right sharding key is important because it controls:
* How evenly your data is distributed across shards.
* How efficient queries are.

{% note info %}

Unlike `INSERT`, `SELECT` queries target all cluster shards regardless of the sharding key. To change this behavior, use the `optimize_skip_unused_shards` setting.

{% endnote %}

You can distribute table data across all cluster shards or a [shard group](../operations/shard-groups.md). A shard group may include both cluster shards and [external shards](#external-shards). You can create a distributed table either for all cluster shards or a specific shard group.

For examples of different sharding methods, see [{#T}](../tutorials/sharding.md).

## External shards {#external-shards}

You can add new shards of external {{ CH }} clusters (so called _external shards_) to shard groups of your {{ mch-name }} cluster. You can use such shards to solve the following tasks:

* Running distributed queries to an external cluster. To do this, create a shard group and consisting only of external shards.
* Running distributed queries to the local and external clusters simultaneously. To do this, create a shard group and consisting of local and external shards.

When running `INSERT` and `SELECT` queries to a distributed table, external shards take part in query processing under the same rules as local cluster shards.

For a shard group with external shards, DDL queries are not supported.

You can add external shards when [creating](../operations/shard-groups.md#create-shard-group) or [updating](../operations/shard-groups.md#update-shard-group) a shard group.

## Shard weight {#shard-weight}

If shards with different weights are involved in the distribution, data is distributed among them in proportion to their weights. To determine what portion of the added rows will end up on a given shard, the shard's weight is divided by the total weight of all shards. For example, if one shard has a weight of `100` and another has a weight of `300`, then 1/4 of all added rows will be sent to the first shard, and 3/4 to the second. Thus, the greater the weight of a shard, the more data it will contain.

You can set the weight of a local shard when [creating](../operations/shards.md#add-shard) or [modifying](../operations/shards.md#shard-update1) the shard, and the weight of an external shard when [creating](../operations/shard-groups.md#create-shard-group) or [modifying](../operations/shard-groups.md#update-shard-group) a shard group.

## Sharding management in {{ mch-name }} {#shard-management}

In {{ mch-name }}, you can create a sharded cluster or enable sharding for an existing cluster.

When you create a non-sharded cluster, the system automatically adds a single shard containing all cluster hosts. To enable sharding for an existing cluster, you need to add at least one more shard.

New sharded clusters can have two or more shards from the start. You can also add more shards to an existing sharded cluster.


{% note info %}

You cannot delete a host from a shard if the [limit for the minimum number of hosts](../concepts/limits.md#mch-limits) has been reached.

{% endnote %}

## Replication in a sharded {{ mch-name }} cluster {#sharding-replication}

In a sharded {{ mch-name }} cluster, [replication](replication.md) is restricted to individual shards, not the entire cluster:
* Each shard stores its own portion of the data.
* All replicas within a single shard hold identical copies of that data portion.
* There is no cross-replication of data between different shards.

In clusters with the [coordination service](coordination-system.md) enabled, replication is activated automatically when you create a shard with two or more hosts.

{% note info %}

You cannot create a shard with two or more hosts in clusters where the coordination service is disabled.

{% endnote %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
