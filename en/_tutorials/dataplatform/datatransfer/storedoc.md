# Migrating data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../../data-transfer/operations/prepare.md#source-mg).
1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-mg).
1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.

        Configure the source cluster connection settings.

    {% note info %}

    Transferring of `Time Series` collections is not supported, so you should [exclude](../../../data-transfer/operations/endpoint/source/mongodb.md#additional-settings) such collections in the endpoint settings.

    {% endnote %}

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `MongoDB`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

        Specify the ID of the target cluster.

1. Create a _{{ dt-type-copy-repl }}_-type [transfer](../../../data-transfer/operations/transfer.md#create) and configure it to use the previously created endpoints.

   To make large collections (over 1 GB) copy more quickly, enable [parallel copy](../../../data-transfer/concepts/sharded.md) in the transfer settings. Specify two or more [workers](../../../data-transfer/concepts/index.md#worker). The collection will be split into the specified number of parts that will be copied concurrently.

   For parallel copy to work, the `_id` field data type must be the same for all documents in the same collection. If a transfer discovers a type mismatch, the collection will not be partitioned but transferred in a single thread instead. If needed, remove documents with mismatched data types from the collection before starting a transfer.

   {% note info %}

   If a document with a different data type is added to a collection after a transfer starts, the transfer will move it at the replication stage after the parallel copy operation is completed. However, when re-activated, the transfer will not be able to partition a collection because the `_id` field type requirement will not be met for some of the documents in the collection.

   {% endnote %}

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to "read-only" mode and transfer the load to the target cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Delete the stopped transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
