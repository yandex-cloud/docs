# Migrating {{ mos-name }} cluster host groups to a different availability zone

{{ mos-name }} cluster [host groups](../concepts/host-groups.md) reside in {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md). You can move host groups from one availability zone to another. To do this:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to your folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the name of the cluster you need and select the ![host-groups.svg](../../_assets/mdb/host-groups.svg) **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
   1. In the line with the host group, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Edit**.
   1. In the **Host placement** field, select the target availability zone for the clusters and remove the source availability zone.
   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Repeat the steps to move each host group.
