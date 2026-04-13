# Migrating a {{ mmg-name }} (Managed Service for MongoDB) cluster from 4.4 to 6.0 using {{ data-transfer-full-name }}


You can migrate a sharded production database under load from a {{ mmg-name }} cluster version 4.4 to version 6.0.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare the target cluster](#prepare-target).
1. [Set up the transfers](#prepare-transfer).
1. [Activate the transfers](#activate-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mmg-name }} cluster: computing resources allocated to hosts, storage and backup size (see [{{ mmg-name }} pricing](../../../storedoc/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Per transfer: Computing resources used and the number of data rows transferred (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Create a {{ mmg-name }} target cluster running version 6.0, identical to the version 4.4 cluster.

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmg-name }} (Managed Service for MongoDB) target cluster](../../../storedoc/operations/cluster-create.md) identical to the source cluster with the following settings:

        * Cluster version: `6.0`.
        * Database name: `db1`.
        * Username: `user1`.
        * Access to cluster hosts: Public.

        {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

    
    1. If you are using security groups in a cluster, make sure they are [configured correctly](../../../storedoc/operations/connect/index.md#configuring-security-groups) and allow connections to it.


    1. [Grant](../../../storedoc/operations/cluster-users.md#updateuser) the `readWrite` role on the database `db1` to `user1`.

    1. [Enable cluster sharding](../../../storedoc/operations/shards.md#enable) and [add](../../../storedoc/operations/shards.md#add-shard) the required number of shards.

- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. In your current working directory, create a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Save the {{ SD }} cluster ID for version 4.4 to an environment variable:

        ```bash
        export MONGODB_CLUSTER_ID=<cluster_ID>
        ```

        You can get the cluster ID from the [list of clusters in your folder](../../../storedoc/operations/cluster-list.md#list-clusters).

    1. Import the {{ SD }} cluster settings for version 4.4 into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${MONGODB_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from your terminal and paste it into the `.tf` file.
    1. Create a new directory `imported-cluster` and move your configuration file there.
    1. Modify the configuration so that you can use it to create a new cluster:

        * Specify the new cluster name in the `resource` string and in the `name` argument.
        * Set `version` to `6.0`.
        * Delete the `created_at`, `health`, `id`, `sharded`, and `status` arguments.
        * In the `host` sections, delete the `health` and `name` arguments.
        * If the `maintenance_window` section contains `type = "ANYTIME"`, delete the `hour` argument.
        * Delete all `user` sections. Use `yandex_mdb_mongodb_user` resource to add database users.
        * Delete all `database` sections. You can add databases using a separate `yandex_mdb_mongodb_database` resource.
        * Optionally, you can customize the configuration further as needed.

    1. Add the database resource to the configuration file:

        ```hcl
        resource "yandex_mdb_mongodb_database" "db1" {
          cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
          name       = "db1"
        }
        ```

        Where `<cluster_name>` is the name of your new cluster as specified in the `yandex_mdb_mongodb_cluster` resource.

    1. Add the resource for creating a user named `user1` to the configuration file:

        ```hcl
        resource "yandex_mdb_mongodb_user" "user1" {
          cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
          name       = "user1"
          password   = "<user_password>"
          permission {
            database_name = "db1"
            roles         = ["readWrite"]
          }
          depends_on = [
            yandex_mdb_mongodb_database.db1
          ]
        }
        ```

        Where `<cluster_name>` is the name of your new cluster as specified in the `yandex_mdb_mongodb_cluster` resource.

    1. Navigate to the `imported-cluster` directory and [get the authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. In the same directory, [configure and initialize the provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Instead of manually creating the provider configuration file, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Move the configuration file to the `imported-cluster` directory and [specify the arguments](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not added the authentication credentials to environment variables, specify them in the configuration file.

    1. Validate your {{ TF }} configuration:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. [Create a user](../../../storedoc/operations/cluster-users.md#adduser) with the `readWrite` role for the source database you want to replicate.

1. Delete unused collections from the database.

1. Disable the unique constraints of indexes in the collections. They will be automatically reenabled after data migration.

1. Evaluate your database workload. If it exceeds 10,000 writes per second, schedule multiple transfers.

    1. Identify collections under high load.
    1. Distribute your collections across multiple transfers.

1. Allocate oplog storage with a 15-20% margin over the cluster disk size. This will allow {{ data-transfer-name }} to read changes from the source cluster throughout the data copy process.


## Prepare the target cluster {#prepare-target}

If the source database has sharded collections, [prepare the target database](../../../data-transfer/operations/prepare.md#target-mg). Do not enable unique constraints for indexes.

## Set up the transfers {#prepare-transfer}

1. [Create source endpoints](../../../data-transfer/operations/endpoint/index.md#create) for each scheduled transfer and specify their settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}**: `<Yandex_StoreDoc_source_cluster_name>` from the drop-down list.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `<source_cluster_database_name>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `<username>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: `<password>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.collections.title }}**: For each endpoint, specify the list of included collections according to your transfer distribution plan.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.excluded_collections.title }}**: Specify `Time Series` collections if your database has any. {{ data-transfer-name }} does not support migration of such collections.

1. [Create target endpoints](../../../data-transfer/operations/endpoint/index.md#create) for each scheduled transfer and specify their settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}**: `<Yandex_StoreDoc_target_cluster_name>` from the drop-down list.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user1`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: `<password>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.database.title }}**: `db1`.

    If your target database contains sharded collections, select either the `Do not clean` or `TRUNCATE` cleanup policy.

    {% include [MongoDB endpoint DROP clean policy warning](../../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

1. [Create](../../../data-transfer/operations/transfer.md#create) **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**-type transfers configured to use the previously created endpoints.

    To speed up copying of large collections (over 1 GB), enable [parallel copy](../../../data-transfer/concepts/sharded.md) in the transfer settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}**: `5` or more
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}**: `8` or more

    The collection will be split into the specified number of parts that will be copied concurrently.

    For parallel copy to work properly, the data type of the `_id` field must be the same for all documents in the same collection. If a transfer detects a type mismatch, the collection will not be split but transferred in a single thread instead. If needed, remove documents with mismatched data types from the collection prior to transfer.

    {% note info %}

    If a document with a different data type is added to the collection after the transfer starts, the transfer will migrate it at the replication stage after parallel copying. However, when reactivated, the transfer will not be able to split the collection into parts because the `_id` field type requirement will not be met for some of the documents in the collection.

    {% endnote %}

## Activate the transfers {#activate-transfer}

1. [Activate the transfers](../../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to read-only mode.
1. If you disabled unique constraints for indexes in the source database, enable them in the target database.
1. Transfer the workload over to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to drop to zero for each transfer. This indicates that the target cluster now contains all changes made in the source cluster after the data copy completed.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfers and wait for their status to change to {{ dt-status-stopped }}.

## Test the transfer {#verify-transfer}

1. [Connect](../../../storedoc/operations/connect/index.md) to the database `db1` in the {{ mmg-name }} target cluster.

1. Verify that the data collections have appeared in the `db1` database:

    ```javascript
    show collections
    db.<collection_name>.find()
    ```

## Delete the resources you created {#clear-out}

To minimize resource consumption, delete the resources you no longer need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the {{ mmg-name }} cluster version `6.0` applying the same method used for its creation:

   {% list tabs group=instructions %}

   - Manually {#manual}

       [Delete the {{ mmg-name }} cluster](../../../storedoc/operations/cluster-delete.md).

   - Using {{ TF }} {#tf}

       {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

   {% endlist %}
