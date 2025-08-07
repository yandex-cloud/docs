1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ myt-name }} cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Select **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}** to create a cluster with the minimum operational configuration.
1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:
    1. Give the cluster a name. The name must be unique within the folder.
    1. Optionally, enter a description for the cluster.
    1. Optionally, create [labels](../../resource-manager/concepts/labels.md):
        1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
        1. Enter a label in `key: value` format.
        1. Press **Enter**.

1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}**, select:
    * [Availability zone](../../overview/concepts/geo-scope.md) for the cluster.
    * [Subnet](../../vpc/operations/subnet-create.md).
    * [Security group](../../vpc/concepts/security-groups.md) for the cluster’s network traffic. This is an optional setting.

    {% note warning %}
       
    You cannot edit any network settings after you create a cluster.
       
    {% endnote %}

1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-config-section_title_fPkN8 }}**, view the cluster configuration parameters.
1. Click **{{ ui-key.yacloud.common.create }}**.
1. Wait until the cluster is ready: its status on the {{ myt-name }} dashboard will change to **Running**. This process can take a while.