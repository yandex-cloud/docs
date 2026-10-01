### Disk space autoscaling is limited {#opensearch-disk-autoscaling-limit}

**Description**

The disk autoscaling limit has been reached, so the cluster cannot increase its disk space when needed. Change the autoscaling settings in the cluster and increase the limit.

**Action**

To increase the disk size:

1. [Navigate]({{ link-console-main }}/link/managed-opensearch) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}** tab.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row with the group you need and select **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Specify the maximum storage size after the expansion.
1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.