# Migrating {{ mos-name }} cluster host groups to a different availability zone

{{ mos-name }} cluster [host groups](../concepts/host-groups.md) reside in {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). To move a host group from one availability zone to another:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/mdb/host-groups.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
   1. In the line with the host group, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit**.
   1. In the **Host placement** field, select the target availability zone for the clusters and remove the source availability zone.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Repeat the steps to move each host group.

## Specifics of migration in {{ data-transfer-full-name }}{#data-transfer}

If your cluster acts as an [endpoint](../../data-transfer/concepts/index.md#endpoint) at data transfer using {{ data-transfer-name }}:

1. Make sure that some cluster host groups are located in an availability zone different from `{{ region-id }}-d`; otherwise, the transfer will not operate correctly. If you are migrating host groups to the `{{ region-id }}-d` availability zone, place at least one group in the `{{ region-id }}-a` or `{{ region-id }}-b` zone. The transfer will select the appropriate zone automatically. If there is a single host group in your cluster, place it in the `{{ region-id }}-a` or `{{ region-id }}-b` zone.

1. If the [transfer type](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) is {{ dt-type-repl }} or {{ dt-type-copy-repl }}, restart the transfer after adding new host groups and deleting the old ones. This way, it will get data about the cluster's new topology. You do not need to restart {{ dt-type-copy }} transfers, as information about the new topology is provided automatically while activating them.

   {% include [reactivate-a-transfer](../../_includes/data-transfer/reactivate-a-transfer.md) %}

For more information, see [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
