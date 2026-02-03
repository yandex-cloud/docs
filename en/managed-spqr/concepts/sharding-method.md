---
title: Selecting a sharding strategy
description: The choice a sharding strategy depends on your data structure. {{ SPQR }} enables you to test the selected strategy in shadow mode and rebalance data on a running system.
keywords:
  - keyword: SPQR sharding methods
  - keyword: SPQR sharding strategy
---

# Selecting a sharding strategy

{{ SPQR }} is a system for horizontal {{ PG }} scaling through [sharding](sharding.md). A sharded system will be a reasonable choice in the following scenarios:

* At the early stage, the database will take up 2 TB or more.
* At the early stage, the write load will exceed 5,000 records per second (write RPS).
* Load and data volume growth will exceed the capacity of a single {{ PG }} node in less than ten years.

The choice of a [sharding strategy](sharding-keys.md#sharding-strategies) depends on your data structure:

* Use the [range strategy](https://docs.pg-sharding.tech/sharding/ranged) if your data and queries are naturally or logically grouped by time, geographic region, or ID range. The strategy allows [data rebalancing](#data-rebalancing) and is preferred in most cases.
* Use the [hash strategy](https://docs.pg-sharding.tech/sharding/hashed) if your data lacks natural or logical grouping or requires even distribution across shards at the early stage.

To change the strategy after the system is up and running, you will have to redistribute your data across shards, so we recommend [testing your strategy](#shadow-mode) before you deploy it.

## Testing a sharding strategy {#shadow-mode}

{{ SPQR }} supports shadow mode to record and simulate the database load. In this mode, the router intercepts and records all SQL queries to a non-sharded database. Next, these queries are simulated on a sharded test database in order to:

* Evaluate query performance.
* Detect queries without a [sharding key](sharding-keys.md).
* Test the selected strategy under real load.

## Architecture requirements {#architecture-requirements}

When designing a sharded system, follow these requirements:

* Include all sharding key columns in the `WHERE` conditions.
  
  There are some exceptions to this rule:
  
  * The router executes virtual queries, e.g.:

    ```sql
    SELECT true;
    SELECT pg_is_in_recovery();
    SELECT now()
    ```
  
  * The sharding key was provided earlier in the transaction, e.g.:

    ```sql
    BEGIN;
    SET application_name = "smth";
    SELECT * FROM users WHERE id = 123;
    SELECT * FROM taxes;
    COMMIT;
    ```

  * A query addresses a reference table, e.g.:

    ```sql
    SELECT * FROM taxes;
    ```

  * The sharding key is provided through a virtual parameter (hint), e.g.:

    ```sql
    INSERT INTO test(id, age) VALUES (10, 16) /*__spqr__sharding_key: 30*/;
    ```

* Index the sharding key columns to enable data movement between shards.
* Do not perform `JOIN` operations between tables whose data resides on different shards. Instead, use one of the following methods:

  * Denormalize the data.
  * Combine the results of multiple queries in the application.
  * Place reference tables on each shard.  
  * Use the same sharding keys (colocation) for linked tables to keep linked data on the same shard.

* Move analytics to specialized storage systems ({{ CH }} or {{ GP }}) using [{{ data-transfer-full-name }}](../../data-transfer/index.yaml).

## Data rebalancing {#data-rebalancing}

For the range strategy, {{ SPQR }} allows data rebalancing when one of the data ranges becomes "hot", i.e., gets a disproportionally higher load than other ranges. Rebalancing is performed manually and consists of the following steps:

1. Spotting the "hot" key or key range responsible for uneven data distribution across shards.
1. [Adding a new shard](../operations/shards.md#create-shard) to the {{ mspqr-name }} cluster.
1. Moving data from the "hot range" to the new shard using the `DISTRIBUTE ... MOVE ...` command in the administrator console.

Rebalancing does note require stopping the system.