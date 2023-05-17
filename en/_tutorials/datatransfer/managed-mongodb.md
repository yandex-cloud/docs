# Migrating data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#source-mg).
1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-mg).
1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MONGO_V2 }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.

      Specify the parameters for connecting to the source cluster.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-MONGO_V2 }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}`.

      Specify the ID of the target cluster.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a _{{ dt-type-copy-repl }}_ type that will use the created endpoints.

   To make large collections (over 1 GB) copy more quickly, enable sharding in the transfer settings: **Runtime environment** → **{{ yandex-cloud }}** → **Sharded copying parameters** → **Number of instances**. Specify a value of `2` or more. The collection will split into the specified number of parts that will be copied concurrently.

   For sharding to work, the [data type](https://www.mongodb.com/docs/manual/reference/bson-types) in the `_id` field should be the same for all documents in a collection. If a transfer discovers a type mismatch, the collection will not be partitioned but transferred in a single thread instead. If required, remove documents with mismatched data types from the collection before starting a transfer.

   {% note info %}

   If a document with a different data type is added to a collection after a transfer starts, the transfer will move it at the replication stage after the copying operation is sharded. However, when re-enabled, the transfer will not be able to partition a collection because the requirement on the `_id` field will not be met for some of the collection's documents.

   {% endnote %}

1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.
1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.
1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to {{ dt-status-stopped }}.

   For more information about transfer statuses, see [Transfer lifecycle](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. [Delete the stopped transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both source and target.
