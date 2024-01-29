# Migrating {{ GP }} cluster hosts to a different availability zone

All {{ mgp-name }} cluster hosts are located in the same {{ yandex-cloud }} [availability zone](../../../overview/concepts/geo-scope.md). To move hosts from one availability zone to another, [restore your cluster from a backup](../cluster-backups.md#restore). During cluster recovery from a backup, specify a new availability zone.

{% include [zone-d-disk-restrictions](../../../_includes/mdb/ru-central1-d-local-ssd.md) %}

## Specifics of migration in {{ data-transfer-full-name }} {#data-transfer}

If your cluster acts as an [endpoint](../../../data-transfer/concepts/index.md#endpoint) at data transfer using {{ data-transfer-name }}:

1. Make sure the cluster hosts are located in the `{{ region-id }}-a` or `{{ region-id }}-b` availability zone; otherwise, the transfer will not operate correctly.
1. If the [transfer type](../../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) is {{ dt-type-repl }} or {{ dt-type-copy-repl }}, restart the transfer after recovery from a backup. This way, it will get data about the cluster's new topology. You do not need to restart {{ dt-type-copy }} transfers, as information about the new topology is provided automatically while activating them.

   {% include [reactivate-a-transfer](../../../_includes/data-transfer/reactivate-a-transfer.md) %}

For more information, see [{#T}](../../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
