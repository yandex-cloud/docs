# Migrating collections from {{ MG }} to {{ mmg-name }}


To migrate collections from a third-party {{ MG }} cluster to your {{ mmg-name }} cluster, follow these steps: transfer the data, switch legacy databases to read-only mode, switch the workload to your {{ yandex-cloud }} cluster.


## Required paid resources {#paid-resources}

* {{ mmg-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Per transfer: Computing resources used and the number of data rows transferred (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Make sure you can connect to the source cluster’s hosts from the internet.

## Migrating data using {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [MMG collections migration with Data Transfer](datatransfer/storedoc.md) %}

## Collection migration example {#example}

1. [Configure the source cluster](#source-setup).
1. [Create and configure the target cluster](#target-setup).
1. [Set up the endpoints and transfer](#prepare-endpoints-transfer).
1. [Transfer data](#transfer).
1. [Delete the resources you created](#clear-out).

### Configure the source cluster {#source-setup}
  
1. Connect to the `mongos` host on the {{ MG }} source cluster via `mongosh`.
1. Create a database `db1`.
1. Create a user with owner privileges for `db1` and log in as that user:

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

### Create and configure the target cluster {#target-setup}

{% list tabs group=cluster %}

- Non-sharded target cluster {#non-sharded}

  1. [Create](../../storedoc/operations/cluster-create.md) a {{ mmg-name }} cluster with your preferred configuration.
  1. [Create](../../storedoc/operations/databases.md#add-db) a database `db1`.
  1. [Create a user](../../storedoc/operations/cluster-users.md#adduser) named `user_transfer` with the [`readWrite`](../../storedoc/concepts/users-and-roles.md#readWrite) role for the new database.
  
- Sharded target cluster {#sharded}

  1. [Create](../../storedoc/operations/cluster-create.md) a {{ mmg-name }} cluster with your preferred configuration. The cluster must have at least two hosts.
  1. [Enable sharding](../../storedoc/operations/shards.md).
  1. [Create](../../storedoc/operations/databases.md#add-db) a database `db1`.
  1. [Create a user](../../storedoc/operations/cluster-users.md#adduser) named `user_transfer` with the [`readWrite`](../../storedoc/concepts/users-and-roles.md#readWrite) role for your new database and the [`mdbShardingManager`](../../storedoc/concepts/users-and-roles.md#mdbShardingManager) role for the `admin` database.
  1. Follow [these steps](../../storedoc/tutorials/sharding.md) to create and configure an empty sharded collection named `collection1` in the `db1` database.

{% endlist %}

### Set up the endpoints and transfer {#prepare-endpoints-transfer}

{% list tabs group=cluster %}

- Non-sharded target cluster {#non-sharded}

  1. [Create the endpoint for the source cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}**: If connecting to the source cluster requires encryption, upload the certificate file.
        * **Host list**: Specify the FQDNs of the source cluster’s hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}**: Specify the port for connecting to the hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user1` password.
  1. [Create the endpoint for the target cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**: `MDB cluster`.
        * Specify the target cluster ID.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user_transfer`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user_transfer` password.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`.
  1. [Create a transfer](../../data-transfer/operations/transfer.md#create):
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: {{ dt-type-copy-repl }}.
     * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Select the endpoint you created for the source cluster.
     * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Select the endpoint you created for the target cluster.

- Sharded target cluster {#sharded}

  1. [Create the endpoint for the source cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}**: If connecting to the source cluster requires encryption, upload the certificate file.
        * **Host list**: Specify the FQDNs of the source cluster’s hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}**: Specify the port for connecting to the hosts.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user1` password.
  1. [Create the endpoint for the target cluster](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**: `MDB cluster`.
         * Specify the target cluster ID.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user_transfer`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the `user_transfer` password.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`.
  1. [Create a transfer](../../data-transfer/operations/transfer.md#create):
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}**: {{ dt-type-copy-repl }}.
      * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}**: Select the endpoint you created for the source cluster.
      * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**: Select the endpoint you created for the target cluster.

{% endlist %}

### Transfer the data {#transfer}

{% list tabs group=cluster %}

- Non-sharded target cluster {#non-sharded}

  1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.
  1. Wait for the transfer status to change to {{ dt-status-repl }}.
  1. Switch the source cluster to <q>read-only</q> mode and transfer the workload over to the target cluster.
  1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait until the **Maximum data transfer delay** value drops to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.
  1. [Connect](../../storedoc/operations/connect/index.md) to the target cluster.
  1. Verify that `collection1` has been transferred and contains 200,000 documents, matching the count in the source cluster:
  
     ```javascript
     use db1
     db.collection1.countDocuments()
     ```

     ```text
     200000
     ```

- Sharded target cluster {#sharded}

  1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.
  1. Wait for the transfer status to change to {{ dt-status-repl }}.
  1. Switch the source cluster to <q>read-only</q> mode and transfer the workload over to the target cluster.
  1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait until the **Maximum data transfer delay** value drops to zero. This means that all changes made in the source cluster after the initial data copy have been transferred to the target cluster.
  1. [Connect](../../storedoc/operations/connect/index.md) to the target cluster.
  1. Verify that `collection1` has been transferred,  that it contains 200,000 documents as in the source cluster, and that the documents are distributed across shards:
       
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

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    To learn more about the transfer lifecycle, see [this {{ data-transfer-full-name }} guide](../../data-transfer/concepts/transfer-lifecycle.md).

1. Once the transfer is stopped, [delete it](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the {{ mmg-name }} cluster](../../storedoc/operations/cluster-delete.md).
