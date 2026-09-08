### Risk of cluster unavailability {#opensearch_disk_free_space}

**Description**

Your host is low on free space. Some operations may be disabled, while the whole cluster may become unavailable, i.e., switch to read-only mode. Increase the disk size or clear unused data.

**Action**

To increase the disk size:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. In the disk type settings, increase the disk size.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
