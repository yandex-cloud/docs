# Sharding ClickHouse tables

It makes sense to shard tables when splitting data into shards significantly helps improve DBMS performance or data availability. To increase availability, each shard should consist of 3 or more database hosts.

Data should be split into shards if:

* Your tables are very big. Consider sharding if your table is 200 GB or larger.
* The content of your tables is non-uniform. For example, data can be clearly classified as frequently queried and rarely queried.
* Your tables require high read and write performance. Sharding helps distribute workloads among the hosts to bypass technical limitations.

Ease of use and actual performance improvements depend strongly on the shard key you choose: make sure that the data is logically distributed across shards and isn't linked to data in different shards.

For more information about sharding, see [{#T}](../concepts/sharding.md).

## How to start sharding tables {#enable}

By default, {{ mch-name }} creates the first shard together with the cluster. This shard includes all the hosts in the cluster. To start using sharding, [add](../operations/shards.md#add-shard) the number of shards you need and create a table on the [Distributed](https://clickhouse.yandex/docs/en/operations/table_engines/distributed/) engine. The article under the link describes sharding strategies and guidelines for creating tables in the applicable format, as well as distributed table limits.

{{ mch-name }} automatically creates the [shard configuration](https://clickhouse.yandex/docs/en/operations/table_engines/distributed/) in the cluster. You can [manage this configuration](../operations/shards.md#shard-update).

## Example of sharding {#example}

Let's say you already have a sharded {{ mch-name }} cluster hosting the `db1` database. Your task is to enable sharding for the `hits` table. A random number, `rand()`, is used as a sharding expression in the example:

1. [Connect](../operations/connect.md) to the database.

1. Create a distributed table:

   ```
   CREATE TABLE sharding ENGINE = Distributed(logs, db1, hits, rand());
   ```

After that, you can do SELECT queries and INSERT queries against the created table. The queries will be processed according to the configuration you set.

