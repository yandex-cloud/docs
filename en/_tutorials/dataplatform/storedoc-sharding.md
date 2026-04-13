# Sharding {{ SD }} collections


When sharding a {{ mmg-name }} cluster, the system automatically creates auxiliary hosts that are [billed](../../storedoc/pricing.md) separately from your main database hosts:
- The hosts created are either `MONGOS` and `MONGOCFG`
- or `MONGOINFRA`

{% include [irreversible-sharding-note.md](../../_includes/mdb/irreversible-sharding-note.md) %}

Consider sharding collections when distributing data across shards can significantly improve database performance or data availability. To increase availability, we recommend composing each shard of 3 or more database hosts.

Both usability and performance improvements depend on your choice of the shard key. Make sure that data is logically distributed across shards and that data in different shards is not interrelated.

You should use sharding for:

* Large datasets: Collections exceeding 200 GB.
* Collections with mixed contents, e.g., frequently and infrequently accessed data.
* Collections requiring high read/write throughput: Sharding spreads the load across hosts to work around technical limitations.

To learn more about sharding, see [{#T}](../../storedoc/concepts/sharding.md).


## Required paid resources {#paid-resources}

You pay for using a {{ mmg-name }} cluster: Computing resources allocated to hosts, including secondary service hosts, as well as storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).


## How to enable collection sharding {#enable}

{% note warning %}

To configure sharding via the `mongosh` CLI, you must run all operations as a user with the [mdbShardingManager](../../storedoc/concepts/users-and-roles.md#mdbShardingManager) role in the `admin` database.

{% endnote %}

1. [Enable sharding](../../storedoc/operations/shards.md#enable) for the cluster.
1. [Connect](../../storedoc/operations/connect/index.md) to your `MONGOS` or `MONGOINFRA` host via the `mongosh` CLI and enable sharding:

   ```text
   sh.enableSharding("<DB_name>")
   ```

   You can get the host type from the [list of cluster hosts](../../storedoc/operations/hosts.md#list-hosts).

1. Create an index for the sharded collection:

   ```text
   db.getSiblingDB("<DB_name>").<collection_name>.createIndex( { "<index>": <index_type> } )
   ```

1. Enable collection sharding:

   ```text
   sh.shardCollection( "<DB_name>.<collection>", { "<index>": <index_type> } )
   ```


1. Reconfigure applications accessing your database to use **only** `MONGOS` or `MONGOINFRA` hosts.

### Heterogeneous sharding {#brackets}

If a collection includes documents with heterogeneous data types, we recommend creating shards based on the `_id` key values of the same type, using the `Type Bracketing` mechanism. This makes sharding and document search faster than when using `_id` values of different types.


## Sharding example {#example}

Suppose you have a sharded {{ mmg-name }} cluster with a `billing` database. You need to enable sharding for the `payment` and `addresses` collections. In our example, the shard key consists of the `payment` index hash and the `addresses` value.

Procedure:

1. [Connect](../../storedoc/operations/connect/index.md) to the `billing` database. Make sure that the account you use to connect to the database has the [mdbShardingManager](../../storedoc/concepts/users-and-roles.md#mdbShardingManager) role in the `admin` database.
1. Enable sharding for the `billing` database:

   ```text
   sh.enableSharding("billing")
   ```

1. Create an index for the sharded collection:

   ```text
   db.payments.ensureIndex( { "_id": "hashed" } )
   ```

1. Create the required number of shards in the [management console]({{ link-console-main }}).
1. Shard the collection based on its namespace:
   ```text
   sh.shardCollection( "billing.payments", { "_id": "hashed" } )
   ```

Once this operation is complete, sharding will be enabled and configured. To confirm this, try listing all available shards using the `sh.status()` command.
