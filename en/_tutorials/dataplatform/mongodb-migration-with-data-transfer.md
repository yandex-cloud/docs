# Migrating collections from {{ MG }} to {{ mmg-name }}

To migrate collections stored in a third-party {{ MG }} cluster to a {{ mmg-name }} cluster, you need to directly transfer the data, make the old databases read-only, and transfer the load to the {{ yandex-cloud }} cluster.

## Before you start {#before-you-begin}

Make sure that you can connect to the source cluster hosts from the internet.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [MMG collections migration with Data Transfer](../datatransfer/managed-mongodb.md) %}

## Example of migrating a collection {#example}

1. [Set up the source cluster](#source-setup).
1. [Create and configure a target cluster](#target-setup).
1. [Set up endpoints and a transfer](#prepare-endpoints-transfer).
1. [Transfer data](#transfer).
1. [Delete the resources you created](#clear-out).

### Set up the source cluster {#source-setup}

1. Connect to the `mongos` host of the {{ MG }} source cluster using the [mongosh](https://docs.mongodb.com/mongodb-shell) utility.
1. Create the `db1` database.
1. Create a user with `db1` owner rights and log in as them:

   ```javascript
   use admin
   db.createUser({
     user: "user1",
     pwd: passwordPrompt(),
     roles: [
         {
             role: "dbOwner",
             db: "db1"
         }
     ]
   })

   db.auth("user1")
   ```

1. Fill in `collection1` in `db1` with random values. 200000 entries will be added to the collection:

   ```javascript
   use db1
   function randomName() {
     // Base 36 uses letters and digits to represent a number:
     return (Math.random()+1).toString(36).substring(2);
   }

   var day = 1000 * 60 * 60 * 24;
   function randomDate () {
     return new Date(Date.now() - (Math.floor(Math.random() * day)));
   }

   for (var i = 1; i <= 200000; ++i) {
     db.collection1.insertOne({
      name: randomName(),
      creationDate: randomDate(),
      uid: i
     });
   }
   ```

### Create and configure a target cluster {#target-setup}

{% list tabs %}

- Non-sharded target cluster

   1. [Create a {{ mmg-name }} cluster](../../managed-mongodb/operations/cluster-create.md) with any suitable configuration.
   1. [Create](../../managed-mongodb/operations/databases.md#add-db) the `db1` database.
   1. [Create](../../managed-mongodb/operations/cluster-users.md#adduser) the `user_transfer` user with the [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) role for the created database.

- Sharded target cluster

   1. [Create a {{ mmg-name }} cluster](../../managed-mongodb/operations/cluster-create.md) with any suitable configuration. There must be at least two hosts in the cluster.
   1. [Enable sharding](../../managed-mongodb/operations/shards.md).
   1. [Create](../../managed-mongodb/operations/databases.md#add-db) the `db1` database.
   1. [Create](../../managed-mongodb/operations/cluster-users.md#adduser) the `user_transfer` user with the [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) role for the created database and the [`mdbShardingManager`](../../managed-mongodb/concepts/users-and-roles.md#mdbShardingManager) role for the `admin` service database.
   1. Following the [instructions](../../managed-mongodb/tutorials/sharding.md), create and configure the empty sharded collection `collection1` in `db1`.

{% endlist %}

### Set up endpoints and a transfer {#prepare-endpoints-transfer}

{% list tabs %}

- Non-sharded target cluster

   1. [Create an endpoint for the source cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **Database type**: `{{ MG }}`.
      * **Connection settings**: `Custom installation`.
         * **CA Certificate**: Upload the certificate file if a connection to the source cluster requires encryption.
         * **Host list**: Specify the FQDN of the source cluster hosts.
         * **Port**: Specify the port for connecting to the hosts.
         * **Authentication source**: `db1`.
         * **Username**: `user1`.
         * **Password**: Enter the password for `user1`.
   1. [Create an endpoint for the target cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **Database type**: `{{ MG }}`.
      * **Connection settings**: `MDB cluster`.
         * Specify the ID of the target cluster.
         * **Username**: `user_transfer`.
         * **Password**: Enter the password for `user_transfer`.
         * **Cleanup policy**: `DROP`.
   1. [Create a transfer](../../data-transfer/operations/transfer.md#create):
      * **Transfer type**:`{{ dt-type-copy-repl }}`.
      * **Source**: Select the created endpoint for the source cluster.
      * **Target**: Select the created endpoint for the target cluster.

- Sharded target cluster

   1. [Create an endpoint for the source cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **Database type**: `{{ MG }}`.
      * **Connection settings**: `Custom installation`.
         * **CA Certificate**: Upload the certificate file if a connection to the source cluster requires encryption.
         * **Host list**: Specify the FQDN of the source cluster hosts.
         * **Port**: Specify the port for connecting to the hosts.
         * **Authentication source**: `db1`.
         * **Username**: `user1`.
         * **Password**: Enter the password for `user1`.
   1. [Create an endpoint for the target cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **Database type**: `{{ MG }}`.
      * **Connection settings**: `MDB cluster`.
         * Specify the ID of the target cluster.
         * **Username**: `user_transfer`.
         * **Password**: Enter the password for `user_transfer`.
         * **Cleanup policy**: `DISABLED `or `TRUNCATE`.
   1. [Create a transfer](../../data-transfer/operations/transfer.md#create):
      * **Transfer type**:`{{ dt-type-copy-repl }}`.
      * **Source**: Select the created endpoint for the source cluster.
      * **Target**: Select the created endpoint for the target cluster.

{% endlist %}

### Transfer the data {#transfer}

{% list tabs %}

- Non-sharded target cluster

   1. [Activate](../../data-transfer/operations/transfer.md#activate) the created transfer.
   1. Wait for the transfer to change to the **Incremented** status.
   1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
   1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery, [s]** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
   1. [Connect](../../managed-mongodb/operations/connect/non-sharded.md) to the target cluster.
   1. Make sure that the `collection1` collection has been transferred and contains 200000 documents like in the source cluster:

      ```javascript
      use db1
      db.collection1.countDocuments()
      ```

      ```text
      200000
      ```

- Sharded target cluster

   1. [Activate](../../data-transfer/operations/transfer.md#activate) the created transfer.
   1. Wait for the transfer to change to the **Incremented** status.
   1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
   1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery, [s]** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
   1. [Connect](../../managed-mongodb/operations/connect/sharded.md) to the target cluster.
   1. Make sure that the `collection1 `collection has been transferred, contains 200000 documents like in the source cluster, and the documents are distributed across shards:

      ```javascript
      use db1
      db.collection1.countDocuments()
      ```

      ```text
      200000
      ```

      ```javascript
      db.collection1.getShardDistribution()
      ```

      ```text
      Shard rs01 at rs01/<host1>
      {
        data: '7.05MiB',
        docs: 99752,
        chunks: 2,
        'estimated data per chunk': '3.52MiB',
        'estimated docs per chunk': 49876
      }
      ---
      Shard rs02 at rs02/<host2>
      {
        data: '7.08MiB',
        docs: 100248,
        chunks: 2,
        'estimated data per chunk': '3.54MiB',
        'estimated docs per chunk': 50124
      }
      ---
      ...
      ```

{% endlist %}

### Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait its status to change to **Stopped**.

   To learn more about the transfer lifecycle, see the [{{ data-transfer-full-name }} documentation](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Delete](../../data-transfer/operations/transfer.md#delete) the stopped transfer.
1. [Delete endpoints for the source and target](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the created {{ mmg-name }} cluster](../../managed-mongodb/operations/cluster-delete.md).
