# Sharding {{ MG }} collections


When sharding a {{ mmg-name }} cluster, the following service hosts are automatically created and [billed](../../managed-mongodb/pricing.md) separately from the main DBMS hosts:
- either `MONGOS` and `MONGOCFG`
- or `MONGOINFRA`

{% include [irreversible-sharding-note.md](../../_includes/mdb/irreversible-sharding-note.md) %}

It makes sense to shard collections when splitting data into shards significantly helps improve DBMS performance or data availability. To increase availability, each shard should consist of 3 or more database hosts.

Ease of use and actual performance improvements significantly depend on the shard key you choose: make sure that the collection data is logically distributed across shards and is not linked to data in different shards.

You should use sharding for:

* Data of significant size: if the collection takes up more than 200 GB.
* Collections with non-uniform contents. For example, data can be clearly classified as frequently queried and rarely queried.
* Collections requiring high read and write speeds. Sharding helps distribute workloads among hosts to bypass technical limitations.

For more information about sharding, see [{#T}](../../managed-mongodb/concepts/sharding.md).

## How to enable collection sharding {#enable}

{% note warning %}

Run all your sharding setup commands via the `mongosh` CLI as a user with the [mdbShardingManager](../../managed-mongodb/concepts/users-and-roles.md#mdbShardingManager) role in the [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database.

{% endnote %}

1. [Enable sharding](../../managed-mongodb/operations/shards.md#enable) for the cluster.
1. [Connect](../../managed-mongodb/operations/connect/index.md) to the `MONGOS` or `MONGOINFRA` host via the `mongosh` CLI and enable sharding:

   ```text
   sh.enableSharding("<DB_name>")
   ```

   You can request the host type with a [list of hosts in the cluster](../../managed-mongodb/operations/hosts.md#list-hosts).

1. Define an index for the sharded collection:

   ```text
   db.getSiblingDB("<DB_name>").<collection_name>.createIndex( { "<index>": <index_type> } )
   ```

1. Enable collection sharding:

   ```text
   sh.shardCollection( "<DB_name>.<collection>", { "<index>": <index_type> } )
   ```

   For a detailed description of the `shardCollection` command, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#definition).

1. Modify the applications accessing your database to use **only** the `MONGOS` or `MONGOINFRA` hosts.

### Sharding heterogeneous data {#brackets}

If a collection includes documents with heterogeneous [data types](https://www.mongodb.com/docs/manual/reference/bson-types), we recommend sharding based on the `_id` key values of the same type using [Type Bracketing](https://www.mongodb.com/docs/manual/reference/method/db.collection.find/#std-label-type-bracketing). This will make sharding and document searching faster than with`_id` values of different types.

### Useful links {#links}

You can learn how to solve issues related to sharding in the {{ MG }} documentation:

* Sharding overview: [Sharding](https://docs.mongodb.com/manual/sharding/index.html).
* About choosing a shard key and sharding strategies: [Shard Keys](https://docs.mongodb.com/manual/core/sharding-shard-key/).

## Example of sharding {#example}

Let's say you already have a sharded {{ mmg-name }} cluster with a `billing` database. You need to enable sharding for the `payment` and `addresses` collections. In the example, the `payment` index hash and the `addresses` field value are used as the shard key.

Sequence of operations:

1. [Connect](../../managed-mongodb/operations/connect/index.md) to the `billing` database. Make sure that the user connecting to the database has the [mdbShardingManager](../../managed-mongodb/concepts/users-and-roles.md#mdbShardingManager) role in the [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database.
1. Enable sharding for the `billing` database:

   ```text
   sh.enableSharding("billing")
   ```

1. Define the index for the sharded collection:

   ```text
   db.payments.ensureIndex( { "_id": "hashed" } )
   ```

1. Create the required number of shards in the [management console]({{ link-console-main }}).
1. Shard the collection based on its namespace:
   ```text
   sh.shardCollection( "billing.payments", { "_id": "hashed" } )
   ```

Sharding is now enabled and configured. To check this, try listing the available shards using the `sh.status()` command.
