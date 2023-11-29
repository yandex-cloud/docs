## Specifics of migration in {{ data-transfer-full-name }} {#data-transfer}

If your cluster acts as an [endpoint](../../data-transfer/concepts/index.md#endpoint) at data transfer using {{ data-transfer-name }}:

1. Make sure that some cluster hosts are located in an availability zone different from `{{ region-id }}-d`; otherwise, the transfer will not run correctly. If you are migrating your cluster hosts to the `{{ region-id }}-d` availability zone, place at least one host in the `{{ region-id }}-a` or `{{ region-id }}-b` zone. The transfer will select the appropriate zone automatically. If there is a single host in your cluster, place it in the `{{ region-id }}-a` or `{{ region-id }}-b` zone.

1. If your [transfer type](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) is {{ dt-type-repl }} or {{ dt-type-copy-repl }}, restart the transfer after adding new hosts and deleting the old ones. This way, it will get data about the cluster's new topology. You do not need to restart {{ dt-type-copy }} transfers, as information about the new topology is provided automatically while activating them.

   {% include [reactivate-a-transfer](reactivate-a-transfer.md) %}

For more information, see [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
