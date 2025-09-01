# Migrating collections from {{ MG }} to {{ mmg-name }}


To migrate collections stored in a third-party {{ MG }} cluster to a {{ mmg-name }} cluster, you need to transfer the data, write-lock the old database, and transfer the load to a {{ yandex-cloud }} cluster.


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mmg-name }} target cluster fee: Using computing resources allocated to hosts, and its disk space (see [{{ SD }} pricing](../../storedoc/pricing.md)).
* Per-transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Make sure that you can connect to the source cluster hosts from the internet.

## Migrating data using {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [MMG collections migration with Data Transfer](datatransfer/managed-mongodb.md) %}

## Example of migrating a collection {#example}

1. [Set up the source cluster](#source-setup).
1. [Create and configure a target cluster](#target-setup).
1. [Set up endpoints and a transfer](#prepare-endpoints-transfer).
1. [Transfer data](#transfer).
1. [Delete the resources you created](#clear-out).

### Set up the source cluster {#source-setup}
  
1. Connect to the `mongos` host of the {{ MG }} source cluster using [`mongosh`](https://docs.mongodb.com/mongodb-shell).
1. Create a `db1` database.
1. Create a user with the `db1` owner permissions and log in with that user's credentials:

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

1. Fill in `collection1` in `db1` with random values. 200,000 entries will be added to the collection:
  
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

{% list tabs group=cluster %}

- Non-sharded target cluster {#non-sharded}

  1. [Create](../../storedoc/operations/cluster-create.md) a {{ mmg-name }} cluster with any suitable configuration.
  1. [Create](../../storedoc/operations/databases.md#add-db) a database named `db1`.
  1. [Create a user](../../storedoc/operations/cluster-users.md#adduser) named `user_transfer` with the [`readWrite`](../../storedoc/concepts/users-and-roles.md#readWrite) role for the new database.
  
- Sharded target cluster {#sharded}

  1. [Create](../../storedoc/operations/cluster-create.md) a {{ mmg-name }} cluster with any suitable configuration. There must be at least two hosts in the cluster.
  1. [Enable sharding](../../storedoc/operations/shards.md).
  1. [Create](../../storedoc/operations/databases.md#add-db) a database named `db1`.
  1. [Create a user](../../storedoc/operations/cluster-users.md#adduser) named `user_transfer` with the [`readWrite`](../../storedoc/concepts/users-and-roles.md#readWrite) role for the created database and the [`mdbShardingManager`](../../storedoc/concepts/users-and-roles.md#mdbShardingManager) role for the `admin` service base.
  1. Following [these steps](../../storedoc/tutorials/sharding.md), create an empty sharded collection named `collection1` in `db1` and configure it.

{% endlist %}

### Set up endpoints and a transfer {#prepare-endpoints-transfer}

{% list tabs group=cluster %}

- Non-sharded target cluster {#non-sharded}

  1. [Create an endpoint for the source cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}**: Upload the certificate file if a connection to the source cluster requires encryption.
        * **Host list**: Specify the FQDN of the source cluster hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}**: Specify the port for connecting to the hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user1`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user1` password.
  1. [Create an endpoint for the target cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**: `MDB cluster`.
        * Specify the ID of the target cluster.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user_transfer`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user_transfer` password.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`
  1. [Create a transfer](../../data-transfer/operations/transfer.md#create):
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: {{ dt-type-copy-repl }}
     * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Select the created endpoint for the source cluster.
     * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Select the created endpoint for the target cluster.

- Sharded target cluster {#sharded}

  1. [Create an endpoint for the source cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}**: Upload the certificate file if a connection to the source cluster requires encryption.
        * **Host list**: Specify the FQDN of the source cluster hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}**: Specify the port for connecting to the hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user1`
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user1` password.
  1. [Create an endpoint for the target cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**: `MDB cluster`.
         * Specify the ID of the target cluster.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user_transfer`
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user_transfer` password.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`.
  1. [Create a transfer](../../data-transfer/operations/transfer.md#create):
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: {{ dt-type-copy-repl }}
      * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Select the created endpoint for the source cluster.
      * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Select the created endpoint for the target cluster.

{% endlist %}

### Transfer the data {#transfer}

{% list tabs group=cluster %}

- Non-sharded target cluster {#non-sharded}

  1. [Activate](../../data-transfer/operations/transfer.md#activate) the created transfer.
  1. Wait for the transfer status to change to {{ dt-status-repl }}.
  1. Switch the source cluster to _read-only_ mode and transfer the load to the target cluster.
  1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
  1. [Connect](../../storedoc/operations/connect/index.md) to the target cluster.
  1. Make sure `collection1` has been transferred and contains 200,000 documents as in the source cluster:
  
     ```javascript
     use db1
     db.collection1.countDocuments()
     ```

     ```text
     200000
     ```

- Sharded target cluster {#sharded}

  1. [Activate](../../data-transfer/operations/transfer.md#activate) the created transfer.
  1. Wait for the transfer status to change to {{ dt-status-repl }}.
  1. Switch the source cluster to _read-only_ and transfer the load to the target cluster.
  1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
  1. [Connect](../../storedoc/operations/connect/index.md) to the target cluster.
  1. Make sure `collection1` has been transferred, contains 200,000 documents as in the source cluster, and the documents are distributed across shards:
       
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
      Shard rs01 at rs01/<host_1>
      {
        data: '7.05MiB',
        docs: 99752,
        chunks: 2,
        'estimated data per chunk': '3.52MiB',
        'estimated docs per chunk': 49876
      }
      ---
      Shard rs02 at rs02/<host_2>
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

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    To learn more about the transfer lifecycle, see the [{{ data-transfer-full-name }}](../../data-transfer/concepts/transfer-lifecycle.md) documentation.

1. [Delete](../../data-transfer/operations/transfer.md#delete) the stopped transfer.
1. [Delete endpoints for both the source and target](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the created {{ mmg-name }}](../../storedoc/operations/cluster-delete.md) cluster.
