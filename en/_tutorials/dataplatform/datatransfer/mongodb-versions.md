# Migrating a {{ mmg-full-name }} cluster from version 4.4 to 6.0 using {{ data-transfer-full-name }}


You can migrate a production loaded sharded database deployed in a {{ mmg-name }} version 4.4 cluster to version 6.0.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare the target cluster](#prepare-target).
1. [Set up your transfers](#prepare-transfer).
1. [Activate the transfers](#activate-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ MG }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ MG }} pricing](../../../managed-mongodb/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Fee per transfer: Use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

Create a {{ mmg-name }} version 6.0 target cluster identical to the version 4.4 cluster.

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mmg-name }} target cluster](../../../managed-mongodb/operations/cluster-create.md) with the same configuration as the source cluster and with the following settings:

        * Cluster version: `6.0`.
        * Database name: `db1`.
        * Username: `user1`.

        To connect to the cluster from the internet, enable public access to its hosts.

    
    1. If using security groups in your cluster, make sure they are [configured correctly](../../../managed-mongodb/operations/connect/index.md#configuring-security-groups) and allow connecting to the cluster.


    1. [Grant](../../../managed-mongodb/operations/cluster-users.md#updateuser) the `readWrite` role for the `db1` database to `user1`.

    1. [Enable cluster sharding](../../../managed-mongodb/operations/shards.md#enable) and [add](../../../managed-mongodb/operations/shards.md#add-shard) the required number of shards.

- Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. In the same working directory, place a `.tf` file with the following contents:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "old" { }
        ```

    1. Write the {{ MG }} version 4.4 cluster ID to an environment variable:

        ```bash
        export MONGODB_CLUSTER_ID=<cluster_ID>
        ```

        You can request the ID with the [list of clusters in the folder](../../../managed-mongodb/operations/cluster-list.md#list-clusters).

    1. Import the {{ MG }} version 4.4 cluster settings into the {{ TF }} configuration:

        ```bash
        terraform import yandex_mdb_mongodb_cluster.old ${MONGODB_CLUSTER_ID}
        ```

    1. Get the imported configuration:

        ```bash
        terraform show
        ```

    1. Copy it from the terminal and paste it into the `.tf` file.
    1. Place the file in the new `imported-cluster` directory.
    1. Modify the copied configuration so that you can create a new cluster from it:

        * Specify the new cluster name in the `resource` string and the `name` parameter.
        * Set the `version` parameter to `6.0`.
        * Delete `created_at`, `health`, `id`, `sharded`, and `status`.
        * In the `host` sections, delete `health` and `name`.
        * If the `maintenance_window` section has `type = "ANYTIME"`, delete the `hour` parameter.
        * Delete all `user` sections (if any). You can add database users using the separate `yandex_mdb_mongodb_user` resource.
        * Delete all `database` sections (if any). You can add databases using the separate `yandex_mdb_mongodb_database` resource.
        * Optionally, make further changes if you need to customize the configuration.

    1. Add the resource to create the database to the file:

        ```hcl
        resource "yandex_mdb_mongodb_database" "db1" {
          cluster_id = yandex_mdb_mongodb_cluster.<cluster_name>.id
          name       = "db1"
        }
        ```

        Where `<cluster_name>` is the new cluster name specified in the `yandex_mdb_mongodb_cluster` resource.

    1. Add the resource to the file to create a user named `user1`:

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

        Where `<cluster_name>` is the new cluster name specified in the `yandex_mdb_mongodb_cluster` resource.

    1. [Get the authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

    1. In the same directory, [configure and initialize a provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download it](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you did not add the authentication credentials to environment variables, specify them in the configuration file.

    1. Check that the {{ TF }} configuration files are correct:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../../_includes/mdb/mmg/terraform/timeouts.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. [Create a user](../../../managed-mongodb/operations/cluster-users.md#adduser) with the `readWrite` role for the source database you want to replicate.

1. Delete unused collections from the database.

1. Disable unique indexes in the collections. They will be enabled after data migration.

1. Estimate your database workload. If it exceeds 10,000 writes per second, plan several transfers.

    1. Identify the high-workload collections.
    1. Distribute your collections between several transfers.

1. Set the oplog storage size with a 15-20% margin over the cluster disk size. This will allow {{ data-transfer-name }} to read changes from the source cluster throughout the data copying process.

    For more information about oplog, see the [{{ MG }} documentation](https://www.mongodb.com/docs/manual/tutorial/change-oplog-size).

## Prepare the target cluster {#prepare-target}

If the source database has sharded collections, [prepare the target database](../../../data-transfer/operations/prepare.md#target-mg). Do not enable unique indexes.

## Set up the transfers {#prepare-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) for each scheduled transfer and specify the endpoint parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}**: `<{{ MG }}_source_cluster_name>` from the drop-down list.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `<source_cluster_database_name>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `<username>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: `<password>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.collections.title }}**: For each endpoint, specify the list of included collections that you allocated for each transfer.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.excluded_collections.title }}**: Specify [time series collections]({{ mg.docs.comd }}/core/timeseries-collections/) if your database has any. {{ data-transfer-name }} does not support migration of such collections.

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) for each planned transfer and specify endpoint parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}**: `<{{ MG }}_target_cluster_name>` from the drop-down list.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: `db1`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: `user1`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: `<password>`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.database.title }}**: `db1`.

    If sharded collections have been created in the target database, select either the `Do not clean` or `TRUNCATE` cleanup policy.

    {% include [MongoDB endpoint DROP clean policy warning](../../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

1. [Create transfers](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.

    To copy large collections (over 1 GB) faster, enable [parallel copy](../../../data-transfer/concepts/sharded.md) in the transfer settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.workers_count.title }}**: `5` or more
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.ParallelSnapshotSettings.threads_count.title }}**: `8` or more

    The collection will split into the specified number of parts that will be copied concurrently.

    For parallel copy to work, the [data type](https://www.mongodb.com/docs/manual/reference/bson-types) in the `_id` field should be the same for all documents in a collection. If a transfer discovers a type mismatch, the collection will not be partitioned but transferred in a single thread instead. If needed, remove documents with mismatched data types from the collection before starting a transfer.

    {% note info %}

    If a document with a different data type is added to a collection after a transfer starts, the transfer will move it at the replication stage after the parallel copy operation is completed. However, when re-activated, the transfer will not be able to partition a collection because the `_id` field type requirement will not be met for some of the documents in the collection.

    {% endnote %}

## Activate the transfers {#activate-transfer}

1. [Activate the transfers](../../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to read-only.
1. If you disabled unique indexes in the source database, enable them in the target database.
1. Transfer the load to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to reach zero for each transfer. This means that all changes that occurred in the source cluster after data was copied are transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfers and wait for their status to change to {{ dt-status-stopped }}.

## Test your transfer {#verify-transfer}

1. [Connect](../../../managed-mongodb/operations/connect/index.md) to `db1` in the {{ mmg-name }} target cluster.

1. Make sure the data collections have appeared in the `db1` database:

    ```javascript
    show collections
    db.<collection_name>.find()
    ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* [Transfer](../../../data-transfer/operations/transfer.md#delete)
* [Endpoints](../../../data-transfer/operations/endpoint/index.md#delete)

Delete the {{ mmg-name }} cluster version `6.0` depending on how it was created:

{% list tabs group=instructions %}

- Manually {#manual}

    Delete the [{{ mmg-name }} cluster](../../../managed-mongodb/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
