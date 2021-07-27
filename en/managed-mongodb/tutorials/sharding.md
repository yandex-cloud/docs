---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Sharding collections {{ MG }}

Sharding in {{ mmg-name }} is available for clusters running {{ MG }} version 4.0 or higher. If your cluster is deployed with version 3.6, you can [upgrade it](../operations/cluster-version-update.md).

Please note that when you shard a {{ mmg-name }} cluster, `MONGOS` and `MONGOCFG` or `MONGOINFRA` service hosts are automatically created and [billed](../pricing.md) separately from the main DBMS hosts.

{% include [irreversible-sharding-note.md](../../_includes/mdb/irreversible-sharding-note.md) %}

It makes sense to shard collections when splitting data into shards significantly helps improve DBMS performance or data availability. To increase availability, each shard should consist of 3 or more database hosts.

Ease of use and actual performance improvements depend strongly on the sharding key you choose: make sure that the data of the collection is logically distributed across shards and isn't linked to data in different shards.

You should use sharding if:

* Significantly large volumes of data. Consider sharding if your collection is 200 GB or more.
* Collections with non-uniform contents. For example, data can be clearly classified as frequently queried and rarely queried.
* Collections requiring high read and write speeds. Sharding helps distribute workloads among hosts to bypass technical limitations.

For more information about sharding, see [{#T}](../concepts/sharding.md).

## How to enable collection sharding {#enable}

{% note warning %}

Run all your sharding setup commands via the `mongo` CLI from a user granted the [mdbShardingManager](../concepts/users-and-roles.md#mdbShardingManager) role in the [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database.

{% endnote %}

1. [Enable sharding](../operations/shards.md#enable) for the cluster.

1. [Connect](../operations/connect.md) to the `MONGOS` or `MONGOINFRA` host using the `mongo` CLI and enable sharding:

   ```
   sh.enableSharding("<database name>")
   ```

   You can obtain the host type with a [list of hosts in the cluster](../operations/hosts.md#list-hosts).

1. Define an index for the sharded collection:

   ```
   db.<collection name>.ensureIndex( { "<index>": "hashed" } )
   ```

1. Enable collection sharding:

   ```
   sh.shardCollection( "<collection>", { "<index>": "hashed" } )
   ```

   For a detailed description of the `shardCollection` command, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#definition).

1. Modify applications that access your database to use **only** the `MONGOS` or `MONGOINFRA` hosts.

### Links on the topic {#links}

From the {{ MG }} documentation, you can learn how to solve issues related to sharding:

* Sharding overview: [Sharding](https://docs.mongodb.com/manual/sharding/index.html).
* Choosing a shard key and sharding strategies: [Shard Keys](https://docs.mongodb.com/manual/core/sharding-shard-key/).

## Example of sharding {#example}

Let's say you already have a {{ mmg-name }} sharded cluster hosting the `billing` database. Your task is to enable sharding for the `payment` and `addresses` collections. In the example, the `payment` index hash and the value of the `addresses` field are used as the shard key.

Sequence of operations:

1. [Connect](../operations/connect.md) to the `billing` database. Make sure that the user connecting to the database has the [mdbShardingManager](../concepts/users-and-roles.md#mdbShardingManager) role in the [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database.

1. Enable `billing` database sharding:

   ```
   sh.enableSharding("billing")
   ```

1. Define the index for the sharded collection:

   ```
   db.payments.ensureIndex( { "_id": "hashed" } )
   ```

1. Create the necessary number of shards in [management console]({{ link-console-main }}).

1. Shard the collection based on its namespace:

   ```
   sh.shardCollection( "billing.payments", { "_id": "hashed" } )
   ```

Sharding is now enabled and configured. To make sure, try listing the available shards using the command `db.adminCommand( { listShards: 1 } )`.

