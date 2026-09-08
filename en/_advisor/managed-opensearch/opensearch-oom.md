### Not enough RAM {#opensearch_oom}

**Description**

The cluster is running out of RAM, which leads to slow performance or emergency shutdowns. Increase the cluster's RAM.

**Action**

To increase the amount of RAM:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Select a host class with the required amount of RAM.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
