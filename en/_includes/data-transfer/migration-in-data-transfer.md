## Specifics of migration in {{ data-transfer-full-name }} {#data-transfer}

If your cluster is used as an [endpoint](../../data-transfer/concepts/index.md#endpoint) when transferring data with {{ data-transfer-name }}, and the [transfer type](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) is {{ dt-type-repl }} or {{ dt-type-copy-repl }}, restart the transfer after migrating the cluster. This way, the transfer will get data about the cluster's new topology.

You do not need to restart {{ dt-type-copy }} transfers, as information about the new topology is provided automatically while activating them.

{% include [reactivate-a-transfer](reactivate-a-transfer.md) %}

For more information, see [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
