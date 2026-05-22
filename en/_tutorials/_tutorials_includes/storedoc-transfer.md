[Create a transfer](../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the new endpoints.

To make large collections (over 1 GB) copy more quickly, enable [parallel copy](../../data-transfer/concepts/sharded.md) in the transfer settings. Specify two or more [workers](../../data-transfer/concepts/index.md#worker). The collection will be split into the specified number of parts that will be copied concurrently.

For parallel copy to work, the `_id` fields in all documents within the collection must have the same data type. If a transfer detects a type mismatch, the collection will not be split but transferred in a single thread instead. If needed, remove documents with mismatched data types from the collection prior to transfer.

{% note info %}

If a document with a different data type is added to the collection after the transfer starts, the transfer will migrate it at the replication stage after parallel copying. However, when reactivated, the transfer will not be able to split the collection into parts, since the requirement for the same `_id` field type in all documents of the collection will not be met.

{% endnote %}
